class Sessync < Formula
  desc "Sync Claude Code sessions between Macs through your own storage, encrypted"
  homepage "https://github.com/latark/sessync"
  url "https://github.com/latark/sessync/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "6af48faf9b2c08d888afe1399b8c0140173a7fbf792630d548279e4b65205a68"
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
