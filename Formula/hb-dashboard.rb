class HbDashboard < Formula
  desc "HTTP Benchmark Tool"
  homepage "https://github.com/watawuwu/hb"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/watawuwu/hb/releases/download/hb-dashboard-v0.1.3/hb-dashboard-aarch64-apple-darwin.tar.xz"
      sha256 "f1bce68afed9c3c39c47673dd03cfdc4aeb8f9488dd873e9e40e73539cd9937b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/watawuwu/hb/releases/download/hb-dashboard-v0.1.3/hb-dashboard-x86_64-apple-darwin.tar.xz"
      sha256 "6c8b11271563e9ae3fe0617a79db714b27ac6743caf7498d22d060cfea53c696"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/watawuwu/hb/releases/download/hb-dashboard-v0.1.3/hb-dashboard-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7697be06ecd29bbe7b0b1d1b0ebfc1188f0f03647441e76e02230ce3f3b9ef7e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/watawuwu/hb/releases/download/hb-dashboard-v0.1.3/hb-dashboard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cf2ad37d3178f03e7111ac58596c511bcc37655d611c98aff6f58b49e98143ae"
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
