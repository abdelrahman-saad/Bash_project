
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

connect_DB() {
    read -p "Enter Database name you want to connect: " db_connect
    if [ -d $DB_DIR/$db_connect ]; then
        cd "$DB_DIR/$db_connect"
        clear
        echo connect to Database successfully \# $db_connect \#
        bash ../../tables_page.sh
    else
        echo the database does not exist 
    fi
}

drop_DB() {
    read -p "Enter Database name you want to drop: " db_drop
    if [ -d $DB_DIR/$db_drop ]; then
        rm -r $DB_DIR/$db_drop
        echo Database dropped successfully \# $db_drop \#
    else
        echo the database does not exist 
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