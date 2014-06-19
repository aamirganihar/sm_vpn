#DESCRIPTION: This file contains details needed to login to Surveyhead site and Usampadmin site which is required by the 
#the script "" 

# USAMP ADMIN LOGIN CREDENTIALS

$usamp_email = "rahul_halankar@persistent.co.in"
$usamp_passwd = "rahul123"

$wd=Dir.pwd
$qgidpth = $wd+"/Input Repository/QG_ID.txt"
$pridpth = $wd+"/Input Repository/Project_Id_In_Use.txt"

# QG CRITERIA DETAILS

$ethnicity = "Native American, Eskimo, Aleutian"
$inc_level = "Decline to answer"
$origin = "Mayotte"
$education = "Advanced degree"
$postal_code_path = $wd+"/Config Management/CAN_PCODE.csv"
$state = "Newfoundland and Labrador"
$city = "AQUAFORTE"
$fsa_path = $wd+"/Config Management/CAN_FSA.csv"


# SURVEYHEAD/PL SIGNUP DETAILS

$url = "http://www.sm.p.surveyhead.com"
$country = "Canada"
$lang = "English"
$pcode_match = "A0A 1A0"
$day = "04"
$month = "July"
$year = "1980"
$employment = "Homemaker"
$marrital_status = "Never married"
$area_code = "204,250,306,403,416,418,450,506,514,519,604,613,705,709,780,807,819,867,902"
$pcode_mismatch = "A1B 3S4"
$pcode_mismatch2 = "K0K 1C0"

# PROFILE CRITERIA DETAILS

$prof_nm = "World View Profile NON_US - MD"
$prof_dn = "World View"
$quest = "How closely do you follow news about politics and government?"
$ans = "Very closely"




