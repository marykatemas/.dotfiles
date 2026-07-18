# version = "0.114.0"

$env.config.color_config = {
    separator: default
    leading_trailing_space_bg: { attr: n }
    header: green_bold
    empty: blue
    bool: light_cyan
    int: default
    filesize: cyan
    duration: default
    datetime: purple
    range: default
    float: default
    string: default
    nothing: default
    binary: default
    binary_null_char: grey42
    binary_printable: cyan_bold
    binary_whitespace: green_bold
    binary_ascii_other: purple_bold
    binary_non_ascii: yellow_bold
    cell-path: default
    row_index: green_bold
    record: default
    list: default
    closure: green_bold
    glob:cyan_bold
    semver: cyan_bold
    semver-range: cyan_bold
    block: default
    hints: dark_gray
    search_result: { bg: red fg: default }
    shape_binary: purple_bold
    shape_block: blue_bold
    shape_bool: light_cyan
    shape_closure: green_bold
    shape_custom: green
    shape_datetime: cyan_bold
    shape_directory: cyan
    shape_external: cyan
    shape_externalarg: green_bold
    shape_external_resolved: light_yellow_bold
    shape_filepath: cyan
    shape_flag: blue_bold
    shape_float: purple_bold
    shape_glob_interpolation: cyan_bold
    shape_globpattern: cyan_bold
    shape_int: purple_bold
    shape_internalcall: cyan_bold
    shape_keyword: cyan_bold
    shape_list: cyan_bold
    shape_literal: blue
    shape_match_pattern: green
    shape_matching_brackets: { attr: u }
    shape_nothing: light_cyan
    shape_operator: yellow
    shape_pipe: purple_bold
    shape_range: yellow_bold
    shape_record: cyan_bold
    shape_redirection: purple_bold
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_table: blue_bold
    shape_variable: purple
    shape_vardecl: purple
    shape_raw_string: light_purple
    shape_garbage: {
        fg: default
        bg: red
        attr: b
    }
}

$env.config.show_banner = false
$env.config.edit_mode = "vi"
$env.config.buffer_editor = "nvim"
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"
$env.config.completions.algorithm = "fuzzy"
$env.config.history.file_format = "sqlite"
$env.config.history.max_size = 5_000_000

# $env.config.keybindings ++= [
#   {
#     name: insert_last_token
#     modifier: alt
#     keycode: char_.
#     mode: [emacs vi_normal vi_insert]
#     event: [
#       { edit: InsertString, value: "!$" }
#       { send: Enter }
#     ]
#   }
# ]

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	^yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != $env.PWD and ($cwd | path exists) {
		cd $cwd
	}
	rm -fp $tmp
}

def man [page] {
    nvim $"+Man ($page)" "+only"
}

# aliases
alias v = nvim
alias c = clear
alias l = ls --all
alias ll = ls -l
alias lt = eza --tree --level=2 --long --icons --git
alias lzg = lazygit
alias lzd = lazydocker
alias oc = opencode
alias ghd = gh dash
alias brewfile = brew bundle dump --force --file=~/.config/homebrew/Brewfile
alias bo = brew outdated
alias buf = brew upgrade --formula
alias buc = brew upgrade --cask
def brewc [] { brew cleanup --prune=all; brew autoremove; brew doctor }
def mas-up [] { mas outdated; mas update }
alias nfu = nix flake update --flake ~/.config/nix/
alias drs = sudo darwin-rebuild switch --flake ~/.config/nix/.#marykatemas-macos --impure
alias hms = home-manager switch --flake ~/.config/nix/.#marykatemas-linux --impure

# https://github.com/nushell/awesome-nu
# https://github.com/nushell/nu_scripts
# И ТАК ДАЛЕЕ

# https://github.com/ahmetb/kubectl-aliases/blob/master/.kubectl_aliases.nu
source modules/kubectl-aliases.nu

# https://github.com/KamilKleina/git-aliases.nu/blob/main/git-aliases.nu
overlay use modules/git-aliases.nu

# https://github.com/nushell/nu_scripts/blob/main/aliases/docker/docker-aliases.nu
use modules/docker-aliases.nu

# https://github.com/nushell/nu_scripts/blob/main/aliases/eza/eza-aliases.nu
use modules/eza-aliases.nu
