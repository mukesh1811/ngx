# ngx

NGX POS for Renuka Systems

# PROJECT MANAGEMENT:

TODO
#####


option to alter key column in input files

Db export separate files

print

Test

Clean up

Export

Code commit

Delivery

#################################################################################################################################################
DONE
#####

Login - ui
Login - db

Register - ui
Register - db

Home - ui

Token - ui
Token - db

Receipt - ui
Receipt - db

Balance - logic
Balance - db pull

Retail - ui
Retail - db

Settings - login page - ui
Settings - login page - db
Settings - change pwd - ui
Settings - change pwd - db
Settings - config functionality
Settings - Export db
Settings - db wipe and export

Set bg picture

Set icon

printTest

Remove exit button from all pages

Remove No.of copies text field from all pages

Lot No:
create screen
lot number text field -> alphanumeric
consignor name drop down
item name drop down
save button -> db update

TOKEN:
move lot no up
lot no -> dropdown
consignor auto update
item name auto update
amt = (wt ? Units) * rate
remove units null check; either wt or units

RETAIL:
amt = (wt ? Units) * rate
remove units null check; either wt or units

Load config file -> split into 3
load consignor name
load item name
load customer name

Pull existing ticket - null check

check and import csv files shared by client

delete config.dart

take closing balance from customer file
customer csv import check - balance column
customer csv import check - no nulls in balance column

#################################################################################################################################################
ASK
####

duplicates in consignor and customer name. currently using id column

Db wipe logic
Cash payment logic
payment_type + cash
Date not correct. Manual input?
Customer Balance -> from Receipt. no from input file


#################################################################################################################################################
Assumptions:
####

"Consignor Code" must in consignor input csv ; else file not loaded
"Customer Code" must in customer input csv ; else file not loaded
"ClosingBalance" must in customer input csv ; else file not loaded
"ClosingBalance" must not have blanks in customer input csv; else file not loaded
"ClosingBalance" must be integer in customer input csv; else file not loaded
"Item Code" must in item input csv; else file not loaded