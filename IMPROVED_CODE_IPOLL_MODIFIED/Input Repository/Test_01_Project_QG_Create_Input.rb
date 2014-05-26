#require '..\surveyurl.rb'
#DESCRIPTION: This file contains data that is required by the "" script , to verify whether #

#NOTE: All the lines enclosed within two '#' characters are comments.#
#      The lines with actual data are without '#' characters and,#
#      In the data, text before the '::' character (text to the left of the '::' character) are FIELD NAME#
#      And text after the '::' character (text to the right of '::' character) are ACTUAL DATA#
#      The '::' character is a separator between the Field name and the actual data and hence is very important#
#      Make sure the '::' chracter is not modified#
#      Do not alter the sequence in which the test data is written #


# USAMPADMIN LOGIN CREDENTIALS

$admin_email = "a1b2c3neethi_thilakan@persistent.co.in"
$admin_passwd = "Neethi@123"

#PROJECT CREATION DETAILS
$proj_status = "Open"
$proj_type = "Survey"
$proj_end_date = "2015-10-20"
$bid_no = "1200123"
$booked_month = "February"
$booked_year = "2011"
$booked_rev = "12000"
$proj_rev = "1200000"
$exp_close_month = "February"
$exp_close_year = "2011"
$client = "TEST CLIENT (RRH)"
$sales_rep = "Neethi T"
$client_pm = "test fname test lname"
$upload_file_loc = "" 

#QUOTA GROUP DETAILS 

$qg_status = "Open"
$qg_close_date = "2015-12-30"
$n = "100"
$inc = "2"
$inc_range = "General_population"
$qg_cat = "Business"
$length = "2"
$cpi = "10"
$rew_type = "Cash" # (Cash/Sweepstakes)
$rew_amt = "2"
$fail_rew_amt = '1'
$oq_rew_amt = '1'
$survey_url = "#{$surveyurl}"
$pub_name = "Test PUB (30 Sept)"

#QUOTA GROUP CRITERIA

$ethnicity = "Native American, Eskimo, Aleutian"
$inc_level = "Prefer not to answer"
$origin = "Mayotte"
$education = "Advanced degree"


