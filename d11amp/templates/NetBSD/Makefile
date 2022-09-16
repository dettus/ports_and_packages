# $NetBSD: Makefile,v 1.10 2021/06/24 07:28:54 wiz Exp $

DISTNAME=		d11amp_%%VERSIONNUM%%
PKGNAME=		${DISTNAME:S/_/-/}
CATEGORIES=		games
MASTER_SITES=		https://www.dettus.net/d11amp/
EXTRACT_SUFX=		.tar.bz2

MAINTAINER=		dettus@dettus.net
HOMEPAGE=		https://www.dettus.net/d11amp/
COMMENT=		MPG123 frontend
LICENSE=		2-clause-bsd

INSTALLATION_DIRS=	bin share/doc/d11amp #${PKGMANDIR}/man5 ${PKGMANDIR}/man6

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/d11amp ${DESTDIR}${PREFIX}/bin
	${INSTALL_DATA} ${WRKSRC}/README.txt ${DESTDIR}${PREFIX}/share/doc/d11amp

## The idea of this test is to check if the output is the expected one.
## for this, the md5sum is being compared.
## dMagnetic has several output modes, each one of them is tested.
#do-test:
#	cd ${WRKSRC} && ${MAKE} SHA256_CMD=sha256 check

.include "../../mk/bsd.pkg.mk"
