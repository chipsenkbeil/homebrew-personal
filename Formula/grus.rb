class Grus < Formula
  desc "Static site generator written in Scala supporting ScalaTags & Markdown."
  homepage "https://get-grus.io"
  url "https://github.com/chipsenkbeil/grus/archive/v0.1.0-assembly.tar.gz"
  sha256 "f3e66acebdae379c85356f53055363cd3c4a7ea5ca9deeba27063a5a8126f6c4"
  head "https://github.com/chipsenkbeil/grus.git"

  depends_on "sbt" => :build
  depends_on :java => "1.7+"

  def install
    ENV.java_cache
    system "sbt", "assembly"
    libexec.install "target/assembly/grus-0.1.0-2.10.6.jar"
    bin.write_jar_script libexec/"grus-0.1.0-2.10.6.jar", "grus"
  end

  test do
    cmd = "#{bin}/grus --version 2>&1"
    assert_match "0.1.0", shell_output(cmd, 1)
  end
end
