class Ccs < Formula
  desc "Cross-project session picker & resumer for Claude Code (fzf UI)"
  homepage "https://github.com/takashi0530/homebrew-ccs"
  url "https://github.com/takashi0530/homebrew-ccs/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "849d26de347bf079afd0dc19a91c37014ede26cce46bd31d478bbd1a68a7e4ca"
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
