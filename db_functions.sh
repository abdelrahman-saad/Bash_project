
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

create_DB() {
    echo # to create an empty line for better user interface
    read -p "Enter Database name : " db_name
    if validate_heading $db_name; then
        if [ -d $db_name ]; then
            echo database already exists
        else
            mkdir $DB_DIR/$db_name
            echo database created successfully
        fi
    else
        echo could not create database it is wrongly named
    fi
}


## this is used to check for table names and database names
## this uses :punct: is to check, an advanced regex for all special chars
##
validate_heading() {
    var=$1
     if [[ $var =~ [0-9] || $var =~ [[:punct:]] ]]; then
        return 1
    fi
    return 0
}