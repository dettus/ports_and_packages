V=		0.59
REVISION=	1
COMMENT=	Simple MP3 player

DISTNAME=	d11amp_${V}
PKGNAME=	d11amp-${V}
EXTRACT_SUFX=	.tar.bz2
CATEGORIES=	audio

HOMEPAGE=	https://www.dettus.net/d11amp
MAINTAINER=	Thomas Dettbarn <dettus@dettus.net>

# BSD
PERMIT_PACKAGE=	YES


LIB_DEPENDS=	graphics/gdk-pixbuf2	\
		x11/gtk+4	\
		archivers/libzip	\
		audio/mpg123		\
		audio/portaudio-svn		
	
WANTLIB = c gtk-4 gdk_pixbuf-2.0 zip mpg123 portaudio

MASTER_SITES=	https://www.dettus.net/d11amp/
MAKE_FLAGS=	CC="${CC}" CFLAGS="${CFLAGS}"

TEST_ENV=	SHA256_CMD=sha256 TMP_DIR=/tmp/d11amp/
TEST_TARGET=	check


do-build:
	cd ${WRKBUILD} && pwd && make

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/d11amp ${PREFIX}/bin/d11amp
	${INSTALL_MAN} ${WRKSRC}/d11amp.1 ${PREFIX}/man/man1

.include <bsd.port.mk>


