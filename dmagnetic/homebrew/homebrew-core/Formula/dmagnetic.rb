class Dmagnetic < Formula
  desc "Play classic textadventures by Magnetic Scrolls in a terminal"
  homepage "https://www.dettus.net/dMagnetic"
  url "https://www.dettus.net/dMagnetic/dMagnetic_0.21.tar.bz2"
  sha256 "32ab4e43aaa2521c71ceea2e26b62d4fbd46a749727e7537a0b38c9e98675e7d"

  def install
    system "make", "install"
  end
  test do
    system "true"
  end
end
