/*
 * Copyright (C) 2017  Axis Communications AB
 */

#include <netclock_conf.h>
#include <gst/net/gstnet.h>
#include <supermain.h>
#define MAX_PORT G_MAXUINT16

typedef struct _NetclkContext { /* extends */ SuperContext super;
  AJ_NetclockConf clk;
  GstNetTimeProvider * time_provider;
} NetclkContext;

/* called when the process receives a signal */
static void
signal_handler(gint signo, NetclkContext *ctx)
{
  ax_warning("Received %s (%d) and will terminate.", strsignal(signo), signo);
  return_from_supermain(EXIT_SUCCESS);
}

/* called when options parsed, file read, validated settings */
gboolean
netclk_context_init(NetclkContext *ctx, json_t * settings) {
  AJ_NetclockConf * clk = &ctx->clk;
  netclock_conf_parse_json(settings, clk); /* already validated will be ok. */

  /* compute port form filename */
  gchar * basename = g_path_get_basename (ctx->super.opt_settings_file);
  gchar *end;
  clk->port = g_ascii_strtoll(basename, &end, 10);
  if (errno == ERANGE || g_strcmp0(end, ".json") != 0 ||
      clk->port <= 0 || clk->port > MAX_PORT) {
    ax_error("Failed to convert: %s", basename);
    g_free(basename);
    return FALSE;
  }
  g_free(basename);

  /* start main logic */
  ax_info("Starting GstNetTimeProvider on port:%d", clk->port);
  ctx->time_provider =
    gst_net_time_provider_new(gst_system_clock_obtain(), NULL, clk->port);
  if (!ctx->time_provider) {
    ax_warning("couldnt instantiate GstNetTimeProvider");
    return FALSE;
  }
  if (clk->qos >= 0) {
    /* FIXME only works if patch available in gstreamer! */
    g_object_set(ctx->time_provider, "qos-dscp", clk->qos, NULL);
  }
  return TRUE;
}

static void
netclk_context_free(NetclkContext *ctx) {
  if (ctx->time_provider) gst_object_unref(ctx->time_provider); // not null safe
  super_context_destroy(&ctx->super);
  g_free(ctx);
}

/* called when the settings are updated, and validated. */
static gboolean /* TRUE for "settings are now in effect", FALSE => need restart */
netclk_settings_changed(G_GNUC_UNUSED NetclkContext *ctx, G_GNUC_UNUSED json_t * settings) {
  /* we cannot apply anything at runtime in this service. */
  return FALSE; /* Couldn't do it, pls restart */
}

int
main(int argc, char **argv)
{
  if (!gst_is_initialized())
    gst_init(NULL, NULL);
  /* Create a type which extends SuperContext, set function pointers, go! */
  NetclkContext *ctx = g_new0(NetclkContext, 1);
  ctx->super.parse_options    = parse_cmd_opts; /* use default implementation */
  ctx->super.validate         = validate_netclk_conf;
  ctx->super.init             = (JsonFn) netclk_context_init;
  ctx->super.settings_changed = (JsonFn) netclk_settings_changed;
  ctx->super.signal_handler   = (SignalFn) signal_handler;
  int result = supermain((SuperContext *) ctx, argc, argv); /* running main loop */
  netclk_context_free(ctx);
  return result;
}