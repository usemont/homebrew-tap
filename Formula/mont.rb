class Mont < Formula
  desc "Native Mont video workflows (Developer Preview)"
  homepage "https://github.com/usemont/mont-cli"
  url "https://github.com/usemont/mont-cli/releases/download/v0.1.0-preview.2/mont-0.1.0-preview.2-darwin-arm64.tar.gz"
  sha256 "ca4a66c0368d05b073b43c61f72fcd029a18326d832afcdc8248abb119f425a9"
  version "0.1.0-preview.2"
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
    system "/usr/bin/python3", pkgshare/"example/workflow.py", "--mont", bin/"mont"
    system "/usr/bin/python3", pkgshare/"example/video_workflow.py",
           "--mont", bin/"mont", "--ffmpeg", Formula["ffmpeg"].opt_bin/"ffmpeg",
           "--ffprobe", Formula["ffmpeg"].opt_bin/"ffprobe", "--output", testpath/"video-proof"
  end
end
