
echo "You are now connected to table #  $1  #"
crud_menu=('Insert into Table' 'Select from Table' 'Delete from Table' 'Update Table' 'Exit')
crud_bool=true

table_name=$1
column_names=$2
meta_data=$3

while $crud_bool; do
    
    select item in "${crud_menu[@]}"; do

        case $REPLY in
            1)
                echo $item
            ;;
            2)
                echo $item
            ;;
            3)
                echo $item
            ;;
            4)
                echo $item
            ;;
            5)
                echo exitting table 
                crud_bool=false
                break
            ;;
            *)
                echo please select a valid option
            ;;
        esac
    
    done

done