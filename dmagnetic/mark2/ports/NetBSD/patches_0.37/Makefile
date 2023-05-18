#!/usr/bin/make -f 
#
#Copyright 2023, dettus@dettus.net
#
#Redistribution and use in source and binary forms, with or without modification,
#are permitted provided that the following conditions are met:
#
#1. Redistributions of source code must retain the above copyright notice, this 
#   list of conditions and the following disclaimer.
#
#2. Redistributions in binary form must reproduce the above copyright notice, 
#   this list of conditions and the following disclaimer in the documentation 
#   and/or other materials provided with the distribution.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
#ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
#WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
#DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE 
#FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
#DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
#SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
#CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
#OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
#OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

PREFIX?=/usr/local
DESTDIR?=/usr/local
MYPREFIX=$(DESTDIR)$(PREFIX)
INSTALLBIN=$(MYPREFIX)/bin
INSTALLSHARE=$(MYPREFIX)/share/doc
INSTALLMAN=$(MYPREFIX)/man

CC?=gcc
AR?=ar
#CFLAGS=-g -O0
CFLAGS?=-O3
CFLAGS+=-Wall 
#CFLAGS+=-Werror
#CPPFLAGS+=-DEXPERIMENTAL_SAVEGAME_SLOTS
PROJ_HOME=./
INCFLAGS= -I$(PROJ_HOME)src/frontends/default/ -I$(PROJ_HOME)src/frontends -I$(PROJ_HOME)src/loader -I$(PROJ_HOME)src/libdmagnetic -I$(PROJ_HOME)src/libdmagnetic/vm68k -I$(PROJ_HOME)src/libdmagnetic/linea -I$(PROJ_HOME)src/libdmagnetic/include 
OBJDIR=$(PROJ_HOME)obj/
LINK=$(CC)
LDFLAGS+="-L"$(OBJDIR)

SOURCES_LOADER=	\
	src/loader/loader_appleii.c	\
	src/loader/loader_archimedes.c	\
	src/loader/loader_atarixl.c	\
	src/loader/loader_common.c	\
	src/loader/loader_d64.c		\
	src/loader/loader_dsk.c		\
	src/loader/loader_msdos.c	\
	src/loader/loader_mw.c		\
	src/loader/maggfxloader.c

SOURCES_LIBDMAGNETIC= \
	src/libdmagnetic/dMagnetic.c

SOURCES_LINEA=	\
	src/libdmagnetic/linea/gfxloader.c	\
	src/libdmagnetic/linea/linea.c

SOURCES_VM68K=	\
	src/libdmagnetic/vm68k/vm68k.c	\
	src/libdmagnetic/vm68k/vm68k_decode.c	\
	src/libdmagnetic/vm68k/vm68k_loadstore.c


SOURCES_FRONTEND=	\
	src/frontends/default/configuration.c	\
	src/frontends/default/default_callbacks.c	\
	src/frontends/default/default_palette.c	\
	src/frontends/default/default_render.c	\
	src/frontends/default/helpscreens.c	\
	src/frontends/default/main.c

OBJ_LOADER=${SOURCES_LOADER:.c=.o}
OBJ_ENGINE=${SOURCES_LIBDMAGNETIC:.c=.o}
OBJ_LINEA=${SOURCES_LINEA:.c=.o}
OBJ_VM68K=${SOURCES_VM68K:.c=.o}
OBJ_DEFAULT=${SOURCES_FRONTEND:.c=.o}


all:	dMagnetic dMagnetic.ini
#	strip dMagnetic

clean:
	rm -rf dMagnetic dMagnetic.ini libdmagnetic.a
	rm -rf $(OBJ_LOADER)
	rm -rf $(OBJ_ENGINE)
	rm -rf $(OBJ_LINEA)
	rm -rf $(OBJ_VM68K)
	rm -rf $(OBJ_DEFAULT)

install: all dMagnetic.6 dMagneticini.5
	install -m 755 -d $(INSTALLBIN)
	install -m 755 -d $(INSTALLMAN)/man5/
	install -m 755 -d $(INSTALLMAN)/man6/
	install -m 755 -d $(INSTALLSHARE)/dMagnetic/

	install -m 755 -s dMagnetic $(INSTALLBIN)/dMagnetic
	install -m 644 dMagneticini.5 $(INSTALLMAN)/man5/dMagneticini.5
	install -m 644 dMagnetic.6 $(INSTALLMAN)/man6/dMagnetic.6
	install -m 644 README.txt $(INSTALLDOC)/dMagnetic/README.txt
	install -m 644 LICENSE.txt $(INSTALLSHARE)/dMagnetic/LICENSE.txt
	cp dMagnetic.ini $(INSTALLSHARE)/dMagnetic/


dMagnetic:	$(OBJ_LOADER) $(OBJ_DEFAULT)  $(OBJ_ENGINE) $(OBJ_LINEA) $(OBJ_VM68K)
	$(LINK) $(LDFLAGS) -o $@ $(OBJ_LOADER)  $(OBJ_ENGINE) $(OBJ_LINEA) $(OBJ_VM68K) $(OBJ_DEFAULT)

dMagnetic.ini:	dMagnetic
	./dMagnetic -helpini >dMagnetic.ini

.c.o:
	$(CC) $(CPPFLAGS) $(CFLAGS) $(CFLAGS_EXTRA) $(INCFLAGS) -c -o $@ $<


# initial inkling for a dmagnetic backend library
libdmagnetic.a:	$(OBJ_ENGINE) $(OBJ_LINEA) $(OBJ_VM68K)
	$(AR) rs libdmagnetic.a $(OBJ_ENGINE) $(OBJ_LINEA) $(OBJ_VM68K)	


## in case some post-compilation checks are needed
## if not, please comment out this line
include ./checks.mk
