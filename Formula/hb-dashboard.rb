class HbDashboard < Formula
  desc "HTTP Benchmark Tool"
  homepage "https://github.com/watawuwu/hb"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/watawuwu/hb/releases/download/hb-dashboard-v0.1.2/hb-dashboard-aarch64-apple-darwin.tar.xz"
      sha256 "07aeb5fd4d4a22cef85ed9eeb4d6d21ec5c7e915c80c6b2b9250bddc02d72805"
    end
    if Hardware::CPU.intel?
      url "https://github.com/watawuwu/hb/releases/download/hb-dashboard-v0.1.2/hb-dashboard-x86_64-apple-darwin.tar.xz"
      sha256 "cb8271a1ac4b2b2430072d819947c6c3121eec59412e62e82bc3af5cd26de953"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/watawuwu/hb/releases/download/hb-dashboard-v0.1.2/hb-dashboard-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "46950ca670380a795fa1ae99714d1f1b1737a8a1e1a169dec4320b741df7678d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/watawuwu/hb/releases/download/hb-dashboard-v0.1.2/hb-dashboard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f2a3456bbaad961ad7cf258090f8449d506f7b525677ab9353a0f6827e61a325"
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
