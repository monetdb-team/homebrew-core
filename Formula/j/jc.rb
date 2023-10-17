class Jc < Formula
  include Language::Python::Virtualenv

  desc "Serializes the output of command-line tools to structured JSON output"
  homepage "https://github.com/kellyjonbrazil/jc"
  url "https://files.pythonhosted.org/packages/c0/06/62f18df8f03b042eea35749dc957e26d6b43f9aba3eb932c126a6aeb92af/jc-1.23.4.tar.gz"
  sha256 "c1e86e230cd3f890953868b3016e45dd3806b8f467e24954335d433644db4df8"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "51d2c530c6b12e45a7f95821d78ca3f322abcac8affe6e580c2b6bf6496a2cdb"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "9affdf8f68cb3847c1e8f697b55f948af4e7a16ba98f205a499d9aaef1d55bb2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "739a800899daba0ca0648e277645741b7c415cd0872eddc70a5e1cf73dfc62b6"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b4bd61dd4c0973077240a0cc49c4d5669775a0b75b0c57ac7a74934da840c9d8"
    sha256 cellar: :any_skip_relocation, sonoma:         "ce487e3ba35daa8e15faa773d7dd17e26a5b36bb0e8e382a8a61ec355c83385d"
    sha256 cellar: :any_skip_relocation, ventura:        "9bf4fa079ff11c6a831658d56ec3319653023d9dfbf7418138c05eef983ee1a9"
    sha256 cellar: :any_skip_relocation, monterey:       "d718612145c8b7106e6a9601ef79531eed0436dd3a4d0b4a938c59a9ea1a3c0e"
    sha256 cellar: :any_skip_relocation, big_sur:        "106827661e1493e33a430cc3ff19a12a5a8db1009e4bba8645ea0f2a39fb5d75"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "44dcb7108c3a4b2e7acc24c4475b5dddc262824890a3fce5c3ae764d539f9287"
  end

  depends_on "pygments"
  depends_on "python@3.12"

  resource "ruamel-yaml" do
    url "https://files.pythonhosted.org/packages/de/7d/4f70a93fb0bdc3fb2e1cbd859702d70021ab6962b7d07bd854ac3313cb54/ruamel.yaml-0.17.35.tar.gz"
    sha256 "801046a9caacb1b43acc118969b49b96b65e8847f29029563b29ac61d02db61b"
  end

  resource "ruamel-yaml-clib" do
    url "https://files.pythonhosted.org/packages/46/ab/bab9eb1566cd16f060b54055dd39cf6a34bfa0240c53a7218c43e974295b/ruamel.yaml.clib-0.2.8.tar.gz"
    sha256 "beb2e0404003de9a4cab9753a8805a8fe9320ee6673136ed7f04255fe60bb512"
  end

  resource "xmltodict" do
    url "https://files.pythonhosted.org/packages/39/0d/40df5be1e684bbaecdb9d1e0e40d5d482465de6b00cbb92b84ee5d243c7f/xmltodict-0.13.0.tar.gz"
    sha256 "341595a488e3e01a85a9d8911d8912fd922ede5fecc4dce437eb4b6c8d037e56"
  end

  def install
    virtualenv_install_with_resources
    man1.install "man/jc.1"
    generate_completions_from_executable(bin/"jc", "--bash-comp", shells: [:bash], shell_parameter_format: :none)
    generate_completions_from_executable(bin/"jc", "--zsh-comp", shells: [:zsh], shell_parameter_format: :none)
  end

  test do
    assert_equal "[{\"header1\":\"data1\",\"header2\":\"data2\"}]\n",
                  pipe_output("#{bin}/jc --csv", "header1, header2\n data1, data2")
  end
end
