class Dots < Formula
  desc "Tiny CLI dotfile manager"
  homepage "https://github.com/navid-rji/dots"
  url "https://github.com/navid-rji/dots/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "d8a931cb6d91635b7602109ab4dabde16c463f8e7832339dbfa92063206682ca"
  license "MIT"
  head "https://github.com/navid-rji/dots.git", branch: "main"

  bottle do
    root_url "https://github.com/navid-rji/homebrew-tap/releases/download/dots-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "b91443102d6678d78177cbaff465d56700720301273f92e363828a164e543819"
    sha256 cellar: :any,                 x86_64_linux: "5fa27c96079ffbeb0d94e726c8c346ea42db433c22b8e4e00bc15010624446d6"
  end

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
