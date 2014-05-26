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
require 'win32/process'
#include 'Suite'
require 'base64'
require 'Input Repository\Test_17_Member_data_review_Input.rb'
require 'Input Repository\surveyurl.rb'
require 'Pop_up_kill.rb'

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
=begin					
					@pid = Process.create(
                                        :app_name  => 'ruby popup_closer_IE.rb',
                                        :creation_flags  => Process::DETACHED_PROCESS
                                        ).process_id
                                     at_exit{ Process.kill(9,@pid) }
=end				
					callPopupKillerIE()
					
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
					$ie.link(:text,"Copy Selected Quota Group").click
					sleep 3
					$st = '1'
					$test_description = "Copy QG"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					
					if($ie.contains_text(/Quota Group details has been copied successfully/))
							puts "QG COPIED"
							$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
					else
							puts "QG COPY FAILED"
							$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
					end
					
					$date=Time.now.strftime("%Y-%m-%d")
					$SECONDS_PER_DAY = 60 * 60 * 24
					$date_added_1=(Time.now + 10*$SECONDS_PER_DAY).localtime.strftime("%Y-%m-%d") 
					puts $date_added_1
					
					$ie.select_list(:name, "optQuotaStatus").set("Open")
					$ie.text_field(:name , 'txtQuotaCloseDate').value = $date_added_1
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
					$ie.goto("http://p.usampadmin.com/cpi_history.php?quota_group_id=#{$qg_n2}")
					$ie.button(:value,"Add New").click
					$ie.text_field(:name, "txtCPI").set("150")
					$ie.button(:value,"Done").click
					$ie.goto("http://p.usampadmin.com/reward_history.php?quota_group_id=#{$qg_n2}")
          sleep 3
					$ie.button(:value,"Add New").click
					$ie.radio(:name, "rdRewardType", "Cash").click
					$ie.text_field(:name, "txtRewardAmount").set("120")
					$ie.button(:value,"Done").click
					sleep 2
					$ie.checkbox(:id, "chkShowSurvey").set
					sleep 2
				    $ie.text_field(:id, "txtSurveyName").set("COPIED AUTO TEST SURVEY")
					$ie.button(:name,"btnSave").click
					sleep 2
					$ie.link(:text,"Logout").click
					
					$ie.close
          puts "def02 ends here"
			
=begin			
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					$obj.Close_all_windows
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
                    sleep 2
                    $ff.button(:value,"START SURVEY").click
                    sleep 10
                    $ff1=FireWatir::Firefox.attach(:title,'Survey')
                    $ff1.goto($sc_red_url)
				    sleep 2
					$ff1.close
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
					$enc_mem_id = Base64.encode64($m1_mid)
					$ie.goto("http://p.usampadmin.com/member_activity_log.php?member_id=#{$enc_mem_id}")
          sleep 3
					$ie.checkbox(:index,1).set
                    $ie.button(:value,"Mark As Earned").click
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
					
					$ff.attach(:url,"http://www.p.ipoll.com/dashboard.php")
                    $ff.link(:url,/my_rewards.php/).click
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
							if ($html_array[index+9] =~ /Earned/)
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
          rescue => e
					puts e.message
					puts e.backtrace.inspect
					$obj.Close_all_windows
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
        end
        
					$ff.goto("http://www.p.ipoll.com/index.php?mode=logout")
					$ff.close
					$ie.link(:text,"Logout").click
					$ie.close
=begin			
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					$obj.Close_all_windows
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
                    $ff1=FireWatir::Firefox.attach(:title,'Survey')
                    $ff1.goto($sc_red_url)
				    sleep 2
					$ff1.close
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
					$enc_mem_id = Base64.encode64($m2_mid)
					$ie.goto("http://p.usampadmin.com/member_activity_log.php?member_id=#{$enc_mem_id}")
          sleep 3
					$ie.checkbox(:index,1).set
                    $ie.button(:value,"Mark As Invalid").click
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
					
					$ff.attach(:url,"http://www.p.ipoll.com/dashboard.php")
                    $ff.link(:url,/my_rewards.php/).click
                    sleep 4
					$st = '5'
					$test_description = "Member Transaction marked as invalid on Member rewards page (PL site)"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                    $html_contents=$ff.html
                    $html_array = $html_contents.split(/\n/)
                    0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /#{$qg_id_2.chomp}/)
							if ($html_array[index+9] =~ /Invalid/)
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
				
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$ie.checkbox(:id, "chkShowSurvey").clear
				#$ie.text_field(:id, "txtSurveyName").set("AUTO TEST SURVEY")
				$ie.button(:value,"Save Group").click
				$ie.link(:text,'Logout').click
				$obj.Delete_cookies
				killPopupKiller()
				$ie.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				$obj.Close_all_windows
			end
					
	  end

end