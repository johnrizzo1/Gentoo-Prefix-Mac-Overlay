# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

#inherit eutils wxwidgets
#inherit flag-o-matic
#strip-flags
#append-flags "-pipe -O3 -fomit-frame-pointer -finline-functions -falign-loops=16 -falign-jumps=16 -falign-functions=16 -falign-labels=16 -falign-loops-max-skip=15 -falign-jumps-max-skip=15 -fprefetch-loop-arrays"

DESCRIPTION="a LGPL-ed pc emulator"
HOMEPAGE="http://bochs.sourceforge.net/"
SRC_URI="mirror://sourceforge/bochs/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""
#IUSE="X debugger readline usb wxwidgets svga sdl ncurses vnc acpi"

#RDEPEND="X? ( x11-libs/libICE
		#x11-libs/libSM
		#x11-libs/libX11
		#x11-libs/libXpm )
	#sdl? ( media-libs/libsdl )
	#svga? ( media-libs/svgalib )
	#wxwidgets? ( =x11-libs/wxGTK-2.8* )
	#readline? ( sys-libs/readline )
	#ncurses? ( sys-libs/ncurses )"

#DEPEND="${RDEPEND}
	#X? ( x11-proto/xproto )
	#>=sys-apps/sed-4"
	#>=app-text/opensp-1.5"

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}"
}

		#--prefix=/Users/jrizzo/gentoo/usr \
src_compile() {
#CFLAGS="-pipe -O3 -I/sw/include -fomit-frame-pointer -finline-functions
#-falign-loops=16 -falign-jumps=16 -falign-functions=16 -falign-labels=16
#-falign-loops-max-skip=15 -falign-jumps-max-skip=15 -fprefetch-loop-arrays
#$CFLAGS"
	#	--enable-usb \
	econf \
		--enable-all-optimizations \
		--enable-clgd54xx \
		--enable-ne2000 \
		--enable-sb16 \
		--enable-plugins \
		--enable-pci \
		--enable-cpu-level=6 \
		--enable-x86-64 \
		--with-sdl \
		--enable-acpi \
		--with-nogui \
		|| die "econf failed"
	
	emake || die "emake failed"
}

src_install() {
	#make DESTDIR="${D}" install unpack_dlx || die "make install failed"

	# workaround
	make install #install_dlx

	dodoc \
		CHANGES \
		PARAM_TREE.txt \
		README \
		README-plugins \
		TESTFORM.txt \
		TODO || \
		die "doco failed"

	#if [ use vnc ]
	#then
		#dodoc README.rfb || die "dodoc failed"
	#fi

	#if [ use wxwidgets ]
	#then
		#dodoc README-wxWindows || die "dodoc failed"
	#fi
}
