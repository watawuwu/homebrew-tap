class HbDashboard < Formula
  desc "HTTP Benchmark Tool Dashboard"
  homepage "https://github.com/watawuwu/hb"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/watawuwu/hb/releases/download/hb-dashboard-v0.1.4/hb-dashboard-aarch64-apple-darwin.tar.xz"
      sha256 "41f0e0657b4c5b4e6f291fea502a48894200889b8ed0830c8f9b6abd46baa341"
    end
    if Hardware::CPU.intel?
      url "https://github.com/watawuwu/hb/releases/download/hb-dashboard-v0.1.4/hb-dashboard-x86_64-apple-darwin.tar.xz"
      sha256 "9e008cdeea55e60b7e87234d429e66b1ea2170e9d39f94934674a9b8a1369bb8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/watawuwu/hb/releases/download/hb-dashboard-v0.1.4/hb-dashboard-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6740a5955675efe18e3d08ad74deb82d7b35c349d204a8e1269284d242c39f97"
    end
    if Hardware::CPU.intel?
      url "https://github.com/watawuwu/hb/releases/download/hb-dashboard-v0.1.4/hb-dashboard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ff985f69c6648458556ef56340b95b2ac572219b4ba8860ecb60e9bfd84bf1f3"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "hb-dashboard" if OS.mac? && Hardware::CPU.arm?
    bin.install "hb-dashboard" if OS.mac? && Hardware::CPU.intel?
    bin.install "hb-dashboard" if OS.linux? && Hardware::CPU.arm?
    bin.install "hb-dashboard" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
