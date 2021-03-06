DIR_INC = ./include
DIR_SRC = ./src
DIR_LIB = ./lib
DIR_AUD = ${DIR_SRC}/audio
DIR_CARD = ${DIR_AUD}/card
DIR_CLI = ${DIR_SRC}/client
DIR_BUTTON = ${DIR_CLI}/button
DIR_FIFO = ${DIR_SRC}/fifo
DIR_TRS = ${DIR_SRC}/transport
DIR_LOG = ${DIR_LIB}/log
DIR_SOCKET = ${DIR_LIB}/socket
DIR_CFG = ${DIR_LIB}/cfg
DIR_OBJ = ./obj
DIR_TEST = ./test
INSTALL_PROGRAM = cp


SRC = $(wildcard ${DIR_SRC}/*.c ${DIR_LIB}/*.c ${DIR_AUD}/*.c ${DIR_CLI}/*.c ${DIR_TRS}/*.c ${DIR_LOG}/*.c ${DIR_SOCKET}/*.c ${DIR_BUTTON}/*.c ${DIR_CARD}/*.c ${DIR_FIFO}/*.c ${DIR_CFG}/*.c)
OBJ = $(patsubst %.c,${DIR_OBJ}/%.o,$(notdir ${SRC}))

TARGET = libIPinterCom.so

BIN_TARGET = ${TARGET}

CROSS_TOOLCHAIN = arm-hisiv400-linux-

ifdef CROSS_TOOLCHAIN
CC = ${CROSS_TOOLCHAIN}gcc
else
CC = gcc
endif

ifndef DESTDIR
	DESTDIR = .
endif

CFLAGS += -g -Wall -I${DIR_INC}

${BIN_TARGET}:${OBJ}
	$(CC) -shared -fPIC $(OBJ) $(LDFLAGS) $(CFLAGS) -o $@

#${DIR_OBJ}/%.o:${DIR_SRC}/%.c ${DIR_LIB}/%.c ${DIR_AUD}/%.c ${DIR_CLI}/%.c ${DIR_TRS}/%.c ${DIR_LOG}/%.c ${DIR_SOCKET}/%.c ${DIR_SOCKET}/%.c ${DIR_BUTTON}/%.c
#	$(CC) $(CFLAGS) $(LDFLAGS) -c  $< -o $@

${DIR_OBJ}/%.o:${DIR_SRC}/%.c
	$(CC) $(CFLAGS) $(LDFLAGS) -c  $< -o $@

${DIR_OBJ}/%.o:${DIR_LIB}/%.c
	$(CC) $(CFLAGS) $(LDFLAGS) -c  $< -o $@

${DIR_OBJ}/%.o:${DIR_AUD}/%.c
	$(CC) $(CFLAGS) $(LDFLAGS) -c $< -o $@

${DIR_OBJ}/%.o:${DIR_CLI}/%.c
	$(CC) $(CFLAGS) $(LDFLAGS) -c $< -o $@

${DIR_OBJ}/%.o:${DIR_TRS}/%.c
	$(CC) $(CFLAGS) $(LDFLAGS) -c $< -o $@

${DIR_OBJ}/%.o:${DIR_LOG}/%.c
	$(CC) $(CFLAGS) $(LDFLAGS) -c $< -o $@

${DIR_OBJ}/%.o:${DIR_SOCKET}/%.c
	$(CC) $(CFLAGS) $(LDFLAGS) -c $< -o $@

${DIR_OBJ}/%.o:${DIR_CFG}/%.c
	$(CC) $(CFLAGS) $(LDFLAGS) -c $< -o $@

${DIR_OBJ}/%.o:${DIR_SOCKET}/%.c
	$(CC) $(CFLAGS) $(LDFLAGS) -c $< -o $@

${DIR_OBJ}/%.o:${DIR_BUTTON}/%.c
	$(CC) $(CFLAGS) $(LDFLAGS) -c $< -o $@

${DIR_OBJ}/%.o:${DIR_CARD}/%.c
	$(CC) $(CFLAGS) $(LDFLAGS) -c $< -o $@

${DIR_OBJ}/%.o:${DIR_FIFO}/%.c
	$(CC) $(CFLAGS) $(LDFLAGS) -c $< -o $@

all:${BIN_TARGET}
	@echo $(SRC)
	@echo $(OBJ)
	@echo "end"


.PHONY:install clean
install:
	@echo "Installing to $(DESTDIR)$(INSTALL_PREFIX)/bin"
	@$(INSTALL_PROGRAM) -rf $(BIN_TARGET) $(DESTDIR)$(INSTALL_PREFIX)/bin
clean:
	rm -rf libIPinterCom.so ${DIR_OBJ}/*.o 
