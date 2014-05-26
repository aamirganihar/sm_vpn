# SUCCESS/FAIL/OVERQUOTA REWARDS

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
require 'Input Repository\surveyurl.rb'
require 'Input Repository\Test_57_Success_fail_oq_rewards_Input.rb'

class Test_57_Success_fail_oq_rewards < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = '57 - '
				$test_description = "Test Case: "+$t.to_s+"  SUCCESS/FAIL/OVERQUOTA REWARDS"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_setting_fail_oq_rewards
	  
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
				$ie.link(:text, "Edit / View Fail Reward History").click
				sleep 5
				$ie.button(:value,"Add New").click
				$ie.radio(:name, "rdRewardType", "Cash").click
				$ie.text_field(:name, "txtRewardAmount").set($fail_rew_amt)
				$ie.button(:value,"Done").click
				sleep 3
				
				$st = '1'
				$test_description = "Saving Fail reward for QG "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.checkbox(:id, "chkFailRewardStatus").isSet?)
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$st = '2'
				$test_description = "Saving Overquota reward for QG "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				$ie.link(:text, "Edit / View Over Quota Reward History").click
				$ie.button(:value,"Add New").click
				$ie.radio(:name, "rdRewardType", "Cash").click
				$ie.text_field(:name, "txtRewardAmount").set("3")
				$ie.button(:value,"Done").click
				if($ie.checkbox(:id, "chkOverQuotaRewardStatus").isSet?)
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
				$ie.link(:text => "Edit / view History",:index => "2").click
				sleep 5
				$ie.button(:value,"Add New").click
				$ie.radio(:name, "rdRewardType", "Cash").click
				$ie.text_field(:name, "txtRewardAmount").set($new_sc_rew)
				$ie.button(:value,"Done").click
				$st = '3'
				$test_description = "Updating Success reward for QG "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.contains_text(/New Reward value has been added successfully/))
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
	  
	  def test_03_success_reward
	  
			begin		
					$file_2 = File.open($qg_id_file_path)
					$qg_id = $file_2.gets
					puts $qg_id
					$file_2.close;
					
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ff = $obj.Surveyhead_login($m1_email,$m1_passwd)
					sleep 5
					puts "## Waiting for surveys to load ##"
					
					$survey_link  = Base64.encode64($qg_id)
                    $survey_link = "link"+$survey_link
                    $survey_link = $survey_link.chomp
                    puts $survey_link
                    sleep 10
                    $ff.link(:id, $survey_link).click
                    sleep 2
                    $ff.button(:value,"START SURVEY").click
                    sleep 10
                    $ff1=FireWatir::Firefox.attach(:title,/Survey/)
                    $ff1.goto($sc_red_url)
				    sleep 2
					$ff1.close
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
					
					@pid = Process.create(
                                        :app_name  => 'ruby popup_closer_IE.rb',
                                        :creation_flags  => Process::DETACHED_PROCESS
                                        ).process_id
                                     at_exit{ Process.kill(9,@pid) }
					
					$enc_mem_id = Base64.encode64($m1_mid)
					$ie.goto("http://p.usampadmin.com/member_activity_log.php?member_id=#{$enc_mem_id}")
					sleep 3
					$ie.checkbox(:index,1).set
                    $ie.button(:value,"Mark As Earned").click
                    sleep 2
					
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
                            else
                                    puts "FAIL"
                            end
                            }
                            break
                    else
                            next
                    end
                    }
					
					$ff.attach(:url,"http://www.p.ipoll.com/dashboard.php")
                    $ff.link(:url,/my_rewards.php/).click
                    sleep 4
					$st = '4'
					$test_description = "Success reward marked as earned on PL site"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                    $html_contents=$ff.html
                    $html_array = $html_contents.split(/\n/)
                    0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /#{$qg_id.chomp}/)
							puts "** CHK AMT **"
							puts $html_array[index+5]
							puts $html_array[index+6]
							puts $html_array[index+7]
							puts $html_array[index+8]
							puts "********"
							if (($html_array[index+9] =~ /Earned/) && ($html_array[index+5] =~ /\$5.00/))
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
					$ff.goto("http://www.p.ipoll.com/index.php?mode=logout")
					$ff.close
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
	  
	  def test_04_fail_reward
	  
			begin		
					$file_2 = File.open($qg_id_file_path)
					$qg_id = $file_2.gets
					puts $qg_id
					$file_2.close;
					
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ff = $obj.Surveyhead_login($m2_email,$m2_passwd)
					sleep 5
					puts "## Waiting for surveys to load ##"
					
					$survey_link  = Base64.encode64($qg_id)
                    $survey_link = "link"+$survey_link
                    $survey_link = $survey_link.chomp
                    puts $survey_link
                    sleep 10
                    $ff.link(:id, $survey_link).click
                    sleep 2
                    $ff.button(:value,"START SURVEY").click
                    sleep 10
                    $ff1=FireWatir::Firefox.attach(:title,/Survey/)
                    $ff1.goto($fl_red_url)
				    sleep 2
					$ff1.close
					
					$ff.attach(:url,"http://www.p.ipoll.com/dashboard.php")
                    $ff.link(:url,/my_rewards.php/).click
                    sleep 4
					$st = '5'
					$test_description = "Fail reward marked as earned on PL site"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                    $html_contents=$ff.html
                    $html_array = $html_contents.split(/\n/)
                    0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /#{$qg_id.chomp}/)
							puts "** CHK AMT **"
							puts $html_array[index+5]
							puts $html_array[index+6]
							puts $html_array[index+7]
							puts $html_array[index+8]
							puts "********"
							if (($html_array[index+9] =~ /Earned/) && ($html_array[index+5] =~ /\$2.00/))
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
					$ff.goto("http://www.p.ipoll.com/index.php?mode=logout")
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
	  
	  def test_05_oq_reward
	  
			begin		
					$file_2 = File.open($qg_id_file_path)
					$qg_id = $file_2.gets
					puts $qg_id
					$file_2.close;
					
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ff = $obj.Surveyhead_login($m3_email,$m3_passwd)
					sleep 5
					puts "## Waiting for surveys to load ##"
					
					$survey_link  = Base64.encode64($qg_id)
                    $survey_link = "link"+$survey_link
                    $survey_link = $survey_link.chomp
                    puts $survey_link
                    sleep 10
                    $ff.link(:id, $survey_link).click
                    sleep 2
                    $ff.button(:value,"START SURVEY").click
                    sleep 10
                    $ff1=FireWatir::Firefox.attach(:title,/Survey/)
                    $ff1.goto($oq_red_url)
				    sleep 2
					$ff1.close
					
					$ff.attach(:url,"http://www.p.ipoll.com/dashboard.php")
                    $ff.link(:url,/my_rewards.php/).click
                    sleep 4
					$st = '6'
					$test_description = "Overquota reward marked as earned on PL site"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                    $html_contents=$ff.html
                    $html_array = $html_contents.split(/\n/)
                    0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /#{$qg_id.chomp}/)
							puts "** CHK AMT **"
							puts $html_array[index+5]
							puts $html_array[index+6]
							puts $html_array[index+7]
							puts $html_array[index+8]
							puts "********"
							if (($html_array[index+9] =~ /Earned/) && ($html_array[index+5] =~ /\$3.00/))
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
					$ff.goto("http://www.p.ipoll.com/index.php?mode=logout")
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
	  
end