class Harbor < Formula
  desc "A lightweight macOS local dev tool that runs web projects without VMs or containers. It auto-sets local domains and trusted HTTPS, and can proxy services to custom URLs."
  homepage "https://github.com/nforst/harbor"
  url "https://github.com/nforst/harbor/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "93330bcd35343dc73976c70227c3391354064a261e1a56ec7cba6c7659de977f"
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
