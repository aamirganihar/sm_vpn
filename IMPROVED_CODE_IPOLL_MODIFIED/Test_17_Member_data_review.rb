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
require 'win32/process'
#include 'Suite'
require 'base64'
require './Input Repository\surveyurl.rb'
require './Input Repository\Test_17_Member_data_review_Input.rb'
#require 'Pop_up_kill.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

class Test_17_Member_data_review < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$qg_id_file_path_2 = $wd+"/Input Repository/Copied_QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "17 - "
				$test_description = "Test Case: "+$t.to_s+"  MEMBER DATA REVIEWING"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_copy_qg_change_reward
	  
			#begin
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
#=begin					
					#@pid = Process.create(
                                        #:app_name  => 'ruby popup_closer_IE.rb',
                                       # :creation_flags  => Process::DETACHED_PROCESS
                                        #).process_id
                                    # at_exit{ Process.kill(9,@pid) }
#=end				
					#callPopupKillerIE()
					
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
					sleep 5
					$ie.link(:text,"Copy Selected Quota Group").click
					#sleep 2
					$ie.alert.exists?
					$ie.alert.ok
					sleep 10
					$st = '1'
					$test_description = "Copy QG"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					
					#sleep 10
					if($ie.html.include?('Quota Group details has been copied successfully'))
							puts "QG COPIED"
							$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
					else
							puts "QG COPY FAILED"
							$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
					end
					
					#$date=Time.now.strftime("%Y-%m-%d")
					#$SECONDS_PER_DAY = 60 * 60 * 24
					#$date_added_1=(Time.now + 10*$SECONDS_PER_DAY).localtime.strftime("%Y-%m-%d") 
					#puts $date_added_1
					
					sleep 5
					$ie.select_list(:name, "optQuotaStatus").select("Open")
					#$ie.text_field(:name , 'txtQuotaCloseDate').value = $date_added_1
					#$ie.image(:xpath, ".//*[@id='quotaCloseTR']/td[2]/a/img").click
					#$ie.button(:xpath, ".//*[@id='datepicker']/table/tbody/tr[1]/td[3]/button").click
					#$ie.td(:xpath, ".//*[@id='datepicker']/table/tbody/tr[6]/td[4]").click
					 #$ie.execute_script("document.getElementsByName('txtQuotaCloseDate').item(0).value = '2014-01-29'")
					 #sleep 10
					$file1 = File.open($qg_id_file_path_2, 'w');
					sleep 25
					#Watir::Wait.until {$ie.html.include? 'GROUP DETAILS:'}
					$qg_id_2= /GROUP DETAILS: QG(\d+)/.match($ie.text)
					$qg_id_2= $qg_id_2.to_s
					$length=$qg_id_2.length
					$qg_id_2=$qg_id_2.slice(17..$length)
					puts $qg_id_2
					$file1.print $qg_id_2;
					$file1.close;
					
					#sleep 5
					$qg_n2 = Base64.encode64($qg_id_2)	
					$ie.button(:name, "btnSave").click
					
					sleep 2
					$ie.goto("http://q.usampadmin.com/cpi_history.php?quota_group_id=#{$qg_n2}")
					$ie.button(:value,"Add New").click
					$ie.text_field(:name, "txtCPI").set("150")
					$ie.button(:value,"Done").click
					$ie.goto("http://q.usampadmin.com/reward_history.php?quota_group_id=#{$qg_n2}")
					sleep 3
					$ie.button(:value,"Add New").click
					$ie.radio(:value, "Cash").click
					$ie.text_field(:name, "txtRewardAmount").set("120")
					$ie.button(:value,"Done").click
					sleep 5
					$ie.checkbox(:id, "chkShowSurvey").set
					sleep 5
					$ie.text_field(:id, "txtSurveyName").set("COPIED AUTO TEST SURVEY")
					$ie.button(:name,"btnSave").click
					sleep 5
          
          puts "setting on add quota group done... goint to criteria page"
          
          #puts "http://p.usampadmin.com/add_quota_group_criteria.php?project_id=MjM2NjI=&quota_group_id=MTEwOTA1&static="
          puts $qg_n2 
          puts $prj_n
          puts "q.usampadmin.com/add_quota_group_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n2}"
          $ie.goto("http://q.usampadmin.com/add_quota_group_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n2}&static=")
#$ie.link(:class, "black_link1").click


#$ie.select_list(:name, "optNationalityId[]").select "United States"
          $ie.button(:value, "Save Group").click 
          sleep 5
					$ie.link(:text,"Logout").click
					
					$ie.close
          puts "def02 ends here"
          
