{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;

    environmentVariables = {
      NH_FLAKE = "/home/mingas/nix-configuration";
    };

    extraConfig = ''
      $env.config = {
        show_banner: false

        color_config: {
          # Primitives – diversidade total
          separator:                  "#a89984"   # cinza/marrom claro
          leading_trailing_space_bg: { attr: n }
          header:                     { fg: "#79740e" attr: b }  # verde bold só para headers
          empty:                      "#076678"   # azul para empty/pipes vazios
          bool:                       { fg: "#427b58" attr: b }  # verde escuro bold para true/false
          int:                        { fg: "#076678" attr: b }  # azul bold para inteiros
          filesize:                   { fg: "#b57614" attr: b }  # laranja bold para tamanhos
          duration:                   "#b57614"   # laranja
          date:                       { fg: "#8f3f71" attr: b }  # roxo bold para datas
          range:                      { fg: "#b57614" attr: b }  # laranja
          float:                      { fg: "#8f3f71" attr: b }  # roxo bold para floats
          string:                     "#3c3836"   # texto padrão (preto escuro) – mais neutro agora
          nothing:                    "#928374"   # cinza para null
          binary:                     "#8f3f71"   # roxo
          cellpath:                   "#076678"   # azul para paths em tabelas
          row_index:                  { fg: "#b57614" attr: b }  # laranja bold para índices
          record:                     "#3c3836"
          list:                       "#3c3836"
          block:                      "#79740e"   # verde só para blocos
          hints:                      "#928374"

          # Shapes – cada um com cor única
          shape_block:                { fg: "#79740e" attr: b }     # verde
          shape_bool:                 { fg: "#427b58" attr: b }     # verde escuro
          shape_directory:            { fg: "#076678" attr: b }     # azul bold
          shape_external:             { fg: "#427b58" attr: b }     # verde escuro
          shape_externalarg:          { fg: "#b57614" attr: b }     # laranja
          shape_filepath:             "#076678"                     # azul
          shape_flag:                 { fg: "#8f3f71" attr: b }     # roxo
          shape_float:                { fg: "#8f3f71" attr: b }     # roxo
          shape_int:                  { fg: "#076678" attr: b }     # azul
          shape_list:                 { fg: "#79740e" attr: b }     # verde
          shape_literal:              "#076678"                     # azul
          shape_operator:             { fg: "#b57614" attr: b }     # laranja
          shape_range:                { fg: "#b57614" attr: b }     # laranja
          shape_string:               "#3c3836"                     # neutro (menos verde!)
          shape_variable:             { fg: "#8f3f71" attr: b }     # roxo
          shape_matching_brackets:    { attr: b }
          shape_and:                  { fg: "#9d0006" attr: b }     # vermelho para lógica
          shape_or:                   { fg: "#9d0006" attr: b }
          shape_pipe:                 { fg: "#9d0006" attr: b }

          # Extras para mais vivacidade
          shape_garbage:              { fg: "#fbf1c7" bg: "#9d0006" attr: b }  # erro vermelho forte
          shape_globpattern:          { fg: "#427b58" attr: b }
          shape_nothing:              "#928374"
          shape_string_interpolation: { fg: "#8f3f71" attr: b }  # roxo dentro de strings
          shape_table:                { fg: "#076678" attr: b }     # tabelas com toque azul
        }

        ls: {
          use_ls_colors: true
        }

        completions: {
          case_sensitive: false
          quick: true
          partial: true
          algorithm: "fuzzy"
        }
      }

      # LS_COLORS mantido rico e colorido
      $env.LS_COLORS = (
        "di=01;34:" + "ln=01;36:" + "ex=01;32:" + "fi=0:" + "so=01;35:" + "pi=01;33:" +
        "bd=01;33:" + "cd=01;33:" + "su=01;31:" + "sg=01;31:" + "tw=01;34:" + "ow=01;34:" +
        "*README=01;33:" + "*README.md=01;33:" + "*LICENSE=01;33:" + "*TODO=01;33:" +
        "*Makefile=01;33:" + "*Cargo.toml=01;33:" + "*package.json=01;33:" +
        "*.rs=32:" + "*.toml=33:" + "*.nix=33:" + "*.md=33:" + "*.json=33:" + "*.yaml=33:" + "*.yml=33:" +
        "*.sh=01;32:" + "*.py=01;32:" + "*.js=01;33:" + "*.ts=01;36:" +
        "*.zip=01;31:" + "*.tar=01;31:" + "*.gz=01;31:" + "*.xz=01;31:" + "*.bz2=01;31:" + "*.7z=01;31:" + "*.rar=01;31:" +
        "*.jpg=35:" + "*.jpeg=35:" + "*.png=35:" + "*.gif=35:" + "*.svg=35:" + "*.webp=35:" +
        "*.pdf=01;35:" + "*.doc=35:" + "*.docx=35:" +
        "*.mp3=36:" + "*.wav=36:" + "*.flac=36:" +
        "*.mp4=36:" + "*.mkv=36:" + "*.avi=36:" +
        "*.log=90:"
      )
    ''
    + builtins.readFile ./fzf-config.nu;
  };
}
