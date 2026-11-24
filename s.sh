
#!/bin/bash

set -e

RULE_DIR="/etc/snort/rules"
RULE_FILE="$RULE_DIR/local.rules"
LOG_DIR="/var/log/snort-lab"
LOG_FILE="$LOG_DIR/alerts.log"

if [[ $EUID -ne 0 ]]; then
    echo "Run using: sudo bash snort_experiment.sh"
    exit 1
fi

read -rp "Enter target device IP address: " TARGET

if ! python3 -c 'import ipaddress,sys; ipaddress.IPv4Address(sys.argv[1])' "$TARGET" 2>/dev/null; then
    echo "Invalid IP address."
    exit 1
fi

echo "Target IP: $TARGET"

IFACE=$(ip route get "$TARGET" |
    awk '{for(i=1;i<=NF;i++) if($i=="dev"){print $(i+1); exit}}')

if [[ -z "$IFACE" ]]; then
    echo "Network interface not found."
    exit 1
fi

echo "Network Interface: $IFACE"

CONF="/etc/snort/snort.lua"

if [[ ! -f "$CONF" ]]; then
    echo "Snort configuration not found."
    exit 1
fi

mkdir -p "$RULE_DIR" "$LOG_DIR"

cat > "$RULE_FILE" <<EOF
alert icmp any any -> $TARGET any (msg:"ICMP Ping Detected"; sid:1000001; rev:1;)
alert tcp any any -> $TARGET 22 (msg:"SSH Connection Attempt"; sid:1000002; rev:1;)
alert tcp any any -> $TARGET 23 (msg:"Telnet Traffic Detected"; sid:1000003; rev:1;)
EOF

echo "Detection rules configured."

snort -T -c "$CONF" -R "$RULE_FILE" -i "$IFACE"

echo "Starting Snort IDS..."

snort -c "$CONF" \
    -R "$RULE_FILE" \
    -i "$IFACE" \
    -A alert_fast \
    -l "$LOG_DIR"
