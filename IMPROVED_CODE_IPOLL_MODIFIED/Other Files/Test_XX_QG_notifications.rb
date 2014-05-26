# QG NOTIFICATIONS 

require 'rubygems'
#require 'watir'
require './Usamp_lib.rb'
require 'test/unit'
#Load WATIR
require 'fileutils'
# Load WIN32OLE library
require 'win32ole' 
require 'Win32API'
#Load the win32 library
require 'win32/clipboard'
include Win32
#include 'Suite'
require 'base64'
require './Input Repository\surveyurl.rb'
require './Input Repository\Test_XX_QG_notifications_Input.rb'

class Test_XX_QG_notifications < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$qg_id_file_path_2 = $wd+"/Input Repository/Notification_QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "XX - "
				$test_description = "Test Case: "+$t.to_s+" QG NOTIFICATIONS "
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
				
	  end
=begin	  
	  def test_02_make_QG_copy
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
					
				#@pid = Process.create(
                      #  :app_name  => 'ruby popup_closer_IE.rb',
                       # :creation_flags  => Process::DETACHED_PROCESS
                      #  ).process_id
                #at_exit{ Process.kill(9,@pid) }
									 
				$file_1 = File.open($proj_id_file_path)
				$prj_id = $file_1.gets
				puts $prj_id
				$file_1.close;
			
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
					
				$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
					
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 5
				$ie.link(:text,"Copy Selected Quota Group").click
				sleep 3
					
				if($ie.html.include?('Quota Group details has been copied successfully'))
					puts "QG COPIED"
				else
					puts "QG COPY FAILED"
				end
					
				#$date=Time.now.strftime("%Y-%m-%d")
				#$SECONDS_PER_DAY = 60 * 60 * 24
				#$date_added_1=(Time.now + 10*$SECONDS_PER_DAY).localtime.strftime("%Y-%m-%d") 
				#puts $date_added_1
					
				$ie.select_list(:name, "optQuotaStatus").select("Open")
				#$ie.text_field(:name , 'txtQuotaCloseDate').value = $date_added_1
				$file1 = File.open($qg_id_file_path_2, 'w');
				$qg_id_2= /GROUP DETAILS: QG(\d+)/.match($ie.text)
				$qg_id_2= $qg_id_2.to_s
				$length=$qg_id_2.length
				$qg_id_2=$qg_id_2.slice(17..$length)
				puts $qg_id_2
				$file1.print $qg_id_2;
				$file1.close;
					
				$qg_n2 = Base64.encode64($qg_id_2)		
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.checkbox(:id, "chkShowSurvey").set
				$ie.text_field(:id, "txtSurveyName").set("QG NOTIFICATIONS SURVEY")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.link(:url,/list_quota_group_publishers.php/).click
				$ie.button(:value,"Add More Publishers").click
				$ie.select_list(:id, "optPublishers").select($pub_name)
				$ie.radio(:name, "rdCPI", "Amount").click
				$ie.text_field(:name, "txtCPI").set("1")
				$ie.button(:value,"Add Publisher").click
				sleep 2
				$ie.link(:text,"Logout").click
				$ie.close
			rescue => e
				  puts e.message
				  puts e.backtrace.inspect
				  $obj.Close_all_windows
				  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				  $myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
	  end
	  
	  def test_03_set_QG_notifications_no_redirection_activity
	  
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				#@pid = Process.create(
                      #  :app_name  => 'ruby popup_closer_IE.rb',
                      #  :creation_flags  => Process::DETACHED_PROCESS
                      #  ).process_id
                #at_exit{ Process.kill(9,@pid) }
				
				$file_1 = File.open($proj_id_file_path)
				$prj_id = $file_1.gets
				puts $prj_id
				$file_1.close;
			
				$file_2 = File.open($qg_id_file_path_2)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
				
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")	
				sleep 2
				$ie.checkbox(:name, "chbEnableNotification").set
				$ie.link(:text, "Edit notification settings").click
				sleep 2
				#$ie.link(:text, "remove").click
				#$ie.link(:text, "remove").click
				$ie.checkbox(:name, "chkNoRedActivity").set
				$ie.text_field(:name, "txtClicksForNoRedActivity").set($no_of_clicks)
				$ie.select_list(:name, "noRedActivityTbl[]").select($employee)
				$ie.button(:value,"Save Notifications Settings").click
				$st = '1'
				$test_description = "Saving QG Notification setting for No Redirection Activity "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.html.include?('Notification settings have been updated successfully'))
					puts "Pass"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "Fail"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.link(:text,"Logout").click
				$ie.close
	  
	  end
	  
	  def test_04_achieve_no_clicks_with_no_redirection
	  
				$file_1 = File.open($proj_id_file_path)
				$prj_id = $file_1.gets
				puts $prj_id
				$file_1.close;
			
				$file_2 = File.open($qg_id_file_path_2)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
					
				$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
					
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 2
				 $ie.goto("p.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
                sleep 3
				# CLICK 1
                $ie.frame(:name, "quota_group_publisher_iframe").link(:text,'GO').click
                sleep 12
				$ie.window(:title,"Survey").use do
                #$ie1=Watir::IE.attach(:title,'Survey')
                sleep 3
				#$ie.close
				end
				# CLICK 2
				 $ie.goto("p.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
                $ie.frame(:name, "quota_group_publisher_iframe").link(:text,'GO').click
                sleep 12
				$ie.window(:title,"Survey").use do
                #$ie1=Watir::IE.attach(:title,'Survey')
                sleep 3
				#$ie1.close
				end
				$ie.goto("http://p.usampadmin.com/quota_group_statistics.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 3
                $html_contents=$ie.html
                $html_array = $html_contents.split(/\n/)
                0.upto($html_array.size - 1) { |index|
                if($html_array[index] =~ /# of Clicks:/)
                    #puts $html_array[index+1]
                    $html_array[index+1].scan(/[0-9]+</){$clicks =$&; $clicks=$clicks.to_i;}
                    break
                else
					next
                end
                }
				$clcks = $no_of_clicks.to_i;
				$st = '2'
				$test_description = "Achieve no. of clicks to trigger notification "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($clcks == $clicks)
					puts "Pass"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "Fail"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.link(:text,"Logout").click
				$ie.close
	  
	  end
=end	  
	  def test_05_remove_notification_setting
	  
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				#@pid = Process.create(
                        #:app_name  => 'ruby popup_closer_IE.rb',
                        #:creation_flags  => Process::DETACHED_PROCESS
                       # ).process_id
                #at_exit{ Process.kill(9,@pid) }
				
				$file_1 = File.open($proj_id_file_path)
				$prj_id = $file_1.gets
				puts $prj_id
				$file_1.close;
			
				$file_2 = File.open($qg_id_file_path_2)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
				
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")	
				sleep 2
				$ie.checkbox(:name, "chbEnableNotification").clear
				$ie.button(:name,"btnSave").click
				sleep 2
				$st = '3'
				$test_description = "Remove Notifications settings "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.checkbox(:name, "chbEnableNotification").isSet?)
					puts "Fail"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
					puts "Pass"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
				$ie.link(:text,"Logout").click
				$ie.close
	  
	  end
	  
end