# 1CommandTools || Automated Pentesting Tools

This repository contains a set of bash scripts that automate reconnaissance, directory listing, and bruteforce scanning for web applications and IP targets. The tools help penetration testers to streamline their discovery process and collect information about the target.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Running the Script](#running-the-script)
  - [Modes](#modes)
  - [Examples](#examples)
- [Summary Files](#summary-files)
- [Tool Installation](#tool-installation)
- [License](#license)

---

## Prerequisites

Before running the scripts, ensure you have the following tools installed:

- **Nmap**
- **Whois**
- **Dig**
- **Nikto**
- **Gobuster**
- **Wpscan** (optional for brute force testing)

Use the provided `checkRequirements.sh` script to verify if all required tools are installed.

## Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/guerriers/1CommandTools.git
   cd 1CommandTools
   ```

2. Edit the `target.txt` file to set up your targets:

   ```
   LHOST=10.10.10.10  # Your local IP (e.g., your attacking machine)
   RHOST=192.168.1.1  # The target IP address for reconnaissance scans
   TARGET_URL=http://localhost/  # The target URL for web testing (e.g., a website)
   ```

3. Run the checkRequirements.sh script to ensure all tools are installed:

   ```
   ./checkRequirements.sh
   ```

   If any tools are missing, the script will attempt to install them.

## Running the Script

### Modes

The main script `1CommandTools.sh` automates various pentesting tools based on the mode you select. The following modes are available:

- `0`: Run **all tools** (Reconnaissance, Directory Listing, and Bruteforce Scanning)
- `1`: Run **Reconnaissance** tools (Nmap, Whois, Dig)
- `2`: Run **Directory Listing** tools (Nikto, Gobuster)
- `3`: Run **Bruteforce Scanning** tools (e.g., placeholder for future bruteforce tools)

Each mode performs a specific set of tasks depending on the nature of the target.

### Examples

1. **Run All Tools (Recon, Directory Listing, and Bruteforce Scanning)**:
   ```
   ./1CommandTools.sh 0
   ```
2. Run Reconnaissance Only:

   ```
   ./1CommandTools.sh 1
   ```

3. Run Directory Listing Only:

   ```
   ./1CommandTools.sh 2
   ```

4. Run Bruteforce Scanning Only (Placeholder):
   ```
   ./1CommandTools.sh 3
   ```

## Summary Files

The script generates the following summary files based on the mode used:

- **`*_summary_recon.txt`** — Contains the results from Nmap, Whois, and Dig, including:

  - Open ports and services
  - Basic DNS information (using Dig)
  - Whois information

- **`*_summary_dirlist.txt`** — Contains results from Nikto and Gobuster, including:

  - Directories and files found
  - Vulnerabilities identified by Nikto (e.g., CVEs, potential misconfigurations)

- **`*_summary_bruteforce.txt`** — Contains results from bruteforce scanning tools such as Wpscan (placeholder), including:

  - Detected weak credentials
  - Notes from bruteforce attempts

- **`*_summary_all.txt`** — A combined summary of all scans (Recon, Directory Listing, and Bruteforce Scanning). This file is generated when running mode `0` and consolidates all the results for easy reference.

Each summary file is generated based on the target IP or URL and mode selected. Recon summaries use the target IP as a prefix, while Directory Listing and Bruteforce summaries use the sanitized target URL. The combined `_summary_all.txt` concatenates the individual summaries.

## Tool Installation

To verify or install missing tools, run the `checkRequirements.sh` script:

```bash
./checkRequirements.sh
```

This script checks for the required tools and how to install the missing tools.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
