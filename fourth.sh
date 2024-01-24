#!/bin/bash

# Function to analyze image files using ExifTool
analyze_images() {
    echo "Analyzing image files..."
    for image in "$1"/*.jpg "$1"/*.jpeg "$1"/*.png "$1"/*.gif; do
        echo "Metadata for $image:"
        exiftool "$image"
    done
}

# Function to analyze audio/video files using Mediainfo
analyze_audio_video() {
    echo "Analyzing audio/video files..."
    for media in "$1"/*.mp3 "$1"/*.mp4 "$1"/*.avi "$1"/*.mkv; do
        echo "Metadata for $media:"
        mediainfo "$media"
    done
}

# Function to analyze network traffic using Tcpdump
analyze_network_traffic() {
    echo "Analyzing network traffic files..."
    for pcap in "$1"/*.pcap; do
        echo "Analyzing $pcap using Tcpdump:"
        tcpdump -n -r "$pcap"
    done
}

# Function to analyze text files using Strings
analyze_text_files() {
    echo "Analyzing text files..."
    for text_file in "$1"/*.txt "$1"/*.log; do
        echo "Strings from $text_file:"
        strings "$text_file"
    done
}

# Main function
main() {
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <directory>"
        exit 
    fi

    directory="$1"

    # Analyze different file types
    analyze_images "$directory"
    analyze_audio_video "$directory"
    analyze_network_traffic "$directory"
    analyze_text_files "$directory"
}

# Run the script
main "$1"