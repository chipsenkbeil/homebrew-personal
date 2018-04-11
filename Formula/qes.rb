class Qes < Formula
  desc "Quartz Event Synthesizer "
  homepage "https://github.com/koekeishiya/qes"
  url "https://github.com/koekeishiya/qes/archive/ddedf008f0c38b134501ad9f328447b671423d34.zip"
  sha256 "bd34dd3f858d6d47fe10d60dd4c73b6670bb486d1dd2d56fdf49ad5c1b140811"
  head "https://github.com/koekeishiya/qes.git"
  version "0.0.2"

  option "with-debug" "Will build the debug version of qes"

  def install
    if build.with? "debug" then
      system "make"
    else
      system "make", "install"
    end

    bin.install "bin/qes"
  end

  test do
    cmd = "#{bin}/qes -v 2>&1"
    assert_match "qes version 0.0.2", shell_output(cmd, 1)
  end
end