=begin			
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					#$obj.Close_all_windows
					$ie.close
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
=end	  
	  end
  
	  def test_03_member_data_review
	  
			begin
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ff = $obj.Surveyhead_login($m1_email,$m1_passwd)
					sleep 5
					puts "## Waiting for surveys to load ##"
					
					$survey_link  = Base64.encode64($qg_id_2)
                    $survey_link = "link"+$survey_link
                    $survey_link = $survey_link.chomp
                    puts $survey_link
                    sleep 10
                    $ff.link(:id, $survey_link).click
                    puts "survey found on dashboard"
                    sleep 2
                    $ff.button(:name,"Submit").click
                    sleep 5
                    #$ff1=FireWatir::Firefox.attach(:title,'Survey')
					 #driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                    #$ff1= Watir::Browser.new driver
                    $ff.window(:title,'Survey').use do
		    sleep 2
                    $ff.goto($sc_red_url)
				    sleep 2
					#$ff.close
				end
				$ff.goto("https://www.q.ipoll.com/dashboard.php")
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
					$enc_mem_id = Base64.encode64($m1_mid)
					$ie.goto("http://q.usampadmin.com/member_activity_log.php?member_id=#{$enc_mem_id}")
          sleep 3
					$ie.checkbox(:xpath, "//input[@name='chkMemberSurveyClickIds[]']").set
                    $ie.button(:value,"Mark As Earned").click
		    $ie.alert.exists?
		    $ie.alert.ok
                    sleep 2
					$st = '2'
					$test_description = "Member Transaction marked as reviewed on activity log (ADMIN)"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$html_contents=$ie.html
                    $html_array = $html_contents.split(/\n/)
					
					0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /#{$qg_id_2}/)
							puts $html_array[index+1]
                            puts "***"
                            puts $html_array[index+8]
                            $html_array[index+8].scan(/[A-Za-z]+</){
                            if ($html_array[index+8] =~ /Earned/)
									puts "PASS"
                                    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                            else
                                    puts "FAIL"
                                    $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                            end
                            }
                            break
                    else
                            next
                    end
                    }
					
					#$ff.attach(:url,"https://www.p.ipoll.com/dashboard.php")
					 #$ff.window(:url,"https://www.p.ipoll.com/dashboard.php").use do
                    $ff.goto("https://www.q.ipoll.com/my_rewards.php")
                    sleep 4
					$st = '3'
					$test_description = "Member Transaction marked as earned on Member rewards page (PL site)"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
          puts "test"
                    $html_contents=$ff.html
                    $html_array = $html_contents.split(/\n/)
                    0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /#{$qg_id_2.chomp}/)
							if ($html_array[index+12] =~ /Earned/)
                                    puts "PASS"
                                    puts "test1"
                                    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                            else
                                    puts "FAIL"
                                    $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                            end
                            break
                    else
                            next
                    end
                    }
	    #end
	    $ff.goto("https://www.q.ipoll.com/index.php?mode=logout")
	     $ff.close
	$ie.link(:text,"Logout").click
	$ie.close
          rescue => e
					puts e.message
					puts e.backtrace.inspect
					#$obj.Close_all_windows
					$ff.close
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
        end
				
					
=begin			
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					#$obj.Close_all_windows
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
=end  

	  end
	  
	  def test_04_member_data_invalid
	  
			begin
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ff = $obj.Surveyhead_login($m2_email,$m2_passwd)
					sleep 5
					puts "## Waiting for surveys to load ##"
					
					$survey_link  = Base64.encode64($qg_id_2)
                    $survey_link = "link"+$survey_link
                    $survey_link = $survey_link.chomp
                    puts $survey_link
                    sleep 10
                    $ff.link(:id, $survey_link).click
                    sleep 2
                    $ff.button(:value,"START SURVEY").click
                    sleep 8
					
                    #$ff1=FireWatir::Firefox.attach(:title,'Survey')
					#driver = Selenium::WebDriver.for :ie #, :profile => "Selenium"
                    #$ie1= Watir::Browser.new driver
                    $ff.window(:title,'Survey').use do
		    sleep 2
                    $ff.goto($sc_red_url)
				    sleep 2
					#$ff.close
				end
				 $ff.goto("https://www.q.ipoll.com/dashboard.php")
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
					$enc_mem_id = Base64.encode64($m2_mid)
					$ie.goto("http://q.usampadmin.com/member_activity_log.php?member_id=#{$enc_mem_id}")
          sleep 3
					$ie.checkbox(:xpath,"//input[@name='chkMemberSurveyClickIds[]']").set
                    $ie.button(:value,"Mark As Invalid").click
		    $ie.alert.exists?
		    $ie.alert.ok
                    sleep 2
					$st = '4'
					$test_description = "Member Transaction marked as Invalid on activity log (ADMIN)"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$html_contents=$ie.html
                    $html_array = $html_contents.split(/\n/)
					0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /#{$qg_id_2}/)
							puts $html_array[index+1]
                            puts "***"
                            puts $html_array[index+8]
                            $html_array[index+8].scan(/[A-Za-z]+</){
                            if ($html_array[index+8] =~ /Invalid/)
									puts "PASS"
                                    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                            else
                                    puts "FAIL"
                                    $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                            end
                            }
                            break
                    else
                            next
                    end
                    }
					
					#$ff.attach(:url,"https://www.p.ipoll.com/dashboard.php")
                    #$ff.link(:url,/my_rewards.php/).click
		    #$ff.window(:url,"https://www.p.ipoll.com/dashboard.php").use do
                    $ff.goto("https://www.q.ipoll.com/my_rewards.php")
                    sleep 4
					$st = '5'
					$test_description = "Member Transaction marked as invalid on Member rewards page (PL site)"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                    $html_contents=$ff.html
                    $html_array = $html_contents.split(/\n/)
                    0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /#{$qg_id_2.chomp}/)
							if ($html_array[index+12] =~ /Invalid/)
                                    puts "PASS"
                                    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                            else
                                    puts "FAIL"
                                    $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                            end
                            break
                    else
                            next
                    end
                    }
					#end
					$ff.goto("http://www.q.ipoll.com/index.php?mode=logout")
					$ff.close
					$ie.link(:text,"Logout").click
					$ie.close
			
			
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
	  
	  def test_05_qg_reset
			
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)	
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
				
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$ie.checkbox(:id, "chkShowSurvey").clear
				#$ie.text_field(:id, "txtSurveyName").set("AUTO TEST SURVEY")
				$ie.button(:value,"Save Group").click
				$ie.link(:text,'Logout').click
				$obj.Delete_cookies
				#killPopupKiller()
				$ie.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
				$ie.close
			end
					
	  end

end