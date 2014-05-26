# CUSTOM HOME PAGE RENDERING

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
require './Input Repository\Test_33_Custom_homepage_render_Input.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

class Test_33_Custom_homepage_render < Test::Unit::TestCase

			$wd=Dir.pwd
			#$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			#$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "33 - "
				$test_description = "Test Case: "+$t.to_s+"  CUSTOM HOME PAGE RENDERING"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_set_config
				
			begin	
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Saving the Custom site settings "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				$ie.goto("http://q.usampadmin.com/site_design.php?site_id=Mg==")
				sleep 6
				$ie.select_list(:name, "optWebPage").select("Home Page")
				sleep 2
				$ie.radio(:id, "idCustomPage").set
				sleep 2
				$ie.text_field(:id, "txtCustomHomePage").set("<html>\n<head>\n<title></title>\n</head>\n<body>\n<h1>\nTEST FOCUSLINE CUSTOM HOME HEADING FOR AUTOMATION</h1>\n<p>\nTEST FOCUSLINE CUSTOM HOMEPAGE</p>\n</body>\n</html>\n")
				sleep 8
				$ie.button(:name,"btnSiteDesign").click
				sleep 2
				if ($ie.html.include?('Home Page details have been updated successfully'))
					puts "Config settings saved"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "Config settings saving failed"
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
	  
	  def test_03_check_rendering
				
			begin	
				$st = "2"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Checking custom site rendering on Focusline site "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				#$ff = FireWatir::Firefox.new
				#driver = Selenium::WebDriver.for :firefox ,:profile => "Selenium"
				#driver = Selenium::WebDriver::Firefox::Profile.new
				@driver = Selenium::WebDriver::Firefox::Profile.from_name "default"
				@driver.assume_untrusted_certificate_issuer=false
				@driver.secure_ssl = true
				$ff = Watir::Browser.new :firefox, :profile => @driver
				#$ff = Watir::Browser.new driver #, :profile => driver
				$ff.goto("http://www.sm.q.surveyhead.com/")
				if ($ff.text.include?("TEST FOCUSLINE CUSTOM HOME HEADING FOR AUTOMATION") && $ff.text.include?("TEST FOCUSLINE CUSTOM HOMEPAGE"))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					  puts "FAIL"
					  $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"            
				end
				$ff.close
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
	  
	  def test_04_revert_changes
			
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				$ie.goto("http://q.usampadmin.com/site_design.php?site_id=Mg==")
				sleep 3
				$ie.select_list(:name, "optWebPage").select("Home Page")
				sleep 2
				$ie.radio(:id, "idStandardPage").set
				sleep 2
				$ie.button(:name,"btnSiteDesign").click
				sleep 2
				$ie.link(:text,"Logout").click
				$ie.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
				$ie.close
			end
			
	  end
end