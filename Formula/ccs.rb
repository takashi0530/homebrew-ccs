class Ccs < Formula
  desc "Cross-project session picker & resumer for Claude Code (fzf UI)"
  homepage "https://github.com/takashi0530/homebrew-ccs"
  url "https://github.com/takashi0530/homebrew-ccs/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "a62f58077d3b4ff1f598d74df2a8f34f22c6dc6a2e3ab7a79288512bf8e9dcb2"
  license "MIT"

  depends_on "fzf"
  depends_on "jq"

  def install
    bin.install "ccs"
  end

  test do
    assert_match "ccs 1.2.0", shell_output("#{bin}/ccs --version")
  end
end
