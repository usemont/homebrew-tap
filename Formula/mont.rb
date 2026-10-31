class Mont < Formula
  desc "Native Mont video workflows (Developer Preview)"
  homepage "https://github.com/usemont/mont-cli"
  url "https://github.com/usemont/mont-cli/releases/download/v0.1.0-preview.5/mont-0.1.0-preview.5-darwin-arm64.tar.gz"
  sha256 "163be9ea22c2c1992019d693a1bcad6b7f95f8da14d9f8813f7f4a6f9372c72f"
  version "0.1.0-preview.5"
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
    system bin/"mont", "-C", testpath/"project-proof", "workflow", "run",
           pkgshare/"example/workflow.mont.json"
    system bin/"mont", "-C", testpath/"video-proof", "workflow", "run",
           pkgshare/"example/video-workflow.mont.json"
  end
end
