class ScalaDebugger < Formula
  desc "Scala libraries and tooling to debug Java and Scala code."
  homepage "https://www.scala-debugger.org/"
  url "https://github.com/ensime/scala-debugger/archive/v1.1.0-M3-2.tar.gz"
  sha256 "af64bda20e440ffb3eeadec449b234f8db324ee9e09b7db5e3dfa2c3a7beb3c6"

  depends_on "sbt" => :build
  depends_on :java => "1.7+"

  def install
    system "sbt", "scalaDebuggerTool/assembly"
    libexec.install "scala-debugger-tool/target/scala-2.10/sdb-1.1.0-M3-2.10.jar"
    bin.write_jar_script libexec/"sdb-1.1.0-M3-2.10.jar", "sdb"
  end

  test do
    cmd = "#{bin}/sdb --help 2>&1"
    assert shell_output(cmd, 1)
  end
end
