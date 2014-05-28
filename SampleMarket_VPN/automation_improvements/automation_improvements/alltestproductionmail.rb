require 'rubygems'
#require 'watir'
require 'test/unit'
#Load WATIR
require 'fileutils'
# Load WIN32OLE library
require 'win32ole' 
require 'Win32API'
require 'net/smtp'
require 'fileutils'
require 'net/imap' 
require 'net/pop'
#run gem install tlsmail and gem install mail before requiring tlsmail
require 'tlsmail'
require 'csv'
require 'YAML'

message = <<MESSAGE_END
From: USAMP QA Automation <USAMPQA@usamp.com>
To: usample_qa <usample_qa@persistent.co.in>; Abhijit Gaonkar <abhijit_gaonkar@persistent.co.in>; Steve Fernandes <steve_fernandes@persistent.co.in>;Vivek Samant <vivek_samant@persistent.co.in>
MIME-Version: 1.0
Content-type: text/html
Subject: SampleMarket automation suite has started

The production automation suite has started.<br><br>

Thanks,<br>
Test Automation team<br>

MESSAGE_END



Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(message, 'qa@gmail.com', 'usample_qa@persistent.co.in')
end

Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(message, 'qa@gmail.com', 'abhijit_gaonkar@persistent.co.in')
end

Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(message, 'qa@gmail.com', 'steve_fernandes@persistent.co.in')
end

#Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
 # smtp.send_message(message, 'qa@gmail.com', 'Ramanath_Kamat@persistent.co.in')
#end

Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(message, 'qa@gmail.com', 'vivek_samant@persistent.co.in')
end

Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(message, 'qa@gmail.com', 'aamirhamza_ganihar@persistent.co.in')
end

system ("runproductionalltest.bat")

system ("productionsummaryalltest.bat")

#File.open("InputRepository/results_stage.yml","r"){|file| YAML.dump(test_result,file)}
test_result = File.open("InputRepository/results_alltest.yml"){|file| YAML::load(file)}
total = test_result['total'] 
fail = test_result['fail'] 
pass = test_result['passed'] 
puts total
puts fail
puts pass



$wd=Dir.pwd
filename = $wd+"/AllTest.html"
	

summary =<<EOF
<html>
<body><center>
<h2><u>Test Automation Summary</u></h2><br /><center><table border=2 width="500px">
<tr><td class="td2"><font color="Black">Total Test Cases:</td>
<td class="td3">#{total}</td>
<tr><td class="td2"><font color="green">Test Cases Passed:</td>
<td class="td3">#{pass}</td>
<tr><td class="td2"><font color="Red">Test Cases Failed:</td>
<td class="td3">#{fail}</td>
</tr></table></center></body></html>

EOF


# Read a file and encode it into base64 format
filecontent = File.read(filename)
encodedcontent = [filecontent].pack("m")   # base64

filename = filename.sub(/^.+\//, "")

marker = "AUNIQUEMARKER"

body =<<EOF
Hi All,<br><br>

The production automation suite has completed. Please find attached the results.<br>
#{summary}<br><br>

Thanks,<br>
Test Automation team<br>
EOF

#body = "Hi All,\n\nThe automation suite has completed. Please find attached the results.\n\nThanks,\nTest Automation team"


# Define the main headers.
part1 =<<EOF
From: USAMP QA Automation <USAMPQA@usamp.com>
To: usample_qa <usample_qa@persistent.co.in>; Abhijit Gaonkar <abhijit_gaonkar@persistent.co.in>; Steve Fernandes <steve_fernandes@persistent.co.in>; Vivek Samant <vivek_samant@persistent.co.in>
Subject: Reports on the tests on PRODUCTION
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=#{marker}
--#{marker}
EOF

# Define the message action
part2 =<<EOF
Content-Type: text/html
Content-Transfer-Encoding:8bit
#{body}
--#{marker}
EOF

# Define the attachment section
part3 =<<EOF
Content-Type: multipart/mixed; name=\"#{filename}\"
Content-Transfer-Encoding:base64
Content-Disposition: attachment; filename="#{filename}"

#{encodedcontent}
--#{marker}--
EOF





mailtext = part1 + part2 + part3
# Let's put our code in safe area

Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)

Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(mailtext, 'qa@gmail.com', 'usample_qa@persistent.co.in')
end

Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(mailtext, 'qa@gmail.com', 'abhijit_gaonkar@persistent.co.in')
end

Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(mailtext, 'qa@gmail.com', 'steve_fernandes@persistent.co.in')
end

#Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
#  smtp.send_message(mailtext, 'qa@gmail.com', 'Ramanath_Kamat@persistent.co.in')
#end

Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(mailtext, 'qa@gmail.com', 'vivek_samant@persistent.co.in')
end

Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(message, 'qa@gmail.com', 'aamirhamza_ganihar@persistent.co.in')
end