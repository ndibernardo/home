{ pkgs, ...}: {

  imports = [
    ./darwin.nix
  ];

  home = {
    homeDirectory = "/Users/nicola";
    username = "nicola";
    stateVersion = "24.05";
    
    packages = with pkgs; [
      #cli
      coreutils
      curl
      fd
      htop
      ripgrep
      tmux
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

      #rust
      rustup

      #scala
      sbt
    ];
  };

  programs = {
    alacritty = {
      enable = true;
      settings = {
        window = {
          title = "tty";
          dynamic_title = true;
          padding = {
            x = 10;
            y = 10;
          };
        };

        font = {
          size = 15;
          normal = {
            family = "PragmataPro Mono";
          };
        };

        colors = {
          primary = {
            background = "#181818";
            foreground = "#d8d8d8";
          };
          cursor = {
            text = "#181818";
            cursor = "#d8d8d8";
          };
          normal = {
            black   = "#181818";
            red     = "#ab4642";
            green   = "#a1b56c";
            yellow  = "#f7ca88";
            blue    = "#7cafc2";
            magenta = "#ba8baf";
            cyan    = "#86c1b9";
            white   = "#d8d8d8";
          };
          bright = {
            black   = "#585858";
            red     = "#ab4642";
            green   = "#a1b56c";
            yellow  = "#f7ca88";
            blue    = "#7cafc2";
            magenta = "#ba8baf";
            cyan    = "#86c1b9";
            white   = "#f8f8f8";
          };
        };
      };
    };

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
      shell = "\${pkgs.zsh}/bin/zsh";
      clock24 = true;
      keyMode = "vi";
      mouse = true;
      sensibleOnTop = true;
      terminal = "alacritty";

      plugins = with pkgs; [
        {
          plugin = (tmuxPlugins.mkTmuxPlugin {
            pluginName = "tinted-tmux";
            version = "unstable";
            src = pkgs.fetchFromGitHub {
              owner = "tinted-theming";
              repo = "tinted-tmux";
              rev = "98b6a7f718454e55f6069f9d492d23703d450155";
              sha256 = "sha256-z+wOt9NNVYv5Ow7u/RohHgxOJELmzwxerRjW74hAEFM=";
              };
            });
          extraConfig = ''
            set -g @tinted-color 'base16-default-dark'
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
        PS1="%~ %# ";
      };
      shellAliases = {
        ga  = "git add";
        gb  = "git branch";
        gc  = "git checkout";
        gcm = "git commit -m";
        gd  = "git pull origin";
        gs  = "git status";
        gup = "git push -u origin HEAD";
        ls  = "ls -G -a";
        ll  = "ls -G -Al";
        lh  = "lh -G -Alh";
        k   = "kubectl";
        d   = "docker";
      };
    };
  };
}
