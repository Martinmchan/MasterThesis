PROG = receiver

PACKAGES = \
	glib-2.0 \
	gstreamer-1.0 \
	gstreamer-net-1.0

CFLAGS += -Wextra -Wall -Wno-error=missing-braces -Wno-error=missing-field-initializers

CFLAGS += $(shell pkg-config --cflags $(PACKAGES))
LDFLAGS += $(shell pkg-config --libs $(PACKAGES))

HEADERS = $(wildcard *.h)
SOURCES = $(wildcard *.c)
OBJECTS = $(patsubst %.c,%.o,$(SOURCES))

all : $(PROG)

$(PROG) : $(HEADERS) $(OBJECTS)
	$(CC) -o $@ $(OBJECTS) $(LDFLAGS)

%.o: %.c
	$(CC) -c $< $(CFLAGS) -o $@
