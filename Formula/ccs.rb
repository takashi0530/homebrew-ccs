class Ccs < Formula
  desc "Cross-project session picker & resumer for Claude Code (fzf UI)"
  homepage "https://github.com/takashi0530/homebrew-ccs"
  url "https://github.com/takashi0530/homebrew-ccs/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "7b3cf0e47307af9432a472f8082300dac59de8293b2cf308f088c079ccad07ec"
  license "MIT"

  depends_on "fzf"
  depends_on "jq"

  def install
    bin.install "ccs"
  end

  test do
    assert_match "ccs 1.1.0", shell_output("#{bin}/ccs --version")
  end
end
