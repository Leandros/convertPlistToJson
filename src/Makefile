CC			= clang
DEBUG		= -O3
CCFLAGS		= $(DEBUG) -Wall -Winline -pipe
LDFLAGS		= -framework Foundation

ifndef PREFIX
	PREFIX = /usr/local
endif
SRC			= convert.m JSONKit.m
OBJ			= $(SRC:.m=.o)
BINS		= $(SRC:.m=)
DSYM		= $(SRC:.m=.dSYM)
BINDIR		= $(PREFIX)/bin


.PHONY:		clean all install

convert:	convert.o jsonkit.o
	$(CC) $(LDFLAGS) -o convert $(OBJ)

convert.o:	convert.m
	$(CC) $(CCFLAGS) -c convert.m

jsonkit.o:	JSONKit.m JSONKit.h
	$(CC) $(CCFLAGS) -c JSONKit.m


all:		convert

install:	all
	install -d $(BINDIR)
	install convert $(BINDIR)

clean:
	rm -rf $(OBJ) *~ $(BINS) $(DSYM)
