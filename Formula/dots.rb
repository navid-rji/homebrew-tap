class Dots < Formula
  desc "Tiny CLI dotfile manager"
  homepage "https://github.com/navid-rji/dots"
  url "https://github.com/navid-rji/dots/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "d2581675c0a1b06edbb18725dbab7857ed76b14ca42bad807a3e905b2fc14050"
  license "MIT"
  head "https://github.com/navid-rji/dots.git", branch: "main"

  bottle do
    root_url "https://github.com/navid-rji/homebrew-tap/releases/download/dots-0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e02c5e5a6e7f2941b2adfbe12bc559e68880858bde47a02204b61a1cb641162b"
    sha256 cellar: :any,                 x86_64_linux: "4fad14c9265fc4b15bb99de7cacbce8c0f46298cc7caf621715b147e53c5018c"
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
