require 'rubygems'
require 'watir'
require 'firewatir'
require 'Usamp_lib'
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


#system ("repobackup.bat")

$wd=Dir.pwd

$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
#puts $out_fl_path
$output_path = $out_fl_path
=begin
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

$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all


$myfile = File.open($out_fl_path, 'a');
$myfile.print "</tr></table></center></body></html>";
$myfile.close;
=end

filename = $wd+"/Output Repository/Non4S_Test_Report.html"
ie = Watir::IE.new
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

The automation suite has completed. Please find attached the results.<br>
#{summary}<br><br>

Thanks,<br>
Test Automation team<br>
EOF


# Define the main headers.
part1 =<<EOF
From: uSamp QA Automation <USAMPQA@usamp.com>
To: usample qa<usample_qa@persistent.co.in>;
Subject: Test Report
MIME-Version: 1.0
Content-type: multipart/mixed; boundary=#{marker}
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


=begin
msg = <<-MSG
From: uSamp QA Automation <USAMPQA@usamp.com>
To: nitin_kumar@persistent.co.in
MIME-Version: 1.0
Content-type: text/html
Subject: Test Report
Hi All,<br><br>

The automation suite has completed. Please find attached the results.<br>
#{summary}<br><br>

Thanks,<br>
Test Automation team<br>


MSG

#mailtext = msg

Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(mailtext, 'qa@gmail.com', 'nitin_kumar@persistent.co.in')
end
=end


Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(mailtext, 'qa@gmail.com', 'usample_qa@persistent.co.in')
end
=begin
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(mailtext, 'qa@gmail.com', 'jesse@usamp.com')
end
=end
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(mailtext, 'qa@gmail.com', 'sarvesh_borkar@persistent.co.in')
end

Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(mailtext, 'qa@gmail.com', 'rujuta_kulkarni@persistent.co.in')
end