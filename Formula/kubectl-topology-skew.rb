class KubectlTopologySkew < Formula
  desc "kubectl plugin to display pod count and skew per topology"
  version "0.1.0"
  on_macos do
    on_arm do
      url "https://github.com/watawuwu/kubectl-topology-skew/releases/download/v0.1.0/kubectl-topology-skew-aarch64-apple-darwin.tar.xz"
      sha256 "f5c8a1c73dde18b1184e55345c73049581ccdc7c578d98fc5fb626ae881636eb"
    end
    on_intel do
      url "https://github.com/watawuwu/kubectl-topology-skew/releases/download/v0.1.0/kubectl-topology-skew-x86_64-apple-darwin.tar.xz"
      sha256 "c9b6c590b3d4611b4d4fc8da4f8717c75a8a9abff92881cebd7fba55e8f31376"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/watawuwu/kubectl-topology-skew/releases/download/v0.1.0/kubectl-topology-skew-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "56b071b0b32351bc85410f325b82ef5d087eee12a53788ae41c3a03931e33c6a"
    end
  end
  license "MIT OR Apache-2.0"

  def install
    on_macos do
      on_arm do
        bin.install "kubectl-topology_skew"
      end
    end
    on_macos do
      on_intel do
        bin.install "kubectl-topology_skew"
      end
    end
    on_linux do
      on_intel do
        bin.install "kubectl-topology_skew"
      end
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
