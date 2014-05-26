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
puts $out_fl_path
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

system ("ruby Test_01_Project_QG_Create.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

message = <<MESSAGE_END
From: USAMP QA Automation <USAMPQA@usamp.com>
To: Nitin Kumar<nitin_kumar@persistent.co.in>
MIME-Version: 1.0
Content-type: text/html
Subject: Test case 1 completed

Test case 1 completed<br><br>

Thanks,<br>
Test Automation team<br>

MESSAGE_END


Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(message, 'qa@gmail.com', 'nitin_kumar@persistent.co.in')
end

system ("ruby Test_02_Auto_Open_QG.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

message = <<MESSAGE_END
From: USAMP QA Automation <USAMPQA@usamp.com>
To: Nitin Kumar<nitin_kumar@persistent.co.in>
MIME-Version: 1.0
Content-type: text/html
Subject: Test case 2 completed

Test case 2 completed<br><br>

Thanks,<br>
Test Automation team<br>

MESSAGE_END


Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(message, 'qa@gmail.com', 'nitin_kumar@persistent.co.in')
end

system ("ruby Test_03_Auto_Close_QG.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

message = <<MESSAGE_END
From: USAMP QA Automation <USAMPQA@usamp.com>
To: Nitin Kumar<nitin_kumar@persistent.co.in>
MIME-Version: 1.0
Content-type: text/html
Subject: Test case 3 completed

Test case 3 completed<br><br>

Thanks,<br>
Test Automation team<br>

MESSAGE_END


Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(message, 'qa@gmail.com', 'nitin_kumar@persistent.co.in')
end

system ("ruby Test_04_Non_member_survey_complete.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

message = <<MESSAGE_END
From: USAMP QA Automation <USAMPQA@usamp.com>
To: Nitin Kumar<nitin_kumar@persistent.co.in>
MIME-Version: 1.0
Content-type: text/html
Subject: Test case 4 completed

Test case 4 completed<br><br>

Thanks,<br>
Test Automation team<br>

MESSAGE_END


Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(message, 'qa@gmail.com', 'nitin_kumar@persistent.co.in')
end

system ("ruby Test_05_Member_registration.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

message = <<MESSAGE_END
From: USAMP QA Automation <USAMPQA@usamp.com>
To: Nitin Kumar<nitin_kumar@persistent.co.in>
MIME-Version: 1.0
Content-type: text/html
Subject: Test case 5 completed

Test case 5 completed<br><br>

Thanks,<br>
Test Automation team<br>

MESSAGE_END


Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(message, 'qa@gmail.com', 'nitin_kumar@persistent.co.in')
end

#system ("ruby Test_06_Survey_complete.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all



system ("ruby Test_07_Publisher_category_filer.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

message = <<MESSAGE_END
From: USAMP QA Automation <USAMPQA@usamp.com>
To: Nitin Kumar<nitin_kumar@persistent.co.in>
MIME-Version: 1.0
Content-type: text/html
Subject: Test case 7 completed

Test case 7 completed<br><br>

Thanks,<br>
Test Automation team<br>

MESSAGE_END


Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(message, 'qa@gmail.com', 'nitin_kumar@persistent.co.in')
end

system ("ruby Test_08_Publisher_margin_%.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

message = <<MESSAGE_END
From: USAMP QA Automation <USAMPQA@usamp.com>
To: Nitin Kumar<nitin_kumar@persistent.co.in>
MIME-Version: 1.0
Content-type: text/html
Subject: Test case 8 completed

Test case 8 completed<br><br>

Thanks,<br>
Test Automation team<br>

MESSAGE_END


Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(message, 'qa@gmail.com', 'nitin_kumar@persistent.co.in')
end

system ("ruby Test_09_US_getcount.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

message = <<MESSAGE_END
From: USAMP QA Automation <USAMPQA@usamp.com>
To: Nitin Kumar<nitin_kumar@persistent.co.in>
MIME-Version: 1.0
Content-type: text/html
Subject: Test case 9 completed

Test case 9 completed<br><br>

Thanks,<br>
Test Automation team<br>

MESSAGE_END


Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(message, 'qa@gmail.com', 'nitin_kumar@persistent.co.in')
end

system ("ruby Test_10_CAN_getcount.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

message = <<MESSAGE_END
From: USAMP QA Automation <USAMPQA@usamp.com>
To: Nitin Kumar<nitin_kumar@persistent.co.in>
MIME-Version: 1.0
Content-type: text/html
Subject: Test case 10 completed

Test case 10 completed<br><br>

Thanks,<br>
Test Automation team<br>

MESSAGE_END


Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(message, 'qa@gmail.com', 'nitin_kumar@persistent.co.in')
end
=end
system ("ruby Test_11_CP_Project.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

message = <<MESSAGE_END
From: USAMP QA Automation <USAMPQA@usamp.com>
To: Nitin Kumar<nitin_kumar@persistent.co.in>
MIME-Version: 1.0
Content-type: text/html
Subject: Test case 11 completed

Test case 11 completed<br><br>

Thanks,<br>
Test Automation team<br>

MESSAGE_END


Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(message, 'qa@gmail.com', 'nitin_kumar@persistent.co.in')
end

system ("ruby Test_12_CP_rule_processing.rb")
#$ff = FireWatir::Firefox.new
#sleep 2
#sleep 2
#$ff.close_all

message = <<MESSAGE_END
From: USAMP QA Automation <USAMPQA@usamp.com>
To: Nitin Kumar<nitin_kumar@persistent.co.in>
MIME-Version: 1.0
Content-type: text/html
Subject: Test case 12 completed

Test case 12 completed<br><br>

Thanks,<br>
Test Automation team<br>

MESSAGE_END


Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(message, 'qa@gmail.com', 'nitin_kumar@persistent.co.in')
end

system ("ruby Test_13_Curl_pixel.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

message = <<MESSAGE_END
From: USAMP QA Automation <USAMPQA@usamp.com>
To: Nitin Kumar<nitin_kumar@persistent.co.in>
MIME-Version: 1.0
Content-type: text/html
Subject: Test case 13 completed

Test case 13 completed<br><br>

Thanks,<br>
Test Automation team<br>

MESSAGE_END


Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(message, 'qa@gmail.com', 'nitin_kumar@persistent.co.in')
end
=begin
system ("ruby Test_14_Traditional_pixel.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_15_Profile_creation.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_16_Reward_creation.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_17_Member_data_review.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_18_Publisher_bids.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_19_Virtual_currency_reflection.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_20_Custom_reward.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_21_Registration_management.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_22_Profile_redirection_on_signup.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_23_Request_cash_out.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_24_Survey_redirection.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_25_Profile_answering.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_26_Site_rendering.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_27_Dashboard_on_off.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_28_Disable_pub_account.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_29_Enable_disable_queue2.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_30_External_prescreener.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_31_Merge_field_survey_url.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_32_Panel_book_search.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_33_Custom_homepage_render.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_34_Add_publisher.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

#system ("ruby Test_35_SH_email_update.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_36_Project_search.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_37_Add_publisher_group.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_38_Add_employee.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_39_Add_client.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_40_Simulate_completes.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_41_Member_search.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_42_QG_notifications.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_43_Add_tools.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_44_Pub_client_association.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_45_Email_link_pub.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_46_Donot_include_member_last_hour.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_47_QG_Publisher_redirect.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_48_Profile_linked_survey.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_49_Supplier_add_show_hide.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_50_Add_prescreener.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_51_Setup_live_closed_QG.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_52_Profile_criteria_cases.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_53_List_projects.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_54_EX_ST_Links.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_55_Member_ID_report.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_56_Profile_mapping_on_corp.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_57_Success_fail_oq_rewards.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_58_Confirmit_code_url.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_59_Confirmit_code_url_recontact.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_60_Survey_complete_invalid_token.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_61_Rewards_at_site_level.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_62_Reward_config_foriegn_lang.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_63_Broadcasts.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_64_Email_clicks_allowed.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_65_Project_QG_Create.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_66_Config_setting_cases.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_67_No_of_QG_clicks_allowed.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_68_QG_cpi_cases.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_69_QG_notif_email.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

#system ("ruby Test_70_FBconnect.rb")
#$ff = FireWatir::Firefox.new
#sleep 2
#$ff.close_all

system ("ruby Test_71_Routing_qns_QG.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_72_Member_registration_UK.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_73_Member_registration_Canada.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_74_Member_registration_India.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

#system ("ruby Test_XX_Member_acc_close.rb")
#$ff = FireWatir::Firefox.new
#sleep 2
#$ff.close_all

#system ("ruby ")

system ("ruby Test_XX_Project_QG_status_change.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all

system ("ruby Test_XX_Profiles_rewards_inactivate.rb")
$ff = FireWatir::Firefox.new
sleep 2
$ff.close_all


$myfile = File.open($out_fl_path, 'a');
$myfile.print "</tr></table></center></body></html>";
$myfile.close;


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


Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(mailtext, 'qa@gmail.com', 'usample_qa@persistent.co.in')
end

Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(mailtext, 'qa@gmail.com', 'jesse@usamp.com')
end

Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'selautomationmail@gmail.com', 'selautomationmail', :login) do |smtp|
  smtp.send_message(mailtext, 'qa@gmail.com', 'sarvesh_borkar@persistent.co.in')
end
=end