class Muchsync < Formula
  desc "Brings notmuch to all of your computers by synchronizing your mail messages and notmuch tags across machines."
  homepage "http://www.muchsync.org/"
  url "http://www.muchsync.org/src/muchsync-5.tar.gz"
  sha256 "8b0afc2ce2dca636ae318659452902e26ac804d1b8b1982e74dbc4222f2155cc"
  head "http://www.muchsync.org/muchsync.git"

  # Needed for configuration
  depends_on "pkg-config" => :build

  # For notmuch & Xapian libray
  depends_on "notmuch"

  # General dependency on database according to instructions
  depends_on "sqlite3" => :build

  # For libcypto
  # export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"
  depends_on "openssl" => :build

  def install
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["sqlite3"].opt_libexec/"lib/pkgconfig"
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["openssl"].opt_libexec/"lib/pkgconfig"
    ENV.prepend_create_path "PKG_CONFIG_PATH", lib/"pkgconfig"

    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    cmd = "#{bin}/muchsync --version 2>&1"
    assert_match "muchsync 5", shell_output(cmd, 1)
  end
end
