# dmroll-homebrew-tap
1. Build Your Go Binary for macOS/Linux

Since Homebrew primarily targets macOS and Linux, you need to compile dmroll as a statically linked binary:

GOOS=darwin GOARCH=amd64 go build -o dmroll
GOOS=linux GOARCH=amd64 go build -o dmroll-linux

If you also want to support Apple Silicon, include:

GOOS=darwin GOARCH=arm64 go build -o dmroll-arm64

You can automate this in a script:

#!/bin/bash
mkdir -p builds
GOOS=darwin GOARCH=amd64 go build -o builds/dmroll-mac
GOOS=darwin GOARCH=arm64 go build -o builds/dmroll-mac-arm
GOOS=linux GOARCH=amd64 go build -o builds/dmroll-linux

2. Host Your Binary Online

To make it accessible for Homebrew, you need to upload the compiled binary to a location where it can be downloaded.

Options:

    GitHub Releases (recommended): GitHub can host versioned binaries.
    Self-hosted server: If you have a server, you can use it.
    Another file hosting service: Be sure it allows direct downloads.

Uploading to GitHub Releases

    Create a new release on GitHub:
        Navigate to your repo → Releases → Draft a new release
        Tag it (e.g., v1.0.0)
        Upload your built binaries (dmroll-mac, dmroll-linux, etc.)

    After uploading, get the direct URLs to the files.

3. Create a Homebrew Formula (that's what this is!)

A Homebrew formula is a Ruby script that tells Homebrew how to install your tool.

    Create a new repository for your Homebrew formula. A common convention is:

github.com/your-username/homebrew-tap

Inside that repo, create a Formula/ directory and a formula file:

Formula/dmroll.rb

Add the following content to dmroll.rb, replacing the placeholders:

class Dmroll < Formula
  desc "CLI tool for rolling dice and consulting tables in D&D 5e (Ruins of Symbaroum)"
  homepage "https://github.com/your-username/dmroll"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/your-username/dmroll/releases/download/v1.0.0/dmroll-mac-arm"
      sha256 "your_sha256_for_mac_arm"
    else
      url "https://github.com/your-username/dmroll/releases/download/v1.0.0/dmroll-mac"
      sha256 "your_sha256_for_mac_amd64"
    end
  end

  on_linux do
    url "https://github.com/your-username/dmroll/releases/download/v1.0.0/dmroll-linux"
    sha256 "your_sha256_for_linux"
  end

  def install
    bin.install "dmroll"
  end

  test do
    system "#{bin}/dmroll", "--help"
  end
end

Compute the SHA256 hash of the binary:

shasum -a 256 dmroll-mac     # For macOS (Intel)
shasum -a 256 dmroll-mac-arm # For macOS (Apple Silicon)
shasum -a 256 dmroll-linux   # For Linux

    Replace your_sha256_checksum_here with the result.

4. Add Your Tap to Homebrew

To allow installation via brew install dmroll, users need to add your repository as a tap:

brew tap your-username/tap
brew install dmroll

If you want to test it locally before pushing:

brew install --build-from-source ./Formula/dmroll.rb

5. Publish & Share

    Push your homebrew-tap repository to GitHub.

    Users can now install dmroll via:

    brew tap your-username/tap
    brew install dmroll

    If you update your tool, release a new version and update the url + sha256 in dmroll.rb.

Bonus: Automate Updates

    Use GitHub Actions to build and upload binaries automatically on new releases.
    Create a script to auto-update the formula.