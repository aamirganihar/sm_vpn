# ENABLE/DISABLE QUEUE2 PAGE

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
require './Input Repository\Test_29_Enable_disable_queue2_Input.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

class Test_29_Enable_disable_queue2 < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "29 - "
				$test_description = "Test Case: "+$t.to_s+"  ENABLE/DISABLE QUEUE2 PAGE"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_enable_q2
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
				$enc_pub_id = Base64.encode64("PU"+"#{$pub_id}")
				$ie.goto("http://q.usampadmin.com/add_publisher.php?hdMode=accountinfo&publisher_id=#{$enc_pub_id}")
				$ie.link(:text,'Settings').click
				sleep 3
				$ie.checkbox(:id,'chbAllowQ2').set
				sleep 2
				$ie.button(:name,'btnSave').click
				sleep 3
				$st = '1'
				$test_description = "Enable Queue2 page in admin"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.checkbox(:id,'chbAllowQ2').set?)
						puts "Q2:Enabled"
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
						puts "Q2: Not Enabled"
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.link(:text,"Logout").click
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
	  
	  def test_03_check_queue2_enabled
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
				$ff = Watir::Browser.new driver
				$ff.goto("http://q.u-samp.com/queue.php?P=#{$pub_id}")
				sleep 10
				$ff.select_list(:id,"optCountryId").select($country)
				$ff.text_field(:name, "txtZipCode").set($zip_code)
				$ff.select_list(:name, "optDayId").select($date)
				$ff.select_list(:name, "optMonthId").select($month)
				$ff.select_list(:name, "optYearId").select($year)
				$ff.radio(:value,"Male").set
				$ff.select_list(:name, "optEthnicityId").select($ethnicity)
				$ff.select_list(:name, "optAnnualHouseholdIncomeId").select($income)
				$ff.text_field(:name, "txtNonMemberEmail").set($email_adr)
				$ff.button(:name,'btNext').click
				sleep 4
				puts $ff.url
				$st = '2'
				$test_description = "Check enabled Queue2"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ff.url == "https://www.q.ipoll.com/queue2.php")
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
	  
	  def test_04_disable_q2
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
				$enc_pub_id = Base64.encode64("PU"+"#{$pub_id}")
				$ie.goto("http://q.usampadmin.com/add_publisher.php?hdMode=accountinfo&publisher_id=#{$enc_pub_id}")
				$ie.link(:text,'Settings').click
				sleep 3
				$ie.checkbox(:id,'chbAllowQ2').clear
				sleep 2
				$ie.button(:name,'btnSave').click
				sleep 3
				$st = '3'
				$test_description = "Disable Queue2 page in admin"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.checkbox(:id,'chbAllowQ2').set?)
						puts "Q2: Not Disabled"
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
						puts "Q2:Disabled"
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
				$ie.link(:text,"Logout").click
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
	  
	  def test_05_check_queue2_disabled
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
				$ff = Watir::Browser.new driver
				$ff.goto("http://q.u-samp.com/queue.php?P=#{$pub_id}")
				sleep 10
				$ff.select_list(:id,"optCountryId").select($country)
				$ff.text_field(:name, "txtZipCode").set($zip_code)
				$ff.select_list(:name, "optDayId").select($date)
				$ff.select_list(:name, "optMonthId").select($month)
				$ff.select_list(:name, "optYearId").select($year)
				$ff.radio(:value,"Male").set
				$ff.select_list(:name, "optEthnicityId").select($ethnicity)
				$ff.select_list(:name, "optAnnualHouseholdIncomeId").select($income)
				$ff.text_field(:name, "txtNonMemberEmail").set($email_adr)
				$ff.button(:name,'btNext').click
				sleep 4
				puts $ff.url
				$st = '4'
				$test_description = "Check disabled Queue2"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ff.url == "http://www.q.ipoll.com/queue2.php")
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
				$ff.close
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end	
	  end
	
end