# The Project Features:
# The Application will be CLI Menu based app, that will provide to user this Menu items:
# Main Menu:
# - Create Database
# - List Databases
# - Connect To Databases
# - Drop Database

echo "Welcome to DB Engine project"

while true; do

    echo "Main Menu:"
    options=('Create Database' 'List Databases' 'Connect to Database' 'Drop Database' 'Exit')
    select opt in "${options[@]}"; do

        case $REPLY in
            1) 
                # TODO: use function to create database
                echo $REPLY
                ;;
            2) 
                # TODO: List DB
                echo $REPLY
                ;;
            3) 
                # TODO: Connect to DB
                echo $REPLY
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
                echo "Invalid choice. Please enter a number from 1 to ${#options[@]}."
                ;;
        esac
        done
        break

done