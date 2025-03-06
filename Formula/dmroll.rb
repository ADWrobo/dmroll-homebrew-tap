class Dmroll < Formula
    desc "...is a command-line tool for Dungeon Masters to roll dice, roll on predefined tables, and generate structured content like ruins for TTRPG campaigns."
    homepage "https://github.com/ADWrobo/dmroll"
    version "v0.2.0"
  
    on_macos do
      if Hardware::CPU.arm?
        url "https://github.com/ADWrobo/dmroll/releases/download/v0.2.0/dmroll-arm64"
        sha256 "a276cdbbcfbcfafe0b13cab075159046bdc96f377fd2fb85f4d05a05e19f30fc"
        def install
            bin.install "dmroll-arm64" => "dmroll"
        end
      else
        url "https://github.com/ADWrobo/dmroll/releases/download/v0.2.0/dmroll"
        sha256 "01c2ee46d56bf460234d21e4e41e0262638aef7d466e2652f33d0e2e51321c81"
        def install
            bin.install "dmroll"
        end
      end
    end
  
    on_linux do
      url "https://github.com/ADWrobo/dmroll/releases/download/v0.2.0/dmroll-linux"
      sha256 "b23ba2b1fc68f07600850dfc1926c8c88225f1f1ebe97f94183536941ea61acc"
      def install
        bin.install "dmroll-linux" => "dmroll"
      end
    end
  
    test do
      system "#{bin}/dmroll", "--help"
    end
  end
  