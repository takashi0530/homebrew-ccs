class Ccs < Formula
  desc "Cross-project session picker & resumer for Claude Code (fzf UI)"
  homepage "https://github.com/takashi0530/homebrew-ccs"
  url "https://github.com/takashi0530/homebrew-ccs/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "d584dd84245b90cf2b12b6285ff43554062ce8d9507ded068d9ad755ffaa3436"
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
