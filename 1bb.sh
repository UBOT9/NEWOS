#!/bin/bash

# Initialize an empty array to store address book records
declare -a address_book

# Function to create an address book
create_address_book() {
    read -p "Enter the number of records: " n

    for ((i = 0; i < n; i++)); do
        read -p "Enter details for record $((i + 1)) (name phone email): " name phone email
        address_book+=("$name|$phone|$email")
    done

    echo "Address book created successfully!"
}

# Function to view the address book
view_address_book() {
    if [ ${#address_book[@]} -eq 0 ]; then
        echo "Address book is empty."
    else
        echo "Address Book:"
        printf "%-10s | %-10s | %-10s\n" "Name" "Phone" "Email"
        echo "-----------------------------"
        for record in "${address_book[@]}"; do
            IFS='|' read -r -a fields <<<"$record"
            printf "%-10s | %-10s | %-10s\n" "${fields[0]}" "${fields[1]}" "${fields[2]}"
        done
    fi
}

# Function to insert a record into the address book
insert_record() {
    read -p "Enter details for new record (name phone email): " name phone email
    address_book+=("$name|$phone|$email")
    echo "New record inserted successfully!"
}

# Function to delete a record from the address book
delete_record() {
    read -p "Enter the name of the record to delete: " name
    found=false

    for ((i = 0; i < ${#address_book[@]}; i++)); do
        if [[ "${address_book[$i]}" == *"$name"* ]]; then
            unset address_book[$i]
            address_book=("${address_book[@]}")
            found=true
            echo "Record deleted successfully!"
            break
        fi
    done

    if ! $found; then
        echo "Record not found."
    fi
}

# Function to modify a record in the address book
modify_record() {
    read -p "Enter the name of the record to modify: " name
    found=false

    for ((i = 0; i < ${#address_book[@]}; i++)); do
        if [[ "${address_book[$i]}" == *"$name"* ]]; then
            read -p "Enter new details for the record (name phone email): " new_name new_phone new_email
            address_book[$i]="$new_name|$new_phone|$new_email"
            found=true
            echo "Record modified successfully!"
            break
        fi
    done

    if ! $found; then
        echo "Record not found."
    fi
}

# Main program loop
while true; do
    echo "Options:"
    echo "1. Create address book"
    echo "2. View address book"
    echo "3. Insert a record"
    echo "4. Delete a record"
    echo "5. Modify a record"
    echo "6. Exit"

    read -p "Enter your choice: " choice

    case $choice in
    1) create_address_book ;;
    2) view_address_book ;;
    3) insert_record ;;
    4) delete_record ;;
    5) modify_record ;;
    6) exit ;;
    *) echo "Invalid choice. Try again." ;;
    esac
done

