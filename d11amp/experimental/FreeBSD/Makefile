COMMENT=	Simple MP3 player

PORTNAME=	d11amp
PORTVERSION=	0.59
CATEGORIES=	audio
MASTER_SITES=	https://www.dettus.net/d11amp/
DISTNAME=	${PORTNAME}_${PORTVERSION}

MAINTAINER=	dettus@dettus.net

LICENSE=	BSD2CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE.txt

		
LIB_DEPENDS=	libmpg123.so:audio/mpg123 \
		libportaudio.so:audio/portaudio	\
		libzip.so:archivers/libzip
USES=		tar:bz2 pkgconfig gnome
USE_GNOME=	gdkpixbuf2 gtk40

TEST_ENV=	SHA256_CMD=sha256 TMP_DIR=/tmp/d11amp/
TEST_TARGET=	check

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/${PORTNAME} ${STAGEDIR}${PREFIX}/bin
	${INSTALL_MAN} ${WRKSRC}/d11amp.1 ${STAGEDIR}${PREFIX}/man/man1

.include <bsd.port.mk>
