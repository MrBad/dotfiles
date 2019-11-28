INCLUDE=.
LIBS=-lX11
CC=gcc
OFLAGS=-c
CFLAGS=-g -Wall -Wextra -std=c99 -pedantic-errors -I$(INCLUDE)

TARGETS=tkstat tkstat_T60Libre
OBJECTS=tkstat.o tkstat_T60Libre.o

all: $(TARGETS)

tkstat: tkstat.o Makefile
	$(CC) $(CFLAGS) -o tkstat tkstat.o $(LIBS)

tkstat_T60Libre: tkstat_T60Libre.o Makefile
	$(CC) $(CFLAGS) -o tkstat_T60Libre tkstat_T60Libre.o $(LIBS)

%o: %.c Makefile *.h
	$(CC) $(CFLAGS) $(OFLAGS) -o $@ $<

install:
	cp $(TARGET) /usr/local/bin/

clean:
	rm $(OBJECTS) $(TARGETS)

