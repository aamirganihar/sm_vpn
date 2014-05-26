require 'rubygems'
#require 'watir'
#require 'firewatir'
require './Usamp_lib.rb'
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
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"


system ("repobackup.bat")

$wd=Dir.pwd

$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
puts $out_fl_path
$output_path = $out_fl_path

myfile = File.open($out_fl_path, 'w');
myfile.print "<html>";
myfile.print "<head><title>Test Automation Report</title><style type=\"text/css\">";
myfile.print "body {background-color: #FFFFF0; font-family: \"VAG Round\" ; color : #000080}";
myfile.print "table {table-layout:automatic; border-color:#000000; cell-spacing:10; font-size=100%; font-family:\"Calibri\"}.td1 {width: 3%; text-align: center}";
myfile.print ".td2 {width: 20%}";
myfile.print ".td3 {width: 15%}</style></head>";
myfile.print "<body><center>";
myfile.print "<h1><u>Test Automation Report</u></h1><br /><center><table border=2 width=\"900px\">";
myfile.close;



Dir.glob(File.join(File.dirname(__FILE__), 'Test_*_*.rb')).each {|f| require f }

#Dir.glob(File.join('', 'Test_*.rb')).each {|f| require f }


$myfile = File.open($out_fl_path, 'a');
$myfile.print "</tr></table></center></body></html>";
$myfile.close;


filename = $wd+"/Output Repository/Non4S_Test_Report.html"

#ie = Watir::IE.new
driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
ie = Watir::Browser.new driver
#ie = FireWatir::Firefox.new
ie.goto("file:///"+filename)


    html_text = ie.html
    $html_contents=ie.html
    #puts $html_contents
    $html_array = $html_contents.split(/\n/)
    #puts $html_array
	0.upto($html_array.size - 1) { |index|
    if($html_array[index] =~ /TEST [A-Z]+ED/)
    #if($html_array[index].contains_text("TEST"))
    puts "***"
    puts $html_array[index]
    #sleep 1
    #puts $html_array[index-1]
    puts "***"
    $html_array[index].scan(/[A-Za-z]+</){
    if ($html_array[index] =~ /TEST PASSED/)
    $pass=$pass.to_i+1
    puts $pass
    puts "***"
    #sleep 1
    else
    if ($html_array[index] =~ /TEST FAILED/)
    $fail=$fail.to_i+1
    puts $fail
    puts "***"
    #sleep 1
    end
    end
    }
    next
    else
    next
    end
                                                
}
                                          
                                          0.upto($html_array.size - 1) { |index|
                                            if($html_array[index] =~ /NOT COMPLETED [A-Z]+LY/)
                                            #if($html_array[index].contains_text("TEST"))
                                                  puts "***"
                                                  puts $html_array[index]
                                                  #sleep 1
                                                  #puts $html_array[index-1]
                                                  puts "***"
                                                  #$html_array[index].scan(/[A-Za-z]+\{[A-Za-z]+\}/){
                                                  $html_array[index].scan(/NOT COMPLETED SUCCESSFULY/){
                                                  if ($html_array[index] =~ /NOT COMPLETED SUCCESSFULY/)
                                                    $incomplete=$incomplete.to_i+1
                                                    puts $incomplete
                                                    puts "***"
                                                    #sleep 1
                                                    end
                                                  }
                                                  next
                                            else
                                                  next
                                                end
                                                
                                          }
                                          ie.close
                                          puts $pass
                                          puts $fail
                                          puts $incomplete                                          
myfile = File.open($out_fl_path, 'w');
myfile.print "<html>";
myfile.print "<body><center>";
myfile.print "<h1><u>Test Automation Summary</u></h1><br /><center><table border=2 width=\"500px\">";
myfile.print "<tr><td class=\"td2\"><font color=\"green\">Test Cases Passed:</td>"
myfile.print "<td class=\"td3\">"+$pass.to_s+"</td>" 
myfile.print "<tr><td class=\"td2\"><font color=\"Red\">Test Cases Failed:</td>"
myfile.print "<td class=\"td3\">"+$fail.to_s+"</td>" 
myfile.print "<tr><td class=\"td2\"><font color=\"Black\">Test Cases Not Completed:</td>"
myfile.print "<td class=\"td3\">"+$incomplete.to_s+"</td>" 
myfile.print "</tr></table></center></body></html>";
myfile.print "#{html_text}"
myfile.close;


summary =<<EOF
<html>
<body><center>
<h1><u>Test Automation Summary</u></h1><br /><center><table border=2 width="500px">
<tr><td class="td2"><font color="green">Test Cases Passed:</td>
<td class="td3">#{$pass}</td>
<tr><td class="td2"><font color="Red">Test Cases Failed:</td>
<td class="td3">#{$fail}</td>
<tr><td class="td2"><font color="Black">Test Cases Not Completed:</td>
<td class="td3">#{$incomplete}</td>
</tr></table></center></body></html>

