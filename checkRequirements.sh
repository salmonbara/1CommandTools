#!/bin/bash

# List of tools required for the script
required_tools=(
    "nmap"
    "whois"
    "dig"
    "nikto"
    "gobuster"
    "wpscan"
    "sqlmap"
)

# Function to check if a tool is installed
check_tool() {
    if ! command -v $1 &> /dev/null; then
        echo "$1 is not installed."
        return 1
    else
        echo "$1 is installed."
        return 0
    fi
}

# Main check function
missing_tools=()
for tool in "${required_tools[@]}"; do
    check_tool "$tool"
    if [ $? -ne 0 ]; then
        missing_tools+=("$tool")
    fi
done

# If there are missing tools, display instructions to install them
if [ ${#missing_tools[@]} -eq 0 ]; then
    echo "All required tools are installed."
else
    echo ""
    echo "The following tools are missing:"
    for tool in "${missing_tools[@]}"; do
        echo "- $tool"
    done

    echo ""
    echo "To install the missing tools, run the following commands:"
    
    for tool in "${missing_tools[@]}"; do
        case $tool in
            nmap)
                echo "sudo apt-get install nmap"
                ;;
            whois)
                echo "sudo apt-get install whois"
                ;;
            dig)
                echo "sudo apt-get install dnsutils"
                ;;
            nikto)
                echo "sudo apt-get install nikto"
                ;;
            gobuster)
                echo "sudo apt-get install gobuster"
                ;;
            wpscan)
                echo "sudo apt-get install wpscan"
                ;;
            sqlmap)
                echo "sudo apt-get install sqlmap"
                ;;
            *)
                echo "Manual installation required for $tool."
                ;;
        esac
    done
fi
