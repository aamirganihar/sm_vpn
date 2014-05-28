# NO. OF EMAIL CLICKS ALLOWED

require 'rubygems'
require 'watir'
require 'Usamp_lib'
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
require 'Input Repository\Test_64_Email_clicks_allowed_Input.rb'

class Test_64_Email_clicks_allowed < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/Copied_QG_ID.txt"
			$Emclk_bcast_id_fl_path = $wd+"/Input Repository/EMCLK_BCAST_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "64 - "
				$test_description = "Test Case: "+$t.to_s+"  NO. OF EMAIL CLICKS ALLOWED "
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_make_setting
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
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
				sleep 2
				$ie.select_list(:name, "optQuotaStatus").set("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.goto("http://p.usampadmin.com/quota_member_pub_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&static=")
				sleep 5
				$ie.checkbox(:id, "chkIncludeExcludeMemberIdToken").set
				$ie.select_list(:id, "optMemberIdToken").set("IDs")
				$ie.text_field(:id, "txtAreaMemberIdTokens").set($member_id_1)
				$ie.button(:value,"Save Group").click
				$st = '1'
				$test_description = "Saving member pub options for a QG "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.checkbox(:id, "chkIncludeExcludeMemberIdToken").isSet? && $ie.contains_text(/Quota group Member Publisher details have been updated successfully/))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	
				end
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
	  
	  def test_03_save_no_of_clicks_set
	  
			begin		
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
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
				#$ie.goto("http://p.usampadmin.com/quota_group_panelshield.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&static=")
				sleep 1
				$ie.link(:text, "PanelShield").click
				sleep 3
				$ie.text_field(:name, "txtNoOfEmailClicks").set($no_of_email_clicks_allowed)
				$ie.button(:value,"Save").click
				sleep 2
				$val = $ie.text_field(:name, "txtNoOfEmailClicks").value
				$st = '2'
				$test_description = "Saving No. of email clicks allowed setting "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if (($val == "2") && $ie.contains_text(/Panelshield details have been updated successfully/))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	
				end
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
	  
	  def test_04_send_bcast
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
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
				
				$ie.goto("http://p.usampadmin.com/query_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&type=new&static=")
				sleep 3
				$ie.button(:value,"Next").click
				sleep 10
				$ie.button(:value,"Get Count").click
				sleep 10 
				$ie.text_field(:id, "txtNoEmailsSenduSampPanel").set("1")
				$ie.button(:value,"Next").click
				sleep 10
				$ie.select_list(:name, "optTemplate").set("Client Services - Template A")
				sleep 5
				$b_subj = "EMCLK:" + "#{$qg_id}"
				$ie.text_field(:id, "tagsSubject").set($b_subj)
				$ie.button(:value,"Next").click
				$ie.text_field(:name, "txtBroadcastName").set("TEST BROADCAST")
				$ie.button(:value,"Next").click
				sleep 3
				$ie.button(:value,"Finish").click
				sleep 3
				$st = '3'
				$test_description = "Complete sending broadcast "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.contains_text(/Your broadcast is being processed/))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	
				end
				$ie.link(:text, "Sent Broadcasts").click
				sleep 15
				$ie.refresh
				sleep 3
				$st = '4'
				$test_description = "Checking transaction in Sent Broadcast link in admin "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.contains_text($b_subj))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	
				end
				$bcast_id = /^(\d+)(\d+)(\d+)/.match($ie.text)
				$bcast_id = $bcast_id.to_s()
				#$bcast_id.chomp!
				puts $bcast_id
				File.open($Emclk_bcast_id_fl_path, 'w') do |f1| 
				f1.puts $bcast_id
				end
				puts "Waiting for system to send email.."
				sleep 5
				$ie.link(:text,"Logout").click
				$obj.Delete_cookies()
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

	  
	  def test_05_check_survey_clicks
	  
			begin	
				$file_1 = File.open($Emclk_bcast_id_fl_path)
				$bcast_id = $file_1.gets
				puts $bcast_id
				$file_1.close;
			
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
					
				$obj = Usamp_lib.new
				
				$bcast_n = Base64.encode64($bcast_id)
				$qg_n = Base64.encode64($qg_id)
				
				$bcast_survey_url = "http://p.surveyhead.com/al.php?e=#{$mem_email}&memid=#{$member_id_1}&QGID=#{$qg_n}=&broadcast_id=#{$bcast_n}"
				puts $bcast_survey_url
				
				# CLICK 1
				$obj.Delete_cookies()
				sleep 4
				$ff = FireWatir::Firefox.new
				$ff.goto($bcast_survey_url)
				sleep 20
				$ff.button(:value,"START SURVEY").click
				sleep 10
                #$ff1 = FireWatir::Firefox.attach(:title,/TEST_AUTOMATION_SURVEY/)
                #$ff.goto($sc_red_url)
				$ff.close
				sleep 2
				# CLICK 2
				$obj.Delete_cookies()
				sleep 4
				$ff = FireWatir::Firefox.new
				$ff.goto($bcast_survey_url)
				sleep 20
				$ff.button(:value,"START SURVEY").click
				sleep 10
                $ff.close
				sleep 2
				# CLICK 3
				$obj.Delete_cookies()
				sleep 4
				$ff = FireWatir::Firefox.new
				$ff.goto($bcast_survey_url)
				sleep 15
				#$ff.button(:value,"START SURVEY").click
				puts "Waiting.."
				sleep 5
                
				$st = '5'
				$test_description = "Member not taken to survey when no. of clicks allowed is exceeded "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff.contains_text($qg_id) && $ff.contains_text(/You may qualify for this survey/))
					puts"FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
				#$ff1.close
				  
				$ff.goto("p.surveyhead.com/index.php?mode=logout")
				$ff.close
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					$obj.Close_all_windows
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
	  end

	  
	  def test_06_reset_no_of_clicks_setting
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
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
				sleep 1
				$ie.link(:text, "PanelShield").click
				sleep 3
				$ie.text_field(:name, "txtNoOfEmailClicks").set("999")
				$ie.button(:value,"Save").click
				sleep 2
				$val = $ie.text_field(:name, "txtNoOfEmailClicks").value
				$st = '6'
				$test_description = "Reverting No. of email clicks allowed setting "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($val == "999" && $ie.contains_text(/Panelshield details have been updated successfully/))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	
				end
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

	  
	  def test_07_check_survey_clicks_after_reverting
	  
			begin	
				$file_1 = File.open($Emclk_bcast_id_fl_path)
				$bcast_id = $file_1.gets
				puts $bcast_id
				$file_1.close;
			
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
					
					
				$bcast_n = Base64.encode64($bcast_id)
				$qg_n = Base64.encode64($qg_id)
				
				$bcast_survey_url = "http://p.surveyhead.com/al.php?e=#{$mem_email}&memid=#{$member_id_1}&QGID=#{$qg_n}=&broadcast_id=#{$bcast_n}"
				puts $bcast_survey_url
				$obj.Delete_cookies()
				sleep 2
				$ff = FireWatir::Firefox.new
				$ff.goto($bcast_survey_url)
				sleep 10
				$ff.button(:value,"START SURVEY").click
				sleep 10
				$st = '7'
				$test_description = "Member taken to survey when no. of clicks allowed is reverted "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff.contains_text(/THIS IS A TEST AUTOMATION SURVEY/))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts"FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.close
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					$obj.Close_all_windows
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
	  end
	  
	  def test_08_qg_reset
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
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
				sleep 2
				$ie.select_list(:name, "optQuotaStatus").set("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.goto("http://p.usampadmin.com/quota_member_pub_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&static=")
				sleep 5
				$ie.checkbox(:id, "chkIncludeExcludeMemberIdToken").clear
				#$ie.select_list(:id, "optMemberIdToken").set("IDs")
				#$ie.text_field(:id, "txtAreaMemberIdTokens").set($member_id_1)
				$ie.button(:value,"Save Group").click
				sleep 3
				$ie.link(:text,"Logout").click
				$ie.close
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					$obj.Close_all_windows
					
			end	
	  end
	  
end