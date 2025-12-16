class Harbor < Formula
  desc "A lightweight macOS local dev tool that runs web projects without VMs or containers. It auto-sets local domains and trusted HTTPS, and can proxy services to custom URLs."
  homepage "https://github.com/nforst/harbor"
  url "https://github.com/nforst/harbor/archive/refs/tags/v1.0.7.tar.gz"
  sha256 "b9435c3c26f13d57696c9eade2f0ac2ac22bb4f807b2a34a52e062c143144335"
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
