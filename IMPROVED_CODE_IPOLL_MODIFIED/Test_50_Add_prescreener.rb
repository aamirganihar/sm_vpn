# ADD PRESCREENER & PASS/FAIL CASES

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
require './Input Repository\Test_50_Add_prescreener_Input.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"
class Test_50_Add_prescreener < Test::Unit::TestCase

			$wd=Dir.pwd
			#$pub_id_file_path = $wd+"/Input Repository/PUB_ID.txt"
			#$pub_name_file_path = $wd+"/Input Repository/PUB_NAME.txt" 
			$presc_name_file_path = $wd+"/Input Repository/PRESC_NAME.txt"
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "50 - "
				$test_description = "Test Case: "+$t.to_s+"  ADD PRESCREENER & PASS/FAIL CASES"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_add_prescreener
				
			begin	
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Adding a prescreener "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
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
				
				$ie.link(:text, "Pre-Screener").click
				sleep 2
				$ie.radio(:xpath, "(//input[@name='rdPrescreenerOption'])[2]").set
				sleep 10
				$ie.link(:id, "linkNewPrescreener").click
				$ext = Time.new
				$ext = $ext.to_s
				$ext_1 = $ext.slice(0..18)
				$presc_nm = "TEST AUTO PRESC_"+$ext_1
				$presc_nm = $presc_nm.gsub(/:/, "")
				File.open($presc_name_file_path, 'w') do |f1| 
				f1.puts $presc_nm
				end
				sleep 5
				$ie.text_field(:id, "txtPreSurveyName").set($presc_nm)
				$ie.select_list(:id, "optCategory").select($cat)
				$ie.button(:value,"Next").click
				sleep 4
				if($ie.html.include?('New question'))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$st = "2"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Adding question to a prescreener "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				sleep 5
				$ie.link(:text, "New question").click
				sleep 8
				$ie.select_list(:id, "optQuestionType").select("Multiple Choice - single select (radio buttons)")
				sleep 10
				$ie.text_field(:id, "txtQuestion").set($qn)
				$ie.text_field(:id, "txtAnswer1").set($op1)
				$ie.text_field(:id, "txtAnswer2").set($op2)
				$ie.link(:text, "logic").click
				sleep 4
				$ie.select_list(:id, "optAnswerLogic1").select("Success")
				$ie.link(:text, "logic").click
				sleep 4
				$ie.select_list(:id, "optAnswerLogic2").select("Fail")
				$ie.button(:value,"Save").click
				if($ie.html.include?('Active'))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				sleep 2
				$ie.radio(:value, "Active").set
				sleep 6
				$ie.button(:name,"btnSave").click
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
	  
	  def test_03_pass_fail_presc
				
			begin	
				$st = "3"
				$test_description = "Checking prescreener pass"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
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
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$ie.select_list(:name, "optQuotaStatus").select("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				
				$survey_url = "http://q.u-samp.com/survey_redirect.php?P=467&QGID=#{$qg_n}&EX=5&ST=1&L=2&PL=&MID="
				#$ff1 = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
				$ff1 = Watir::Browser.new driver
				$ff1.goto($survey_url)
				sleep 4
				$ff1.radio(:index => 1).set
				$ff1.button(:value,"NEXT").click
				if($ff1.html.include?('The average thickness of the continental'))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff1.close
				
				$st = "4"
				$test_description = "Checking prescreener fail"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				#$ie.frame(:name, "quota_group_publisher_iframe").link(:text,'GO').click
				#$ff2 = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
				$ff2 = Watir::Browser.new driver
				$ff2.goto($survey_url)
				sleep 5
				$ff2.radio(:index => 1).set
				$ff2.button(:value,"NEXT").click
				if($ff2.html.include?('Thank you for your interest'))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff2.close
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
	  
	  def test_04_act_inact_presc
				
			begin	
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
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$ie.select_list(:name, "optQuotaStatus").select("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.link(:text, "Pre-Screener").click
				sleep 3
				$ie.radio(:id, "radPreSurveyActiveStatus").set
				sleep 6
				$ie.button(:name,"btnSave").click
				sleep 5
				$st = "5"
				$test_description = "Prescreener Active"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				$survey_url = "http://q.u-samp.com/survey_redirect.php?P=467&QGID=#{$qg_n}&EX=5&ST=1&L=2&PL=&MID="
				#$ff1 = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
				$ff1 = Watir::Browser.new driver
				$ff1.goto($survey_url)
				sleep 4
				if($ff1.text.include?($qn))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff1.close
				#
				
				$st = "6"
				$test_description = "Prescreener Inactive"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$ie.link(:text, "Pre-Screener").click
				sleep 3
				$ie.radio(:id, "radPreSurveyInactiveStatus").set
				sleep 6
				$ie.button(:name,"btnSave").click
				sleep 5
				#$ff2 = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
				$ff2 = Watir::Browser.new driver
				$ff2.goto($survey_url)
				sleep 4
				if($ff2.html.include?('The average thickness of the continental'))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff2.close
				
				$ie.radio(:value, "NO").click
				sleep 5
				$ie.button(:name,"btnSave").click
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

end