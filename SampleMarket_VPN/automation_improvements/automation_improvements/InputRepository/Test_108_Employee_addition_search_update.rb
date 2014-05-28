$usamp_email = "rahul_halankar@persistent.co.in"
$usamp_passwd = "rahul123"
$Department = "Business Development Dept"
$extension = Time.new
$extension = $extension.to_s
$extension = $extension.slice(13..18)
$mail_address1="test23_"+$extension
$mail_address="test23_des"+$extension+"@mailop.com"
$mail_address = $mail_address.gsub(/:/, "")
#$mail_address1 = $mail_address1.gsub(/:/, "")

$fname = "Test_fname"+$extension
$lname = "Test_lname"+$extension
$fname = $fname.gsub(/:/, "")
$lname = $lname.gsub(/:/, "")

puts $fname
puts $lname
puts $mail_address


