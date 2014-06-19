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

$wd=Dir.pwd
filename = $wd+"/Results_Stage.csv"
begin
i=1
j=1
f=0


#csvData = CSV.read("./Results_Stage.csv")
#puts csvData
#puts csvData[j][5]
#puts csvData[108][5]

pass=0
fail=0
file = File.open("./Results_Stage.csv","r") do |f1|
#file = File.open("C:\Users\aditya_ballikar\Desktop\adi.csv", "r") do |f1|
  while line = f1.gets
    arr= line.split(",")
   
    if arr[5]=="true"
      pass=pass+1
    elsif arr[5]=="false"
      fail=fail+1
    end
    
  end
end
total = pass+fail

puts pass
puts fail
puts total



#puts csvData[f][109]

=begin
	while (i <= 197)
		myString = csvData[i][5]
		#puts myString
		#puts csvData[f][109]
		#puts csvData[f][5]
		#puts csvData[j][5]
		#if (myString[f] =~ /false/)
		if (csvData[i][5] =~ /false/)
				fail+=1
			else
				pass+=1
			end
			#puts myString
			puts fail
			i+=1
			f+=1
			#f = f.to_i+1
	
		end		
		
	puts fail
	puts pass
	total = pass.to_i+fail.to_i
=end	
	
=begin
if (csvData[f][5] =~ /false/)
			fail+=1
			else
				pass+=1
			end
			puts myString
			i+=1
			#f+=1
			#f = f.to_i+1
	
=end
		
	
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

#{summary}<br><br>
end


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
To: usample_qa <usample_qa@persistent.co.in>; Abhijit Gaonkar <abhijit_gaonkar@persistent.co.in>; Steve Fernandes <steve_fernandes@persistent.co.in>; Vivek Samant <vivek_samant@persistent.co.in>; Josh Ewing <jewing@usamp.com>; Sirisha Chigurupati <sirisha@usamp.com>
Subject: 4S API AUTOMATION - STAGE
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
begin
Net::SMTP.start('relay.jangosmtp.net', 25,'relay.jangosmtp.net',
'qa_usamp', 'sampleu09!', :plain) do |smtp|
smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
['vipul_paikane@persistent.co.in','kanevipul87@gmail.com','rahul_halankar@persistent.co.in','nitin_kumar@persistent.co.in','gaurav_parrikar@persistent.co.in','sangeeta_pai@persistent.co.in','abhijit_gaonkar@persistent.co.in','steve_fernandes@persistent.co.in','aditya_ballikar@persistent.co.in','vivek_samant@persistent.co.in','mayuri_rivankar@persistent.co.in','mangesh_naik@persistent.co.in'])
end
rescue Exception => e
print "Exception occured: " + e
end


begin
Net::SMTP.start('relay.jangosmtp.net', 25,'relay.jangosmtp.net',
'qa_usamp', 'sampleu09!', :plain) do |smtp|
smtp.open_message_stream(from at example.com', ['to at example.com]) do |f|
f.puts 'From: from at example.com'
f.puts 'To: to at example.com'
f.puts 'Subject: test message'
f.puts
f.puts 'This is a test message.'
end
end
define("JANGOMAIL_USERNAME",'qa_usamp');
define("JANGOMAIL_PASSWORD",'sampleu09!');
public $Host = 'relay.jangosmtp.net';
public $SMTPAuth = true;
public $Username = JANGOMAIL_USERNAME;
public $Password = JANGOMAIL_PASSWORD;

Net::SMTP.start('your.smtp.server', 25, 'mail.from.domain',
'Your Account', 'Your Password', :login)

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

=end

=begin
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


begin
  Net::SMTP.start('relay.jangosmtp.net',25,'relay.jangosmtp.net','qa_usamp','sampleu09!', :plain) do |smtp|
     smtp.sendmail(mailtext, 'nitin_kumar@persistent.co.in',
                          ['abhijit_gaonkar@persistent.co.in'])
  end
rescue Exception => e
  print "Exception occured: " + e
end
sleep(2)

begin
  Net::SMTP.start('relay.jangosmtp.net',25,'relay.jangosmtp.net','qa_usamp','sampleu09!', :plain) do |smtp|
     smtp.sendmail(mailtext, 'nitin_kumar@persistent.co.in',
                          ['steve_fernandes@persistent.co.in'])
  end
rescue Exception => e
  print "Exception occured: " + e
end 

begin
  Net::SMTP.start('relay.jangosmtp.net',25,'relay.jangosmtp.net','qa_usamp','sampleu09!', :plain) do |smtp|
     smtp.sendmail(mailtext, 'nitin_kumar@persistent.co.in',
                          ['vivek_samant@persistent.co.in'])
  end
rescue Exception => e
  print "Exception occured: " + e
end 
sleep(2)




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

puts "ALL Done"

#Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
#  smtp.send_message(mailtext, 'qa@gmail.com', 'Ramanath_Kamat@persistent.co.in')
#end

Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(mailtext, 'qa@gmail.com', 'vivek_samant@persistent.co.in')
end

Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(mailtext, 'qa@gmail.com', 'jewing@usamp.com')
end

Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(mailtext, 'qa@gmail.com', 'sirisha@usamp.com')
end