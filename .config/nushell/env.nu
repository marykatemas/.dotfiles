# version = "0.114.0"

$env.PROMPT_COMMAND = {||
    let dir = match (do -i { $env.PWD | path relative-to $nu.home-dir }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)(ansi reset)"

    $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
}

$env.PROMPT_COMMAND_RIGHT = {||
    # create a right prompt in magenta with green separators and am/pm underlined
    let time_segment = ([
        (ansi reset)
        (ansi magenta)
        (date now | format date '%x %X') # try to respect user's locale
    ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
        str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $time_segment] | str join)
}

# https://specifications.freedesktop.org/basedir/latest/
$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
$env.XDG_DATA_HOME   = ($env.HOME | path join ".local" "share")
$env.XDG_STATE_HOME  = ($env.HOME | path join ".local" "state")
$env.XDG_CACHE_HOME  = ($env.HOME | path join ".cache")
$env.XDG_CONFIG_DIRS = "/etc/xdg"
$env.XDG_DATA_DIRS   = "/usr/local/share:/usr/share"
# $env.XDG_RUNTIME_DIR = $"/run/user/(id -u)"

$env.SHELL = (which nu | get path)

use std "path add"
path add "/opt/homebrew/sbin"
path add "/opt/homebrew/bin"
path add ($env.HOME | path join ".local" "bin")
path add "/nix/var/nix/profiles/default/bin"
path add "/run/current-system/sw/bin"
path add ("/etc/profiles/per-user" | path join (whoami) "bin")

$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

mkdir ($nu.data-dir | path join "autoload")

$env.STARSHIP_CONFIG = ($env.XDG_CONFIG_HOME | path join "starship" "starship.toml")
if (which starship | is-not-empty) {
    starship init nu | save -f ($nu.data-dir | path join "autoload" "starship.nu")
}

if (which zoxide | is-not-empty) {
    zoxide init nushell --hook prompt | save -f ($nu.data-dir | path join "autoload" "zoxide.nu")
}

if (which mise | is-not-empty) {
    mise activate nu | save -f ($nu.data-dir | path join "autoload" "mise.nu")
}

if (which atuin | is-not-empty) {
    atuin init nu | save -f ($nu.data-dir | path join "autoload" "atuin.nu")
}

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
if (which carapace | is-not-empty) {
    carapace _carapace nushell | save -f ($nu.data-dir | path join "autoload" "carapace.nu")
}

if (which wt | is-not-empty) {
    wt config shell init nu | save -f ($nu.data-dir | path join "autoload" "worktrunk.nu")
}
