PORTNAME=	d11amp
DISTVERSION=	%%VERSIONNUMBERHERE%%
CATEGORIES=	audio
MASTER_SITES=	https://www.dettus.net/d11amp/
DISTNAME=	${PORTNAME}_${DISTVERSION}

MAINTAINER=	dettus@dettus.net
COMMENT=	Oldskool MP3 player
WWW=		https://www.dettus.net/d11amp/

LICENSE=	BSD2CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE.txt

LIB_DEPENDS=	libmpg123.so:audio/mpg123 \
		libportaudio.so:audio/portaudio	\
		libzip.so:archivers/libzip

USES=		gnome pkgconfig tar:bz2
USE_GNOME=	cairo gdkpixbuf2 gtk40

PLIST_FILES=	bin/d11amp	\
		man/man1/d11amp.1.gz

TEST_ENV=	SHA256_CMD=sha256 TMP_DIR=/tmp/d11amp/
TEST_TARGET=	check

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/${PORTNAME} ${STAGEDIR}${PREFIX}/bin
	${INSTALL_MAN} ${WRKSRC}/d11amp.1 ${STAGEDIR}${PREFIX}/man/man1

.include <bsd.port.mk>
