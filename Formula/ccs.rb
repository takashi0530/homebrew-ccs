class Ccs < Formula
  desc "Cross-project session picker & resumer for Claude Code (fzf UI)"
  homepage "https://github.com/takashi0530/homebrew-ccs"
  url "https://github.com/takashi0530/homebrew-ccs/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "b9600b752023b995df835a80683267f4604dea8c55540b3456a8b6177b782474"
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
