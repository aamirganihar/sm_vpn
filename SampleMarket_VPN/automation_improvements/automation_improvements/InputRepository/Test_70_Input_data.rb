#DESCRIPTION: This file contains details needed to login to Surveyhead site and Usampadmin site which is required by the 
#the script "" 

#NETWORK SITE CLIENT LOGIN DETAILS#

$usnet_email = "rahul_halankar@persistent.co.in"
$usnet_passwd = "1234"
$type = "Client"

$wd=Dir.pwd
$qgidpth = $wd+"/Input Repository/QG_ID.txt"
$pridpth = $wd+"/Input Repository/Project_Id_In_Use.txt"


#CLIENT PANELSHIELD PROJECT DETAILS#

$country ="UNITED STATES"
$survey_lnth = "5"

#SUPPLIER ADDITION DETAILS#

$supplier_nm = "Clear Voice"
$sup_id = "59"
$sup_allowed_link = "http://203.199.26.75/usamp/Test_auto/TEST_CP_SURVEY.php"
$sup_reject_link	= "http://203.199.26.75/usamp/Test_auto/TEST_CP_REJ.php"
$supplier2_nm = "AIP Corp"
$sup2_id = "1"
