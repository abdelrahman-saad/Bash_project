
#############################################################
## This file hold declarations for functions used for Tables#
#############################################################

source '../../db_functions.sh'

list_tables() {
    lines=`ls | grep *.txt |wc -l`
    if (( lines == 0 )); then
        echo no tables found
    else
        ls | grep *.txt
    fi 
}

drop_table() {
    read -p "Enter table name you want to drop: " table_drop
    if [[ -f "${table_drop}.txt" ]]; then
        rm  $table_drop "${table_drop}.txt"
        echo table deleted successfully \# $table_drop \#
    else
        echo the table does not exist 
    fi
}

create_table() {
    read -p 'Enter table name :' table_name
    if [[ -f $table_name ]]; then
        echo table name already exists
    else
        if [[ -n $table_name ]]; then
            if validate_heading $table_name ; then
                clear
                bash ../../create_table.sh $table_name   
            else
                echo please enter a vialid table name        
            fi
        else
            echo please enter a non-empty table name
        fi
    fi

}

connect_table() {
    read -p 'Enter table name you want to connect :' table_name
    # Check if table_name ends with .txt and remove it

    if [[ "$table_name" == *.txt ]]; then
        table_name="${table_name%.txt}"
    fi

    if [[ -f $table_name ]]; then
        if [[ -n $table_name ]]; then
        #initialize array
            column_names=()
            metadata=()
        # fill arrays with awk expression to capture metadata and column names 
            readarray -t column_names < <(awk -F ':' '{print $1}' "$table_name")
            readarray -t metadata < <(awk -F ':' '{print $2}' "$table_name")
            # echo "Column Names: ${column_names[@]}"
            # echo "Metadata: ${metadata[@]}"

            #go to file manipulation commands
        else
            echo please enter non-empty table name
        fi
    else
        echo table does not exist 
    fi
}