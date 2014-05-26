# QG NOTIFICATIONS EMAIL DELIVERY

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
require './Input Repository\Test_69_QG_notif_email_Input.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

class Test_69_QG_notif_email < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			#$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$qg_id_file_path_2 = $wd+"/Input Repository/Notification_QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "69 - "
				$test_description = "Test Case: "+$t.to_s+" QG NOTIFICATIONS EMAIL DELIVERY"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
				
	  end
	  
	  def test_02_check_notif_email_delivery
	  
			begin	
				$file_1 = File.open($proj_id_file_path)
				$prj_id = $file_1.gets
				puts $prj_id
				$file_1.close;
			
				$file_2 = File.open($qg_id_file_path_2)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$st = '1'
				$test_description = "Checking notification email delivery"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				#$ff = FireWatir::Firefox.new
				@driver = Selenium::WebDriver::Firefox::Profile.from_name "default"
				@driver.assume_untrusted_certificate_issuer=false
				@driver.secure_ssl = true
				$ff = Watir::Browser.new :firefox, :profile => @driver
				$ff.goto("http://www.rediff.com")
				sleep 3
				#$ff.maximize
				$ff.link(:text,"Sign in").click
				sleep 5
				$ff.text_field(:id,"c_uname").set($redf_uname)
				$ff.text_field(:id,"c_pass").set($redf_pass)
				$ff.button(:id,"btn_login").click
				sleep 10
				$clk = "of clicks: " + "#{$no_of_clicks}"
				if ($ff.html.include?('United Sample Projects'))
					puts "PASS: MAIL RECEIVED"
					$ff.link(:text => /United Sample Projects/).click
					sleep 5
					#$a = /No Redirection Activity/.match($ie.text)
					#$a = $a.to_s
					if ($ff.html.include?($qg_id) && $ff.html.include?($clk) && $ff.html.include?('No Redirection Activity'))
						puts "PASS"
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
					else
						puts "FAIL"
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
					end
				else
					puts "FAIL:TAKING TOO LONG"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED(Mail taking too long)</font></td></tr>"
				end
				$ff.link(:text,"Signout").click
				#$ff.close_all
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
	  
	  def test_03_remove_notification_setting
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				#@pid = Process.create(
                        #:app_name  => 'ruby popup_closer_IE.rb',
                       # :creation_flags  => Process::DETACHED_PROCESS
                       # ).process_id
                #at_exit{ Process.kill(9,@pid) }
				
				$file_1 = File.open($proj_id_file_path)
				$prj_id = $file_1.gets
				puts $prj_id
				$file_1.close;
			
				$file_2 = File.open($qg_id_file_path_2)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
				
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")	
				sleep 2
				$ie.checkbox(:name, "chbEnableNotification").clear
				sleep 2
				$ie.button(:name,"btnSave").click
				sleep 4
				$st = '2'
				$test_description = "Remove Notifications settings "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.checkbox(:name, "chbEnableNotification").set?)
					puts "Fail"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
					puts "Pass"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
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