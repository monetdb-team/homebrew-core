class Upx < Formula
  desc "Compress/expand executable files"
  homepage "https://upx.github.io/"
  url "https://github.com/upx/upx/releases/download/v4.2.4/upx-4.2.4-src.tar.xz"
  sha256 "5ed6561607d27fb4ef346fc19f08a93696fa8fa127081e7a7114068306b8e1c4"
  license "GPL-2.0-or-later"
  head "https://github.com/upx/upx.git", branch: "devel"

  bottle do
    sha256 cellar: :any_skip_relocation, monterey: "db18963055dd657d579824a7daaf69f79e1639a10fd1accb399e84ddcd5d649c"
    sha256 cellar: :any_skip_relocation, big_sur:  "8e6aa21f689985270ff1cc3857ef9848f63f3c79a96604884ee846ce76e6401b"
  end

  depends_on "cmake" => :build
  depends_on "ucl" => :build

  uses_from_macos "zlib"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"upx", "-1", "-o", "./hello", test_fixtures("elf/hello")
    assert_path_exists testpath/"hello"
    system bin/"upx", "-d", "./hello"
  end
end
