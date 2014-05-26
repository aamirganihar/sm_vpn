# PROFILES/REWARDS INACTIVATE

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
require './Input Repository\Test_XX_Profiles_rewards_inactivate_Input.rb'

class Test_XX_Profiles_rewards_inactivate < Test::Unit::TestCase

			$wd=Dir.pwd
			$prof_id_path = $wd+"/Input Repository/Profile_ID.txt"
			$prof_2_id_path = $wd+"/Input Repository/Profile_2_ID.txt"
			$Don_id_file_path = $wd+"/Input Repository/DON_REWARD_ID.txt"
			$Gift_id_file_path = $wd+"/Input Repository/GIFT_REWARD_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "XX - "
				$test_description = "Test Case: "+$t.to_s+"  PROFILES/REWARDS INACTIVATE"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end 
	  
	  def test_02_inactivate_profiles
	  
			begin	
				$st = "1"
				$test_description = "Inactivate Profile 1 "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				$file_1 = File.open($prof_id_path)
				$prf_id = $file_1.gets
				puts $prf_id
				$file_1.close;
			
				$file_2 = File.open($prof_2_id_path)
				$prf_2_id = $file_2.gets
				puts $prf_2_id
				$file_2.close;
					
				$prf_1 = Base64.encode64($prf_id)
				$prf_2 = Base64.encode64($prf_2_id)
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
				#PROFILE 1
				$ie.goto("http://q.usampadmin.com/add_profile.php?intProfileId=#{$prf_1}")
				sleep 2
				$ie.radio(:name, "rdbProfileStatus").click
				$ie.button(:value,"Update & Next").click
				sleep 2
				$ie.goto("http://q.usampadmin.com/add_profile.php?intProfileId=#{$prf_1}")
				sleep 2
				if ($ie.radio(:value,"INACTIVE").set?)
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				#PROFILE 2
				$st = "2"
				$test_description = "Inactivate Profile 2 "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				$ie.goto("http://q.usampadmin.com/add_profile.php?intProfileId=#{$prf_2}")
				sleep 2
				$ie.radio(:name, "rdbProfileStatus").click
				$ie.button(:value,"Update & Next").click
				sleep 2
				$ie.goto("http://q.usampadmin.com/add_profile.php?intProfileId=#{$prf_2}")
				sleep 2
				if ($ie.radio(:value,"INACTIVE").set?)
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.link(:text,'Logout').click
				$obj.Delete_cookies
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
	  
	  def test_03_inactivate_rewards
	  
			begin	
				$st = "3"
				$test_description = "Inactivate Donation reward "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				$file_1 = File.open($Don_id_file_path)
				$don_id = $file_1.gets
				puts $don_id
				$file_1.close;
			
				$file_2 = File.open($Gift_id_file_path)
				$gift_id = $file_2.gets
				puts $gift_id
				$file_2.close;
					
				$don_rew_id = Base64.encode64($don_id)
				$gift_rew_id = Base64.encode64($gift_id)
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
				$ie.goto("http://q.usampadmin.com/list_reward_types.php")
				sleep 1
				$ie.goto("http://q.usampadmin.com/add_reward_type.php?rid=#{$don_rew_id}")
				sleep 8
				$ie.radio(:value, "INACTIVE").set
				$ie.button(:value,"Update").click
				sleep 2
				if ($ie.radio(:value, "INACTIVE").set?)
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$st = "4"
				$test_description = "Inactivate Gift reward "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$ie.goto("http://q.usampadmin.com/list_reward_types.php")
				sleep 1
				$ie.goto("http://q.usampadmin.com/add_reward_type.php?rid=#{$gift_rew_id}")
				sleep 8
				$ie.radio(:value, "INACTIVE").set
				$ie.button(:value,"Update").click
				sleep 2
				if ($ie.radio(:value, "INACTIVE").set?)
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.link(:text,'Logout').click
				$obj.Delete_cookies
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
	  
end