# FACEBOOK CONNECT

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
require 'Input Repository\Test_70_FBconnect_Input.rb'

class Test_44_FBconnect < Test::Unit::TestCase

			$wd=Dir.pwd
			$pub_id_file_path = $wd+"/Input Repository/PUB_ID.txt"
			$pub_name_file_path = $wd+"/Input Repository/PUB_NAME.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "70 - "
				$test_description = "Test Case: "+$t.to_s+"  FACEBOOK CONNECT"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_fbconnect
			
			begin	
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Facebook connect (Dashboard redirection)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = FireWatir::Firefox.new
				$ff.goto 'http://www.facebook.com/'
				sleep 3
				$ff.text_field(:id,"email").set($FB_email)
				$ff.text_field(:id,"pass").set($FB_pass)
				$ff.button(:value,"Log In").click
				sleep 5
				$ff1 = FireWatir::Firefox.new
				$ff1.goto 'http://www.p.surveyhead.com'
				sleep 3
				$ff1.link(:text, "Connect").click
				sleep 25
				if($ff1.contains_text(/Welcome back/))
					puts "DASHBOARD REDIRECTION PASSED"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "DASHBOARD REDIRECTION FAILED"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				sleep 2
				$st = "2"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Verification on linked account"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$ff1.link(:text, "Account").click
				$eml = $ff1.text_field(:name, "txtEmail").value
				if($eml == "test_fb_link@testmail.com")
						puts 'Pass'
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
						puts 'Fail'   
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff1.goto("http://www.p.surveyhead.com/index.php?mode=logout")
				$obj.Delete_cookies()
				$ff1.close_all
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff3 = FireWatir::Firefox.new
				$obj.Delete_cookies()
				sleep 2
				$ff3.close
				
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					#$obj.Close_all_windows
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
	  end
	  
end