EOF

# Read a file and encode it into base64 format
filecontent = File.read(filename)
encodedcontent = [filecontent].pack("m")   # base64

filename = filename.sub(/^.+\//, "")

marker = "AUNIQUEMARKER"


body =<<EOF
Hi All,<br><br>

The Admin automation suite has completed. Please find attached the results.<br>
#{summary}<br><br>

Thanks,<br>
Test Automation team<br>
EOF


# Define the main headers.
part1 =<<EOF
From: uSamp QA Automation <USAMPQA@usamp.com>
To: usample qa<usample_qa@persistent.co.in>;Jesse Aguero<jesse@usamp.com>;Sarvesh Sinai Borkar <sarvesh_borkar@persistent.co.in>
Subject: Test Report - Admin
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
                          ['nitin_kumar@persistent.co.in'])
  end
rescue Exception => e  
  print "Exception occured: " + e 
end 
sleep 2

begin 
    Net::SMTP.start('relay.jangosmtp.net', 25,'relay.jangosmtp.net',
                    'qa_usamp', 'sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['rahul_halankar@persistent.co.in'])
  end
rescue Exception => e  
  print "Exception occured: " + e 
end 

begin 
    Net::SMTP.start('relay.jangosmtp.net', 25,'relay.jangosmtp.net',
                    'qa_usamp', 'sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['gaurav_parrikar@persistent.co.in'])
  end
rescue Exception => e  
  print "Exception occured: " + e 
end

begin 
    Net::SMTP.start('relay.jangosmtp.net', 25,'relay.jangosmtp.net',
                    'qa_usamp', 'sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['vipul_paikane@persistent.co.in'])
  end
rescue Exception => e  
  print "Exception occured: " + e 
end

begin 
    Net::SMTP.start('relay.jangosmtp.net', 25,'relay.jangosmtp.net',
                    'qa_usamp', 'sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['mittal_saglani@persistent.co.in'])
  end
rescue Exception => e  
  print "Exception occured: " + e 
end

begin    
    Net::SMTP.start('relay.jangosmtp.net', 25,'relay.jangosmtp.net',
                    'qa_usamp', 'sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['maryushka_fernandes@persistent.co.in'])
  end
rescue Exception => e  
  print "Exception occured: " + e 
end

begin    
    Net::SMTP.start('relay.jangosmtp.net', 25,'relay.jangosmtp.net',
                    'qa_usamp', 'sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['sandesh_hurli@persistent.co.in'])
  end
rescue Exception => e  
  print "Exception occured: " + e 
end

begin    
    Net::SMTP.start('relay.jangosmtp.net', 25,'relay.jangosmtp.net',
                    'qa_usamp', 'sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['mangesh_naik@persistent.co.in'])
  end
rescue Exception => e  
  print "Exception occured: " + e 
end

begin    
    Net::SMTP.start('relay.jangosmtp.net', 25,'relay.jangosmtp.net',
                    'qa_usamp', 'sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['neethi_thilakan@persistent.co.in'])
  end
rescue Exception => e  
  print "Exception occured: " + e 
end

begin    
    Net::SMTP.start('relay.jangosmtp.net', 25,'relay.jangosmtp.net',
                    'qa_usamp', 'sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['sangeeta_pai@persistent.co.in'])
  end
rescue Exception => e  
  print "Exception occured: " + e 
end

begin    
    Net::SMTP.start('relay.jangosmtp.net', 25,'relay.jangosmtp.net',
                    'qa_usamp', 'sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['jesse@usamp.com'])
  end
rescue Exception => e  
  print "Exception occured: " + e 
end
=begin

begin    
    Net::SMTP.start('relay.jangosmtp.net', 25,'relay.jangosmtp.net',
                    'qa_usamp', 'sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['gaurav.parrikar@gmail.com'])
  end
rescue Exception => e  
  print "Exception occured: " + e 
end

begin    
    Net::SMTP.start('relay.jangosmtp.net', 25,'relay.jangosmtp.net',
                    'qa_usamp', 'sampleu09!', :plain) do |smtp|
            smtp.sendmail(mailtext, 'USAMPQA@usamp.com',
                          ['usample_qa@persistent.co.in'])
  end
rescue Exception => e  
  print "Exception occured: " + e 
end
=end

Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
#Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  #smtp.send_message(mailtext, 'qa@gmail.com', 'usample_qa@persistent.co.in')
#end

#Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  #smtp.send_message(mailtext, 'qa@gmail.com', 'jesse@usamp.com')
#end

#Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  #smtp.send_message(mailtext, 'qa@gmail.com', 'sarvesh_borkar@persistent.co.in')
#end

#Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  #smtp.send_message(mailtext, 'qa@gmail.com', 'aamirhamza_ganihar@persistent.co.in')
#end