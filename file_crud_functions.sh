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