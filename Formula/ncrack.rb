class Ncrack < Formula
  desc "Network authentication cracking tool"
  homepage "https://nmap.org/ncrack/"
  url "https://github.com/nmap/ncrack/archive/v0.6.0.tar.gz"
  sha256 "676a323b1e9066193461f25e31445262bae495fde7dfcaf56555c3056dae24cc"
  head "https://github.com/nmap/ncrack.git"

  bottle do
    sha256 "3238195981e41fa370773424e84259ab50504d21974498c83be208f1c229532a" => :high_sierra
    sha256 "7e3a16f3b37949e91338e50f2e2cd1f50da7f3b1700b8ef242ce457673d3c397" => :sierra
    sha256 "aab525771a1fb8eee4d2aab1d9164482b62cef6664ff3f2a8034b4171207be6c" => :el_capitan
    sha256 "dbaa016ba2cb398e4e7da7352ca889fd5f26bd91926549badd9d80227cf1f5b4" => :yosemite
  end

  depends_on "openssl"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_match version.to_f.to_s, shell_output(bin/"ncrack --version")
  end
end
