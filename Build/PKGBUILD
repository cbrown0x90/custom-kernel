pkgname=linux-ulm
pkgver=4.5.1
pkgrel=1
license=('GPL')
arch=('x86_64')
install=${pkgname}.install
source=("https://www.kernel.org/pub/linux/kernel/v4.x/linux-${pkgver}.tar.xz"
		"https://raw.githubusercontent.com/free-city-of-ulm/custom-kernel/master/Sources/${pkgver}.config"
		"https://raw.githubusercontent.com/free-city-of-ulm/custom-kernel/master/Sources/logo_linux_clut224.ppm"
		"https://raw.githubusercontent.com/free-city-of-ulm/custom-kernel/master/Sources/${pkgver}.preset")
md5sums=('488fac47d1c73e8a21ac71f7f3121009'
		'0e2436cf9c54f118b45e38ce45abe27c'
		'c1b7315081daa2ebec1548b2d6ded197'
		'35aa4396ff8c2cd1e2501db489c42668')
validpgpkeys=()

prepare() {
	cd "linux-$pkgver"
	cp "../logo_linux_clut224.ppm" drivers/video/logo/
	cp "../$pkgver.config" .config
}

build() {
	cd "linux-$pkgver"
	make
}

package() {
	cd "linux-$pkgver"
	mkdir -p "${pkgdir}"/lib/modules
	mkdir -p -m 777 "${pkgdir}"/boot/
	make INSTALL_MOD_PATH="${pkgdir}" modules_install
	cp arch/x86_64/boot/bzImage "${pkgdir}/boot/${pkgver}-ULM"
	install -D -m644 "${srcdir}/${pkgver}.preset" "${pkgdir}/etc/mkinitcpio.d/${pkgname}.preset"
}
