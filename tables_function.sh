
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