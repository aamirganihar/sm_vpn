# EMAIL LINK TO PUBLISHER

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
require './Input Repository\Test_45_Email_link_pub_Input.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

class Test_45_Email_link_pub < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "45 - "
				$test_description = "Test Case: "+$t.to_s+"  EMAIL LINK TO PUBLISHER"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_email_link_admin
				
			begin	
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Email link to publisher "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
				$file_1 = File.open($proj_id_file_path)
				$prj_id = $file_1.gets
				puts $prj_id
				$file_1.close;
				
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
				
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$ie.select_list(:name, "optQuotaStatus").select("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				 $ie.goto("q.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 3
				$ie.frame(:name,"quota_group_publisher_iframe").button(:value,"Email Link to Publisher").click
				sleep 10
				$ie.button(:value,"Send Email").click
				sleep 5
				if ($ie.html.include?('Email has been sent successfully'))
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
	  
	  def test_03_check_email
				
			begin	
				$st = '2'
				$test_description = "Checking email delivered"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				#$qg_n = Base64.encode64($qg_id)
				#puts $qg_n
				sleep 20
				#$ff1 = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :ie#, :profile => "Selenium"
				$ff1 = Watir::Browser.new driver
				$ff1.goto("http://www.mailinator.com/inbox.jsp?to=auto_test_pub2")
				sleep 2
				
				$ff1.link(:text => /Your Link for Survey/).click
				#$ff1.link(:text ,"Your Link for Survey").click
				sleep 3
				#puts $ff1.html
				#if ($ff1.html.include?('survey_redirect') && $ff1.text.include?(/#{$pub_id}/) && $ff1.text.include?(/#{$qg_id}/))
				if ($ff1.html.include?('Your Link for Survey'))
					puts "MAIL PASSED"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"	
				else
					puts "MAIL FAILED"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	
				end
				$ff1.close		
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
				$ff1.close
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end				
				
	  end
end