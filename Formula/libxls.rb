class Libxls < Formula
  desc "Library to support basic XLS imports"
  homepage "https://github.com/libxls/libxls"
  url "https://github.com/libxls/libxls/releases/download/v1.5.0/libxls-1.5.0.tar.gz"
  sha256 "c53a55187aeb0545e6fb5cfc89ad9521af80b1afc7eff407ac94c1bd59a64202"
  head "https://github.com/libxls/libxls.git", :branch => "master"

  def install
    system "./bootstrap" if build.head?
    system "./configure"
    system "make", "prefix=#{prefix}"
    system "make", "prefix=#{prefix}", "install"
  end

  test do
    output = pipe_output("#{bin}/xls2csv --version 2>/dev/null")
    assert_equal "2", output.lines.last.chomp
  end
end
