class Sessync < Formula
  desc "Sync Claude Code sessions between Macs through your own storage, encrypted"
  homepage "https://github.com/latark/sessync"
  url "https://github.com/latark/sessync/archive/refs/tags/v3.1.2.tar.gz"
  sha256 "1b3b4989c15609de839fadcbe97b9687482e8496d82c89a3633642ef63fff9df"
  license "MIT"

  depends_on "jq"
  depends_on :macos
  depends_on "rclone"
  depends_on "ripgrep"

  def install
    libexec.install "bin", "lib", "uninstall.sh"
    bin.install_symlink libexec/"bin/sessync"
  end

  def caveats
    <<~EOS
      In your own terminal (not inside Claude): the storage, keys, encryption password
      and the Claude Code hooks:
        sessync setup
      To remove the hooks and the Keychain items before `brew uninstall sessync`:
        #{opt_libexec}/uninstall.sh --purge
    EOS
  end

  test do
    assert_match "sessync #{version}", shell_output("#{bin}/sessync version")
    assert_match "sessync setup", shell_output("SESSYNC_LANG=en #{bin}/sessync help")
  end
end
