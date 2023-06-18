# ngx

NGX POS for Renuka Systems

# PROJECT MANAGEMENT:

TODO
#####

duplicates in consignor and customer name. currently using id column - use name-location (5) - check in db

after save, cursor move to first element

lot number not mandatory - "no lot"

token and retail

token no | date(DDMMYYYY)

Item wise summary - split it into 2
token:
item | rate | sum(units)
total weight = sum(wt)
retail
item | rate | sum(wt) | sum(amt)

option to alter key column in input files

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

--------------------------------------------- after demo 1

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

Db export separate files

--------------------------------------------- after demo 2

c and g - numeric
units mandatory in token
mark not mandatory
item name - not code use name

#################################################################################################################################################
ASK
####




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