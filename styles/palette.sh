#!/usr/bin/env bash

_hex() { printf '#%s' "$(printf '%s' "$1" | tr -d ' #' | tr '[:upper:]' '[:lower:]')"; }

_cfg="$HOME/.config/ghostty/config"
_user="$HOME/.config/ghostty/themes"
_builtin="/Applications/Ghostty.app/Contents/Resources/ghostty/themes"
_cache="$HOME/.cache/marykatemas/palette.sh"

_theme=$(sed -n 's/^theme[[:blank:]]*=[[:blank:]]*//p' "$_cfg" 2>/dev/null)
_theme="${_theme#"${_theme%%[! ]*}"}"
_theme="${_theme%"${_theme##*[! ]}"}"

_file=""
[[ "$_theme" == */* ]] && _file="$_theme"
[[ -z "$_file" && -f "$_user/$_theme" ]] && _file="$_user/$_theme"
[[ -z "$_file" && -f "$_builtin/$_theme" ]] && _file="$_builtin/$_theme"

if [[ -n "$_file" && -f "$_file" ]]; then
	_cached=""
	[[ -f "$_cache" ]] && {
		read -r _cached <"$_cache"
		_cached="${_cached#\# }"
	}

	if [[ "$_cached" != "$_file" || "$_file" -nt "$_cache" ]]; then
		mkdir -p "${_cache%/*}" 2>/dev/null
		{
			printf '# %s\n' "$_file"
			while IFS= read -r _l; do
				case "$_l" in
				palette\ =\ *)
					_e="${_l#palette = }"
					printf 'export marykate_color%s=%s\n' "${_e%%=*}" "$(_hex "${_e#*=}")"
					;;
				background\ =\ *) printf 'export marykate_bg=%s\n' "$(_hex "${_l#background = }")" ;;
				foreground\ =\ *) printf 'export marykate_fg=%s\n' "$(_hex "${_l#foreground = }")" ;;
				cursor-color\ =\ *) printf 'export marykate_cursor_color=%s\n' "$(_hex "${_l#cursor-color = }")" ;;
				cursor-text\ =\ *) printf 'export marykate_cursor_text=%s\n' "$(_hex "${_l#cursor-text = }")" ;;
				selection-background\ =\ *) printf 'export marykate_selection_bg=%s\n' "$(_hex "${_l#selection-background = }")" ;;
				selection-foreground\ =\ *) printf 'export marykate_selection_fg=%s\n' "$(_hex "${_l#selection-foreground = }")" ;;
				esac
			done <"$_file"
		} >"$_cache"
	fi

	source "$_cache"
fi

unset _hex _cfg _user _builtin _cache _theme _file _cached
