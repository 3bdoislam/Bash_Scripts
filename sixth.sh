#!/bin/bash

enumerate_subdomains() {
    local domain="$1"
    local iterations="$2"
    local output_file="subdomains_${domain}.txt"

    echo "Enumerating subdomains for ${domain}..."

    for ((i = 1; i <= iterations; i++)); do
        amass enum -d "$domain" -o "$output_file.amass.$i" -v
        subfinder -d "$domain" -o "$output_file.subfinder.$i" -silent
        cat "$output_file.amass.$i" "$output_file.subfinder.$i" | sort -u > "$output_file"
    done

    rm "$output_file.amass."* "$output_file.subfinder."*

    echo "Subdomains enumeration completed for ${domain}."
    echo "Unique subdomains saved to ${output_file}."
}

count_subdomains() {
    local domain="$1"
    local output_file="subdomains_${domain}.txt"
    local count=$(wc -l < "$output_file")

    echo "Total unique subdomains for ${domain}: ${count}"
}

main() {
    if [ "$#" -lt 2 ]; then
        echo "Usage: $0 <domain_file> <iterations>"
        exit 1
    fi

    domain_file="$1"
    iterations="$2"

    while IFS= read -r domain; do
        enumerate_subdomains "$domain" "$iterations"
        count_subdomains "$domain"
    done < "$domain_file"
}

main "$@"