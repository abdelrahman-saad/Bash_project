#############################################################
## This file hold declarations for functions used for       #
## table manipulation (insert, select, delete, update )     #
#############################################################

insert_into() {
    echo ${COL_NAMES}
    echo ${META_DATA}
    meta_data=(${META_DATA[@]})
    length=(${#meta_data[@]})
    read -p "Please enter the values separated with comma: " input

    IFS=',' read -r -a input_array <<< "$input"

    if [[ ${#input_array[@]} -eq length ]]; then
        #get the index of the primary key from metadata file using sed
        pk_index=$(sed -n '/@/=' "$1")

        #convert the item into an integer
        val=$((pk_index - 1))

        #get the item in the user input array that corresponds to the pk 
        pk_value="${input_array[val]}"

        #check if the pk is empty
        if [ -z ${input_array[val]} ]; then
            echo the PK should not be empty
            return 1
        fi

        #check if the pk does exist in the data
        if grep -q "^${pk_value}," "$1.txt"; then
            echo "Value '$pk_value' already exists in column '$((pk_index))'."
            return 1
        fi

        #remove @ from the pk to check on its data type
        meta_data=("${meta_data[@]//@/}")

        valid_input=true
        for ((i = 0; i < ${#input_array[@]}; i++)); do
            if [[ "${meta_data[i]}" == "string" && ! "${input_array[i]}" =~ ^[[:alnum:]]+$ ]]; then
                valid_input=false
                echo "Invalid string data type at index $i"
                break
            elif [[ "${meta_data[i]}" == "int" && ! "${input_array[i]}" =~ ^[0-9]+$ ]]; then
                valid_input=false
                echo "Invalid int data type at index $i"
                break
            fi
        done

        if $valid_input; then
            # Insert values into file separated by commas
            echo "$(IFS=,; printf '%s' "${input_array[*]}")" >> "$1.txt"
            echo "Values inserted successfully."
        fi
    else
        echo "Please stick to the same number of columns"
    fi


}

select_from() {
    echo 'select from the column names below you want to have the condition for'

    cols=(${COL_NAMES[@]})
    length=(${#cols[@]})


    for ((i = 0; i < length; i++)); do
        echo "$((i + 1)): ${cols[i]}"
    done  
    echo 'type all to print all lines'
    read -p "column number : " answer

    if ((answer >= 1 && answer <= length)); then
        selected_column="${cols[answer - 1]}"
        read -p "Enter the value to check in column '$selected_column': " value

         # Print the header line
        for ((i = 0; i < ${#cols[@]}; i++)); do
            printf "%-20s" "${cols[i]}"
        done
        echo ""

        # Print the data records
        awk -F ',' -v col="$answer" -v val="$value" '
            NR > 0 && $col == val {
                for (i = 1; i <= NF; i++) printf "%-20s", $i
                print ""
            }
        ' "$1.txt"

    elif [[ $answer == 'all' ]]; then

     # Print the header line
    for ((i = 0; i < ${#cols[@]}; i++)); do
        printf "%-20s" "${cols[i]}"
    done
    echo ""

    # Print all data records
    awk -F ',' '
        NR > 0 {
            for (i = 1; i <= NF; i++) printf "%-20s", $i
            print ""
        }
    ' "$1.txt"
    else
        echo "Invalid column number."
    fi


}

delete_from() {
    echo 'select from the column names below you want to have the condition for'

    cols=(${COL_NAMES[@]})
    length=(${#cols[@]})

    for ((i = 0; i < length; i++)); do
        echo "$((i + 1)): ${cols[i]}"
    done  
    echo 'type all to delete all lines'
    read -p "column number : " answer

    if ((answer >= 1 && answer <= length)); then
        selected_column="${cols[answer - 1]}"
        read -p "Enter the value to check in column '$selected_column': " value

        # Delete rows using sed and store the number of rows deleted
        sed -i -E "/^([^,]*,){$((answer - 1))}$value,/d" "$1.txt" | echo "Rows Deleted Successfully "
    elif [[ $answer == 'all' ]]; then
        truncate -s 0 "$1.txt" | echo "All Records were successfully deleted"
    else
        echo "Invalid column number."
    fi


}

update_table() {

echo 'select from the column names below you want to have the condition for'

cols=(${COL_NAMES[@]})
length=(${#cols[@]})

for ((i = 0; i < length; i++)); do
    echo "$((i + 1)): ${cols[i]}"
done  

read -p "Enter the number of the column: " answer
 selected_column="${cols[answer - 1]}"
read -p "Enter the old value to replace in column $selected_column: " old_value
read -p "Enter the new value: " new_value

# Update rows using awk in-place and store the number of rows updated
updated_count=$(sed -i -E "1,\$ s/^(([^,]*,){$((answer - 1))})$old_value,/\1$new_value,/" "$1.txt")

echo "Values Updated Successsfully"

}