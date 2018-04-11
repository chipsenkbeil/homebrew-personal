class Qes < Formula
  desc "Quartz Event Synthesizer "
  homepage "https://github.com/koekeishiya/qes"
  url "https://github.com/koekeishiya/qes/archive/ddedf008f0c38b134501ad9f328447b671423d34.zip"
  sha256 "0a323c8079548460bb6f0b95c84caa918e23e893fe54968bb6c5a05461c6f8b0"
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
