class Ccs < Formula
  desc "Cross-project session picker & resumer for Claude Code (fzf UI)"
  homepage "https://github.com/takashi0530/homebrew-ccs"
  url "https://github.com/takashi0530/homebrew-ccs/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "a3a120d054b8486dda6956f706c7d4b69beaa4b6837fd259175e08d58e160998"
  license "MIT"

  depends_on "fzf"
  depends_on "jq"

  def install
    bin.install "ccs"
  end

  test do
    assert_match "ccs 1.0.1", shell_output("#{bin}/ccs --version")
  end
end
