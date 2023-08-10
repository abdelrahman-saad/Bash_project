
source '../../file_crud_functions.sh'

echo "You are now connected to table #  $1  #"
crud_menu=('Insert into Table' 'Select from Table' 'Delete from Table' 'Update Table' 'Exit')
crud_bool=true

table_name=$1
# column_names=(${COL_NAMES})
# meta_data=(${META_DATA})
# echo ${column_names[@]}
# echo ${meta_data[@]}
while $crud_bool; do
    
    select item in "${crud_menu[@]}"; do

        case $REPLY in
            1)
                insert_into $table_name 
            ;;
            2)
                select_from $table_name
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