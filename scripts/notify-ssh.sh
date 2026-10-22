#!/usr/bin/env bash
# Notify every active SSH pseudo-terminal belonging to the current user.
set -u
current_user=$(id -un)
while IFS= read -r line; do
  read -r -a fields <<< "$line"
  [[ "${fields[0]:-}" == "$current_user" ]] || continue
  [[ "$line" == *'('*')'* ]] || continue
  tty=''
  for field in "${fields[@]}"; do
    if [[ "$field" == pts/* ]]; then tty="$field"; break; fi
  done
  [[ -n "$tty" ]] || continue
  terminal="/dev/$tty"
  [[ -c "$terminal" && -w "$terminal" ]] || continue
  printf '\a' > "$terminal" 2>/dev/null && printf 'BEL sent to %s\n' "$terminal"
done < <(who)
