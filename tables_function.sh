
#############################################################
## This file hold declarations for functions used for Tables#
#############################################################

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
    ls "${table_drop}"*
    pwd
    if [[ -f "${table_drop}.txt" ]]; then
        rm  $table_drop "${table_drop}.txt"
        echo table deleted successfully \# $table_drop \#
    else
        echo the table does not exist 
    fi
}