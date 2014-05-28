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

system ("CookieTest.bat")

system ("cookiesummary.bat")

test_result = File.open("InputRepository/cookieresults_stage.yml"){|file| YAML::load(file)}
total = test_result['total'] 
fail = test_result['fail'] 
pass = test_result['passed'] 



$wd=Dir.pwd
filename = $wd+"/cookieReport.html"
	

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


$wd=Dir.pwd
filename = $wd+"/cookieReport.html"


# Read a file and encode it into base64 format
filecontent = File.read(filename)
encodedcontent = [filecontent].pack("m")   # base64

filename = filename.sub(/^.+\//, "")

marker = "AUNIQUEMARKER"

body =<<EOF
Hi All,<br><br>

The automation suite has completed. Please find attached the results.<br>
#{summary}<br><br>

Thanks,<br>
Test Automation team<br>
EOF


#body = "Hi All,\n\nThe automation suite has completed. Please find attached the results.\n\nThanks,\nTest Automation team"


# Define the main headers.
part1 =<<EOF
From: USAMP QA Automation <USAMPQA@usamp.com>
To: Alias for Usample Dev <usample_dev@persistent.co.in>
Subject: Geo IP test report
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
  smtp.send_message(mailtext, 'qa@gmail.com', 'usample_dev@persistent.co.in')
end
