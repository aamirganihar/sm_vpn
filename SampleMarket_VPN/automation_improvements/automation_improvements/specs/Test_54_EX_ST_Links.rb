# EX/ST LINKS

require 'rubygems'
require 'watir'
require 'Usamp_lib'
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
require 'Input Repository\Test_54_EX_ST_Links_Input.rb'

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
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$ie.select_list(:name, "optQuotaStatus").set("Open")
				$ie.button(:name,"btnSave").click
				
				$ff = FireWatir::Firefox.new
				$ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
				sleep 2
				$ff.goto("http://p.u-samp.com/survey_redirect.php?P=467&QGID=#{$qg_n}&EX=2&ST=1&L=2&PL=&MID=")
				sleep 30
				$ff.text_field(:name, "txtFname").set("AUTO FNAME")
				$ff.text_field(:name, "txtLname").set("AUTO LNAME")
                $ff.select_list(:name, "optCountryId").set($country)
                $ff.select_list(:name, "optLanguageId").set($lang)
                sleep 7
                $ff.select_list(:name, "optStateId").set($state)
                sleep 2
                $ff.text_field(:name, "txtZipPostal").set($zip_match)
                $ff.select_list(:name, "optNonUSDayId").set($day)
                $ff.select_list(:name, "optNonUSMonthId").set($month)
                $ff.select_list(:name, "optNonUSYearId").set($year)
                $ff.radio(:value, "Male").set
				$extension = Time.new
                $extension = $extension.to_s
                $extension = $extension.slice(0..18)
                $mail_address="auto_test.des"+$extension+"@mailinator.com"
                $mail_address = $mail_address.gsub(/:/, "")
                $mail_address = $mail_address.gsub(/\s/, "")
                $mem_1 = $mail_address
				$ff.text_field(:name, "txtEmail").set($mail_address)
                sleep 5
                $ff.text_field(:name, "txtConfirmEmail").set($mail_address)
                $ff.text_field(:name, "txtPassword").set($mail_address)
                $ff.text_field(:name, "txtConfirmPassword").set($mail_address)
                $ff.checkbox(:name, "chbTermsAndConditions").set
				sleep 1
                $code= "test string"
                puts $code
				$ff.text_field(:name,"recaptcha_response_field").set($code)
                $ff.button(:value, "Submit").click
				$ff.select_list(:name, "optAnnualHouseholdIncomeId").set($inc_level)
                $ff.select_list(:name, "optEducationLevelId").set($education)
                $ff.select_list(:name, "optEmploymentStatusId").set($employment)
                $ff.select_list(:name, "optMaritalStatusId").set($marrital_status)
                $ff.select_list(:name, "optEthnicityId").set($ethnicity)
                $ff.select_list(:name, "optNationalityId").set($origin)
                $ff.radio(:value, "N").set
                $ff.button(:id, "bt_submit").click
                sleep 5
				puts "**** Waiting for surveys to load ****"
				sleep 35
				if ($ff.contains_text(/#{$qg_id}/))
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("p.surveyhead.com/index.php?mode=logout")
				$ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
                $ff.close
				$ie.link(:text,'Logout').click
				$obj.Delete_cookies
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
				
				$ff = FireWatir::Firefox.new
				$ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
				sleep 2
				$ff.goto("http://p.u-samp.com/survey_redirect.php?P=467&QGID=#{$qg_n}&EX=2&ST=1&L=2&PL=&MID=")
				sleep 30
				$ff.text_field(:name, "txtFname").set("AUTO FNAME")
				$ff.text_field(:name, "txtLname").set("AUTO LNAME")
                $ff.select_list(:name, "optCountryId").set($country)
                $ff.select_list(:name, "optLanguageId").set($lang)
                sleep 7
                $ff.select_list(:name, "optStateId").set($state)
                sleep 2
                $ff.text_field(:name, "txtZipPostal").set($zip_match)
                $ff.select_list(:name, "optNonUSDayId").set($day)
                $ff.select_list(:name, "optNonUSMonthId").set($month)
                $ff.select_list(:name, "optNonUSYearId").set($year)
                $ff.radio(:value, "Male").set
				$extension = Time.new
                $extension = $extension.to_s
                $extension = $extension.slice(0..18)
                $mail_address="auto_test.des"+$extension+"@mailinator.com"
                $mail_address = $mail_address.gsub(/:/, "")
                $mail_address = $mail_address.gsub(/\s/, "")
                $mem_1 = $mail_address
				$ff.text_field(:name, "txtEmail").set($mail_address)
                sleep 5
                $ff.text_field(:name, "txtConfirmEmail").set($mail_address)
                $ff.text_field(:name, "txtPassword").set($mail_address)
                $ff.text_field(:name, "txtConfirmPassword").set($mail_address)
                $ff.checkbox(:name, "chbTermsAndConditions").set
				sleep 1
                $code= "test string"
                puts $code
				$ff.text_field(:name,"recaptcha_response_field").set($code)
                $ff.button(:value, "Submit").click
				$ff.select_list(:name, "optAnnualHouseholdIncomeId").set($inc_level)
                $ff.select_list(:name, "optEducationLevelId").set($education)
                $ff.select_list(:name, "optEmploymentStatusId").set($employment)
                $ff.select_list(:name, "optMaritalStatusId").set($marrital_status)
                $ff.select_list(:name, "optEthnicityId").set($ethnicity_mismatch)
                $ff.select_list(:name, "optNationalityId").set($origin)
                $ff.radio(:value, "N").set
                $ff.button(:id, "bt_submit").click
                sleep 5
				puts "**** Waiting for surveys to load ****"
				sleep 35
				if ($ff.contains_text(/You may qualify/) && $ff.contains_text(/#{$qg_id}/))
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
				$ff.goto("p.surveyhead.com/index.php?mode=logout")
				$ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
                $ff.close
				#$ie.link(:text,'Logout').click
				#$obj.Delete_cookies
				#$ie.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
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
				
				$ff = FireWatir::Firefox.new
				$ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
				sleep 2
				$ff.goto("http://p.u-samp.com/survey_redirect.php?P=467&QGID=&EX=3&ST=1&L=2&PL=&MID=")
				sleep 30
				$ff.text_field(:name, "txtFname").set("AUTO FNAME")
				$ff.text_field(:name, "txtLname").set("AUTO LNAME")
                $ff.select_list(:name, "optCountryId").set($country)
                $ff.select_list(:name, "optLanguageId").set($lang)
                sleep 7
                $ff.select_list(:name, "optStateId").set($state)
                sleep 2
                $ff.text_field(:name, "txtZipPostal").set($zip_match)
                $ff.select_list(:name, "optNonUSDayId").set($day)
                $ff.select_list(:name, "optNonUSMonthId").set($month)
                $ff.select_list(:name, "optNonUSYearId").set($year)
                $ff.radio(:value, "Male").set
				$extension = Time.new
                $extension = $extension.to_s
                $extension = $extension.slice(0..18)
                $mail_address="auto_test.des"+$extension+"@mailinator.com"
                $mail_address = $mail_address.gsub(/:/, "")
                $mail_address = $mail_address.gsub(/\s/, "")
                $mem_1 = $mail_address
				$ff.text_field(:name, "txtEmail").set($mail_address)
                sleep 5
                $ff.text_field(:name, "txtConfirmEmail").set($mail_address)
                $ff.text_field(:name, "txtPassword").set($mail_address)
                $ff.text_field(:name, "txtConfirmPassword").set($mail_address)
                $ff.checkbox(:name, "chbTermsAndConditions").set
				sleep 1
                $code= "test string"
                puts $code
				$ff.text_field(:name,"recaptcha_response_field").set($code)
                $ff.button(:value, "Submit").click
				sleep 5
				$ff.select_list(:name, "optAnnualHouseholdIncomeId").set($inc_level)
                $ff.select_list(:name, "optEducationLevelId").set($education)
                $ff.select_list(:name, "optEmploymentStatusId").set($employment)
                $ff.select_list(:name, "optMaritalStatusId").set($marrital_status)
                $ff.select_list(:name, "optEthnicityId").set($ethnicity)
                $ff.select_list(:name, "optNationalityId").set($origin)
                $ff.radio(:value, "N").set
                #$ff.button(:value, "NEXT").click
                $ff.button(:id, "bt_submit").click
                sleep 5
				puts "**** Waiting for surveys to load ****"
				sleep 35
				if ($ff.contains_text(/Based on questions/))
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("p.surveyhead.com/index.php?mode=logout")
				$ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
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
				$ie.goto("p.usampadmin.com/add_publisher.php?hdMode=accountinfo&publisher_id=#{$enc_pub_id}")
				$ie.link(:text,"Redirects / Pixels").click
				#$ie.text_field(:id, "txtSuccess").set($ext_sc)
				#$ie.text_field(:id, "txtFail").set($ext_fl)
				#$ie.text_field(:id, "txtOver").set($ext_oq)
				sleep 4
				$ie.radio(:value, "2").set
				$ie.text_field(:id, "txtSTurl").set($pub_st)
				sleep 2
				$ie.button(:value,"Save").click
				
				$ff = FireWatir::Firefox.new
				$ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
				sleep 2
				$ff.goto("http://p.u-samp.com/survey_redirect.php?P=467&QGID=#{$qg_n}&EX=2&ST=2&L=2&PL=&MID=")
				sleep 30
				$ff.text_field(:name, "txtFname").set("AUTO FNAME")
				$ff.text_field(:name, "txtLname").set("AUTO LNAME")
                $ff.select_list(:name, "optCountryId").set($country)
                $ff.select_list(:name, "optLanguageId").set($lang)
                sleep 7
                $ff.select_list(:name, "optStateId").set($state)
                sleep 2
                $ff.text_field(:name, "txtZipPostal").set($zip_match)
                $ff.select_list(:name, "optNonUSDayId").set($day)
                $ff.select_list(:name, "optNonUSMonthId").set($month)
                $ff.select_list(:name, "optNonUSYearId").set($year)
                $ff.radio(:value, "Male").set
				$extension = Time.new
                $extension = $extension.to_s
                $extension = $extension.slice(0..18)
                $mail_address="auto_test.des"+$extension+"@mailinator.com"
                $mail_address = $mail_address.gsub(/:/, "")
                $mail_address = $mail_address.gsub(/\s/, "")
                $mem_1 = $mail_address
				$ff.text_field(:name, "txtEmail").set($mail_address)
                sleep 5
                $ff.text_field(:name, "txtConfirmEmail").set($mail_address)
                $ff.text_field(:name, "txtPassword").set($mail_address)
                $ff.text_field(:name, "txtConfirmPassword").set($mail_address)
                $ff.checkbox(:name, "chbTermsAndConditions").set
				sleep 1
                $code= "test string"
                puts $code
				$ff.text_field(:name,"recaptcha_response_field").set($code)
                $ff.button(:value, "Submit").click
				$ff.select_list(:name, "optAnnualHouseholdIncomeId").set($inc_level)
                $ff.select_list(:name, "optEducationLevelId").set($education)
                $ff.select_list(:name, "optEmploymentStatusId").set($employment)
                $ff.select_list(:name, "optMaritalStatusId").set($marrital_status)
                $ff.select_list(:name, "optEthnicityId").set($ethnicity)
                $ff.select_list(:name, "optNationalityId").set($origin)
                $ff.radio(:value, "N").set
                $ff.button(:id, "bt_submit").click
                sleep 5
				puts "**** Waiting for surveys to load ****"
				sleep 35
				if ($ff.contains_text(/#{$qg_id}/))
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("p.surveyhead.com/index.php?mode=logout")
				$ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
                $ff.close
				$ie.link(:text,'Logout').click
				$obj.Delete_cookies
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
				
				$ff = FireWatir::Firefox.new
				$ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
				sleep 2
				$ff.goto("http://p.u-samp.com/survey_redirect.php?P=467&QGID=#{$qg_n}&EX=2&ST=2&L=2&PL=&MID=")
				sleep 30
				$ff.text_field(:name, "txtFname").set("AUTO FNAME")
				$ff.text_field(:name, "txtLname").set("AUTO LNAME")
                $ff.select_list(:name, "optCountryId").set($country)
                $ff.select_list(:name, "optLanguageId").set($lang)
                sleep 7
                $ff.select_list(:name, "optStateId").set($state)
                sleep 2
                $ff.text_field(:name, "txtZipPostal").set($zip_match)
                $ff.select_list(:name, "optNonUSDayId").set($day)
                $ff.select_list(:name, "optNonUSMonthId").set($month)
                $ff.select_list(:name, "optNonUSYearId").set($year)
                $ff.radio(:value, "Male").set
				$extension = Time.new
                $extension = $extension.to_s
                $extension = $extension.slice(0..18)
                $mail_address="auto_test.des"+$extension+"@mailinator.com"
                $mail_address = $mail_address.gsub(/:/, "")
                $mail_address = $mail_address.gsub(/\s/, "")
                $mem_1 = $mail_address
				$ff.text_field(:name, "txtEmail").set($mail_address)
                sleep 5
                $ff.text_field(:name, "txtConfirmEmail").set($mail_address)
                $ff.text_field(:name, "txtPassword").set($mail_address)
                $ff.text_field(:name, "txtConfirmPassword").set($mail_address)
                $ff.checkbox(:name, "chbTermsAndConditions").set
				sleep 1
                $code= "test string"
                puts $code
				$ff.text_field(:name,"recaptcha_response_field").set($code)
                $ff.button(:value, "Submit").click
				$ff.select_list(:name, "optAnnualHouseholdIncomeId").set($inc_level)
                $ff.select_list(:name, "optEducationLevelId").set($education)
                $ff.select_list(:name, "optEmploymentStatusId").set($employment)
                $ff.select_list(:name, "optMaritalStatusId").set($marrital_status)
                $ff.select_list(:name, "optEthnicityId").set($ethnicity_mismatch)
                $ff.select_list(:name, "optNationalityId").set($origin)
                $ff.radio(:value, "N").set
                $ff.button(:id, "bt_submit").click
                sleep 5
				puts "**** Waiting for surveys to load ****"
				sleep 35
				if ($ff.contains_text(/You may qualify/) && $ff.contains_text(/#{$qg_id}/))
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
				$ff.goto("p.surveyhead.com/index.php?mode=logout")
				$ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
                $ff.close
				#$ie.link(:text,'Logout').click
				#$obj.Delete_cookies
				#$ie.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
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
				
				$ff = FireWatir::Firefox.new
				$ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
				sleep 2
				$ff.goto("http://p.u-samp.com/survey_redirect.php?P=467&QGID=&EX=3&ST=1&L=2&PL=&MID=")
				sleep 30
				$ff.text_field(:name, "txtFname").set("AUTO FNAME")
				$ff.text_field(:name, "txtLname").set("AUTO LNAME")
                $ff.select_list(:name, "optCountryId").set($country)
                $ff.select_list(:name, "optLanguageId").set($lang)
                sleep 7
                $ff.select_list(:name, "optStateId").set($state)
                sleep 2
                $ff.text_field(:name, "txtZipPostal").set($zip_match)
                $ff.select_list(:name, "optNonUSDayId").set($day)
                $ff.select_list(:name, "optNonUSMonthId").set($month)
                $ff.select_list(:name, "optNonUSYearId").set($year)
                $ff.radio(:value, "Male").set
				$extension = Time.new
                $extension = $extension.to_s
                $extension = $extension.slice(0..18)
                $mail_address="auto_test.des"+$extension+"@mailinator.com"
                $mail_address = $mail_address.gsub(/:/, "")
                $mail_address = $mail_address.gsub(/\s/, "")
                $mem_1 = $mail_address
				$ff.text_field(:name, "txtEmail").set($mail_address)
                sleep 5
                $ff.text_field(:name, "txtConfirmEmail").set($mail_address)
                $ff.text_field(:name, "txtPassword").set($mail_address)
                $ff.text_field(:name, "txtConfirmPassword").set($mail_address)
                $ff.checkbox(:name, "chbTermsAndConditions").set
				sleep 1
                $code= "test string"
                puts $code
				$ff.text_field(:name,"recaptcha_response_field").set($code)
                $ff.button(:value, "Submit").click
				$ff.select_list(:name, "optAnnualHouseholdIncomeId").set($inc_level)
                $ff.select_list(:name, "optEducationLevelId").set($education)
                $ff.select_list(:name, "optEmploymentStatusId").set($employment)
                $ff.select_list(:name, "optMaritalStatusId").set($marrital_status)
                $ff.select_list(:name, "optEthnicityId").set($ethnicity)
                $ff.select_list(:name, "optNationalityId").set($origin)
                $ff.radio(:value, "N").set
                #$ff.button(:value, "NEXT").click
                $ff.button(:id, "bt_submit").click
                sleep 5
				puts "**** Waiting for surveys to load ****"
				sleep 35
				if ($ff.contains_text(/Based on questions/))
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("p.surveyhead.com/index.php?mode=logout")
				$ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
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
	  
	  def test_08_revert_pub_settings
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
				sleep 2
				$enc_pub_id = "PU#{$pub_id}"
				$enc_pub_id = Base64.encode64($enc_pub_id)
				$ie.goto("p.usampadmin.com/add_publisher.php?hdMode=accountinfo&publisher_id=#{$enc_pub_id}")
				$ie.link(:text,"Redirects / Pixels").click
				$ie.radio(:value, "1").set
				#$ie.text_field(:id, "txtSTurl").set($pub_st)
				sleep 2
				$ie.button(:value,"Save").click
				$ie.link(:text,'Logout').click
				$obj.Delete_cookies
				$ie.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				$obj.Close_all_windows
			end
	  end

end