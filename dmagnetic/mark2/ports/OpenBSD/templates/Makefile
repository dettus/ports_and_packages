COMMENT=	interpreter for Magnetic Scrolls games

V=		%%VERSIONNUMBERHERE%%
DISTNAME=	dMagnetic_${V}
PKGNAME=	dmagnetic-${V}
EXTRACT_SUFX=	.tar.bz2
CATEGORIES=	games

HOMEPAGE=	https://www.dettus.net/dMagnetic/
MAINTAINER=	Thomas Dettbarn <dettus@dettus.net>

# BSD
PERMIT_PACKAGE=	Yes

WANTLIB += c

MASTER_SITES=	https://www.dettus.net/dMagnetic/

MAKE_FLAGS=	CC="${CC}" CFLAGS="${CFLAGS}"

TEST_ENV=	SHA256_CMD=sha256
TEST_TARGET=	check

.include <bsd.port.mk>
