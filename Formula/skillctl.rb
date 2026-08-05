class Skillctl < Formula
  desc "Manage and install third-party Agent Skills"
  homepage "https://github.com/es2737/skillctl"
  url "https://github.com/es2737/skillctl/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f504fab679ef01d533dbcabc0566461c407e171d670b123f16759e5aa88842e5"
  license "MIT"

  depends_on "go" => :build
  depends_on "gh"

  def install
    ldflags = "-X main.buildVersion=v#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/skillctl"
  end

  test do
    assert_match "skillctl v#{version}", shell_output("#{bin}/skillctl --version")

    output = shell_output("#{bin}/skillctl init --manifest #{testpath}/skills.json --dry-run --json")
    assert_match '"status": "would_create"', output
  end
end
