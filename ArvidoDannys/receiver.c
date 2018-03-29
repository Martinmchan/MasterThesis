#include <gst/gst.h>
#include <glib.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <gst/net/gstnet.h>
#include <gst/net/gstnettimeprovider.h>
#include <gst/net/gstnetclientclock.h>
#include <time.h>


#define DEFAULT_AUDIO_CAPS \
  "audio/x-raw, format=S16LE,channels=1,rate=48000"

#define DEFAULT_RTP_CAPS \
  "application/x-rtp, media=audio, payload=96, encoding-name=L16, clock-rate=48000, channels=2"

#define CLOCK_REMOTE_ADDRESS "172.25.13.200"
#define CLOCK_REMOTE_PORT 5015

#define RTP_PORT 6000

static GstElement *interleave = NULL;
static GstElement *pipeline = NULL;
static GstElement *filesink = NULL;
static GstElement *output_selector = NULL;
static GMutex mutex;

static int nbr_of_streams = 0;
static GMainLoop *mainloop;
GHashTable * mapping; 

static void
signal_handler(G_GNUC_UNUSED gint signo)
{
  g_main_loop_quit (mainloop);
}


static void
on_rtpbin_pad_added(G_GNUC_UNUSED GstElement *rtpbin, GstPad * new_pad,
                    G_GNUC_UNUSED void *context)
{
g_mutex_lock (&mutex);
  static int i = 0;

  printf("Added source: %d\n", i);

  GstElement * rtpL16depay = gst_element_factory_make("rtpL16depay", NULL);
  GstPad * pad = gst_element_get_static_pad(rtpL16depay, "sink");

  GstElement * audioconvert = gst_element_factory_make("audioconvert", NULL);
  GstElement * alsacaps = gst_element_factory_make("capsfilter", NULL);
  //GstCaps * caps = gst_caps_from_string(g_strdup_printf(DEFAULT_AUDIO_CAPS,i+1));
  GstCaps * caps = gst_caps_from_string(DEFAULT_AUDIO_CAPS);
  g_object_set(alsacaps, "caps", caps, NULL);

  gst_bin_add_many(GST_BIN(pipeline), rtpL16depay, audioconvert, alsacaps, NULL);
  gst_pad_link(new_pad, pad);

  gst_element_link_many(rtpL16depay, audioconvert, alsacaps, NULL);

  //Read from the map
  guint ssrc = GPOINTER_TO_UINT(g_object_get_data(G_OBJECT(new_pad), "ssrc"));
  GString ssrcString = g_int_hash((void *) ssrc);
  guint index = (guint) g_hash_table_lookup(mapping, (void *)ssrcString);

  
  printf("ssrc %d\n", ssrc);
  printf("ssrcString %s\n", ssrcString);
  printf("index %d\n", index);

  pad = gst_element_get_static_pad(alsacaps, "src");
  GstPad * another_pad  = gst_element_get_static_pad(interleave, g_strdup_printf("sink_%u",index));
  gst_pad_link(pad, another_pad);

  gst_element_sync_state_with_parent(rtpL16depay);
  gst_element_sync_state_with_parent(audioconvert);
  gst_element_sync_state_with_parent(alsacaps);

  if(++i == nbr_of_streams) {
    GstPad * file_srcpad = gst_element_get_static_pad(output_selector, "src_1");
    g_object_set(output_selector, "active-pad", file_srcpad, NULL);
    gst_element_sync_state_with_parent(filesink);
    printf("Recording started\n");
  }

  //GST_DEBUG_BIN_TO_DOT_FILE(GST_BIN(pipeline), GST_DEBUG_GRAPH_SHOW_ALL, "pipeline_2");

  g_mutex_unlock(&mutex);
}



