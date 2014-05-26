# ADDITIONAL TOOLS

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
require './Input Repository\Test_43_Add_tools_Input.rb'

class Test_Test_43_Add_tools < Test::Unit::TestCase

			$wd=Dir.pwd
			$pub_id_file_path = $wd+"/Input Repository/PUB_ID.txt"
			$pub_name_file_path = $wd+"/Input Repository/PUB_NAME.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "43 - "
				$test_description = "Test Case: "+$t.to_s+"  ADDITIONAL TOOLS"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_geo_database_lookup
				
			begin	
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Geo database look up "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
				$ie.goto("http://q.usampadmin.com/geo_database_lookup.php?showHeader=yes")
				#$ie.goto("http://p.usampadmin.com/additional_tools.php")
				sleep 5
				#$ie.select_list(:name, "optToolsId").select("Geo Database Lookup")
				#sleep 5
				$ie.text_field(:id, "txtZipCode").set($zip)
				sleep 3
				$ie.button(:xpath, ".//*[@id='USAGeoLookup']/table/tbody/tr[9]/td[3]/input").click
				sleep 5
				if($ie.html.include?("803") && $ie.html.include?("4472") && $ie.html.include?("06037") && $ie.html.include?("LOS ANGELES") && $ie.html.include?("CA"))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
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
	  
	  def test_03_token_member_lookup
				
			begin	
				$st = "2"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Token member look up "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
				$ie.goto("http://q.usampadmin.com/additional_tools.php")
				sleep 5
				$ie.select_list(:name, "optToolsId").select("Token Member Lookup")
				sleep 7
				$ie.text_field(:id, "txtTokens").set($token)
				sleep 5
				$ie.button(:id,"btnSubmit").click
				sleep 10
				if($ie.html.include?("rahul1486@gmsfdail.comxyz") && $ie.html.include?("M3717013") && $ie.html.include?("iPoll Member"))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
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