class Hb < Formula
  desc "HTTP Benchmark Tool"
  homepage "https://github.com/watawuwu/hb"
  version "0.6.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.6.2/hb-aarch64-apple-darwin.tar.xz"
      sha256 "c69a3bddd3975201e0eb9d895a830c5a595c217e147d433c174c18054bb59e1b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.6.2/hb-x86_64-apple-darwin.tar.xz"
      sha256 "f0d1b5959b99a63029f1705c7cf2b3fd84089e0d4e392ef2439081770b460049"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.6.2/hb-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9f66218a4d3ce279fd3df3be317c01a8bf36e54ae9813474677ab9662b5c4a84"
    end
    if Hardware::CPU.intel?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.6.2/hb-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c9d91ba11cbf70c75e195bdbb3ab6baae27edab660d37bce60e937997770e3b9"
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
