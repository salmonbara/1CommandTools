#!/bin/bash

# Load target variables from target.txt
source target.txt

output_prefix=$(echo "$RHOST" | sed 's/\./_/g')  # Replace dots with underscores for filenames
TARGET_URL_SANITIZED=$(echo "$TARGET_URL" | sed 's/[:\/\.]/_/g')  # Sanitize TARGET_URL for filenames

mode=$1  # Mode: 0 = all, 1 = recon, 2 = directory listing, 3 = bruteforce scan

# Display Help/Usage information
function display_help {
    echo "Usage: $0 {mode}"
    echo ""
    echo "Automates discovery and penetration testing tools for a given IP or web target."
    echo ""
    echo "Arguments:"
    echo "  mode             The mode to run the script. Possible values are:"
    echo "                   0  - Run all tests (recon, directory listing, bruteforce scanning)."
    echo "                   1  - Run reconnaissance tools like nmap, whois, dig, etc."
    echo "                   2  - Run directory listing tools like nikto, gobuster, etc."
    echo "                   3  - Run bruteforce scanning tools."
    echo ""
    echo "Examples:"
    echo "  $0 0"
    echo "      Runs all tests on the RHOST and TARGET_URL."
    echo ""
    echo "  $0 1"
    echo "      Runs reconnaissance tools on RHOST."
    echo ""
    exit 0
}

# Reconnaissance
function run_recon {
    summary_file="${output_prefix}_summary_recon.txt"
    echo "Starting Recon on $RHOST" > "$summary_file"
    echo "======================" >> "$summary_file"

    # Nmap scan
    echo "Running Nmap..." >> "$summary_file"
    nmap_output=$(nmap -A -Pn $RHOST | grep -E "^[0-9]+/tcp.*open")
    echo "Open Ports and Services (Nmap):" >> "$summary_file"
    echo "$nmap_output" | awk '{print $1, $3, $4}' >> "$summary_file"
    echo "======================" >> "$summary_file"

    # Whois
    echo "Running Whois..." >> "$summary_file"
    whois_output=$(whois $RHOST | head -n 10)
    echo "Whois Info:" >> "$summary_file"
    echo "$whois_output" >> "$summary_file"
    echo "======================" >> "$summary_file"

    # DNS info (dig)
    echo "Running Dig..." >> "$summary_file"
    dig_output=$(dig $RHOST +short)
    echo "DNS Info (Dig):" >> "$summary_file"
    echo "$dig_output" >> "$summary_file"
    echo "======================" >> "$summary_file"
}

# Directory Listing
function run_dir_list {
    summary_file="${TARGET_URL_SANITIZED}_summary_dirlist.txt"
    echo "Starting Directory Listing on $TARGET_URL" > "$summary_file"
    echo "======================" >> "$summary_file"

    # Nikto
    echo "Running Nikto..." >> "$summary_file"
    nikto_output=$(nikto -h $TARGET_URL | grep -E "OSVDB|CVE")
    echo "Vulnerabilities Detected (Nikto):" >> "$summary_file"
    echo "$nikto_output" >> "$summary_file"
    echo "======================" >> "$summary_file"

    # Gobuster
    echo "Running Gobuster..." >> "$summary_file"
    gobuster_output=$(gobuster dir -u $TARGET_URL -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -q | grep "Status: 200")
    echo "Discovered Directories (Gobuster):" >> "$summary_file"
    echo "$gobuster_output" | awk '{print $1}' >> "$summary_file"
    echo "======================" >> "$summary_file"
}

# Bruteforce Scan (future option for brute force tools)
function run_bruteforce_scan {
    summary_file="${TARGET_URL_SANITIZED}_summary_bruteforce.txt"
    echo "Starting Bruteforce Scan on $TARGET_URL" > "$summary_file"
    echo "======================" >> "$summary_file"

    # Placeholder for tools like wpscan, etc.
    echo "Placeholder for bruteforce scan tools like wpscan." >> "$summary_file"
    echo "======================" >> "$summary_file"
}

# Run all modes
function run_all {
    run_recon
    run_dir_list
    run_bruteforce_scan

    combined_summary="${output_prefix}_summary_all.txt"
    cat "${output_prefix}_summary_recon.txt" \
        "${TARGET_URL_SANITIZED}_summary_dirlist.txt" \
        "${TARGET_URL_SANITIZED}_summary_bruteforce.txt" \
        > "$combined_summary"
}

# Main function
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    display_help
fi

case $mode in
    0)
        run_all
        ;;
    1)
        run_recon
        ;;
    2)
        run_dir_list
        ;;
    3)
        run_bruteforce_scan
        ;;
    *)
        echo "Usage: $0 {0|1|2|3} or -h for help"
        exit 1
        ;;
esac
