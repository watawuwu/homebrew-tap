class Hb < Formula
  desc "HTTP Benchmark Tool"
  homepage "https://github.com/watawuwu/hb"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.6.1/hb-aarch64-apple-darwin.tar.xz"
      sha256 "42d2f4f4b3eb3bac292e876f3c494430d339979cc882eb8102953dff453fff2e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.6.1/hb-x86_64-apple-darwin.tar.xz"
      sha256 "56a4a32e5002b241e7306a0975f0dc544e4e723959405c1aa3936ef106689d98"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.6.1/hb-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ac1e16db57099ad9478d6c8b52d3bdba3d6a8b69a4dab51ee42168212c7bd14d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.6.1/hb-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eb5e347189669235cc7db5c0012ff17e2bfb6eb6f8c296beae72531a12d9b936"
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
    bin.install "hb" if OS.mac? && Hardware::CPU.arm?
    bin.install "hb" if OS.mac? && Hardware::CPU.intel?
    bin.install "hb" if OS.linux? && Hardware::CPU.arm?
    bin.install "hb" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
