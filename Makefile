CC      := gcc
LD      := ld
LDFLAGS := -shared -fpic -lrt   -L../logger -llogger

TOP =..
OBJS =  hashmap.o 
TARGET:= libhashmap.so
#ARCH=arm


CFLAGS += -I$(TOP)/include -I../logger
CFLAGS += -I$(TOP)/src
CFLAGS += -pthread -D_GNU_SOURCE
CFLAGS += $(INCLUDE_PATH)
CFLAGS += -fPIC
CFLAGS += -DDEBUG
# Default architecture is x86
ARCH ?= x86

ifeq ($(ARCH),arm)
CFLAGS += -mtune=cortex-a8
CFLAGS += -mfpu=neon
CFLAGS += -ftree-vectorize
CFLAGS += -mfloat-abi=softfp
CFLAGS += -mcpu=arm9
CFLAGS += -DSCU_BUILD
endif



all:$(OBJS)
	$(LD) $(LDFLAGS) -o $(TARGET) $(OBJS) 

%.o:%.c
	$(CC) -c -o $@ $< $(CFLAGS)  

.PHONY:clean

clean:  
	@rm *.so *.o -rf

.PHONY:intall
install:
	@cp $(TARGET) /usr/scu/libs
                                      
