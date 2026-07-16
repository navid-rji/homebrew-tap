class Dots < Formula
  desc "Tiny CLI dotfile manager"
  homepage "https://github.com/navid-rji/dots"
  url "https://github.com/navid-rji/dots/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "0d4f3c4f5b20626c6a74d8dbab194f8758e57cc1191b8afe4e5ea43bf252587f"
  license "MIT"
  head "https://github.com/navid-rji/dots.git", branch: "main"

  bottle do
    root_url "https://github.com/navid-rji/homebrew-tap/releases/download/dots-0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "1508dfea702e7d4d8f8519f48dbd8bfa406d5177ae408c16ad26de848402ac99"
    sha256 cellar: :any,                 x86_64_linux: "3f5ed1a4df397250839e1b05bd4fade98e7241dd69776884757c0b7ea7ddc880"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/navid-rji/dots/internal/buildinfo.version=#{version}
    ]
    system "go", "build", *std_go_args(ldflags: ldflags)
    generate_completions_from_executable(bin/"dots", shell_parameter_format: :cobra, shells: [:bash, :zsh, :fish])
  end

  test do
    assert_match "dots version #{version}", shell_output("#{bin}/dots --version")
  end
end
