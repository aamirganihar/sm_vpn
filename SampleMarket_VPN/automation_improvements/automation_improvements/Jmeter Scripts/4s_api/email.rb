require 'rubygems'
#require 'watir'
#require 'Usamp_lib'
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


$wd=Dir.pwd

filename = $wd+"/Results/Results.csv"

#Read a file and encode it into base64 format
filecontent = File.read(filename)
encodedcontent = [filecontent].pack("m")   # base64

filename = filename.sub(/^.+\//, "")

marker = "AUNIQUEMARKER"


body =<<EOF
Hi All,

The automation suite has completed. Please find attached the results.

Thanks,
Test Automation team
EOF


# Define the main headers.
part1 =<<EOF
From: USAMP QA Automation <USAMPQA@usamp.com>
To: Vipul Pai Kane <vipul_paikane@persistent.co.in>;Rahul_Halankar <rahul_halankar@persistent.co.in>;Nitin Kumar <nitin_kumar@persistent.co.in>;Gaurav Parrikar <gaurav_parrikar@persistent.co.in>;Sangeeta Pai<sangeeta_pai@persistent.co.in>;Maria Braganza<maria_braganza@persistent.co.in>
Subject: 4S API Automation Report
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=#{marker}
--#{marker}
EOF

# Define the message action
part2 =<<EOF
Content-Type: text/plain
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
begin 
    Net::SMTP.start('relay.jangosmtp.net',25,'relay.jangosmtp.net',
                    'qa_usamp','sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['rahul_halankar@persistent.co.in'])
end
rescue Exception => e  
  print "Exception occured: " + e 
end  
sleep(2)

#Let's put our code in safe area
begin 
    Net::SMTP.start('relay.jangosmtp.net',25,'relay.jangosmtp.net',
                    'qa_usamp','sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['kanevipul87@gmail.com'])
end
rescue Exception => e  
  print "Exception occured: " + e 
end  
sleep(2)

# Let's put our code in safe area
begin 
    Net::SMTP.start('relay.jangosmtp.net',25,'relay.jangosmtp.net',
                    'qa_usamp','sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['vipul_paikane@persistent.co.in'])
end
rescue Exception => e  
  print "Exception occured: " + e 
end  
sleep(2)

#Let's put our code in safe area
begin 
    Net::SMTP.start('relay.jangosmtp.net',25,'relay.jangosmtp.net',
                    'qa_usamp','sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['gaurav_parrikar@persistent.co.in'])
end
rescue Exception => e  
  print "Exception occured: " + e 
end  
sleep(2)

#Let's put our code in safe area
begin 
    Net::SMTP.start('relay.jangosmtp.net',25,'relay.jangosmtp.net',
                    'qa_usamp','sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['sangeeta_pai@persistent.co.in'])
end
rescue Exception => e  
  print "Exception occured: " + e 
end  
sleep(2)

#Let's put our code in safe area
begin 
    Net::SMTP.start('relay.jangosmtp.net',25,'relay.jangosmtp.net',
                    'qa_usamp','sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['maria_braganza@persistent.co.in'])
end
rescue Exception => e  
  print "Exception occured: " + e 
end  
sleep(2)

#Let's put our code in safe area
begin 
    Net::SMTP.start('relay.jangosmtp.net',25,'relay.jangosmtp.net',
                    'qa_usamp','sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['nitin_kumar@persistent.co.in'])
end
rescue Exception => e  
  print "Exception occured: " + e 
end  
sleep(2)

#Let's put our code in safe area
begin 
    Net::SMTP.start('relay.jangosmtp.net',25,'relay.jangosmtp.net',
                    'qa_usamp','sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['aditya_ballikar@persistent.co.in'])
end
rescue Exception => e  
  print "Exception occured: " + e 
end  
sleep(2)

