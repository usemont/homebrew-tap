class Mont < Formula
  desc "Native Mont video workflows (Developer Preview)"
  homepage "https://github.com/usemont/mont-cli"
  url "https://github.com/usemont/mont-cli/releases/download/v0.1.0-preview.8/mont-0.1.0-preview.8-darwin-arm64.tar.gz"
  sha256 "fb9eeb5b8186eff0404bf78baf0e422ae0541ff61179ed4e53d469753ead200a"
  version "0.1.0-preview.8"
  license :cannot_represent

  depends_on macos: :sonoma
  depends_on arch: :arm64
  depends_on "ffmpeg"

  def install
    bin.install "bin/mont"
    pkgshare.install "README.md", "TERMS.txt", "THIRD_PARTY_NOTICES.txt", "SBOM.json", "example"
  end

  test do
    assert_equal "mont #{version}", shell_output("#{bin}/mont --version").strip
    ENV["PATH"] = "#{Formula["ffmpeg"].opt_bin}:/usr/bin:/bin:/usr/sbin:/sbin"
    ENV["RENDER_WORKER_FFMPEG_PATH"] = (Formula["ffmpeg"].opt_bin/"ffmpeg").to_s
    ENV["RENDER_WORKER_FFPROBE_PATH"] = (Formula["ffmpeg"].opt_bin/"ffprobe").to_s
    system bin/"mont", "-C", testpath/"project-proof", "workflows", "run",
           pkgshare/"example/workflow.mont.json"
    system bin/"mont", "-C", testpath/"video-proof", "workflows", "run",
           pkgshare/"example/video-workflow.mont.json"
  end
end
