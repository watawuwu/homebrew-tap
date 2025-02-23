class Hb < Formula
  desc "HTTP Benchmark Tool"
  homepage "https://github.com/watawuwu/hb"
  version "0.6.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.6.3/hb-aarch64-apple-darwin.tar.xz"
      sha256 "cd9498a3d121d45578639e7e85c1d16b1f9c9d42e7fc805b18189573f2b70990"
    end
    if Hardware::CPU.intel?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.6.3/hb-x86_64-apple-darwin.tar.xz"
      sha256 "98e1ca65401cd7e058e05d4fd4310450aef652f9af0e5691ae5554391152858e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.6.3/hb-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "479490a61bdaa66f0192c17b045ed2c4d32397aedf44f18635760322ad3cb378"
    end
    if Hardware::CPU.intel?
      url "https://github.com/watawuwu/hb/releases/download/hb-v0.6.3/hb-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a0d9168c3a00991867f0bd19896b19ade774e89f9d30987da9c1f71f79df0530"
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
