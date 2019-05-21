# Created by: Thomas Dettbarn
# $Id$

PORTNAME=	dMagnetic
PORTVERSION=	0.12
CATEGORIES=	games
MASTER_SITES=	http://www.dettus.net/dMagnetic/
DISTNAME=	${PORTNAME}_${PORTVERSION}

MAINTAINER=	dettus@dettus.net
COMMENT=	A Magnetic Scrolls Interpreter

LICENSE=	BSD2CLAUSE

USES=		
MANPAGE1=	dMagnetic.1
MANPAGE5=	dMagneticini.5
DOC1=		README.txt
DOC2=		LICENSE.txt
DOC3=		dMagnetic.ini

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/${PORTNAME} ${STAGEDIR}${PREFIX}/bin
	${INSTALL_MAN} ${WRKSRC}/${MANPAGE1} ${STAGEDIR}${MANPREFIX}/man/man1
	${INSTALL_MAN} ${WRKSRC}/${MANPAGE5} ${STAGEDIR}${MANPREFIX}/man/man5
	${INSTALL_DATA_DIR} ${$TAGEDIR}${DATAPREFIX}/dMagnetic
	${INSTALL_DATA} ${WRKSRC}/${DOC1} ${STAGEDIR}${DATAPREFIX}/dMagnetic
	${INSTALL_DATA} ${WRKSRC}/${DOC2} ${STAGEDIR}${DATAPREFIX}/dMagnetic
	${INSTALL_DATA} ${WRKSRC}/${DOC3} ${STAGEDIR}${DATAPREFIX}/dMagnetic

.include <bsd.port.mk>
