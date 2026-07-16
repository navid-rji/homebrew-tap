class Dots < Formula
  desc "Tiny CLI dotfile manager"
  homepage "https://github.com/navid-rji/dots"
  url "https://github.com/navid-rji/dots/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "0d4f3c4f5b20626c6a74d8dbab194f8758e57cc1191b8afe4e5ea43bf252587f"
  license "MIT"
  head "https://github.com/navid-rji/dots.git", branch: "main"

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
