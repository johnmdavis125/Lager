#!/bin/zsh
echo "do some stuff"
mongo --eval "
    db = db.getSiblingDB('lagerDB'); 
    db.records.insertOne({'userName': 'johndavis', 'date': '29 Mar 2022', 'category': 'Coding Projects', 'Duration': '60', 'timeOfEntry': '0000' }); 
    db.records.insertOne({'userName': 'johndavis', 'date': '29 Mar 2022', 'category': 'Coding Projects', 'Duration': '60', 'timeOfEntry': '0000' }); 
    db.records.find({}).forEach(printjson); 
"

echo "do some more stuff"
