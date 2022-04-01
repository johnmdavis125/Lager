#!/bin/zsh
echo -e '\n\n\n\n\n\n\n\n\n'
genTimestamp() {
        TIMESTAMP=$(date)
    }

echo "        ---   Welcome to Lager! What'll it be?   ---"
echo -e "\n" 
echo "                             |~~~~|__"
echo "                             | o  |  |"
echo "                             |   o|__|"
echo "                             |____|"

echo -e '\n\n'
read "?'c' to create a new record, 's' to search existing records: " CHOSEN_ACTION


if [ '$CHOSEN_ACTION'='c' ]
then
    typeset -A CATEGORIES
    CATEGORIES=([cp]=Code_Projects [cc]=Coding_Course [hh]=Holy_Hour [wo]=Work_Out [kp]=KDP [gp]=Guitar_Practice [ph]=Photography_Videography [ps]=Photoshop [dn]=Design [ts]=Tee_Shirt_Business [ct]=CompTia [re]=Real_Estate [dl]=Dev_Log [el]=Electronics_PCB [rd]=Reading_Books) 

    echo "CREATE NEW RECORD"
    echo "Category Options:"
    for KEY VALUE in ${(kv)CATEGORIES}
    do
        echo "$KEY: $VALUE"
    done
    
    read "?Enter the appropriate 2-letter key code: " KEY_CODE

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


