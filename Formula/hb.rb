class Hb < Formula
  desc "HTTP Benchmark Tool"
  homepage "https://github.com/watawuwu/hb"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.5.0/hb-aarch64-apple-darwin.tar.xz"
      sha256 "7060f21fd5d73844f0ad476bf1a91081276389bef4f52e3b8511915c65e9b738"
    end
    if Hardware::CPU.intel?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.5.0/hb-x86_64-apple-darwin.tar.xz"
      sha256 "fcc871eae521ab39ede2fe2d93c0b1422ee07d054b2d530ea884ee3828e37342"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.5.0/hb-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3443da381a4779b9a52cec24476483812ec8c7d4a4b0a57a290357750d2f6717"
    end
    if Hardware::CPU.intel?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.5.0/hb-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7df171af961753828fd262e8c4a0d064f170d95eee2e1e4a5ede7c76168a5259"
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
