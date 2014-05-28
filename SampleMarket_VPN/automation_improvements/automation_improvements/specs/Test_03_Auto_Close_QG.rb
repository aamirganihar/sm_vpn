# QG AUTO CLOSE (TIME/CLICKS/COMPLETES)

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
require 'Input Repository\Test_03_Auto_Close_QG_Input.rb'

class Test_03_Auto_close_QG < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "3 - "
				$test_description = "Test Case: "+$t.to_s+"  AUTO CLOSE QG (TIME/CLICKS/COMPLETES)"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_autoclose_time
				
				$st = '1'
				$test_description = "Auto close QG (Time)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
	  
	  
			begin
					
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
					
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
					$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
					$ie.select_list(:name, "optQuotaStatus").set("Open")
					$ie.button(:name,"btnSave").click
					sleep 2
					$date=Time.now.strftime("%Y-%m-%d")
					$ie.link(:text,"Auto-Close").click
					sleep 2
					$ie.select_list(:name, "optAutoCloseStatus").set("ON")
					$ie.radio(:name, "rdCloseQGAt", "Setdate").click
					$ie.text_field(:name , 'txtSetDate').value = $date
					
					$stamp = Time.new
					$stamp = $stamp.to_s
					$hour = $stamp.slice(11..12)
					$min = $stamp.slice(14..15)
					$second = $stamp.slice(17..18)
					puts $hour
					puts $min
					puts $second
					if ($min.to_i < 58 && $min.to_i > 8) 
						$min = $min.to_i+2
					else 
					    if ($min.to_i < 8) 
							$min1 = $min.to_i+2
							$min = "0"+$min1.to_s
						else
							if ($min.to_i == 58 && $hour.to_i >= 9 && $hour.to_i <23)
						            $min = $min.to_i+2
									$min = 60 - $min.to_i
									$hour = $hour.to_i+1
									$min = $min.to_i+1
							else
								if ($min.to_i == 58 && $hour.to_i < 9)
										 $min = $min.to_i+2
										 $min = 60 - $min.to_i
										 $hour = $hour.to_i+1
										 $hour = "0"+$hour.to_s
										 $min = "0"+$min.to_s
								else
								    if ($min.to_i > 58 && $hour.to_i >= 9 && $hour.to_i <23)
										  $min = $min.to_i+2
										  $min = $min.to_i - 60
										  $hour = $hour.to_i+1
									else
										if ($min.to_i > 58 && $hour.to_i < 9 )
											  $min = $min.to_i+2
											  $min = $min.to_i - 60
											  $hour = $hour.to_i+1
											  $hour = "0"+$hour.to_i
										else
											if ($min.to_i == 58 && $hour.to_i == 23)
												  $min = $min.to_i+2
												  $min = 60 - $min.to_i
												  $hour = '00'
											else
												if ($min.to_i > 58 && $hour.to_i == 23)
													  $min = $min.to_i+2
													  $min = $min.to_i - 60
													  $hour = '00'
												end
										    end
										end
									end
								end
							end
						end
					end
					$ie.select_list(:name, "optHours").set($hour)
					$ie.select_list(:name, "optMinutes").set($min)
					$ie.radio(:name, "rdClosedSurveyOptions", "survey_closed").click
					$ie.button(:value,"Save Group").click
					if ($ie.contains_text('Quota group details have been updated successfully'))
							puts "Time Settings Saved"
					else
							puts "Time settings saving failed"
					end
					
					sleep 200
					$ie.link(:text, "Stats").click
					sleep 8
					if ($ie.contains_text('Closed change status'))
								$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                puts "TIME_SET_PASSED"
					else 
								$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                puts "TIME_SET_FAILED"
					end
					$ie.link(:text,'Logout').click
					$obj.Delete_cookies
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
	  
	  def test_03_autoclose_clicks
				
				$st = '2'
				$test_description = "Auto close QG (Clicks) "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
			
					begin
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
							
							$obj = Usamp_lib.new
							$obj.Delete_cookies()
							$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
							$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
							$ie.select_list(:name, "optQuotaStatus").set("Open")
							$ie.button(:name,"btnSave").click
							$ie.link(:text,"Auto-Close").click
							sleep 2
							$ie.select_list(:name, "optAutoCloseStatus").set("ON")
							$ie.radio(:name, "rdCloseQGAt", "Clicks").click
							$ie.text_field(:name,"txtNoOfClicks").set($no_of_clicks)
							$ie.radio(:name, "rdClosedSurveyOptions", "survey_closed").click
							sleep 2
							$ie.button(:value,"Save Group").click
							sleep 3
							if ($ie.contains_text('Quota group details have been updated successfully'))
									puts "Clicks Settings Saved"
							else
									puts "Clicks settings saving failed"
							end
							$ie.link(:url,/list_quota_group_publishers.php/).click
							sleep 2
							$ie.frame(:name, "quota_group_publisher_iframe").link(:text,'GO').click
							sleep 100
							$ie.link(:text, "Stats").click
							sleep 3
							if ($ie.contains_text('Closed change status'))
										  $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
							else 
										  $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
							end
							$ie.link(:text,'Logout').click
							$obj.Delete_cookies
							$ie.close
              $ie1 = Watir::IE.attach(:title,'TEST_AUTOMATION_SURVEY')
              $ie1.close
					
					
					rescue => e
							puts e.message
							puts e.backtrace.inspect
							$obj.Close_all_windows
							$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
							$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
							$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
					
					end			
			
			end
	
			def test_04_autoclose_completes
				
				$st = '3'
				$test_description = "Auto close QG (Completes) "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				begin
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
							
							$obj = Usamp_lib.new
							$obj.Delete_cookies()
							$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
							$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
							$ie.select_list(:name, "optQuotaStatus").set("Open")
							$ie.button(:name,"btnSave").click
							sleep 2
							$ie.link(:text,"Auto-Close").click
                            sleep 2
                            $ie.select_list(:name, "optAutoCloseStatus").set("ON")
                            $ie.radio(:name, "rdCloseQGAt", "Completes").click
                            $ie.text_field(:name,"txtNoOfCompletes").set($no_of_completes)
                            $ie.radio(:name, "rdClosedSurveyOptions", "survey_closed").click
                            sleep 2
                            $ie.button(:value,"Save Group").click
							if ($ie.contains_text('Quota group details have been updated successfully'))
									puts "Completes Settings Saved"
							else
									puts "Completes settings saving failed"
							end
							$ie.link(:url,/list_quota_group_publishers.php/).click
							sleep 5
							$ie.frame(:name, "quota_group_publisher_iframe").link(:text,'GO').click
                            sleep 20
                            $ie=Watir::IE.attach(:title,'TEST_AUTOMATION_SURVEY')
                            $ie.speed = :fast
                            $ie.goto('http://p.u-samp.com/redirect.php?S=1')
                            sleep 2
                            $ie.close
                            sleep 98
                            $ie=Watir::IE.attach(:title,'uSamp.com')
                            $ie.speed = :fast
                            sleep 2
                            $ie.link(:text, "Stats").click
                            sleep 3
							if ($ie.contains_text('Closed change status'))
                                      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                            else 
                                      $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                            end
							$ie.link(:text,'Logout').click
                            $obj.Delete_cookies
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

end