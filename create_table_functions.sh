
source "../../db_functions.sh"

create_table() {
    read -p 'Enter Column Name and datatype (String, Int) seperated by a comma ( , )' line
    column_name=$(echo $line | cut -d ',' -f1)
    datatype=$(echo $line |cut -d ',' -f2)
    lower_datatype="${datatype,,}"
    if [[ -n "$column_name" && -n "$datatype" ]]; then
        if validate_heading "$column_name"; then
            if [[ "$lower_datatype" == "string" || "$lower_datatype" == "int" ]]; then
                if grep -q "^${column_name}" "$1"; then
                    echo "Column '$column_name' already exists in the table."
                else
                    echo "${column_name} : ${lower_datatype}" >> "$1"
                    if [[ $? -eq 0 ]]; then
                        echo "Column was added to table successfully"
                    else
                        echo "An issue happened while writing"
                        echo "$1"
                    fi
                fi
            else
                echo issue occured $lower_datatype
            fi
            else
                echo issue validated $lower_datatype
        fi
        else
        echo $column_name
        echo $lower_datatype
        echo values are empty
    fi
}

list_columns() {
    lines=`cat $1 | wc -l `
    if (( lines == 0 )); then
        echo no columns found
    else
        echo `cat $1`
    fi
}

delete_column() {
    read -p 'Enter Column Name you want to delete: ' line
    if [[ -n $line ]]; then
        count=$(sed -n "/^$line/p" "$1" | wc -l)
        if [[ $count -ge 1 ]]; then
        var=(`grep "^$line.*@$" "$1" | wc -l`)
            if [[ var -ge 1 ]]; then
            echo "cannot delete a pk column"
                return 1
            else
                sed -i "/^$line/d" "$1"
                echo column deleted successfully
            fi
        else
            echo please enter a valid column name
        fi
    else
        echo please enter a valid column name
    fi
}

delete_table() {
    read -p 'Are you sure you want to delete the table (y,n): ' answer
    lower_answer="${answer,,}"
    if [[ $lower_answer == 'y' ]]; then
        rm $1 $1.txt
        return 0
    fi
    return 1
}

select_pk() {
    read -p 'Which column do you want to mark as a pk: ' chosen_column
    if [[ -n $column_name ]]; then
    #adding a cape ^ to ensure the table name not datatype
        if grep -q "^$chosen_column" <<< "$(cat $1)"; then
        sed -i "/\b$chosen_column\b/s/$/@/" "$1"
        echo "Column '$chosen_column' marked as PK."
        return 0
        else
            echo "Column '$chosen_column' not found in the list."
            return 1
        fi
    else
        echo 'please enter a valid column name'
        return 1
    fi
}

save_table() {

    if ! $1; then
        echo "Cannot save table columns without selecting a pk"
        return 1
    fi

    read -p 'Are you sure you want to save the table (y,n): ' answer
    lower_answer="${answer,,}"
    if [[ $lower_answer == 'y' ]]; then
        return 0
    fi
    return 1
}