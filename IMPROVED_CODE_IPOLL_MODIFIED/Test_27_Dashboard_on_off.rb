# DASHBOARD ON/OFF 

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
require './Input Repository\Test_27_Dashboard_on_off_Input.rb'

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

  def test_02_dash_ON
			
			begin	
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				
				$enc_mid = Base64.encode64($m1_mid)
				$ie.goto("http://q.usampadmin.com/member_activity_log.php?member_id=#{$enc_mid}")
				sleep 2
				
				dashboard_value = $ie.link(:text, "ON").text
				puts dashboard_value
				
				$ie= $obj.Focusline_login($m1_email,$m1_passwd)
				
				sleep 5
			
				if ($ie.html.include? 'Based on questions you have already answered, we believe that you may also qualify for these surveys:')
				
				$myfile.print "<td class=\"td3\"><font color=\"red\">TEST PASSED</font></td></tr>"
						puts "ON: PASSED"
				else
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST FAILED</font></td></tr>"
						puts "ON: FAILED"
				end
				#$ie.goto("http://www.sm.p.surveyhead.com/index.php?mode=logout")
				#sleep 5
				$ie.link(:text,"Logout").click
				$ie.close
				#https://sm.p.surveyhead.com/index.php?mode=logout
				rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
				$ie.close
				$ff.close
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
		end
		
		def test_03_dash_OFF
			
			begin	
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				

			    
				$enc_mid = Base64.encode64($m1_mid)

				
				$ie.goto("http://q.usampadmin.com/member_activity_log.php?member_id=#{$enc_mid}")
				sleep 2
				


				$st = '2'
				
				$ie.link(:text,"ON").click

			$ie.alert.ok 
				sleep 2
				dashboard_value2 = $ie.link(:text, "OFF").text
				puts dashboard_value2
				#$ie.link(:text, "Login as Member (Admin)").click
				$ie= $obj.Focusline_login($m1_email,$m1_passwd)
				if ($ie.text.include? 'Currently there are no surveys available for you to complete. Check back again soon as new surveys are made available daily.')
				$myfile.print "<td class=\"td3\"><font color=\"red\">TEST PASSED</font></td></tr>"
						puts "OFF:PASSED"
				else
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
						puts "OFF: FAILED"
				end
				#$ie.goto("http://www.sm.p.surveyhead.com/index.php?mode=logout")
				sleep 5
				
				
				$ie.link(:text,"Logout").click
				$ie.close
			
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
				$ie.close
				$ff.close
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
		end
		
		def test_04_dash_reset_ON
			
			begin	
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
			    
				$enc_mid = Base64.encode64($m1_mid)
				$ie.goto("http://q.usampadmin.com/member_activity_log.php?member_id=#{$enc_mid}")
				sleep 2

				sleep 5
				$st = '3'
				$ie.link(:text,"OFF").click
				$ie.alert.ok 
				sleep 5
				$ie.link(:text,"Logout").click
				$ie.close
			
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
				$ie.close
				$ff.close
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
		end	
end