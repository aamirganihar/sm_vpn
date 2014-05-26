# EX/ST LINKS

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
require './Input Repository\Test_54_EX_ST_Links_Input.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

class Test_EX_ST_Links < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "54 - "
				$test_description = "Test Case: "+$t.to_s+"  EX/ST LINKS "
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_ex_2_st_1_match_criteria
  
			begin	
				$st = "1"
				$test_description = "EX=2 / ST=1 case (QG criteria match)"
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
				
				#$ff = FireWatir::Firefox.new
				@driver = Selenium::WebDriver::Firefox::Profile.from_name "default"
				@driver.assume_untrusted_certificate_issuer=false
				@driver.secure_ssl = true
				$ff = Watir::Browser.new :firefox, :profile => @driver
				$ff.goto("q.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
				sleep 2
				$ff.goto("http://q.u-samp.com/survey_redirect.php?P=467&QGID=#{$qg_n}&EX=2&ST=1&L=2&PL=&MID=")
				sleep 10
				$ff.text_field(:name, "txtFname").set("AUTO FNAME")
				$ff.text_field(:name, "txtLname").set("AUTO LNAME")
				$ff.select_list(:name, "optLanguageId").select($lang)
                
				$ff.select_list(:name, "optDayId").select($day)
				$ff.select_list(:name, "optMonthId").select($month)
				$ff.select_list(:name, "optYearId").select($year)
				$ff.radio(:value, "Male").set
				$ff.select_list(:name, "optCountryId").select($country)
				sleep 7
				$ff.select_list(:name, "optStateId").select($state)
				sleep 2
				$ff.text_field(:name, "txtZipPostal").set($zip_match)
				$extension = Time.new
				$extension = $extension.to_s
				$extension = $extension.slice(0..18)
				$mail_address="auto_test.des"+$extension+"@mailinator.com"
				$mail_address = $mail_address.gsub(/:/, "")
				$mail_address = $mail_address.gsub(/\s/, "")
				$mem_1 = $mail_address
				puts $mail_address
				sleep 5
				$ff.text_field(:id, "txtEmail").set($mail_address)
				puts"email id"
				sleep 5
				$ff.text_field(:id, "txtConfirmEmail").set($mail_address)
				puts "confirm email"
				$ff.text_field(:id, "txtPassword").set($mail_address)
				puts "password"
				$ff.text_field(:id, "txtConfirmPassword").set($mail_address)
				puts "confirm password"
				$ff.checkbox(:name, "chbTermsAndConditions").set
				sleep 1
				$code= "test string"
				puts $code
				$ff.text_field(:name,"recaptcha_response_field").set($code)
				$ff.button(:value, "Submit").click
				sleep 15
				$ff.select_list(:name, "optAnnualHouseholdIncomeId").select($inc_level)
				$ff.select_list(:name, "optEducationLevelId").select($education)
				$ff.select_list(:name, "optEmploymentStatusId").select($employment)
				$ff.select_list(:name, "optMaritalStatusId").select($marrital_status)
				$ff.select_list(:name, "optEthnicityId").select($ethnicity)
				$ff.select_list(:name, "optNationalityId").select($origin)
				$ff.radio(:value, "N").set
				$ff.button(:id, "bt_submit").click
				sleep 5
				puts "**** Waiting for surveys to load ****"
				sleep 3
				if ($ff.text.include?($qg_id))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("q.ipoll.com/index.php?mode=logout")
				$ff.goto("q.surveuhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
				$ff.close
				$ie.link(:text,'Logout').click
				$obj.Delete_cookies
				$ie.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
				$ff.close
				$ie.close
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
				
	  end
	  
  def test_03_ex_2_st_1_mismatch_criteria
	  
			begin	
				$st = "2"
				$test_description = "EX=2 / ST=1 case (QG criteria mismatch )"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
					
				#$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
				
				#$ff = FireWatir::Firefox.new
				@driver = Selenium::WebDriver::Firefox::Profile.from_name "default"
				@driver.assume_untrusted_certificate_issuer=false
				@driver.secure_ssl = true
				$ff = Watir::Browser.new :firefox, :profile => @driver
				$ff.goto("q.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
				sleep 2
				$ff.goto("http://q.u-samp.com/survey_redirect.php?P=467&QGID=#{$qg_n}&EX=2&ST=1&L=2&PL=&MID=")
				sleep 30
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
				$ff.select_list(:name, "optAnnualHouseholdIncomeId").select($inc_level)
                $ff.select_list(:name, "optEducationLevelId").select($education)
                $ff.select_list(:name, "optEmploymentStatusId").select($employment)
                $ff.select_list(:name, "optMaritalStatusId").select($marrital_status)
                $ff.select_list(:name, "optEthnicityId").select($ethnicity_mismatch)
                $ff.select_list(:name, "optNationalityId").select($origin)
                $ff.radio(:value, "N").set
                $ff.button(:id, "bt_submit").click
                sleep 5
				puts "**** Waiting for surveys to load ****"
				sleep 45
				if ($ff.html.include?('You may qualify') && $ff.text.include?($qg_id))
          puts "FAILED"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
          puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
				$ff.goto("q.ipoll.com/index.php?mode=logout")
				$ff.goto("q.surveyhead.com/recaptcha_automation_proxy.php?mode=test") # setting normal mode
                $ff.close
				#$ie.link(:text,'Logout').click
				#$obj.Delete_cookies
				#$ie.close
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
	  
	  
	  def test_04_ex_3_st_1
	  
			begin	
				$st = "3"
				$test_description = "EX=3 / ST=1 CASE"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
					
				#$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
				
				#$ff = FireWatir::Firefox.new
				@driver = Selenium::WebDriver::Firefox::Profile.from_name "default"
				@driver.assume_untrusted_certificate_issuer=false
				@driver.secure_ssl = true
				$ff = Watir::Browser.new :firefox, :profile => @driver
				$ff.goto("q.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
				sleep 2
				$ff.goto("http://q.u-samp.com/survey_redirect.php?P=467&QGID=&EX=3&ST=1&L=2&PL=&MID=")
				sleep 30
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
				sleep 5
				$ff.select_list(:name, "optAnnualHouseholdIncomeId").select($inc_level)
                $ff.select_list(:name, "optEducationLevelId").select($education)
                $ff.select_list(:name, "optEmploymentStatusId").select($employment)
                $ff.select_list(:name, "optMaritalStatusId").select($marrital_status)
                $ff.select_list(:name, "optEthnicityId").select($ethnicity)
                $ff.select_list(:name, "optNationalityId").select($origin)
                $ff.radio(:value, "N").set
                #$ff.button(:value, "NEXT").click
                $ff.button(:id, "bt_submit").click
                sleep 5
				puts "**** Waiting for surveys to load ****"
				sleep 35
				if ($ff.html.include?('Based on questions'))
          puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
          puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("q.ipoll.com/index.php?mode=logout")
				$ff.goto("q.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
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
	  
	  def test_05_ex_2_st_2_match_criteria
	  
			begin	
				$st = "4"
				$test_description = "EX=2 / ST=2 case (QG criteria match)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
					
				
				$qg_n = Base64.encode64($qg_id)
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
				sleep 2
				$enc_pub_id = "PU#{$pub_id}"
				$enc_pub_id = Base64.encode64($enc_pub_id)
				$ie.goto("q.usampadmin.com/add_publisher.php?hdMode=accountinfo&publisher_id=#{$enc_pub_id}")
				$ie.link(:text,"Redirects / Pixels").click
				#$ie.text_field(:id, "txtSuccess").set($ext_sc)
				#$ie.text_field(:id, "txtFail").set($ext_fl)
				#$ie.text_field(:id, "txtOver").set($ext_oq)
				sleep 4
				$ie.radio(:value, "2").set
				$ie.text_field(:id, "txtSTurl").set($pub_st)
				sleep 2
				$ie.button(:value,"Save").click
				
				#$ff = FireWatir::Firefox.new
				@driver = Selenium::WebDriver::Firefox::Profile.from_name "default"
				@driver.assume_untrusted_certificate_issuer=false
				@driver.secure_ssl = true
				$ff = Watir::Browser.new :firefox, :profile => @driver
				$ff.goto("q.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
				sleep 2
				$ff.goto("http://q.u-samp.com/survey_redirect.php?P=467&QGID=#{$qg_n}&EX=2&ST=2&L=2&PL=&MID=")
				sleep 30
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
				$ff.select_list(:name, "optAnnualHouseholdIncomeId").select($inc_level)
                $ff.select_list(:name, "optEducationLevelId").select($education)
                $ff.select_list(:name, "optEmploymentStatusId").select($employment)
                $ff.select_list(:name, "optMaritalStatusId").select($marrital_status)
                $ff.select_list(:name, "optEthnicityId").select($ethnicity)
                $ff.select_list(:name, "optNationalityId").select($origin)
                $ff.radio(:value, "N").set
                $ff.button(:id, "bt_submit").click
                sleep 5
				puts "**** Waiting for surveys to load ****"
				sleep 35
				if ($ff.text.include?($qg_id))
          puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
          puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("q.ipoll.com/index.php?mode=logout")
				$ff.goto("q.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
                $ff.close
				$ie.link(:text,'Logout').click
				$obj.Delete_cookies
				$ie.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
				$ff.close
				$ie.close
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end	
	  end
	  
	  def test_06_ex_2_st_2_mismatch_criteria
	  
			begin	
				$st = "5"
				$test_description = "EX=2 / ST=2 case (QG criteria mismatch )"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
					
				#$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
				
				#$ff = FireWatir::Firefox.new
				@driver = Selenium::WebDriver::Firefox::Profile.from_name "default"
				@driver.assume_untrusted_certificate_issuer=false
				@driver.secure_ssl = true
				$ff = Watir::Browser.new :firefox, :profile => @driver
				$ff.goto("q.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
				sleep 2
				$ff.goto("http://q.u-samp.com/survey_redirect.php?P=467&QGID=#{$qg_n}&EX=2&ST=2&L=2&PL=&MID=")
				sleep 30
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
				$ff.select_list(:name, "optAnnualHouseholdIncomeId").select($inc_level)
                $ff.select_list(:name, "optEducationLevelId").select($education)
                $ff.select_list(:name, "optEmploymentStatusId").select($employment)
                $ff.select_list(:name, "optMaritalStatusId").select($marrital_status)
                $ff.select_list(:name, "optEthnicityId").select($ethnicity_mismatch)
                $ff.select_list(:name, "optNationalityId").select($origin)
                $ff.radio(:value, "N").set
                $ff.button(:id, "bt_submit").click
                sleep 5
				puts "**** Waiting for surveys to load ****"
				sleep 35
				if ($ff.html.include?('You may qualify') && $ff.text.include?($qg_id))
          puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
          puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
				$ff.goto("q.ipoll.com/index.php?mode=logout")
				$ff.goto("q.surveyhead.com/recaptcha_automation_proxy.php?mode=test") # setting normal mode
                $ff.close
				#$ie.link(:text,'Logout').click
				#$obj.Delete_cookies
				#$ie.close
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
	  
	  def test_07_ex_3_st_2
	  
			begin	
				$st = "6"
				$test_description = "EX=3 / ST=2 CASE"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
					
				#$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
				
				#$ff = FireWatir::Firefox.new
				@driver = Selenium::WebDriver::Firefox::Profile.from_name "default"
				@driver.assume_untrusted_certificate_issuer=false
				@driver.secure_ssl = true
				$ff = Watir::Browser.new :firefox, :profile => @driver
				$ff.goto("q.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
				sleep 2
				$ff.goto("http://q.u-samp.com/survey_redirect.php?P=467&QGID=&EX=3&ST=1&L=2&PL=&MID=")
				sleep 30
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
				$ff.select_list(:name, "optAnnualHouseholdIncomeId").select($inc_level)
                $ff.select_list(:name, "optEducationLevelId").select($education)
                $ff.select_list(:name, "optEmploymentStatusId").select($employment)
                $ff.select_list(:name, "optMaritalStatusId").select($marrital_status)
                $ff.select_list(:name, "optEthnicityId").select($ethnicity)
                $ff.select_list(:name, "optNationalityId").select($origin)
                $ff.radio(:value, "N").set
                #$ff.button(:value, "NEXT").click
                $ff.button(:id, "bt_submit").click
                sleep 5
				puts "**** Waiting for surveys to load ****"
				sleep 35
				if ($ff.html.include?('Based on questions'))
          puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
          puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("q.ipoll.com/index.php?mode=logout")
				$ff.goto("q.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
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
	  
	  def test_08_revert_pub_settings
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
				sleep 2
				$enc_pub_id = "PU#{$pub_id}"
				$enc_pub_id = Base64.encode64($enc_pub_id)
				$ie.goto("q.usampadmin.com/add_publisher.php?hdMode=accountinfo&publisher_id=#{$enc_pub_id}")
				$ie.link(:text,"Redirects / Pixels").click
				sleep 5
				$ie.radio(:name, "radioST").set
				#$ie.text_field(:id, "txtSTurl").set($pub_st)
				sleep 2
				$ie.button(:value,"Save").click
				$ie.link(:text,'Logout').click
				$obj.Delete_cookies
				$ie.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
				$ie.close
			end
	  end

end