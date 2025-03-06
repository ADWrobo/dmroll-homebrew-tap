class Dmroll < Formula
    desc "...is a command-line tool for Dungeon Masters to roll dice, roll on predefined tables, and generate structured content like ruins for TTRPG campaigns."
    homepage "https://github.com/ADWrobo/dmroll"
    version "v0.1.0"
  
    on_macos do
      if Hardware::CPU.arm?
        url "https://github.com/ADWrobo/dmroll/releases/download/v0.1.0/dmroll-arm64"
        sha256 "1d97594d10eb5e0a031efecb35e78656a37355a78192f0681543c4b385f66fde"
        def install
            bin.install "dmroll-arm64" => "dmroll"
        end
      else
        url "https://github.com/ADWrobo/dmroll/releases/download/v0.1.0/dmroll"
        sha256 "93ab3ede68a179fdf9af9373cf6ff3919f80d85fe6a56cc09a4766021ab668cc"
        def install
            bin.install "dmroll"
        end
      end
    end
  
    on_linux do
      url "https://github.com/ADWrobo/dmroll/releases/download/v0.1.0/dmroll-linux"
      sha256 "1a06498d6709d10243ca1b09a557f57db34f4c34ad2e1be9246e7417a50f1a85"
      def install
        bin.install "dmroll-linux" => "dmroll"
      end
    end
  
    test do
      system "#{bin}/dmroll", "--help"
    end
  end
  