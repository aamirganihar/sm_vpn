#DESCRIPTION: This file contains details needed to login to Surveyhead site and Usampadmin site which is required by the 
#the script "" 

# USAMP ADMIN LOGIN CREDENTIALS

$usamp_email = "rahul_halankar@persistent.co.in"
$usamp_passwd = "rahul123"

$wd=Dir.pwd
$qgidpth = $wd+"/Input Repository/QG_ID_2.txt"
$pridpth = $wd+"/Input Repository/Project_Id_In_Use.txt"


#UNITED SAMPLE QG CRITERIA DETAILS #

$county = "LOS ANGELES"
$city = "LOS ANGELES"
$state_fips = "6"
$zip_code_path = $wd+"/Config Management/US_ZIP_CODE.csv"
$m1_site = "FocuslineSurveys"



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
$state = "California"
$ethnicity = "Native American, Eskimo, Aleutian"
$inc_level = "Decline to answer"
$origin = "Belize"
$education = "Advanced degree"









