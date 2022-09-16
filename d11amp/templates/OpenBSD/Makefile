V =		%%VERSIONNUM%%
COMMENT =	frontend for MPG123
DISTNAME =	d11amp_${V}
PKGNAME =	d11amp-${V}
EXTRACT_SUFX =	.tar.bz2
CATEGORIES =	games

HOMEPAGE =	https://www.dettus.net/d11amp/
MAINTAINER =	Thomas Dettbarn <dettus@dettus.net>

# BSD
PERMIT_PACKAGE =	Yes

WANTLIB += c

MASTER_SITES =	https://www.dettus.net/d11amp/

MAKE_FLAGS =	CC="${CC}" CFLAGS="${CFLAGS}"

TEST_ENV =	SHA256_CMD=sha256
TEST_TARGET =	check

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/d11amp ${PREFIX}/bin/d11amp
	${INSTALL_DATA} ${WRKSRC}/LICENSE.txt ${PREFIX}/share/d11amp
	${INSTALL_DATA} ${WRKSRC}/README.txt ${PREFIX}/share/d11amp

.include <bsd.port.mk>
