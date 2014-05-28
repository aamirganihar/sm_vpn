# CONFIG SETTINGS CASES - REWARDS CASH OUT % & DEFAULT FIRST SURVEY CPI / CAP AMOUNT 

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
require 'Input Repository\Test_66_Config_setting_cases_Input.rb'

class Test_67_Config_setting_cases < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_2_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_2_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "66 - "
				$test_description = "Test Case: "+$t.to_s+" CONFIG SETTINGS CASES - REWARDS CASH OUT % & DEFAULT FIRST SURVEY CPI / CAP AMOUNT  "
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_saving_config_setting
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$ie.goto("http://p.usampadmin.com/configuration_settings.php")
				sleep 2
				$ie.text_field(:name, "txtRewardCashoutPercent").set($rew_cashout)
                $ie.text_field(:id, "txtFirstSurveyCpiPerc").set($fcpi)
                $ie.text_field(:id, "txtCapAmount").set($cap_amt)
                $ie.button(:value,"UPDATE").click
				sleep 2
				$st = '1'
				$test_description = "Saving the Config setting in admin"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$val1 = $ie.text_field(:name, "txtRewardCashoutPercent").value
				$val2 = $ie.text_field(:id, "txtFirstSurveyCpiPerc").value
				$val3 = $ie.text_field(:id, "txtCapAmount").value
				
				if ($ie.contains_text(/Global values have been updated successfully/) && ($val1 == $rew_cashout) && ($val2 == $fcpi) && ($val3 == $cap_amt))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
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
	  
	  def test_03_survey_complete
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Surveyhead_login($mem_email,$mem_passwd)
				sleep 25
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				$survey_link  = Base64.encode64($qg_id)
                $survey_link = "link"+$survey_link
                $survey_link = $survey_link.chomp
                puts $survey_link
                sleep 10
                #CLICK1
				$ff.link(:id, $survey_link).click
                sleep 8
                $ff.button(:value,"START SURVEY").click
                sleep 12
                $ff1 = FireWatir::Firefox.attach(:title,'TEST_AUTOMATION_SURVEY')
				sleep 2
				$ff1.goto($sc_red_url)
				sleep 2
				$st = '2'
				$test_description = "Dashboard Survey Complete"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff1.contains_text(/Congratulations, you've just completed the survey/))
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff1.close
				  
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
	  
	  def test_04_check_reward_cost
			
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
				$ie.goto("p.usampadmin.com/quota_group_statistics.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 3
				$st = '3'
				$test_description = "Check Reward cost (as per cash out %)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$html_contents=$ie.html
                $html_array = $html_contents.split(/\n/)
                    0.upto($html_array.size - 1) { |index|
                        if($html_array[index] =~ /Reward Costs/)
                            $rew_val = $html_array[index+1]
                            break
                        else
                            next
                        end
                    }
                if ($rew_val =~ /#{$rew_cost}/)
					puts "Pass"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "Fail"
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
	  
	  
	  def test_05_check_default_fcpi_cap_amt
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$enc_pub_id = Base64.encode64($pub_id)
				$ie.goto("http://p.usampadmin.com/add_publisher_revenue.php?hdMode=revenue_setup&publisher_id=#{$enc_pub_id}")
				sleep 4
				$ie.radio(:id, "chkRecRev2").set
				sleep 3
				$val1 = $ie.text_field(:id, "txtFirstRouterCpi").value
				$val2 = $ie.text_field(:id, "txtCapAmount").value
				$st = '4'
				$test_description = "Check default first CPI and cap amount at publisher level"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($val1 == $fcpi && $val2 == $cap_amt)
					puts "Pass"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "Fail"
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


end