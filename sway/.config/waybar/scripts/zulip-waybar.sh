#!/usr/bin/env bash
# Waybar custom module: Zulip unread count

# Config: create an .env file with these variables:
# ZULIP_URL="https://your.zulip.server"
# ZULIP_EMAIL="you@example.com"
# ZULIP_KEY="your_api_key_here"
source "./zulip-waybar.env"

MENTIONS_ONLY="${MENTIONS_ONLY:-true}"

response=$(curl -s --max-time 5 \
    -u "${ZULIP_EMAIL}:${ZULIP_KEY}" \
    -X POST \
    --data 'event_types=["message"]' \
    "${ZULIP_URL}/api/v1/register")

if [[ $? -ne 0 || -z "$response" ]]; then
    printf '{"text":"󰒱 ?","tooltip":"Zulip: connection failed","class":"error"}\n'
    exit 0
fi

if [[ "$MENTIONS_ONLY" == "true" ]]; then
    count=$(printf '%s' "$response" | jq '[.unread_msgs.mentions | length] | add // 0')
else
    count=$(printf '%s' "$response" | jq '
        [
            (.unread_msgs.streams[]?.unread_message_ids | length),
            (.unread_msgs.pms[]?.unread_message_ids     | length),
            (.unread_msgs.huddles[]?.unread_message_ids | length)
        ] | add // 0
    ')
fi

if (( count > 0 )); then
    printf '{"text":"󰒱 %d","tooltip":"%d unread messages in Zulip","class":"unread"}\n' \
        "$count" "$count"
else
    printf '{"text":"󰒱","tooltip":"No unread Zulip messages","class":"idle"}\n'
fi
