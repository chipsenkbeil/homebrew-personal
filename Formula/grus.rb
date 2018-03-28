class Grus < Formula
  desc "Static site generator written in Scala supporting ScalaTags & Markdown."
  homepage "https://get-grus.io"
  url "https://github.com/chipsenkbeil/grus/archive/v0.1.1.tar.gz"
  sha256 "b07d76c8d7972747f8d4b8e60cf069f78535d3f2583d8ab09f0bba7a8d3a43f1"
  head "https://github.com/chipsenkbeil/grus.git"

  depends_on "sbt" => "0.13.17"
  depends_on :java => "1.7+"

  def install
    ENV.java_cache
    system "sbt", "'+++2.11.8 assembly'"
    libexec.install "target/assembly/grus-0.1.1-2.11.8.jar"
    bin.write_jar_script libexec/"grus-0.1.1-2.11.8.jar", "grus"
  end

  test do
    cmd = "#{bin}/grus --version 2>&1"
    assert_match "0.1.1", shell_output(cmd, 1)
  end
end
