# REDIRECTION TO PROFILE UPON REGISTRATION 

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
require 'Input Repository\Test_22_Redirection_profile_on_signup_Input.rb'

class Test_22_Profile_redirection_on_signup < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "22 - "
				$test_description = "Test Case: "+$t.to_s+"  REDIRECTION TO PROFILE UPON REGISTRATION"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
	  end
	  
	  def test_02_prof_redirection
	  
			begin
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$enc_site_id = Base64.encode64($site_id)
                $enc_site_id = $enc_site_id.chomp
                $site_det_url = "http://p.usampadmin.com/add_site.php?site_id=#{$enc_site_id}"
                $site_det_url=$site_det_url.chomp
				$ie.goto($site_det_url)
				$ie.select_list(:id, "optRegistrationRedirect").set($prof_name)
				sleep 2
				$ie.button(:value,"Update").click
				$st = '1'
				$test_description = "Saving site settings in admin"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.contains_text(/Site Variables have been updated successfully/))
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
				
				# MEMBER SIGN UP ON FOCUSLINE
				
				$ff = FireWatir::Firefox.new
				$ff.goto("sm.p.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
				$ff.goto("sm.p.surveyhead.com/registration_step1.php")
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
				$mail_address="auto_test.des"+$extension+"@mailop.com"
				$mail_address = $mail_address.gsub(/:/, "")
				$mail_address = $mail_address.gsub(/\s/, "")
				$mem_2 = $mail_address
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
				$ff.button(:value, "NEXT").click
				sleep 30
				$st = '2'
				$test_description = "Redirection to profile on registration"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ff.contains_text($prof_d_name))
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
					  
				$ff.goto("sm.p.surveyhead.com/index.php?mode=logout")
				$ff.goto("sm.p.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
				$ff.close
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
	  
	  def test_03_dashboard_redirection
	  
			begin
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$enc_site_id = Base64.encode64($site_id)
                $enc_site_id = $enc_site_id.chomp
                $site_det_url = "http://p.usampadmin.com/add_site.php?site_id=#{$enc_site_id}"
                $site_det_url=$site_det_url.chomp
				$ie.goto($site_det_url)
				$ie.select_list(:id, "optRegistrationRedirect").set("Dashboard")
				$ie.button(:value,"Update").click
				$st = '3'
				$test_description = "Saving site settings in admin"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.contains_text(/Site Variables have been updated successfully/))
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
				
				# MEMBER SIGN UP ON FOCUSLINE
				
				$ff = FireWatir::Firefox.new
				$ff.goto("sm.p.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
				$ff.goto("sm.p.surveyhead.com/registration_step1.php")
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
				$mail_address="auto_test.des"+$extension+"@mailop.com"
				$mail_address = $mail_address.gsub(/:/, "")
				$mail_address = $mail_address.gsub(/\s/, "")
				$mem_2 = $mail_address
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
				$ff.button(:value, "NEXT").click
				sleep 45
				$st = '4'
				$test_description = "Redirection to dashboard on registration"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ff.contains_text(/Total Earnings/))
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
					  
				$ff.goto("sm.p.surveyhead.com/index.php?mode=logout")
				$ff.goto("sm.p.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
				$ff.close
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
	  
end