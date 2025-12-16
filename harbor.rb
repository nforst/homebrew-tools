class Harbor < Formula
  desc "A lightweight macOS local dev tool that runs web projects without VMs or containers. It auto-sets local domains and trusted HTTPS, and can proxy services to custom URLs."
  homepage "https://github.com/nforst/harbor"
  url "https://github.com/nforst/harbor/archive/refs/tags/v1.0.6.tar.gz"
  sha256 "6f6869bb454455499ed2022dcd90ec68b26a81c34d6ae60ae302068815b95061"
  license "ISC"

  depends_on "node"

  def install
    system "npm", "ci"
    system "npm", "run", "build"
    system "chmod", "+x", "dist/index.js"

    libexec.install Dir["*"]
    bin.install_symlink libexec/"dist/index.js" => "harbor"
  end

  def caveats
    <<~EOS
      To complete the installation, run:
        harbor install

      Before uninstalling, run:
        harbor uninstall
    EOS
  end

  test do
    system "#{bin}/harbor", "--help"
  end
end
