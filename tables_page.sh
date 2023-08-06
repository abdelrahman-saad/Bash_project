# Importing tables control file
source ../../tables_function.sh

pwd
table_menu=('Create Table' 'List Table' 'Drop Table' 'Insert into Table' 'Select from Table' 'Delete from Table' 'Update Table' 'Exit')

while true; do
    
    select item in "${table_menu[@]}"; do

        case $REPLY in
            1)
                echo $item
            ;;
            2)
                list_tables
            ;;
            3)
                drop_table
            ;;
            4)
                echo $item
            ;;
            5)
                echo $item
            ;;
            6)
                echo $item
            ;;
            7)
                echo $item
            ;;
            8)
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