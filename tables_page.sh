# Importing tables control file
source ../../tables_function.sh

pwd
table_menu=('Create Table' 'List Table' 'Drop Table' 'Connect Table' 'Exit')

while true; do
    
    select item in "${table_menu[@]}"; do

        case $REPLY in
            1)
                create_table # this is found in tables_functions.sh
            ;;
            2)
                list_tables
            ;;
            3)
                drop_table
            ;;
            4)
                connect_table
            ;;
            5)
                echo exitting database 
                clear
                break
            ;;
            *)
                echo please select a valid option
            ;;
        esac
    
    done
break
done