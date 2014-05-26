# QG PUBLISHER REDIRECTS

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
require './Input Repository\Test_47_QG_Publisher_redirect_Input.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"
require "watir-webdriver/extensions/wait"
class Test_47_QG_Publisher_redirect < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "47 - "
				$test_description = "Test Case: "+$t.to_s+"  QG PUBLISHER REDIRECT LINKS"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_make_pub_settings
				
			begin	
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Saving Publisher redirect settings "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$enc_pub_id = "PU#{$pub_id}"
				$enc_pub_id = Base64.encode64($enc_pub_id)
				$ie.goto("q.usampadmin.com/add_publisher.php?hdMode=accountinfo&publisher_id=#{$enc_pub_id}")
				$ie.link(:text,"Redirects / Pixels").click
				sleep 5
				$ie.text_field(:id, "txtSuccess").set($ext_sc)
				$ie.text_field(:id, "txtFail").set($ext_fl)
				$ie.text_field(:id, "txtOver").set($ext_oq)
				sleep 4
				$ie.radio(:xpath, "(//input[@id='radioST'])[2]").set
				sleep 4
				$ie.text_field(:id, "txtSTurl").set($pub_st)
				sleep 2
				$ie.button(:value,"Save").click
				if($ie.html.include?('Pixels Details have been updated successfully') && $ie.radio(:xpath, "(//input[@id='radioST'])[2]").set?)
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
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
				$ie.button(:value,"Add More Publishers").click
				$ie.select_list(:id, "optPublishers").select($pub_name)
				$ie.radio(:name, "rdCPI").click
				$ie.text_field(:name, "txtCPI").set("1")
				$ie.button(:value,"Add Publisher").click
				sleep 5
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
	  
	  def test_03_check_QG_redirect
				
			begin	
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$qg_n = Base64.encode64($qg_id)
				
				$st = "2"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Success redirect link at QG level (Merge fields)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$survey_url = "http://q.u-samp.com/survey_redirect.php?P=#{$pub_id}&QGID=#{$qg_n}&EX=5&ST=2&L=2&PL=&MID=#{$mid1}&SP=#{$sp1}"
				
				#$ie = Watir::IE.new
				driver = Selenium::WebDriver.for :ie #, :profile => "Selenium"
				$ie = Watir::Browser.new driver
				$ie.goto($survey_url)
				sleep 3
				$ie.goto('http://q.u-samp.com/redirect.php?S=1')
				if($ie.url == "http://203.199.26.75/usamp/SC.php?MID=TEST_QG_MID&SP=TEST_QG_SP")
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.close
				$st = "3"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Fail redirect link at QG level (Merge fields)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				#$ie = Watir::IE.new
				driver = Selenium::WebDriver.for :ie #, :profile => "Selenium"
				$ie = Watir::Browser.new driver
				$ie.goto($survey_url)
				sleep 3
				$ie.goto('http://q.u-samp.com/redirect.php?S=2')
				if($ie.url == "http://203.199.26.75/usamp/FL.php?MID=TEST_QG_MID&SP=TEST_QG_SP")
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.close
				
				$st = "4"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Overquota redirect link at QG level (Merge fields)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				#$ie = Watir::IE.new
				driver = Selenium::WebDriver.for :ie #, :profile => "Selenium"
				$ie = Watir::Browser.new driver
				$ie.goto($survey_url)
				sleep 3
				$ie.goto('http://q.u-samp.com/redirect.php?S=3')
				if($ie.url == "http://203.199.26.75/usamp/OQ.php?MID=TEST_QG_MID&SP=TEST_QG_SP")
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
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
	  
	  def test_04_check_pub_redirect
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
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
				#Opening the registration page
				# @pid = Process.create(
				#:app_name  => 'ruby popup_closer_IE.rb',
				#  :creation_flags  => Process::DETACHED_PROCESS
				#  ).process_id
      
				#  at_exit{ Process.kill(9,@pid) }
				
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 2
				$ie.goto("q.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 4
				$ie.frame(:name, "quota_group_publisher_iframe").button(:name,"btnEditRedirects").click
				sleep 3
				$ie.button(:name,"btnRemoveRedirectLinks").click
				$ie.link(:text,'Logout').click
				$obj.Delete_cookies
				$ie.close
				
				$survey_url = "http://q.u-samp.com/survey_redirect.php?P=#{$pub_id}&QGID=#{$qg_n}&EX=5&ST=2&L=2&PL=&MID=#{$mid2}&SP=#{$sp2}"
				
				$st = "5"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Success redirect link at Publisher level (Merge fields)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				#$ie = Watir::IE.new
				driver = Selenium::WebDriver.for :ie #, :profile => "Selenium"
				$ie = Watir::Browser.new driver
				$ie.goto($survey_url)
				sleep 3
				$ie.goto('http://q.u-samp.com/redirect.php?S=1')
				if($ie.url == "http://203.199.26.75/usamp/SC.php?MID=TEST_PUB_MID&SP=TEST_PUB_SP")
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.close
				
				$st = "6"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Fail redirect link at Publisher level (Merge fields)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				#$ie = Watir::IE.new
				driver = Selenium::WebDriver.for :ie #, :profile => "Selenium"
				$ie = Watir::Browser.new driver
				$ie.goto($survey_url)
				sleep 3
				$ie.goto('http://q.u-samp.com/redirect.php?S=2')
				if($ie.url == "http://203.199.26.75/usamp/FL.php?MID=TEST_PUB_MID&SP=TEST_PUB_SP")
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.close
				
				$st = "7"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Overquota redirect link at Publisher level (Merge fields)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				#$ie = Watir::IE.new
				driver = Selenium::WebDriver.for :ie #, :profile => "Selenium"
				$ie = Watir::Browser.new driver
				$ie.goto($survey_url)
				sleep 3
				$ie.goto('http://q.u-samp.com/redirect.php?S=3')
				if($ie.url == "http://203.199.26.75/usamp/OQ.php?MID=TEST_PUB_MID&SP=TEST_PUB_SP")
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
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
	  
	  def test_05_reset_pub_settings
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
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
				
				#@pid = Process.create(
				#   :app_name  => 'ruby popup_closer_IE.rb',
				#  :creation_flags  => Process::DETACHED_PROCESS
				#  ).process_id
      
				# at_exit{ Process.kill(9,@pid) }
				
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 2
				$ie.goto("q.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$ie.frame(:name, "quota_group_publisher_iframe").button(:name,"btnClearData").click
				$ie.alert.exists?
				$ie.alert.ok
				sleep 2
				$ie.frame(:name, "quota_group_publisher_iframe").button(:name,"btnRemovePublisher").click
				$ie.alert.exists?
				$ie.alert.ok
				$st = "8"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Removing Publisher redirect settings "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$enc_pub_id = "PU#{$pub_id}"
				$enc_pub_id = Base64.encode64($enc_pub_id)
				$ie.goto("q.usampadmin.com/add_publisher.php?hdMode=accountinfo&publisher_id=#{$enc_pub_id}")
				$ie.link(:text,"Redirects / Pixels").click
				sleep 5
				$ie.text_field(:id, "txtSuccess").set("")
				$ie.text_field(:id, "txtFail").set("")
				$ie.text_field(:id, "txtOver").set("")
				sleep 4
				$ie.radio(:xpath, "//input[@id='radioST']").set
				#$ie.text_field(:id, "txtSTurl").set($pub_st)
				sleep 2
				$ie.button(:value,"Save").click
				if($ie.html.include?('Pixels Details have been updated successfully') && $ie.radio(:xpath, "//input[@id='radioST']").set?)
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