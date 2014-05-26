# DISABLE PUBLISHER ACCOUNT

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
require './Input Repository\Test_28_Disable_pub_account_Input.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

class Test_28_Disable_pub_account < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "28 - "
				$test_description = "Test Case: "+$t.to_s+"  DISABLE PUBLISHER ACCOUNT"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_disable_pub_account
			
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
				$enc_pub_id = Base64.encode64("PU"+"#{$pub_id}")
				$ie.goto("http://q.usampadmin.com/add_publisher.php?hdMode=accountinfo&publisher_id=#{$enc_pub_id}")
				$ie.checkbox(:id,'chkPubDisabled').set
				$ie.button(:name,'btnSave').click
				$st = '1'
				$test_description = "Disable Publisher account"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				sleep 5
				if ($ie.html.include?('Publisher account is disabled'))
						puts 'Pass'
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
						puts 'Fail'   
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

	  def test_03_check_registration_disabled_pub
				
			begin	
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                $ff = Watir::Browser.new driver
				$ff.goto("http://www.q.ipoll.com/registration_step1.php?P=#{$pub_id}")
				sleep 5
				$st = '2'
				$test_description = "Registration page disabled"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff.html.include?('This page is no longer available'))
						puts 'Pass'
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
						puts 'Fail'   
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
	  
	  def test_04_check_queue_page_disabled_pub
				
			begin	
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                $ff = Watir::Browser.new driver
				$ff.goto("http://q.u-samp.com/queue.php?P=#{$pub_id}")
				sleep 5
				$st = '3'
				$test_description = "Queue page disabled"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff.html.include?('This page is no longer available'))
						puts 'Pass'
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
						puts 'Fail'   
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
	  
	  def test_05_check_disabled_pub_login
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				sleep 5
				$ff = $obj.Network_site_login($pub_email,$pub_passwd,'Publisher')
				sleep 7
				$st = '4'
				$test_description = "Disabled Publisher login disallowed"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				sleep 5
				if($ff.html.include?('This account has been disabled.'))
						puts 'Pass'
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
						puts 'Fail'   
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

	  def test_06_check_EX_5_click
				
			begin	
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$qg_n = Base64.encode64($qg_id)
				
				
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                $ff = Watir::Browser.new driver
				$ff.goto("http://q.u-samp.com/survey_redirect.php?P=#{$pub_id}&QGID=#{$qg_n}&EX=5&ST=1&PL=&MID=")
				sleep 5
				$st = '5'
				$test_description = "Disable Publisher EX=5 link not allowed"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff.html.include?('This page is no longer available'))
						puts 'Pass'
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
						puts 'Fail'   
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

	  def test_07_enable_pub_account
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
				$enc_pub_id = Base64.encode64("PU"+"#{$pub_id}")
				$ie.goto("http://q.usampadmin.com/add_publisher.php?hdMode=accountinfo&publisher_id=#{$enc_pub_id}")
				$ie.checkbox(:id,'chkPubDisabled').clear
				sleep 2
				$ie.button(:name,'btnSave').click
				sleep 3
				$st = '6'
				$test_description = "Enable Publisher account"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.checkbox(:id,'chkPubDisabled').set?)
						puts 'Fail'   
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else 
						puts 'Pass'
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

	  def test_08_check_registration
	  
			begin	
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                $ff = Watir::Browser.new driver
				$ff.goto("http://www.q.ipoll.com/registration_step1.php?P=#{$pub_id}")
				sleep 2
				$st = '7'
				$test_description = "Registration page enabled"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff.html.include?('Your first name'))
						puts 'Pass'
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
						puts 'Fail'   
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

	  def test_09_check_queue_page
	  
			begin	
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                $ff = Watir::Browser.new driver
				$ff.goto("http://q.u-samp.com/queue.php?P=#{$pub_id}")
				sleep 10
				$st = '8'
				$test_description = "Queue page enabled"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff.html.include?('What country do you live in'))
						puts 'Pass'
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
						puts 'Fail'   
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

	  def test_10_check_pub_login
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				sleep 5
				$ff = $obj.Network_site_login($pub_email,$pub_passwd,'Publisher')
				sleep 7
				$st = '9'
				$test_description = "Publisher login allowed"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				sleep 5
				if($ff.html.include?('Welcome'))
						puts 'Pass'
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
						puts 'Fail'   
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("https://q.network.u-samp.com/login.php?hdMode=logout")
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
		
	  def test_11_check_EX_5_click
				
			begin	
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$qg_n = Base64.encode64($qg_id)
				
				
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                $ff = Watir::Browser.new driver
				$ff.goto("http://q.u-samp.com/survey_redirect.php?P=#{$pub_id}&QGID=#{$qg_n}&EX=5&ST=1&PL=&MID=")
				sleep 5
				$st = '10'
				$test_description = "Disable Publisher EX=5 link not allowed"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff.html.include?('Thank you for your interest'))
						puts 'Pass'
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
						puts 'Fail'   
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
	  
end