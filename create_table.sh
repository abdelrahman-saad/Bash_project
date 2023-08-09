#############################################################
###    This file hold declarations for creating Tables    ###
#############################################################


source "../../create_table_functions.sh"
echo "Welcome to table options for table # ${1} #"
column_menu=('Add Column' 'View Columns' 'Delete Column' 'Mark PK' 'Done' 'Exit' )

pk_selected=1
touch "$1" "$1.txt"
# chmod a+w "$1.txt"

while true; do

    select item in "${column_menu[@]}"; do

        case $REPLY in

            1)
                create_table "$1" # this is found in create_table_functions.sh //// we use $1 for file that will contain meta data 
                ;;
            2)
                list_columns "$1"
                ;;
            3)
                delete_column "$1"
                ;;
            4)
            ;;
            5)
            ;;
            6)
            ;;
            *)
            echo not a valid option
        esac
    done


done