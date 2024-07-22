{ pkgs, ... }: {

  home = {
    homeDirectory = "/Users/nicola";
    username = "nicola";
    stateVersion = "24.05";

    packages = with pkgs; [
      #cli
      coreutils
      curl
      fd
      grpcurl
      htop
      jq
      ripgrep
      tree
      unzip
      wget
      z-lua
      zip

      #clojure
      babashka
      clj-kondo
      clojure
      leiningen
      neil

      #editor
      neovim

      #elixir
      elixir

      #java
      maven

      #javascript
      nodejs

      #nix
      nixd
      nixpkgs-fmt

      #proto
      protobuf

      #rust
      rustup

      #scala
      sbt
    ];
  };

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    fzf = {
      enable = true;
    };

    home-manager = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "ndibernardo";
      ignores = [
        ".DS_STORE"
        "*.swp"
        ".idea"
        ".envrc"
        ".direnv"
      ];
      extraConfig = {
        apply.whitespace = "fix";
        color = {
          diff = "auto";
          status = "auto";
          branch = "auto";
        };
        push.default = "simple";
        pull.rebase = "true";
        init.defaultBranch = "main";
      };
    };

    java = {
      enable = true;
      package = pkgs.jdk17;
    };

    tmux = {
      enable = true;
      baseIndex = 1;
      prefix = "C-a";
      clock24 = true;
      keyMode = "vi";
      mouse = true;
      sensibleOnTop = true;

      plugins = with pkgs; [
        {
          plugin = (tmuxPlugins.mkTmuxPlugin {
            pluginName = "tinted-tmux";
            version = "unstable";
            rtpFilePath = "tmuxcolors.tmux";
            src = fetchFromGitHub {
              owner = "tinted-theming";
              repo = "tinted-tmux";
              rev = "98b6a7f718454e55f6069f9d492d23703d450155";
              sha256 = "sha256-z+wOt9NNVYv5Ow7u/RohHgxOJELmzwxerRjW74hAEFM=";
            };
          });
          extraConfig = ''
            set -g @tinted-color 'base16-one-light'
          '';
        }
      ];
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      completionInit = ''
        autoload -Uz compinit && compinit
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      '';
      history = {
        size = 50000;
        expireDuplicatesFirst = true;
        ignoreAllDups = true;
        ignoreDups = true;
        ignoreSpace = true;
      };
      localVariables = {
        PS1 = "%~ %# ";
      };
      shellAliases = {
        ga = "git add";
        gb = "git branch";
        gc = "git checkout";
        gcm = "git commit -m";
        gd = "git pull origin";
        gs = "git status";
        gup = "git push -u origin HEAD";
        ls = "ls -G -a";
        ll = "ls -G -Al";
        lh = "lh -G -Alh";
        k = "kubectl";
        d = "docker";
      };
    };
  };
}
