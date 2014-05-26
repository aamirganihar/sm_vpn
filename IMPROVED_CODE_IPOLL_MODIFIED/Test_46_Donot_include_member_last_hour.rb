# DO NOT INCLUDE MEMBER WHO SIGNED UP IN LAST ONE HOUR

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
require './Input Repository\Test_46_Donot_include_member_last_hour_Input.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

class Test_46_Donot_include_member_last_hour < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
        def test_01_report_head
	  
				$t = "46 - "
				$test_description = "Test Case: "+$t.to_s+"  DO NOT INCLUDE MEMBER WHO SIGNED UP IN LAST ONE HOUR"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	end
	  
	  def test_02_qg_setup
				
			begin	
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Enabling setting at QG level "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
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
				
				puts $prj_n
				puts $qg_n

				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				puts "q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}"
				$ie.select_list(:name, "optQuotaStatus").select("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.checkbox(:id, "chkExcludeMembers").set
				$ie.text_field(:id, "txtExcludeMembersHours").set($hours)
				$ie.button(:value,"Save Group").click
				if($ie.html.include?('Quota group details have been updated successfully') && $ie.checkbox(:id, "chkExcludeMembers").set?)
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
	  
	  def test_03_member_signup_check_survey
				
			begin	
				$st = "2"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Survey not shown immediately after member sign up "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
				$ff = Watir::Browser.new driver
				# ff.maximize
				#$ff = Watir::IE.new
				$ff.goto("q.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
				$ff.goto("q.ipoll.com/registration_step1.php")
				$ff.text_field(:name, "txtFname").set("AUTO FNAME")
				$ff.text_field(:name, "txtLname").set("AUTO LNAME")
				$ff.select_list(:name, "optCountryId").select($country)
				$ff.select_list(:name, "optLanguageId").select($lang)
				sleep 7
				$ff.select_list(:name, "optStateId").select($state)
				sleep 2
				$ff.text_field(:name, "txtZipPostal").set($zip_match)
				$ff.select_list(:name, "optDayId").select($day)
				$ff.select_list(:name, "optMonthId").select($month)
				$ff.select_list(:name, "optYearId").select($year)
				$ff.radio(:value, "Male").set
				$extension = Time.new
				$extension = $extension.to_s
				$extension = $extension.slice(0..18)
				$mail_address="auto_test.des"+$extension+"@mailinator.com"
				$mail_address = $mail_address.gsub(/:/, "")
				$mail_address = $mail_address.gsub(/\s/, "")
				$mem_1 = $mail_address
				$ff.text_field(:id, "txtEmail").set($mail_address)
				sleep 5
				$ff.text_field(:id, "txtConfirmEmail").set($mail_address)
				$ff.text_field(:id, "txtPassword").set($mail_address)
				$ff.text_field(:id, "txtConfirmPassword").set($mail_address)
				$ff.checkbox(:name, "chbTermsAndConditions").set
				sleep 1
				$code= "test string"
				puts $code
				$ff.text_field(:name,"recaptcha_response_field").set($code)
				$ff.button(:value, "Submit").click
				#sleep 10
				$ff.select_list(:name, "optAnnualHouseholdIncomeId").select($inc_level)
				$ff.select_list(:name, "optEducationLevelId").select($education)
				$ff.select_list(:name, "optEmploymentStatusId").select($employment)
				$ff.select_list(:name, "optMaritalStatusId").select($marrital_status)
				$ff.select_list(:name, "optEthnicityId").select($ethnicity)
				$ff.select_list(:name, "optNationalityId").select($origin)
				$ff.radio(:value, "N").set
				$ff.button(:value, "NEXT").click
				sleep 5
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				puts "**** Waiting for surveys to load ****"
				sleep 30
				if($ff.html.include?($qg_id))
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
				$ff.goto("q.ipoll.com/index.php?mode=logout")
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
	  
	  def test_04_disable_setting
				
			begin	
				$st = "3"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Disabled setting at QG level "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
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
					
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$ie.checkbox(:id, "chkExcludeMembers").clear
				#$ie.text_field(:id, "txtExcludeMembersHours").set($hours)
				$ie.button(:value,"Save Group").click
				if($ie.html.include?('Quota group details have been updated successfully'))
					puts "Updated message shown"
					if($ie.checkbox(:id, "chkExcludeMembers").set?)
						puts 'Fail'   
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
					else
						puts 'Pass'
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
					end
				else
					puts "Updated message not shown"
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
	  
	  def test_05_check_survey_shown
	  
			begin	
				$st = "4"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Survey shown when setting disabled "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Surveyhead_login($mem_1,$mem_1)
				sleep 5
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				puts "**** Waiting for surveys to load ****"
				sleep 30
				if($ff.html.include?($qg_id))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("q.ipoll.com/index.php?mode=logout")
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