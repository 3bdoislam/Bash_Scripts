#!/bin/bash

# Function to generate a random password
generate_password() {
    length=$1
    use_lowercase=$2
    use_uppercase=$3
    use_numbers=$4
    use_special_chars=$5

    # Define character sets
    lowercase="abcdefghijklmnopqrstuvwxyz"
    uppercase="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    numbers="0123456789"
    special_chars="!@#$%^&*()-=_+[]{}|;:'\",.<>/?\`~"

    # Initialize the password variable
    password=""

    # Combine character sets based on specified criteria
    all_chars=""
    [ "$use_lowercase" = true ] && all_chars+="$lowercase"
    [ "$use_uppercase" = true ] && all_chars+="$uppercase"
    [ "$use_numbers" = true ] && all_chars+="$numbers"
    [ "$use_special_chars" = true ] && all_chars+="$special_chars"

    # Check if at least one character set is selected
    if [ -z "$all_chars" ]; then
        echo "Error: At least one character set (lowercase, uppercase, numbers, special characters) must be selected."
        exit 1
    fi

    #Generate the random password
    for ((i = 0; i < length; i++)); do
        password+=${all_chars:$((RANDOM % ${#all_chars})):1}
    done

    echo "$password"
}

# Main function
main() {
    if [ "$#" -lt 1 ]; then
        echo "Usage: $0 <password_length> [options]"
        echo "Options:"
        echo "  -l  Include lowercase letters"
        echo "  -u  Include uppercase letters"
        echo "  -n  Include numbers"
        echo "  -s  Include special characters"
        exit 1
    fi

    # Parse command line arguments
    length=$1
    use_lowercase=false
    use_uppercase=false
    use_numbers=false
    use_special_chars=false

    # Check options
    for option in "${@:2}"; do
        case $option in
            -l) use_lowercase=true ;;
            -u) use_uppercase=true ;;
            -n) use_numbers=true ;;
            -s) use_special_chars=true ;;
            *)
                echo "Invalid option: $option"
                exit 1
                ;;
        esac
    done

    # Generate and display the password
    password=$(generate_password "$length" "$use_lowercase" "$use_uppercase" "$use_numbers" "$use_special_chars")
    echo "Generated Password: $password"
}

# Run the script
main "$@"