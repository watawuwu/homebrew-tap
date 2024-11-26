class PrometheusSeriesDiff < Formula
  homepage "https://github.com/watawuwu/prometheus-series-diff"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/watawuwu/prometheus-series-diff/releases/download/v0.1.2/prometheus-series-diff-aarch64-apple-darwin.tar.xz"
      sha256 "e527de46b2226229d7fb9eec4abde4e11afe252b4a63b0479119527f78c02662"
    end
    if Hardware::CPU.intel?
      url "https://github.com/watawuwu/prometheus-series-diff/releases/download/v0.1.2/prometheus-series-diff-x86_64-apple-darwin.tar.xz"
      sha256 "f8919644c8dbface2f5a1283cf0e4aaa2fde894f9c69a253c70b0ecc7d0fe1a1"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/watawuwu/prometheus-series-diff/releases/download/v0.1.2/prometheus-series-diff-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "9cded35c8d05b4f0d43ca51a3dfa0fd8f41cfae9d61a84307c4b396ab3b4dc3b"
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-unknown-linux-gnu": {},
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
    bin.install "prometheus-series-diff" if OS.mac? && Hardware::CPU.arm?
    bin.install "prometheus-series-diff" if OS.mac? && Hardware::CPU.intel?
    bin.install "prometheus-series-diff" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
