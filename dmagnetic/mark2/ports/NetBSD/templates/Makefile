# $NetBSD: Makefile,v 1.10 2021/06/24 07:28:54 wiz Exp $

DISTNAME=		dMagnetic_%%VERSIONNUMBERHERE%%
PKGNAME=		${DISTNAME:S/_/-/}
CATEGORIES=		games
MASTER_SITES=		https://www.dettus.net/dMagnetic/
EXTRACT_SUFX=		.tar.bz2

MAINTAINER=		dettus@dettus.net
HOMEPAGE=		https://www.dettus.net/dMagnetic/
COMMENT=		Magnetic Scrolls Interpreter
LICENSE=		2-clause-bsd

INSTALL_MAKE_FLAGS=	INSTALL_MAKE_FLAGS=     MYPREFIX="${DESTDIR}${PREFIX}"
INSTALLATION_DIRS=	bin share/doc/dMagnetic ${PKGMANDIR}/man5 ${PKGMANDIR}/man6

## The idea of this test is to check if the output is the expected one.
## for this, the sha256sum is being compared.
## dMagnetic has several output modes, each one of them is tested.
do-test:
	cd ${WRKSRC} && ${MAKE} SHA256_CMD=sha256 check

.include "../../mk/bsd.pkg.mk"
