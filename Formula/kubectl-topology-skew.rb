class KubectlTopologySkew < Formula
  desc "kubectl plugin to display pod count and skew per topology"
  version "0.2.0"
  on_macos do
    on_arm do
      url "https://github.com/watawuwu/kubectl-topology-skew/releases/download/v0.2.0/kubectl-topology-skew-aarch64-apple-darwin.tar.xz"
      sha256 "6b88f227b1cfb33fabf4de1b0f8083a959e82572423a04619ee8791de8ed3f13"
    end
    on_intel do
      url "https://github.com/watawuwu/kubectl-topology-skew/releases/download/v0.2.0/kubectl-topology-skew-x86_64-apple-darwin.tar.xz"
      sha256 "daa216929260b49a714af57a2df0bdd07b878afa258f5cdcf47c0a639cb61a09"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/watawuwu/kubectl-topology-skew/releases/download/v0.2.0/kubectl-topology-skew-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2db3341ffb392fc2773ba0d19149b87ec670e24e2b77191358de9099480d7ae6"
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
