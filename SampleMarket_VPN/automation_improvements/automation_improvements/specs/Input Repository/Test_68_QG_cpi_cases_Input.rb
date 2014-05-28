# PUBLISHER AUTO-ADD & QG CPI CASES INPUT 

# USAMPADMIN LOGIN CREDENTIALS

$admin_email = "rahul_halankar@persistent.co.in"
$admin_passwd = "rahul123"

$std_us_perc = '3.00'
$std_non_us_perc = '2.00'
$fcpi_perc = '5.00'
$cap_amt = '4.00'

# ACTUAL CPI VALUES (IN DOLLARS)
$std_us = '$0.30'         # $std_us = $std_us_perc * $qg_cpi / 100; ($qg_cpi = $10 in our case) 
$std_non_us = '$0.20'     # $std_non_us = $std_non_us_perc * $qg_cpi / 100; ($qg_cpi = $10 in our case)
$fcpi = '$0.40'	          # $fcpi = ($qg_cpi - $reward) * $fcpi_perc / 100 ; ($qg_cpi = $10 & $reward = $2 in our case)

$sc_red_url = 'http://p.u-samp.com/redirect.php?S=1'

$pub_id = 'PU264'
$pub_name = 'Automation FCPI/Normal Test Pub'

#MEMBER DETAILS

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
$inc_level = "Prefer not to answer"
$origin = "Mayotte"
$education = "Advanced degree"