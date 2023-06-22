# ngx

NGX POS for Renuka Systems

# PROJECT MANAGEMENT:

TODO
#####

token - print - remove consignor
remove title customer name and item name

item wise report - add date
item wise report - grand total amount

every drop down should have search

date and time

customer balance - date - today

token load slow for consignor and item dropdown

duplicates check in input file

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
item csv import check - no nulls
after save, cursor move to first element
token no | date(DDMMYYYY)
save in print - under canSave flag
lot number not mandatory - "no lot"

duplicates in consignor and customer name. currently using id column - use name-location (5) - check in db
construct name-loc
deconstruct name-loc to id

add all columns to input file validation

decouple validation and savetodb

print token
print retail

print others

Item wise summary - split it into 2
token:
item | rate | sum(units)
total weight = sum(wt)
retail
item | rate | sum(wt) | sum(amt)
but made common as
item name
rate:
total_units:
total_weight:
total_amount:

#################################################################################################################################################
ASK
####

item wise report - only today? db wipe?

#################################################################################################################################################
ASKED
####

Db wipe logic - put password protection (renuka)
Cash payment logic  = payment_type + cash - [X]
Date not correct. Manual input? - battery problem
Customer Balance -> from Receipt. no from input file

#################################################################################################################################################
Assumptions:
####

"Consignor Code" must in consignor input csv ; else file not loaded
"Customer Code" must in customer input csv ; else file not loaded
"ClosingBalance" must in customer input csv ; else file not loaded
"ClosingBalance" must not have blanks in customer input csv; else file not loaded
"ClosingBalance" must be integer in customer input csv; else file not loaded
"Item Name" must in item input csv; else file not loaded
"Item Name" must not have blanks