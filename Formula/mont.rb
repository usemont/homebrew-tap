class Mont < Formula
  desc "Native Mont project workspaces (Developer Preview)"
  homepage "https://github.com/usemont/mont-cli"
  url "https://github.com/usemont/mont-cli/releases/download/v0.1.0-preview.1/mont-0.1.0-preview.1-darwin-arm64.tar.gz"
  sha256 "36b61bffd4852758154338e104d51039f72bd676c7027180aed95d97fb6715c9"
  version "0.1.0-preview.1"
  license :cannot_represent

  depends_on macos: :sonoma
  depends_on arch: :arm64

  def install
    bin.install "bin/mont"
    pkgshare.install "README.md", "TERMS.txt", "THIRD_PARTY_NOTICES.txt", "SBOM.json", "example"
  end

  test do
    assert_match "mont #{version}", shell_output("#{bin}/mont --version")
    system bin/"mont", "init", testpath/"project", "--project-id", "homebrew-mont-preview"
    system bin/"mont", "-C", testpath/"project", "validate"
  end
end
