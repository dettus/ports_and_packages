# Created by: Thomas Dettbarn
# $Id$

PORTNAME=	dMagnetic
PORTVERSION=	0.13
CATEGORIES=	games
MASTER_SITES=	http://www.dettus.net/dMagnetic/
DISTNAME=	${PORTNAME}_${PORTVERSION}

MAINTAINER=	dettus@dettus.net
COMMENT=	A Magnetic Scrolls Interpreter

LICENSE=	BSD2CLAUSE

USES=		
MANPAGE1=	dMagnetic.1
MANPAGE5=	dMagneticini.5
DATADIR=	${PREFIX}/share/dMagnetic/
DATA1=		README.txt
DATA2=		LICENSE.txt
DATA3=		dMagnetic.ini


do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/${PORTNAME} ${STAGEDIR}${PREFIX}/bin
	${INSTALL_MAN} ${WRKSRC}/${MANPAGE1} ${STAGEDIR}${MANPREFIX}/man/man1
	${INSTALL_MAN} ${WRKSRC}/${MANPAGE5} ${STAGEDIR}${MANPREFIX}/man/man5
	${MKDIR} ${STAGEDIR}/${DATADIR}
	${INSTALL_DATA} ${WRKSRC}/${DATA1} ${STAGEDIR}/${DATADIR}
	${INSTALL_DATA} ${WRKSRC}/${DATA2} ${STAGEDIR}/${DATADIR}
	${INSTALL_DATA} ${WRKSRC}/${DATA3} ${STAGEDIR}/${DATADIR}


.include <bsd.port.mk>
