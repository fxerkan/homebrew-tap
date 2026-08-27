# Homebrew formula for concealer.
#
# Place this file in the tap repo (github.com/fxerkan/homebrew-tap) as Formula/concealer.rb.
# Users then run:  brew install fxerkan/tap/concealer
#
# To update for a new release (see PACKAGING.md):
#   1) git tag v0.9.14 && git push --tags
#   2) point url at the tag, then:  shasum -a 256 <tarball>  → paste the sha256
class Concealer < Formula
  desc "Local-only, single-file secret manager over SOPS + age (CLI · Web UI · MCP)"
  homepage "https://github.com/fxerkan/concealer"
  url "https://github.com/fxerkan/concealer/archive/refs/tags/v0.9.16.tar.gz"
  sha256 "509788fdbf937bc0f8bff00ad45f9b045e58ad017fbdac722f38b6fbcdf81b2b"
  license "MIT"

  # Bundle sops/age/expect so users don't have to install them separately.
  depends_on "age"
  depends_on "expect"
  # python3 ships with macOS; require it explicitly for Linux/clean installs.
  depends_on "python@3.13"
  depends_on "sops"

  def install
    libexec.install "concealer", "webui.html"
    (libexec/"concealer").chmod 0755
    bin.install_symlink libexec/"concealer"
    bin.install_symlink libexec/"concealer" => "cer" # short alias
  end

  def caveats
    <<~EOS
      Your vault is stored under ~/.concealer by default.
      To get started:
        concealer init          # generates a master password + recovery codes + a CLI token
        export CONCEALER_TOKEN=… # run the line printed by init
        concealer web 8787      # web UI:  http://localhost:8787

      Detailed help and examples:  concealer help
    EOS
  end

  test do
    assert_match "concealer #{version}", shell_output("#{bin}/concealer version")
    assert_match "USAGE", shell_output("#{bin}/concealer help")
    # dependencies must be on PATH (brew installs them)
    %w[sops age age-keygen expect].each { |b| assert which(b), "#{b} not on PATH" }
  end
end
