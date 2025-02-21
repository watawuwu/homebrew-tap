class Hb < Formula
  desc "HTTP Benchmark Tool"
  homepage "https://github.com/watawuwu/hb"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.4.0/hb-aarch64-apple-darwin.tar.xz"
      sha256 "eaf0b5a001d82a35b4394377fe3ec563246138cab905dd03d26975198e31b483"
    end
    if Hardware::CPU.intel?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.4.0/hb-x86_64-apple-darwin.tar.xz"
      sha256 "5f3eea71c32ba7ab510795387b8941823a11c05052b5a86e86cb4e595931ce3c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.4.0/hb-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d5f14f13b42503ae4503ffcfc519d37fb2b6f292a15da148124c06199a1d4b42"
    end
    if Hardware::CPU.intel?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.4.0/hb-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2ddb64116c5cfa16ab76e16059983f6f1881387a0c702266fec75b97aa8de89a"
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
