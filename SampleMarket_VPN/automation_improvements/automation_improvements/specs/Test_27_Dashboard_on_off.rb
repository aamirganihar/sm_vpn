# DASHBOARD ON/OFF 

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
require 'Input Repository\Test_27_Dashboard_on_off_Input.rb'

class Test_27_Dashboard_on_off < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "27 - "
				$test_description = "Test Case: "+$t.to_s+"  DASHBOARD ON/OFF"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_dash_off
			
			begin	
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				@pid = Process.create(
                                        :app_name  => 'ruby popup_closer_IE.rb',
                                        :creation_flags  => Process::DETACHED_PROCESS
                                        ).process_id
                                     at_exit{ Process.kill(9,@pid) }
				$enc_mid = Base64.encode64($m1_mid)
				$ie.goto("http://p.usampadmin.com/member_activity_log.php?member_id=#{$enc_mid}")
				sleep 2
				$ie.link(:text,"ON").click
				
				$ff = $obj.Surveyhead_login($m1_email,$m1_passwd)
				sleep 25
				$st = '1'
				$test_description = "Surveys not shown when member dashboard is OFF"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ff.contains_text($qg_id))
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
						puts "OFF: FAILED"
				else
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
						puts "OFF: PASSED"
				end
				$ff.goto("http://www.p.surveyhead.com/index.php?mode=logout")
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
	  
	  def test_03_dash_on
			
			begin	
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				@pid = Process.create(
                                        :app_name  => 'ruby popup_closer_IE.rb',
                                        :creation_flags  => Process::DETACHED_PROCESS
                                        ).process_id
                                     at_exit{ Process.kill(9,@pid) }
				$enc_mid = Base64.encode64($m1_mid)
				$ie.goto("http://p.usampadmin.com/member_activity_log.php?member_id=#{$enc_mid}")
				sleep 2
				$ie.link(:text,"OFF").click
				
				$ff = $obj.Surveyhead_login($m1_email,$m1_passwd)
				sleep 25
				$st = '2'
				$test_description = "Surveys are shown when member dashboard is ON"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ff.contains_text($qg_id))
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
						puts "ON: PASSED"
				else
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
						puts "ON: FAILED"
				end
				$ff.goto("http://www.p.surveyhead.com/index.php?mode=logout")
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
end