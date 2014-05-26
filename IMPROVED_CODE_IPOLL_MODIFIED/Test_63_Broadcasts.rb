# BROADCAST / EMAIL INVITES

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
require './Input Repository\Test_63_Broadcasts_Input.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

class Test_63_Broadcasts < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$Bcast_id_fl_path = $wd+"/Input Repository/BCAST_ID.txt"
			$Rem_bcast_id_fl_path = $wd+"/Input Repository/REM_BCAST_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "63 - "
				$test_description = "Test Case: "+$t.to_s+"  BROADCAST / EMAIL INVITES "
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_make_setting
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin1_login($admin_email,$admin_passwd)
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
					
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")	
				sleep 2
				$ie.select_list(:name, "optQuotaStatus").select("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.goto("http://q.usampadmin.com/quota_member_pub_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&static=")
				sleep 5
				$ie.checkbox(:id, "chkIncludeExcludeMemberIdToken").set
				$ie.select_list(:id, "optMemberIdToken").select("IDs")
				$ie.text_field(:id, "txtAreaMemberIdTokens").set($member_id_1)
				$ie.button(:value,"Save Group").click
				$st = '1'
				$test_description = "Saving member pub options for a QG "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.checkbox(:id, "chkIncludeExcludeMemberIdToken").set? && $ie.html.include?('Quota group Member Publisher details have been updated successfully'))
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
					#$obj.Close_all_windows
					$ie.close
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
	  
	  end
	  
	  def test_03_send_bcast
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin1_login($admin_email,$admin_passwd)
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
				
				$ie.goto("http://q.usampadmin.com/query_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&type=new&static=")
				sleep 3
				$ie.button(:value,"Next").click
				sleep 10
				$ie.select_list(:name, "optTemplate").select("Client Services - Template A")
				sleep 5
				$b_subj = "Bcast:" + "#{$qg_id}"
				$ie.text_field(:id, "tagsSubject").set($b_subj)
				$ie.button(:value,"Next").click
				$ie.text_field(:name, "txtBroadcastName").set("TEST BROADCAST")
				$ie.button(:value,"Next").click
				sleep 3
				$ie.button(:value,"Get Count").click
				sleep 10 
				$ie.text_field(:id, "txtNoEmailsSenduSampPanel").set("1")
				#$ie.button(:value,"Next").click
				sleep 5
				$ie.button(:name, "btnFinish").click
				sleep 3
				$st = '2'
				$test_description = "Complete sending broadcast "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.html.include?('Your broadcast is being processed'))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	
				end
				$ie.link(:text, "Sent Broadcasts").click
				sleep 200
				$ie.refresh
				sleep 3
				$st = '3'
				$test_description = "Checking transaction in Sent Broadcast link in admin "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.text.include?($b_subj))
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
				File.open($Bcast_id_fl_path, 'w') do |f1| 
				f1.puts $bcast_id
				end
				puts "Waiting for system to send email.."
				sleep 60
				$ie.link(:text,"Logout").click
				$ie.close
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					#$obj.Close_all_windows
					$ie.close
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
	  end
	  
	  def test_04_send_reminder
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin1_login($admin_email,$admin_passwd)
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
				
				sleep 60 
				
				$ie.goto("http://q.usampadmin.com/query_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&type=new&static=")
				sleep 3
				$ie.button(:value,"Next").click
				sleep 10
				$ie.select_list(:name, "optTemplate").select("Client Services - Template A")
				sleep 5
				$b_subj = "Rem:" + "#{$qg_id}"
				$ie.text_field(:id, "tagsSubject").set($b_subj)
				$ie.button(:value,"Next").click
				$ie.text_field(:name, "txtBroadcastName").set("TEST BROADCAST")
				$ie.button(:value,"Next").click
				sleep 3
				$ie.button(:value,"Get Count").click
				sleep 10 
				$ie.radio(:xpath, "(//input[@name='radiobuttonGroup1'])[2]").click
				sleep 3
				$ie.text_field(:id, "txtNoEmailsSenduSampPanel").set("1")
				sleep 5
				#$ie.button(:value,"Next").click
				$ie.button(:id, "btnFinish").click
				sleep 3
				$st = '4'
				$test_description = "Complete sending broadcast reminder "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.html.include?('Your broadcast is being processed'))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	
				end
				$ie.link(:text, "Sent Broadcasts").click
				sleep 200
				$ie.refresh
				sleep 3
				$st = '5'
				$test_description = "Checking reminder in Sent Broadcast link in admin "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.text.include?($b_subj))
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
				File.open($Rem_bcast_id_fl_path, 'w') do |f1| 
				f1.puts $bcast_id
				end
				$ie.link(:text,"Logout").click
				$ie.close
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					#$obj.Close_all_windows
					$ie.close
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end	
	  end
	  
	  def test_05_complete_survey
	  
			begin	
				$file_1 = File.open($Bcast_id_fl_path)
				$bcast_id = $file_1.gets
				puts $bcast_id
				$file_1.close;
			
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
					
					
				$bcast_n = Base64.encode64($bcast_id)
				$qg_n = Base64.encode64($qg_id)
				
				$bcast_survey_url = "http://q.ipoll.com/al.php?e=#{$mem_email}&memid=#{$member_id_1}&QGID=#{$qg_n}=&broadcast_id=#{$bcast_n}"
				puts $bcast_survey_url
				
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
				$ff = Watir::Browser.new driver
				$ff.goto($bcast_survey_url)
				sleep 20
				$ff.button(:value,"START SURVEY").click
				sleep 10
				#$ff1 = FireWatir::Firefox.attach(:title,/Survey/)
				$ff.goto($sc_red_url)
				sleep 2
				$st = '6'
				$test_description = "Survey complete (Broadcast link) "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff.html.include?("Congratulations, you've just completed the survey"))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts"FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				#$ff1.close
				  
				$ff.goto("q.ipoll.com/index.php?mode=logout")
				$ff.close
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					#$obj.Close_all_windows
					$ff.close
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
	  end
	  
	  def test_06_change_setting
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin1_login($admin_email,$admin_passwd)
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
					
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")	
				sleep 2
				$ie.select_list(:name, "optQuotaStatus").select("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.goto("http://q.usampadmin.com/quota_member_pub_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&static=")
				sleep 5
				$ie.checkbox(:id, "chkIncludeExcludeMemberIdToken").set
				$ie.select_list(:id, "optMemberIdToken").select("IDs")
				$ie.text_field(:id, "txtAreaMemberIdTokens").clear
				$ie.text_field(:id, "txtAreaMemberIdTokens").set($member_id_2)
				$ie.button(:value,"Save Group").click
				$st = '7'
				$test_description = "Saving member pub options for a QG for scheduling broadcast "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.checkbox(:id, "chkIncludeExcludeMemberIdToken").set? && $ie.html.include?('Quota group Member Publisher details have been updated successfully'))
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
					#$obj.Close_all_windows
					$ie.close
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
	  end
	  
	  def test_07_schedule_bcast
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin1_login($admin_email,$admin_passwd)
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
				
				$ie.goto("http://q.usampadmin.com/query_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&type=new&static=")
				sleep 3
				$ie.button(:value,"Next").click
				sleep 10
				$ie.select_list(:name, "optTemplate").select("Client Services - Template A")
				sleep 5
				$b_subj = "Sch_Bcast:" + "#{$qg_id}"
				$ie.text_field(:id, "tagsSubject").set($b_subj)
				$ie.button(:value,"Next").click
				sleep 3
				$ie.text_field(:name, "txtBroadcastName").set("TEST BROADCAST")
				#$ie.button(:value,"Next").click
				sleep 10
				$ie.radio(:xpath, "(//input[@name='rdSchedule'])[2]").click
				# Calculate schedule time
				#$date=Time.now.strftime("%Y-%m-%d")
				#puts $date
				#$ie.execute_script("document.getElementsByName('txtStartDate').item(0).value = '2014-01-27'")
				$flg = 0
				$stamp = Time.new
				$stamp = $stamp.to_s
				$hour = $stamp.slice(11..12)
				$min = $stamp.slice(14..15)
				$second = $stamp.slice(17..18)
				puts $hour
				puts $min
				puts $second
				if ($hour.to_i >= 12)
					$flg = 1;
					$hour = $hour.to_i() - 12
				end
				if ($hour == "01")
					$hour = "1"
				else 
					if ($hour == "02")
						$hour = "2"
					else
						if ($hour == "03")
						$hour = "3"
						else
							if ($hour == "04")
                            $hour = "4"
							else
								if ($hour == "05")
								$hour = "5"
								else
									if ($hour == "06")
									$hour = "6"
									else
                                        if ($hour == "07")
                                        $hour = "7"
                                        else
                                            if ($hour == "08")
                                              $hour = "8"
                                            else
                                                if ($hour == "09")
                                                    $hour = "9"
                                                end
                                            end
                                        end
									end
								end
							end
						end
					end
				end
				if ($min.to_i <=10)
					$min = 15
				else 
					if ($min.to_i >= 15 && $min.to_i <25)
						$min = 30
					else
						if ($min.to_i >= 25 && $min.to_i <40)
							$min = 45
						else
							if ($min.to_i >= 40 && $min.to_i <55)
								$min = 00
								$hour = $hour.to_i+1
							else
								$min = 15
								$hour = $hour.to_i+1
							end
						end
					end    
				end
				puts "**"
				$hour = $hour.to_s()
				$hour = $hour.chomp()
				$min = $min.to_s()
				$min = $min.chomp()
				puts $hour
				puts $min
				#$ie.text_field(:name , 'txtStartDate').value = $date
				#$ie.image(:xpath, "html/body/table/tbody/tr[5]/td/table/tbody/tr/td[3]/table/tbody/tr[6]/td/table/tbody/tr[2]/td/table/tbody/tr/td/table/tbody/tr[4]/td/table/tbody/tr[3]/td/table/tbody/tr[2]/td/table/tbody/tr[2]/td[2]/a/img").click
				#$ie.button(:xpath, ".//*[@id='datepicker']/table/tbody/tr[1]/td[3]/button").click
				#$ie.td(:xpath, ".//*[@id='datepicker']/table/tbody/tr[6]/td[4]").click
				$ie.execute_script("document.getElementsByName('txtStartDate').item(0).value = '2014-05-07'")
				$ie.select_list(:name, "optTimeHour").select($hour)
				#$ie.select_list(:name, "optTimeMin").select(/#{$min}/)
				$ie.select_list(:name, "optTimeMin").select($min)
				if ($flg == 0)
					$ie.radio(:name, "rdTime", "am").click
				else
					$ie.radio(:name, "rdTime", "pm").click
				end
				sleep 4
				$ie.button(:value,"Next").click
				$ie.button(:value,"Get Count").click
				sleep 10 
				$ie.text_field(:id, "txtNoEmailsSenduSampPanel").set("1")
				#$ie.button(:value,"Next").click
				sleep 3
				$ie.button(:id, "btnFinish").click
				sleep 3
				$st = '8'
				$test_description = "Complete scheduling broadcast "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.html.include?('Your broadcast is being processed'))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	
				end
				$ie.link(:text, "Scheduled Broadcasts").click
				sleep 100
				$ie.refresh
				sleep 3
				$st = '9'
				$test_description = "Checking transaction in Scheduled Broadcast page in admin "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.text.include?($b_subj))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	
				end
				sleep 3
				$ie.link(:text,"Logout").click
				$ie.close
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					#$obj.Close_all_windows
					$ie.close
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end	
	  end
	  
	  def test_08_update_from_server
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin1_login($admin_email,$admin_passwd)
				sleep 2
				$file_1 = File.open($proj_id_file_path)
				$prj_id = $file_1.gets
				puts $prj_id
				$file_1.close;
			
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$file_3 = File.open($Bcast_id_fl_path)
				$bcast_id = $file_3.gets
				puts $bcast_id
				$file_3.close;
				
				$file_4 = File.open($Rem_bcast_id_fl_path)
				$rem_bcast_id = $file_4.gets
				puts $rem_bcast_id
				$file_4.close;
				
				sleep 30
				puts "Waiting for system to send broadcast..."
				sleep 30
				puts "Waiting for system to send broadcast..."
				sleep 30
					
				$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
				$bcast_id = $bcast_id.chomp()
				$rem_bcast_id = $rem_bcast_id.chomp()
				$ie.goto("http://q.usampadmin.com/query_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&type=new&static=")
				sleep 3
				$ie.link(:text, "Sent Broadcasts").click
				sleep 50
				#$ie.radio(:index, "2").click
				$chbx_val1 = "checked" + "#{$bcast_id}"
				$ie.radio(:value,"#{$chbx_val1}").click
				$ie.button(:value,"Update from Mail Server").click
				sleep 5
				$b_subj = "Bcast:" + "#{$qg_id}"
				$b_subj = "#{$b_subj}" + " (Complete)"
				puts $b_subj
				$st = '10'
				$test_description = "Update from mail server "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.text.include?($b_subj))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL:TAKING TOO LONG"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED(Mail sending taking too long)</font></td></tr>"	
				end
				$ie.link(:text, "Sent Broadcasts").click
				sleep 50
				#$ie.radio(:index, "1").click
				$chbx_val2 = "checked" + "#{$rem_bcast_id}"
				$ie.radio(:value,"#{$chbx_val2}").click
				$ie.button(:value,"Update from Mail Server").click
				sleep 5
				$b_subj = "Rem:" + "#{$qg_id}"
				$b_subj = "#{$b_subj}" + " (Complete)"
				puts $b_subj
				$st = '11'
				$test_description = "Update from mail server (Reminder) "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.text.include?($b_subj))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL:TAKING TOO LONG"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED(Mail sending taking too long)</font></td></tr>"	
				end
				
				$ie.link(:text,"Logout").click
				$ie.close
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					#$obj.Close_all_windows
					$ie.close
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
	  end
	  
	  def test_09_check_email_delivery
				
			begin	
				$st = '12'
				$test_description = "Checking email delivery"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
				$ff = Watir::Browser.new driver
				$ff.goto("http://www.rediff.com")
				sleep 3
				#$ff.maximize
				$ff.link(:text,"Sign in").click
				sleep 10
				$ff.text_field(:id,"c_uname").set($redf_uname)
				$ff.text_field(:id,"c_pass").set($redf_pass)
				$ff.button(:id,"btn_login").click
				sleep 10
				$b_subj = "Bcast:" + "#{$qg_id}"
				if ($ff.text.include?($b_subj))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL:TAKING TOO LONG"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED(Mail sending taking too long)</font></td></tr>"
				end
				$st = '13'
				$test_description = "Checking email delivery (Reminder)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$b_subj = "Rem:" + "#{$qg_id}"
				if ($ff.text.include?($b_subj))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL:TAKING TOO LONG"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED(Mail sending taking too long)</font></td></tr>"
				end
				
				$ff.link(:text,"Signout").click
				$ff.close
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					#$obj.Close_all_windows
					$ff.close
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end	
				
				
	  end
	  
	  
	  def test_10_qg_reset
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin1_login($admin_email,$admin_passwd)
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
					
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")	
				sleep 2
				$ie.select_list(:name, "optQuotaStatus").select("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.goto("http://q.usampadmin.com/quota_member_pub_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&static=")
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
					#$obj.Close_all_windows
					$ie.close
					
			end	
	  end

end