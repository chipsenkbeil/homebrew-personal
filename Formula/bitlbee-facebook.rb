class BitlbeeFacebook < Formula
  desc "Facebook protocol plugin for BitlBee "
  homepage "https://github.com/bitlbee/bitlbee-facebook"
  url "https://github.com/bitlbee/bitlbee-facebook/releases/download/v1.2.0/bitlbee-facebook-1.2.0.tar.gz"
  sha256 "be46e29af4c27cce4dab2249d23ce398c27ddecf9172ce2d4adf6f802a7c566a"
  head "https://github.com/bitlbee/bitlbee-facebook.git"

  # TODO: Should we make bitlbee a permanent dependency?
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "bitlbee" => :build

  depends_on "glib"
  depends_on "json-glib"

  # NOTE: Install and test from
  # https://github.com/unrevre/homebrew-ales/blob/master/Formula/bitlbee-facebook.rb
  def install
    system "./autogen.sh", "--disable-debug",
                           "--disable-dependency-tracking",
                           "--disable-silent-rules",
                           "--prefix=#{prefix}",
                           "--with-plugindir=#{prefix}/lib/bitlbee"
    system "make", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test bitlbee-facebook`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "true"
  end
end
