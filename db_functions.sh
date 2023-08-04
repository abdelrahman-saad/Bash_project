
#########################################################
## This file hold declarations for functions used for DB#
##     this containes (Create, Drop, List, Connect)    ##
#########################################################

DB_DIR='./DATABASES'

list_DB() {
    lines=`ls $DB_DIR | wc -l`
    if (( lines ==0 )); then
        echo no databases found
    else
        echo `ls $DB_DIR`
    fi
}
