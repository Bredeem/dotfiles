#!/usr/bin/env bash
# Same order as xkb_layout in the sway config: no,no,fi
names=(nob sme fin)

emit() {
    local name="${names[$1]:-?}"
    printf '{"text":"%s","class":"%s"}\n' "$name" "$name"
}

# Initial state
emit "$(swaymsg -t get_inputs -r | jq -r 'first(.[] | select(.type=="keyboard")).xkb_active_layout_index')"

# Follow changes
swaymsg -t subscribe -m '["input"]' \
  | jq --unbuffered -r 'select(.change=="xkb_layout" and .input.type=="keyboard") | .input.xkb_active_layout_index' \
  | while read -r idx; do emit "$idx"; done
