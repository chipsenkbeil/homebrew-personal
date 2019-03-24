class Notmuch < Formula
  desc "Thread-based email index, search, and tagging"
  homepage "https://notmuchmail.org"
  url "https://notmuchmail.org/releases/LATEST-notmuch-0.28.3.tar.gz"
  sha256 "4e212d8b4ae30da04edb05d836dcdb569488ff6760706cecb882488eb1710eec"
  head "git://notmuchmail.org/git/notmuch"

  # Re-enable installing with python3 bindings, which seems to be
  # missing from the stock repo formula
  option "with-python3", "Will build and install bindings for python3"

  depends_on "doxygen" => :build
  depends_on "libgpg-error" => :build
  depends_on "pkg-config" => :build
  depends_on "sphinx-doc" => :build
  depends_on "emacs"
  depends_on "glib"
  depends_on "gmime"
  depends_on "python@2"
  depends_on "talloc"
  depends_on "xapian"
  depends_on "zlib"

  # If we're installing the python3 bindings, we obviously
  # need to depend on python3 as well
  if build.with? "python3" then
    depends_on "python"
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --mandir=#{man}
      --with-emacs
      --emacslispdir=#{elisp}
      --emacsetcdir=#{elisp}
      --without-ruby
    ]

    # Emacs and parallel builds aren't friends
    ENV.deparallelize

    system "./configure", *args
    system "make", "V=1", "install"

    cd "bindings/python" do
      system "python2.7", *Language::Python.setup_install_args(prefix)

      # Install python3 bindings if indicated
      if build.with? "python3" then
        system "python3", *Language::Python.setup_install_args(prefix)
      end
    end
  end

  test do
    (testpath/".notmuch-config").write "[database]\npath=#{testpath}/Mail"
    (testpath/"Mail").mkpath
    assert_match "0 total", shell_output("#{bin}/notmuch new")
  end
end
