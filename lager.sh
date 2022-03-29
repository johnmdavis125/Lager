#!/bin/zsh
echo ''
echo ''
echo ''
genTimestamp() {
        TIMESTAMP=$(date)
    }

echo "Welcome to Lager! What'll it be?" 
read "?'c' to create a new record, 's' to search existing records: " CHOSEN_ACTION

if [ '$CHOSEN_ACTION'='c' ]
then
    typeset -A CATEGORIES
    CATEGORIES=([cp]=code_projects [cc]=coding_course [hh]=holy_hour [wo]=work_out [kp]=KDP [gp]=guitar_practice [ph]=photography_videography [ps]=photoshop [dn]=design [ts]=tee_shirt_business [ct]=compTia [re]=real_estate [dl]=Dev_Log [el]=electronics_PCB [rd]=reading_books) 

    echo "CREATE NEW RECORD"
    echo "Category Options:"
    for KEY VALUE in ${(kv)CATEGORIES}
    do
        echo "$KEY: $VALUE"
    done
    
    read "?Enter the 2-letter appropriate 2-letter key code: " KEY_CODE

    ENTRY_CATEGORY=${CATEGORIES[$KEY_CODE]}
    echo "Selected Category: $ENTRY_CATEGORY"

    read "?Duration? (min): " DURATION

    USER_NAME=$(whoami)
    echo Username: $USER_NAME

    genTimestamp
fi

mongo --eval "
    db = db.getSiblingDB('lagerDB'); 
    db.records.insertOne({'userName': '$USER_NAME', 'category': '$ENTRY_CATEGORY', 'Duration': '$DURATION', 'Timestamp': '$TIMESTAMP' }); 
    db.records.find({}).forEach(printjson); 
"


