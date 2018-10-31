class Calcurse < Formula
  desc "Text-based personal organizer"
  homepage "https://calcurse.org/"
  url "https://calcurse.org/files/calcurse-4.3.0.tar.gz"
  sha256 "31ecc3dc09e1e561502b4c94f965ed6b167c03e9418438c4a7ad5bad2c785f9a"
  head "git://git.calcurse.org/calcurse.git"

  bottle do
    sha256 "c3f0fc356930d24114a2ef1c16679f1184ba60a4f5bb888b822f6a343f7ae5b5" => :mojave
    sha256 "0fbabcf326ec92cf28ec57ff76f77e1a6fa41217f7d11ef5090c18b7bfc5b8aa" => :high_sierra
    sha256 "0a4237919a02a48d0c661ae43a4da579c69bf826921af07d14d9ade6f835374a" => :sierra
    sha256 "4cca241225bacb88ffd8c9f97e8c7b4027068551523f07874975362995eacf54" => :el_capitan
  end

  # NOTE: calcurse-caldav depends on python 3 and httplib2

  depends_on "gettext"

  if build.head? then
    # For documentation
    depends_on "asciidoc" => :build

    # For general building
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  def install
    if build.head? then
      system "./autogen.sh"

      # NOTE: There is some bug with documentation generation in HEAD where
      #       xmllint fails to validate calcurse.1.xml
      system "./configure",
        "--disable-docs",
        "--disable-dependency-tracking",
        "--prefix=#{prefix}"
    else
      system "./configure",
        "--disable-dependency-tracking",
        "--prefix=#{prefix}"
    end

    system "make"
    system "make", "install"
  end

  test do
    system bin/"calcurse", "-v"
    system bin/"calcurse-caldav", "-v"
  end
end
