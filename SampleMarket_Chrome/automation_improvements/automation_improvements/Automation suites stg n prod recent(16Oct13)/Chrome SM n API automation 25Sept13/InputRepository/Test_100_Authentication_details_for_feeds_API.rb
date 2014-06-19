#DESCRIPTION: This file contains details needed to test the member registration functionality# 

#NOTE: All the lines enclosed within two '#' characters are comments.#
#      The lines with actual data are without '#' characters and,#
#      In the data, text before the '::' character (text to the left of the '::' character) are FIELD NAME#
#      And text after the '::' character (text to the right of '::' character) are ACTUAL DATA#
#      The '::' character is a separator between the Field name and the actual data and hence is very important#
#      Make sure the '::' chracter is not modified#
#      Do not alter the sequence in which the test data is written #


#MEMBER CREATION DETAILS#
$FNAME = "Nitin"
$LNAME = "Kumar"
$COUNTRY = "United States"
$LANGUAGE = "English"
$STATE = "California"
$Zip_code = "90001"
$DATE = "04"
$MONTH = "July"
$YEAR = "1985"
$EMAIL = "test22_des@mailop.com"
$MAIL = "test22_des"
$PASSWORD = "test"
$INCOME = "10,000- 19,999"
$EDUCATION = "High school graduate"
$EMPLOYMENT = "Full-Time Employee"
$INDUSTRY = "Computers: Software / Services"
$ROLE = "Executives"
$JOB_TITLE = "Partner"
$ETHNICITY = "African American"
$MARITIAL_STATUS = "Never married"
$COUNTRY_ORIGIN = "United States"

#The language speaking value depends from person to person. There are certain values that can be set#
#I am using the values for English --> 2, French --> 3, #
#Here it is default set to English as reading and writing and using the default values#
$CHILDREN = "N"
#User invite #
#I would like to receive a maximum of 1 email each week. --> 1#
#I would like to receive a maximum of 2-3 emails each week.--> 3#
#I would like to receive a maximum of 4-5 emails each week.--> 5#
#I would like to receive a maximum of 6-7 emails each week.--> 7#
#I do not have a preference in the maximum number of emails I receive each week.--> 0#
$INVITE = "0"

#UNITED SAMPLE PROJECT CREATION DETAILS #
$PROJECT_STATUS = "Open"
$PROJECT_TYPE = "Survey"
$PROJECT_END_DATE = "2011-10-20"
$BID = "1200123"
$BOOKED_MONTH = "February"
$BOOKED_YEAR = "2010"
$BOOKED_REVENUE = "12000"
$PROJECT_REVENUE = "1200000"
$EXP_CLOSE_MONTH = "February"
$EXP_CLOSE_YEAR = "2011"
$CLIENT	 = "TEST CLIENT (RRH)"
$SALES_REP = "Rahul Halankar"
$CLIENT_PM = "test fname test lname"


#UNITED SAMPLE QG CREATION DETAILS #
$QG_STATUS = "Setting Up"
$QG_CLOSE_DATE = "2010-12-30"
$N_Sample_Size = "100"
$INCIDENCE = "2"
$INCIDENCE_RANGE = "General_population"
$QG_CATEGORY = "Business"
$LENGTH	 = "Time"
$TIME_QNS = "2"
$CPI	 = "10"
$REW_TYPE = "Cash"
$REW_AMOUNT = "10"
$NEW_REW_AMOUNT = "20"
$FAIL_REW_AMT = "1"
$OVERQUOTA_REW_AMT = "1"
$SURVEY_URL = "http://203.199.26.75/usamp/TEST_SURVEY.php"
$PUBLISHER_NAME = "Test PUB (30 Sept)"

$usamp_email = "rahul_halankar@persistent.co.in"
$usamp_passwd = "rahul123"
$uname = "usernitin"
$passwd = "passnitin"