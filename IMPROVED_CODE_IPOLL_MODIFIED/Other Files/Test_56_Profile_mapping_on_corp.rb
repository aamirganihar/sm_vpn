# PROFILE MAPPING/UNMAPPING ON CORP SITE

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
require './Input Repository\Test_56_Profile_mapping_on_corp_Input.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

class Test_56_Profile_mapping_on_corp < Test::Unit::TestCase

			$wd=Dir.pwd
			$prof_2_name_path = $wd+"/Input Repository/Profile_2_Name.txt"
			$prof_2_id_path = $wd+"/Input Repository/Profile_2_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "56 - "
				$test_description = "Test Case: "+$t.to_s+"  PROFILE MAPPING/UNMAPPING ON CORP SITE"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_map_profile_corp
	  
			begin	
				$file_2 = File.open($prof_2_id_path)
				$prf_id = $file_2.gets
				puts $prf_id
				$file_2.close;
				
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$ie.goto("http://p.usampadmin.com/panel_book_search_profiles.php")
				sleep 2
				$ie.checkbox(:value,$prf_id).set
				$ie.button(:name,"Update").click
				
				$st = '1'
				$test_description = "Mapping Profile to be shown on CORP site in admin"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.html.include?('Profiles are added for panel book search successfuly') && $ie.checkbox(:value,$prf_id).set?)
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
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
	  
	  def test_03_check_prof_on_corp
	  
			begin	
				$file_1 = File.open($prof_2_name_path)
				$prf_nm = $file_1.gets
				puts $prf_nm
				$file_1.close;
				
				$st = "2"
				$test_description = "Search profile on CORP site"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                $ff = Watir::Browser.new driver
				$ff.goto("http://www.p.usamp.com/technology/")
				sleep 3
				$ff.text_field(:id, "panel_search_box").set($prf_nm)
				sleep 2
				$ff.button(:value,"Search").click
				sleep 6
				$str = $prf_nm + "-ENG"
				puts $str
				if($ff.text.include?($str))
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
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end		
	  end
	  
	  def test_04_unmap_profile_corp
	  
			begin	
				$file_2 = File.open($prof_2_id_path)
				$prf_id = $file_2.gets
				puts $prf_id
				$file_2.close;
				
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$ie.goto("http://p.usampadmin.com/panel_book_search_profiles.php")
				sleep 2
				$ie.checkbox(:value,$prf_id).clear
				$ie.button(:name,"Update").click
				
				$st = '3'
				$test_description = "Unmapping Profile to be shown on CORP site in admin"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.checkbox(:value,$prf_id).isSet?)
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
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
	  
	  def test_05_check_prof_on_corp
	  
			begin	
				$file_1 = File.open($prof_2_name_path)
				$prf_nm = $file_1.gets
				puts $prf_nm
				$file_1.close;
				
				$st = "4"
				$test_description = "Search unmapped profile on CORP site"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                $ff = Watir::Browser.new driver
				$ff.goto("http://www.p.usamp.com/")
				sleep 3
				$ff.text_field(:id, "panel_search_box").set($prf_nm)
				sleep 2
				$ff.button(:value,"Search").click
				sleep 6
				$str = $prf_nm + "-ENG"
				puts $str
				if($ff.text.include?($str))
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
				$ff.close
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