# Importing database control file
source ./db_functions.sh 


# create dir for database if not existed
mkdir -p $DB_DIR


echo "Welcome to DB Engine project"

while true; do

    echo "Main Menu:"

    # a var that holds the list options incase we want to add items for later
    menu=('Create Database' 'List Databases' 'Connect to Database' 'Drop Database' 'Exit')

    # select option from menu options 
    select item in "${menu[@]}"; do

        case $REPLY in
            1) 
                create_DB
                ;;
            2) 
                list_DB
                ;;
            3) 
                connect_DB
                ;;

            4) 
                # TODO: Drop DB
                echo $REPLY
                ;;
            5) 
                echo "Thanks for using the system :)"
                exit
                ;;
            *) 
                echo "Invalid choice. Please enter a number from 1 to ${#menu[@]}."
                ;;
        esac

        done

done