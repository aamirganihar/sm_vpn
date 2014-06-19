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
$MAIL = "test25.des"
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

$project_name = "TEST_QG_TRACKING_STUDY"

$Project_id = "PR10840"
$QG1_name = "	Test Automation QG_Thu Oct 21 11:39:27"
$QG1_number = "QG47034"

$QG2_name = "Copy (1) of Test Automation QG_Wed Oct 20 10:39:04"
$QG2_number = "QG47004"
      $QG2 = $QG2_number.slice(2..6)
      puts $QG2
$usamp_email = "rahul_halankar@persistent.co.in"
$usamp_passwd = "rahul123"
#$tracking_id = $QG1_number+" "+$QG1_name
$tracking_id = $QG1_number+$QG1_name
p $tracking_id
$tracking_id = $tracking_id.gsub(/\t/, " ")
p $tracking_id