class Dots < Formula
  desc "Tiny CLI dotfile manager"
  homepage "https://github.com/navid-rji/dots"
  url "https://github.com/navid-rji/dots/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "d8a931cb6d91635b7602109ab4dabde16c463f8e7832339dbfa92063206682ca"
  license "MIT"
  head "https://github.com/navid-rji/dots.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/navid-rji/dots/internal/buildinfo.version=#{version}
    ]
    system "go", "build", *std_go_args(ldflags: ldflags)
  end

  test do
    assert_match "dots version #{version}", shell_output("#{bin}/dots --version")
  end
end
