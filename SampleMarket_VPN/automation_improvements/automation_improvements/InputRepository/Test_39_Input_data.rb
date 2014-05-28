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
$area_code_path = $wd+"/Config Management/US_AREACODE.csv"
$cbsa = "31100"
$country_fips = "06037"
$dma = "803"
$miles = "5"
$miles_zip = "90002"
$msa_pmsa = "4472"
$state = "California"
$county = "LOS ANGELES"
$city = "LOS ANGELES"
$state_fips = "6"
$zip_code_path = $wd+"/Config Management/US_ZIP_CODE.csv"


# SURVEYHEAD/PL SIGNUP DETAILS

$url = "http://www.sm.p.surveyhead.com"
$country = "United States"
$lang = "English"
$zip_match = "90001"
$day = "04"
$month = "July"
$year = "1980"
$employment = "Homemaker"
$marrital_status = "Never married"
$state_mismatch = "Georgia"

# PROFILE CRITERIA DETAILS

$prof_nm = "Casinos & Gambling - US English (JB & LWB)"
$quest = "Thank you for agreeing to participate in our casinos and gambling profile! Based on your responses, we may invite you to participate in future surveys ranging on a wide variety of interesting topics. How many times have you visited Las Vegas within the last 12 months?"
$ans = "None"



