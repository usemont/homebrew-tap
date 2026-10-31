class Mont < Formula
  desc "Native Mont video workflows (Developer Preview)"
  homepage "https://github.com/usemont/mont-cli"
  url "https://github.com/usemont/mont-cli/releases/download/v0.1.0-preview.7/mont-0.1.0-preview.7-darwin-arm64.tar.gz"
  sha256 "7aef3fd9a680cbbefdbb43cbfa673cba78b31ebd4ea222c5c5a959c47ec55194"
  version "0.1.0-preview.7"
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
