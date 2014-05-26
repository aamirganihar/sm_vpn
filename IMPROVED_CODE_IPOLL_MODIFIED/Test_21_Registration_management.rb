# REFLECTION OF REGISTRATION MANAGEMENT SETTINGS 

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
require './Input Repository\Test_21_Registration_management_Input.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

class Test_21_Registration_management < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "21 - "
				$test_description = "Test Case: "+$t.to_s+"  REFLECTION OF REGISTRATION MANAGEMENT SETTINGS"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
	  end
	  
	  def test_02_signup_with_normal_settings
	  
			begin	
				$extension = Time.new
                $extension = $extension.to_s
                $extension = $extension.slice(0..18)
                $mail_address="auto_test_des21"+$extension+"@mailop.com"
                $mail_address = $mail_address.gsub(/:/, "")
                $mail_address = $mail_address.gsub(/\s/, "")
                $mem_1 = $mail_address
                                
                #ff = FireWatir::Firefox.new
				@driver = Selenium::WebDriver::Firefox::Profile.from_name "default"
				@driver.assume_untrusted_certificate_issuer=false
				@driver.secure_ssl = true
				ff = Watir::Browser.new :firefox, :profile => @driver
                #ff.maximize
				$st = '1'
				$test_description = "Registration with normal settings "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                ff.goto('http://www.q.ipoll.com/recaptcha_automation_proxy.php?mode=test')
				ff.goto("http://sm.q.surveyhead.com/registration_step1.php")
				if(ff.select_list(:name, "optCountryId").exists? && ff.select_list(:name, "optLanguageId").exists?)
                        ff.select_list(:name, "optCountryId").select($country)
                        #Entering the users Language
                        ff.select_list(:name, "optLanguageId").select($lang)
                else
                        puts "COUNTRY/LANGUAGE DOES NOT EXIST"
                end
				if(ff.text_field(:name, "txtFname").exists? && ff.text_field(:name, "txtLname").exists? && ff.select_list(:name, "optStateId").exists? && ff.select_list(:name, "optNonUSDayId").exists? && ff.radio(:value, "Male").exists? && ff.text_field(:name, "txtEmail").exists? && ff.text_field(:name, "txtPassword").exists? && ff.checkbox(:name, "chbTermsAndConditions").exists?)
                        puts "PASS"
                        $fl = 0              
                        #Entering the users First Name
                        ff.text_field(:name, "txtFname").set("TEST AUTO MEMBER")
                        #Entering the users Last Name
                        ff.text_field(:name, "txtLname").set("TEST AUTO MEMBER")
                        #Need to wait for the states to get generated
                        sleep 2
                        #Entering the users state
                        ff.select_list(:name, "optStateId").select($state)
                        sleep 4
                        #Entering the user city
                        ff.select_list(:id, "optCityId").select($city)
                        #Entering the users Date of birth
                        ff.select_list(:name, "optNonUSDayId").select($day)
                        #Entering the users Month of Birth
                        ff.select_list(:name, "optNonUSMonthId").select($month)
                        #Entering the users Year of birth
                        ff.select_list(:name, "optNonUSYearId").select($year)
                        #Entering the users gender
                        ff.radio(:value, "Male").set
                        #Entering the users Email id
                        ff.text_field(:name, "txtEmail").set($mail_address)
                        #need to wait for a while as same data is being used 2 times
                        sleep 5
                        #Confirming the users Email id
                        ff.text_field(:name, "txtConfirmEmail").set($mail_address)
                        #Entering the users password
                        ff.text_field(:name, "txtPassword").set($mail_address)
                        #Confirming the users password 
                        ff.text_field(:name, "txtConfirmPassword").set($mail_address)
                        #Accepting the terms and conditions
                        ff.checkbox(:name, "chbTermsAndConditions").set
						$code= "test string"
                        puts $code
						ff.text_field(:name,"recaptcha_response_field").set($code)
                        ff.button(:value, "Submit").click
                else
                        puts "FAIL - STEP 1 PAGE"
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                end
				if(ff.select_list(:name, "optAnnualHouseholdIncomeId").exists? && ff.select_list(:name, "optEducationLevelId").exists? && ff.select_list(:name, "optEmploymentStatusId").exists? && ff.select_list(:name, "optMaritalStatusId").exists? && ff.select_list(:name, "optNationalityId").exists? && ff.radio(:value, "N").exists? && $fl == 0)
                        puts "PASS"
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"          
                        #Entering the users income
                        ff.select_list(:name, "optAnnualHouseholdIncomeId").select($inc_level)
                        #Entering the users Education status
                        ff.select_list(:name, "optEducationLevelId").select($education)
                        #Entering the users employment status
                        ff.select_list(:name, "optEmploymentStatusId").select($employment)
                        #Entering the users maritial status
                        ff.select_list(:name, "optMaritalStatusId").select($marrital_status)
                        #Entering the users Nationality
                        ff.select_list(:name, "optNationalityId").select($origin)
                        #Setting the radio button to N
                        ff.radio(:value, "N").set
                        #Setting the radio button to I do not have a preference in the maximum number of emails I receive each week.
                        #ff.radio(:value, "0").set
                        ff.button(:value, "NEXT").click
                else
                        puts "FAIL - STEP 2 PAGE"
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                end
				sleep 25
				ff.goto("http://sm.q.surveyhead.com/index.php?mode=logout")
				ff.goto("sm.q.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
                #ff.link(:text,"Logout").click
                ff.close
			rescue => e
				  puts e.message
				  puts e.backtrace.inspect
				  #$obj.Close_all_windows
				  ff.close
				  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				  $myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end		
	  end
	  
	  def test_03_make_spec_registration_settings_in_admin
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$ie.goto("http://q.usampadmin.com/registration_management.php")
				$ie.select_list(:id, "optLanguageId").select("English")
				sleep 2
                $ie.select_list(:name, "optCountryId").select("Djibouti")
                sleep 8
                $ie.button(:value,"LOAD").click
                sleep 2
                $ie.checkbox(:id, "employment_status").clear
                $ie.checkbox(:id, "industry").clear
                $ie.checkbox(:id, "role").clear
                $ie.checkbox(:id, "marital_status").clear
                $ie.checkbox(:name, "country_of_origin").clear
                $ie.checkbox(:name, "what_languages").clear
                $ie.checkbox(:name, "children_in_household").clear
                $ie.button(:value,"SAVE").click
				$st = '2'
				$test_description = "Saving registration management settings in config settings (Admin) "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.checkbox(:id, "employment_status").set? || $ie.checkbox(:id, "industry").set? || $ie.checkbox(:id, "role").set? || $ie.checkbox(:id, "marital_status").set? || $ie.checkbox(:name, "country_of_origin").set? || $ie.checkbox(:name, "what_languages").set? || $ie.checkbox(:name, "children_in_household").set?)
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
					puts "PASS"
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
	  
	  def test_04_check_registration_after_new_settings
	  
			begin	
				$extension = Time.new
                $extension = $extension.to_s
                $extension = $extension.slice(0..18)
                $mail_address="auto_test_des22"+$extension+"@mailop.com"
                $mail_address = $mail_address.gsub(/:/, "")
                $mail_address = $mail_address.gsub(/\s/, "")
                $mem_1 = $mail_address
				#ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :ie #, :profile => "Selenium"
                ff = Watir::Browser.new driver
                #ff.maximize
				$st = '3'
				$test_description = "Registration with changed settings "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                ff.goto('http://www.q.ipoll.com/recaptcha_automation_proxy.php?mode=test')
				ff.goto("http://sm.q.surveyhead.com/registration_step1.php")
				if(ff.select_list(:name, "optCountryId").exists? && ff.select_list(:name, "optLanguageId").exists?)
                        ff.select_list(:name, "optCountryId").select($country)
                        #Entering the users Language
                        ff.select_list(:name, "optLanguageId").select($lang)
                else
                        puts "COUNTRY/LANGUAGE DOES NOT EXIST"
                end
				if(ff.text_field(:name, "txtFname").exists? && ff.text_field(:name, "txtLname").exists? && ff.select_list(:name, "optStateId").exists? && ff.select_list(:name, "optNonUSDayId").exists? && ff.radio(:value, "Male").exists? && ff.text_field(:name, "txtEmail").exists? && ff.text_field(:name, "txtPassword").exists? && ff.checkbox(:name, "chbTermsAndConditions").exists?)
                        puts "PASS"
                        $flg=0
                        ff.text_field(:name, "txtFname").set("TEST AUTO MEMBER")
                        ff.text_field(:name, "txtLname").set("TEST AUTO MEMBER")
                        sleep 2
                        ff.select_list(:name, "optStateId").select($state)
                        sleep 5
                        ff.select_list(:id, "optCityId").select($city)
                        ff.select_list(:name, "optNonUSDayId").select($day)
                        ff.select_list(:name, "optNonUSMonthId").select($month)
                        ff.select_list(:name, "optNonUSYearId").select($year)
                        ff.radio(:value, "Male").set
                        ff.text_field(:name, "txtEmail").set($mail_address)
                        sleep 5
                        ff.text_field(:name, "txtConfirmEmail").set($mail_address)
                        ff.text_field(:name, "txtPassword").set($mail_address)
                        ff.text_field(:name, "txtConfirmPassword").set($mail_address)
                        ff.checkbox(:name, "chbTermsAndConditions").set
						$code= "test string"
                        puts $code
						ff.text_field(:name,"recaptcha_response_field").set($code)
                        ff.button(:value, "Submit").click
                else
                        puts "Failed on page 1"
                        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                end
				if(ff.select_list(:name, "optAnnualHouseholdIncomeId").exists? && ff.select_list(:name, "optEducationLevelId").exists? && $flg==0 )
                            puts "Pass1"
                            if(ff.select_list(:name, "optEmploymentStatusId").exists? && ff.select_list(:name, "optMaritalStatusId").exists? && ff.select_list(:name, "optNationalityId").exists? && ff.radio(:value, "N").exists? && ff.radio(:value, "0").exists?)
                                    puts "**FAIL (unselected fields shown) **"
                                    $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED(Unchecked fields exists)</font></td></tr>"
                            else
									#Entering the users income
                                    ff.select_list(:name, "optAnnualHouseholdIncomeId").select($inc_level)
                                    #Entering the users Education status
                                    ff.select_list(:name, "optEducationLevelId").select($education)
                                    #Setting the radio button to N
                                    #ff.radio(:value, "N").set
                                    #Setting the radio button to I do not have a preference in the maximum number of emails I receive each week.
                                    #ff.radio(:value, "0").set
                                    ff.button(:value, "NEXT").click
                                    sleep 25
                                    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                            end
                else
							puts "Failed on page 2"
                            $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                end
				
				#ff.link(:text,"Logout").click
                ff.goto("http://sm.q.surveyhead.com/index.php?mode=logout")
                ff.goto('http://www.q.ipoll.com/recaptcha_automation_proxy.php?mode=normal') # setting normal mode
                ff.close
			rescue => e
				  puts e.message
				  puts e.backtrace.inspect
				  #$obj.Close_all_windows
				  ff.close
				  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				  $myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end	
				
	  end
	  
	  def test_05_revert_registration_mgmnt_settings
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$ie.goto("http://q.usampadmin.com/registration_management.php")
				$ie.select_list(:id, "optLanguageId").select("English")
				sleep 2
                $ie.select_list(:name, "optCountryId").select("Djibouti")
                sleep 8
                $ie.button(:value,"LOAD").click
                sleep 2
				$ie.link(:text, "Configuration Settings").click
				sleep 5
                $ie.link(:text, "Registration Management").click
                $ie.select_list(:id, "optLanguageId").select("English")
                $ie.select_list(:name, "optCountryId").select("Djibouti")
                $ie.button(:value,"LOAD").click
                $ie.checkbox(:id, "employment_status").set
                $ie.checkbox(:id, "industry").set
                $ie.checkbox(:id, "role").set
                $ie.checkbox(:id, "job_title").set
                $ie.checkbox(:id, "marital_status").set
                $ie.checkbox(:name, "country_of_origin").set
                $ie.checkbox(:name, "what_languages").set
                #$ie.checkbox(:name, "instant_message_id").set
                $ie.checkbox(:name, "children_in_household").set
                $ie.button(:value,"SAVE").click
		sleep 6
				$st = '4'
				$test_description = "Reverting registration management settings in config settings (Admin) "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.checkbox(:id, "employment_status").set? || $ie.checkbox(:id, "industry").set? || $ie.checkbox(:id, "role").set? || $ie.checkbox(:id, "marital_status").set? || $ie.checkbox(:name, "country_of_origin").set? || $ie.checkbox(:name, "what_languages").set? || $ie.checkbox(:name, "children_in_household").set?)
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
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
	  
end