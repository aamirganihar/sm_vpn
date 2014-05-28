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
require 'YAML'
require 'net/pop' 
#run gem install tlsmail and gem install mail before requiring tlsmail
require 'tlsmail'
require 'YAML'

marker = "AUNIQUEMARKER"


body =<<EOF
Hi All,

The production automation suite has started.

Thanks,
Test Automation team
EOF


#body = "Hi All,\n\nThe automation suite has completed. Please find attached the results.\n\nThanks,\nTest Automation team"


# Define the main headers.

partA =<<EOF
From: USAMP QA Automation <USAMPQA@usamp.com>
To: usample qa<usample_qa@persistent.co.in>; Abhijit Gaonkar <abhijit_gaonkar@persistent.co.in>; Steve Fernandes <steve_fernandes@persistent.co.in>; Ramanath Kamat <Ramanath_Kamat@persistent.co.in>; Vivek Samant <vivek_samant@persistent.co.in>
Subject: SampleMarket automation suite has started
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=#{marker}
--#{marker}
EOF


# Define the message action
partB =<<EOF
Content-Type: text/plain
Content-Transfer-Encoding:8bit
#{body}
--#{marker}
EOF


mailtext1 = partA + partB 
Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(mailtext1, 'qa@gmail.com', 'nitin_kumar@persistent.co.in')
end




#system ("productiontest.bat")

$wd=Dir.pwd
filename = $wd+"/Report_prod.html"

test_result = File.open("InputRepository/results.yml"){|file| YAML::load(file)}
@passed = test_result['passed'] 
@total = test_result['total'] 
@fail = test_result['fail'] 

=begin
driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
ie = Watir::Browser.new driver
#ie = FireWatir::Firefox.new
ie.goto("file:///"+filename)

    sleep 3
    body_text = ie.text
    ie.close
    puts body_text
    #body_text=ff.html
    html_array = body_text.split(/\n/)
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ /examples/)
      @code = html_array[index+0]
      break
        else
          next
        end
        }

    @total = @code.slice(0..2)
    @fail = @code.slice(12..14)
    @passed = @code1.to_i-@code2.to_i
    
    test_result = {}
    test_result['total'] = @total
    test_result['fail'] = @fail
    test_result['passed'] = @passed
    File.open("InputRepository/results.yml","w"){|file| YAML.dump(test_result,file)}
=end    
    summary =<<EOF
<html>
<body><center>
<h1><u>Test Automation Summary</u></h1><br /><center><table border=2 width="500px">
<tr><td class="td2"><font color="Black">Total Test Cases:</td>
<td class="td3">#{@total}</td>
<tr><td class="td2"><font color="green">Test Cases Passed:</td>
<td class="td3">#{@passed}</td>
<tr><td class="td2"><font color="Red">Test Cases Failed:</td>
<td class="td3">#{@fail}</td>
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
To: usample qa<usample_qa@persistent.co.in>; Abhijit Gaonkar <abhijit_gaonkar@persistent.co.in>; Steve Fernandes <steve_fernandes@persistent.co.in>; Ramanath Kamat <Ramanath_Kamat@persistent.co.in>; Vivek Samant <vivek_samant@persistent.co.in>
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
=begin
# Let's put our code in safe area
begin 
    Net::SMTP.start('relay.jangosmtp.net',25,'relay.jangosmtp.net',
                    'qa_usamp','sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['usample_qa@persistent.co.in'])
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
                          ['nitin_kumar@persistent.co.in'])
end
rescue Exception => e  
  print "Exception occured: " + e 
end  
sleep(2)
=end

Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(mailtext, 'qa@gmail.com', 'nitin_kumar@persistent.co.in')
end
