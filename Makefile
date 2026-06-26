CFLAGS = -Wall -O2 -fcommon -Wextra -Wno-missing-field-initializers
LDFLAGS = -lX11

BUILD = ./build

VPATH = src:.
OBJ = $(addprefix ${BUILD}/,\
      	main.o \
	temperature.o \
	datetime.o \
	cat.o \
	run_command.o \
	util.o \
	volume.o \
	cpu.o \
	disk.o \
	ram.o)

TARGET = dwmkb

all: ${BUILD} ${TARGET}

${TARGET}: ${OBJ} src/util.h src/status.h config.h
	${CC} ${CFLAGS} -o $@ ${OBJ} ${LDFLAGS}

${BUILD}/%.o: %.c
	${CC} ${CFLAGS} -c $< -o $@ ${LDFLAGS}

${BUILD}:
	mkdir -p $@

clean:
	rm -rf ${BUILD} ${TARGET}

install:
	chmod 755 dwmkb
	cp -f dwmkb /usr/local/bin/dwmkb

.PHONY: all clean install