int main(int argc, char *argv[]) {

  GstClock *clock = NULL;
  GstElement *rtpbin = NULL;

  nbr_of_streams = atoi(argv[1]);

  gst_init (&argc, &argv);

  g_mutex_init(&mutex);


  mainloop = g_main_loop_new(NULL, FALSE);

  //Make the map
  mapping = g_hash_table_new (NULL, NULL);
  g_hash_table_insert(mapping, (void *)"200", (void *)0);
  g_hash_table_insert(mapping, (void *)"38", (void *)1);

  clock = gst_net_client_clock_new("net-clock",CLOCK_REMOTE_ADDRESS, CLOCK_REMOTE_PORT, 0);
  gst_clock_wait_for_sync(clock, 5000 * GST_MSECOND);

  pipeline = gst_pipeline_new(NULL);

  gst_pipeline_use_clock((GstPipeline *)pipeline, clock);
  gst_element_set_base_time(pipeline, 0);
  gst_element_set_start_time(pipeline, GST_CLOCK_TIME_NONE);

  interleave = gst_element_factory_make("interleave", NULL);
  rtpbin = gst_element_factory_make("rtpbin", NULL);
  filesink = gst_element_factory_make("filesink", NULL);

  output_selector = gst_element_factory_make("output-selector", NULL);
  GstElement * fakesink = gst_element_factory_make("fakesink", NULL);

  time_t mytime;
  mytime = time(NULL);

  g_object_set(filesink, "location", g_strdup_printf("./%s.raw", asctime(gmtime(&mytime))), NULL);
  gst_bin_add_many(GST_BIN(pipeline),rtpbin, interleave, output_selector, fakesink, filesink, NULL);
  gst_element_link_many(interleave, output_selector, fakesink, NULL);
  gst_element_link(output_selector, filesink);

  /* Sync-related stuff */
  g_object_set(rtpbin, "buffer-mode", 4, NULL);
  g_object_set(rtpbin, "ntp-time-source", 3, NULL);
  g_object_set(rtpbin, "ntp-sync", TRUE, NULL);

  int i;
  for(i = 0; i < nbr_of_streams; i++) {
    GstElement *rtpcaps = NULL;
    GstCaps *caps = NULL;
    rtpcaps = gst_element_factory_make("capsfilter", NULL);
    caps = gst_caps_from_string(DEFAULT_RTP_CAPS);
    g_object_set(rtpcaps, "caps", caps, NULL);

    GstElement * rtpsrc = gst_element_factory_make("udpsrc", NULL);
    GstElement * rtcpsrc = gst_element_factory_make("udpsrc", NULL);
    g_object_set(rtpsrc, "port", (RTP_PORT + i*2), NULL);
    g_object_set(rtcpsrc, "port", (RTP_PORT + i*2) + 1, NULL);

    gst_bin_add_many(GST_BIN(pipeline), rtpcaps, rtpsrc, rtcpsrc, NULL);

    gst_element_link(rtpsrc, rtpcaps);

    GstPad * rtp_sinkpad = gst_element_get_request_pad(rtpbin, "recv_rtp_sink_%u");
    GstPad * rtp_srcpad = gst_element_get_static_pad(rtpcaps, "src");
    gst_pad_link(rtp_srcpad, rtp_sinkpad);

    GstPad * rtcp_sinkpad = gst_element_get_request_pad(rtpbin, "recv_rtcp_sink_%u");
    GstPad * rtcp_srcpad = gst_element_get_static_pad(rtcpsrc, "src");
    gst_pad_link(rtcp_srcpad, rtcp_sinkpad);
    gst_element_get_request_pad(interleave, g_strdup_printf("sink_%u",i));
  }

  g_signal_connect(rtpbin, "pad-added",
  G_CALLBACK(on_rtpbin_pad_added), interleave);

  gst_element_set_state(pipeline, GST_STATE_PLAYING);

  //GST_DEBUG_BIN_TO_DOT_FILE(GST_BIN(pipeline), GST_DEBUG_GRAPH_SHOW_ALL, "pipeline");

  signal(SIGINT, signal_handler);

  g_main_loop_run(mainloop); /* wait for mainloop to be quit */

  //GST_DEBUG_BIN_TO_DOT_FILE(GST_BIN(pipeline), GST_DEBUG_GRAPH_SHOW_ALL, "pipeline_3");

  gst_element_set_state(pipeline, GST_STATE_NULL);

  return 0;
}
