class Pbctl < Formula
    desc "Everything you need to get started with development at Productboard"
    homepage "https://github.com/tozes/pbctl"
    url "https://github.com/tozes/pbctl/blob/main/release/pbctl-v0.0.0.tar.gz"
    sha256 "da4fa6d639477ca71107b7d0e443cf8e9d658349da28971d9ebb45d27d12e5db"
    depends_on "tozes/pbctl/pbctl-node" => "12.21.0"
  
    def install
      inreplace "bin/pbctl", /^CLIENT_HOME=/, "export PBCTL_OCLIF_CLIENT_HOME=#{lib/"client"}\nCLIENT_HOME="
      inreplace "bin/pbctl", "\"$DIR/node\"", Formula["pbctl-node"].opt_bin/"node"
      libexec.install Dir["*"]
      bin.install_symlink libexec/"bin/pbctl"
  
      bash_completion.install libexec/"node_modules/@pbctl/plugin-autocomplete/autocomplete/brew/bash" => "pbctl"
      zsh_completion.install libexec/"node_modules/@pbctl/plugin-autocomplete/autocomplete/brew/zsh/_pbctl"
    end
  
    def caveats; <<~EOS
      To use the pbctl CLI's autocomplete --
        Via homebrew's shell completion:
          1) Follow homebrew's install instructions https://docs.brew.sh/Shell-Completion
              NOTE: For zsh, as the instructions mention, be sure compinit is autoloaded
                    and called, either explicitly or via a framework like oh-my-zsh.
          2) Then run
            $ pbctl autocomplete --refresh-cache
        OR
        Use our standalone setup:
          1) Run and follow the install steps:
            $ pbctl autocomplete
    EOS
    end
  
    test do
      system bin/"pbctl", "version"
    end
  end