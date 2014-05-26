# CANADA GET COUNT CASE

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
require './Input Repository\Test_10_CAN_getcount_Input.rb'
require './Input Repository\surveyurl.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

class Test_10_CAN_getcount < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
		
		def test_01_report_head
	  
				$t = "10 - "
				$test_description = "Test Case: "+$t.to_s+"  CANADA GET COUNT"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
									  
		end
		
		def test_02_CAN_getcount
		
				#begin
				
						$obj = Usamp_lib.new
						$obj.Delete_cookies()
						$ie = $obj.Usampadmin1_login($admin_email,$admin_passwd)	
						$pub_enc_id = Base64.encode64($pub_id)
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
						$ie.checkbox(:id, "chkShowSurvey").set
						$ie.text_field(:id, "txtSurveyName").set("CAN GETCOUNT SURVEY")
						$ie.button(:value,"Save Group").click
						$ie.goto("q.usampadmin.com/add_quota_group_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
						sleep 6
						#$postal_code_path = $postal_code_path.gsub("/", "\\")
                        #$fsa_path = $fsa_path.gsub("/", "\\")
						$ie.select_list(:name, "optCountryId").select("Canada")
                        $ie.select_list(:name, "optIncomeLevels[]").select($inc_level)
                        $ie.select_list(:name, "optNationalityId[]").select($origin)
                        $ie.select_list(:name, "optEducationLevels[]").select($education)
			sleep 1
                        $ie.checkbox(:id, "chkCanadaGeoTarget").set
			sleep 5
                        $ie.radio(:id, "rdCanadaPostalCode").set
                        #$ie.file_field(:id, "uploadCSVFile").set($postal_code_path)
			sleep 3
						$ie.text_field(:id, "txtList").set($postal_code)
                        sleep 2
						$ie.button(:value,"Save Group").click
                        sleep 3
                        $ie.button(:value,"Get Count").click
						sleep 5
						puts "*** Waiting for count to load ***"
						sleep 40
						$html_contents=$ie.html
                             $html_array = $html_contents.split(/\n/)
                                0.upto($html_array.size - 1) { |index|
                                if($html_array[index] =~ /# of members from uSamp Panel/)
                                        
                                    $mem_count = $html_array[index+2]
                                        break
                                else
                                        next
                                end
                                }
                        puts "************"
                        $mem_count = $mem_count.to_s
                        $ln = $mem_count.length
                        puts $mem_count
                        $mem_count = $mem_count.slice(25..$ln-1)
                        puts $mem_count
                        $mem_count = $mem_count.to_i
                        puts $mem_count
                        $mem_count = $mem_count+1
						
						#MEMBER SIGN UP
						
						$extension = Time.new
                        $extension = $extension.to_s
                        $extension = $extension.slice(0..18)
                        $mail_address="test21.des"+$extension+"@mailop.com"
                        $mail_address = $mail_address.gsub(/:/, "")
						$mail_address = $mail_address.gsub(/\s/, "")
                        $mem_1 = $mail_address
                                
                        #ff = FireWatir::Firefox.new
				@driver = Selenium::WebDriver::Firefox::Profile.from_name "default"
					@driver.assume_untrusted_certificate_issuer=false
					@driver.secure_ssl = true
					ff = Watir::Browser.new :firefox, :profile => @driver
						ff.goto('http://www.q.ipoll.com/recaptcha_automation_proxy.php?mode=test') # setting test mode to bypass RE-CAPTCHA
                        # Opening p.surveyhead.com site
                        ff.goto("http://sm.q.surveyhead.com/registration_step1.php")
						ff.text_field(:name, "txtFname").set("AUTO FNAME")
                        ff.text_field(:name, "txtLname").set("AUTO LNAME")
						ff.select_list(:name, "optCountryId").select($country)
						ff.select_list(:name, "optLanguageId").select($lang)
						sleep 7 
                        #Entering the users Country Name
                        ff.select_list(:name, "optCountryId").select($country)
                        #Entering the users Language
                        ff.select_list(:name, "optLanguageId").select($lang)
                        #Need to wait for the states to get generated
                        sleep 7
                        #Entering the users state
                        ff.select_list(:name, "optStateId").select($state)
                        sleep 2
                        ff.text_field(:name, "txtZipPostal").set($pcode_match)
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
                        #Clicking on submit
                        ff.button(:value, "Submit").click
                        #Entering the users income
                        ff.select_list(:name, "optAnnualHouseholdIncomeId").select($inc_level)
                        #Entering the users Education status
                        ff.select_list(:name, "optEducationLevelId").select($education)
                        #Entering the users employment status
                        ff.select_list(:name, "optEmploymentStatusId").select($employment)
                        #Entering the users maritial status
                        ff.select_list(:name, "optMaritalStatusId").select($marrital_status)
                        ff.select_list(:name, "optNationalityId").select($origin)
                        #Setting the radio button to N
                        ff.radio(:value, "N").set
                        #Setting the radio button to I do not have a preference in the maximum number of emails I receive each week.
                        ff.button(:value, "NEXT").click
                        sleep 6
						puts "**** Waiting for surveys to load ****"
						sleep 25
						$st = '1'
						$test_description = "Survey shown on dashboard after CANADA targeting criteria match"
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						if (ff.text.include?("CAN GETCOUNT SURVEY"))
								 $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                  puts "PASS"
                        else
                                  $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                                  puts "FAIL"
                        end
						$ie.link(:text, "Criteria").click
            sleep 500
						$ie.button(:value,"Get Count").click
                          sleep 45
						  $html_contents=$ie.html
                                $html_array = $html_contents.split(/\n/)
                                   0.upto($html_array.size - 1) { |index|
                                      if($html_array[index] =~ /# of members from uSamp Panel/)
                                        
                                            $new_mem_count = $html_array[index+2]
                                                      break
                                                        else
                                                              next
                                                        end
                                                      }
                        puts "************"
                        $new_mem_count = $new_mem_count.to_s
                        $ln = $new_mem_count.length
                        puts $new_mem_count
                        $new_mem_count = $new_mem_count.slice(25..$ln-1)
                        puts $new_mem_count
                        $new_mem_count = $new_mem_count.to_i
                        puts $new_mem_count 
						$st = '2'
						$test_description = "Member comes in QG Get count"
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						if($new_mem_count == $mem_count)
								puts "GET COUNT PASS"
								$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                        else
								puts "GET COUNT FAIL"
								$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                        end
						ff.link(:text,"My Account").click
                        ff.text_field(:name, "txtZipPostal").set($pcode_mismatch)
                        ff.button(:value,"Update Account").click
                        sleep 2
                        ff.link(:text,"Dashboard").click
                        sleep 5		
						$st = '3'
						$test_description = "Survey not shown for non-matching member"
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                        sleep 30
                        if (ff.text.include?("CAN GETCOUNT SURVEY"))
								$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
								puts "FAIL"
						else
								$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
								puts "PASS"
              end
            $ie.link(:text, "Criteria").click
            sleep 3  
						$ie.radio(:id, "rdCanadaFSA").set
                        #$ie.file_field(:id, "uploadCSVFile").set($fsa_path)
						$ie.text_field(:id, "txtList").set($fsa)
                        sleep 2
                        $ie.button(:value,"Save Group").click
                        sleep 3
						ff.link(:text,"Dashboard").click
                        sleep 5
						$st = '4'
						$test_description = "Member not matching General/Canada targetting criteria (FSA) is not shown the survey on dashboard"
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						if (ff.text.include?("CAN GETCOUNT SURVEY"))
								$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                                puts "FSA_MISMATCH:FAIL"
                        else
                                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                puts "FSA_MISMATCH:PASS"
                        end
						ff.link(:text,"My Account").click
                        ff.text_field(:name, "txtZipPostal").set($pcode_match)
                        ff.button(:value,"Update Account").click
                        sleep 2
                        ff.link(:text,"Dashboard").click
                        sleep 5
						$st = '5'
						$test_description = "Member matching General/Canada targetting criteria (FSA) is shown the survey on dashboard"
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						if (ff.text.include?("CAN GETCOUNT SURVEY"))
                                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                puts "FSA_MATCH:PASS"
                        else
								$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                                puts "FSA_MATCH:FAIL"
                        end
						$ie.radio(:id, "rdCanadaAreaCode").set
                        #$ie.radio(:id, "rdCanadaDataInput").set
                        $ie.text_field(:id, "txtList").set($area_code)
                        sleep 1
                        $ie.button(:value,"Save Group").click
                        sleep 2
                        ff.link(:text,"Dashboard").click
                        sleep 5
						$st = '6'
						$test_description = "Member matching General/Canada targetting criteria (AREA CODE) is shown the survey on dashboard"
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						if (ff.text.include?("CAN GETCOUNT SURVEY"))
								$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                puts "AREA_MATCH:PASS"
                        else
                                $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
								puts "AREA_MATCH:FAIL"
                        end
						ff.link(:text,"My Account").click
                        ff.text_field(:name, "txtZipPostal").set($pcode_mismatch2)
                        ff.button(:value,"Update Account").click
                        sleep 2
                        ff.link(:text,"Dashboard").click
                        sleep 5
						$st = '7'
						$test_description = "Member not matching General/Canada targetting criteria (AREA CODE) is not shown the survey on dashboard"
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						if (ff.text.include?("CAN GETCOUNT SURVEY"))
								$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                                #puts "AREA_MISMATCH:FAIL"
                        else
                                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                #puts "AREA_MISMATCH:PASS"
                        end
						$ie.radio(:id, "rdCanadaCityProvince").set
                        $ie.select_list(:id, "optProvince_1").select($state)
                        sleep 4
                        $ie.select_list(:id, "optCanadaCity_1").select($city)
                        $ie.button(:value,"Save Group").click
                        sleep 2
                        ff.link(:text,"Dashboard").click
                        sleep 5
						$st = '8'
						$test_description = "Member not matching General/Canada targetting criteria (STATE/CITY) is not shown the survey on dashboard"
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						sleep 25
						if (ff.text.include?("CAN GETCOUNT SURVEY"))
                                $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                                puts "STATE_MISMATCH:FAIL"
                        else
                                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                puts "STATE_MISMATCH:PASS"
                        end
						ff.link(:text,"My Account").click
                        ff.text_field(:name, "txtZipPostal").set($pcode_match)
                        ff.button(:value,"Update Account").click
                        sleep 2
                        ff.link(:text,"Dashboard").click
                        sleep 5
						$st = '9'
						$test_description = "Member matching General/Canada targetting criteria (STATE/CITY) is shown the survey on dashboard"
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						if (ff.text.include?("CAN GETCOUNT SURVEY"))
                                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                puts "STATE_MATCH:PASS"
                        else
                                $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                                puts "STATE_MATCH:FAIL"
                        end
						
						$ie.link(:text, "Profile Criteria").click
                        sleep 2
                        $ie.select_list(:name, "optProfileId1").select($prof_nm)
                        sleep 3
                        $ie.select_list(:name, "optQuestionId1").select($quest)
                        sleep 3
                        $ie.select_list(:name, "optAnswerId1[]").select($ans)
                        $ie.button(:value,"Save Group").click
                        sleep 2
                        $ie.button(:value,"Get Count").click
                        sleep 45
                        $html_contents=$ie.html
                        $html_array = $html_contents.split(/\n/)
                        0.upto($html_array.size - 1) { |index|
                            if($html_array[index] =~ /# of members from uSamp Panel/)
                                    $mem_count = $html_array[index+2]
                                        break
                            else
                                        next
                            end
                            }
                        puts "************"
                        $mem_count = $mem_count.to_s
                        $ln = $mem_count.length
                        puts $mem_count
                        $mem_count = $mem_count.slice(25..$ln-1)
                        puts $mem_count
                        $mem_count = $mem_count.to_i
                        puts $mem_count
                        $mem_count = $mem_count+1
						ff.link(:text, "Profiles").click
                        ff.link(:text,$prof_dn).click
                        sleep 2
			ff.radio(:index => 6).set
                        #ff.radio(:xpath,"(//input[@id='QN_1138'])[5]").set
                        ff.button(:value,"Next").click
                        ff.link(:text, "Surveys").click
                        sleep 5
						$st = '10'
						$test_description = "Member matching General/Profile criteria is shown the survey on dashboard"
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						sleep 30
                        if (ff.text.include?("CAN GETCOUNT SURVEY"))
								$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                puts "PROF_MATCH:PASS"
                        else
                                $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                                puts "PROF_MATCH:FAIL"
                              end
                $ie.link(:text, "Criteria").click
                sleep 500
						$ie.button(:value,"Get Count").click
                        sleep 45
                        $html_contents=$ie.html
                                 $html_array = $html_contents.split(/\n/)
                                   0.upto($html_array.size - 1) { |index|
                                      if($html_array[index] =~ /# of members from uSamp Panel/)
                                        
                                            $new_mem_count = $html_array[index+2]
                                                      break
                                                        else
                                                              next
                                                        end
                                                      }
                        puts "************"
                        $new_mem_count = $new_mem_count.to_s
                        $ln = $new_mem_count.length
                        puts $new_mem_count
                        $new_mem_count = $new_mem_count.slice(25..$ln-1)
                        puts $new_mem_count
                        $new_mem_count = $new_mem_count.to_i
                        puts $new_mem_count 
						$st = '11'
						$test_description = "Member comes in get count"
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						if($new_mem_count == $mem_count)
                                puts "PRF GET COUNT PASS"
                                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                        else
								puts "PRF GET COUNT FAIL"
                                $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                        end
						ff.link(:text, "Profiles").click
                        ff.link(:text,$prof_dn).click
                        sleep 2
			ff.radio(:index => 8).set
                        #ff.radio(:xpath, "(//input[@id='QN_1138'])[7]").set
                        ff.button(:value,"Next").click
                        ff.link(:text, "Surveys").click
						$st = '12'
						$test_description = "Member not matching General/Profile criteria is not shown the survey on dashboard"
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						sleep 25
						if (ff.text.include?("CANADA GETCOUNT SURVEY"))
                                $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                                puts "PROF_MISMATCH:FAIL"
                        else
                                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                puts "PROF_MISMATCH:PASS"                                  
                        end
						ff.goto("http://sm.q.surveyhead.com/index.php?mode=logout")
						ff.goto('http://www.q.ipoll.com/recaptcha_automation_proxy.php?mode=normal') # setting normal mode
                        ff.close
						$ie.link(:text,"Logout").click
						$ie.close
=begin						
				rescue => e
						puts e.message
						puts e.backtrace.inspect
						#$obj.Close_all_windows
						$ie.close
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
					
				end	
=end		
		end
		
		def test_03_qg_reset_prof_criteria
		
				#begin	
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)	
					#$pub_enc_id = Base64.encode64($pub_id)
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
					sleep 3
					$ie.link(:text, "Criteria").click
					sleep 5
					$ie.link(:text, "Profile Criteria").click
					sleep 5
					$ie.select_list(:id, "optProfileId1").select("--Select Profile--")
					sleep 5
					$ie.button(:value,"Save Group").click
					sleep 3
					$ie.link(:text,"Logout").click
					$ie.close
=begin					
				rescue => e
						puts e.message
						puts e.backtrace.inspect
						#$obj.Close_all_windows
						$ie.close
						
				end
=end			
		end
		
		def test_04_cangetcnt_mempub
		
				#begin	
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)	
					$pub_enc_id = Base64.encode64($pub_id)
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
					sleep 3
					$ie.link(:text, "Criteria").click
					sleep 2
					$ie.link(:text, "Member/Pub Options").click
					sleep 5
					$ie.checkbox(:id, "chkDoubleOpted").set
					$ie.checkbox(:name, "chkExcludeMembersFromThisClient").set
					$ie.checkbox(:name, "chkCompletedAnySurvey").set
					sleep 2
					$ie.button(:value,"Save Group").click
					sleep 3
					$ie.link(:text, "Criteria").click
					sleep 4
					$ie.button(:value,"Get Count").click
					sleep 5
					puts "*** Waiting for count to load ***"
					sleep 55
					$html_contents=$ie.html
                        $html_array = $html_contents.split(/\n/)
                            0.upto($html_array.size - 1) { |index|
                            if($html_array[index] =~ /# of members from uSamp Panel/)
                                        
                                    $mem_count = $html_array[index+2]
                                        break
                            else
                                        next
                            end
                        }
                    puts "************"
                    $mem_count = $mem_count.to_s
                    $ln = $mem_count.length
                    puts $mem_count
                    $mem_count = $mem_count.slice(25..$ln-1)
                    puts $mem_count
                    $mem_count = $mem_count.to_i
                    puts $mem_count	
					$extension = Time.new
                    $extension = $extension.to_s
                    $extension = $extension.slice(0..18)
                    $mail_address="test21.des"+$extension+"@mailop.com"
                    $mail_address = $mail_address.gsub(/:/, "")
					$mail_address = $mail_address.gsub(/\s/, "")
                    $mem_1 = $mail_address
                                
                    #ff = FireWatir::Firefox.new
					@driver = Selenium::WebDriver::Firefox::Profile.from_name "default"
					@driver.assume_untrusted_certificate_issuer=false
					@driver.secure_ssl = true
					ff = Watir::Browser.new :firefox, :profile => @driver
                     #Maximizing the window
                    #ff.maximize
					ff.goto('http://www.q.ipoll.com/recaptcha_automation_proxy.php?mode=test') # setting test mode to bypass RE-CAPTCHA
                    # Opening p.surveyhead.com site
					sleep 3
                    ff.goto("http://sm.q.surveyhead.com/registration_step1.php")
					ff.text_field(:name, "txtFname").set("AUTO FNAME")
                    ff.text_field(:name, "txtLname").set("AUTO LNAME")
					ff.select_list(:name, "optCountryId").select($country)
					ff.select_list(:name, "optLanguageId").select($lang)
					sleep 7 
                    #Entering the users Country Name
                    ff.select_list(:name, "optCountryId").select($country)
                    #Entering the users Language
                    ff.select_list(:name, "optLanguageId").select($lang)
                    #Need to wait for the states to get generated
                    sleep 7
                    #Entering the users state
                    ff.select_list(:name, "optStateId").select($state)
                    sleep 2
                    ff.text_field(:name, "txtZipPostal").set($pcode_match)
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
                    #Clicking on submit
                    ff.button(:value, "Submit").click
                    #Entering the users income
                    ff.select_list(:name, "optAnnualHouseholdIncomeId").select($inc_level)
                    #Entering the users Education status
                    ff.select_list(:name, "optEducationLevelId").select($education)
                    #Entering the users employment status
                    ff.select_list(:name, "optEmploymentStatusId").select($employment)
                    #Entering the users maritial status
                    ff.select_list(:name, "optMaritalStatusId").select($marrital_status)
                    ff.select_list(:name, "optNationalityId").select($origin)
                    #Setting the radio button to N
                    ff.radio(:value, "N").set
                    #Setting the radio button to I do not have a preference in the maximum number of emails I receive each week.
                    ff.button(:value, "NEXT").click
                    sleep 6
					puts "**** Waiting for surveys to load ****"
					sleep 25
					$st = '13'
					$test_description = "Survey not shown on dashboard when Member pub options mismatch"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					if (ff.text.include?("CAN GETCOUNT SURVEY"))
						 $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                         puts "FAIL"
                    else
                         $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                         puts "PASS"
                       end
                       $ie.link(:text, "Criteria").click
                       sleep 3
					$ie.button(:value,"Get Count").click
                    sleep 45
					$html_contents=$ie.html
                        $html_array = $html_contents.split(/\n/)
                            0.upto($html_array.size - 1) { |index|
                            if($html_array[index] =~ /# of members from uSamp Panel/)
                                       
                                    $new_mem_count = $html_array[index+2]
                                    break
                            else
                                    next
                            end
                       }
                    puts "************"
                    $new_mem_count = $new_mem_count.to_s
                    $ln = $new_mem_count.length
                    puts $new_mem_count
                    $new_mem_count = $new_mem_count.slice(25..$ln-1)
                    puts $new_mem_count
                    $new_mem_count = $new_mem_count.to_i
                    puts $new_mem_count 
					$st = '14'
					$test_description = "Member does not come in QG Get count when member pub options mismatch"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					if($new_mem_count == $mem_count)
						puts "GET COUNT PASS"
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                    else
						puts "GET COUNT FAIL"
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                    end
					ff.goto('http://sm.q.surveyhead.com/index.php?mode=logout')
					sleep 2
					ff.close
					$ie.goto("http://q.usampadmin.com/list_members.php")
					sleep 2
					$ie.text_field(:name, "txtFirstName").set("AUTO FNAME")
					$ie.text_field(:name,'txtEmail').set($mem_1)
					$ie.text_field(:name,'txtPassword').set($mem_1)
					$ie.select_list(:id, 'optPLSites').select("FocuslineSurveys")
					sleep 2
					$ie.button(:value,'Search').click
					sleep 8
					$ie.link(:text => /M[0-9]/).click
					sleep 5
					$ie.link(:text, "Member Details").click
					sleep 5
					$ie.radio(:value, "Y").click
					$ie.button(:value,"Save Details").click
					sleep 3
					$ff = $obj.Focusline_login($mem_1,$mem_1)
					sleep 5
					 puts "Waiting for surveys to load..."
					
					$st = '15'
					$test_description = "Survey shown on dashboard when member pub options match"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					if ($ff.text.include?("CAN GETCOUNT SURVEY"))
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
					    puts "PASS" 
					else
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
						puts "FAIL"  
					end
					#$ff.goto('http://s.pl1.ipoll.com/index.php?mode=logout')
					$ff.goto("http://www.sm.q.surveyhead.com/index.php?mode=logout")
					$ff.goto("q.ipoll.com/recaptcha_automation_proxy.php?mode=normal")
					sleep 2
					$ff.close
							  
					$mem_count = $mem_count+1
					$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
					sleep 3
					$ie.link(:text, "Criteria").click
					sleep 500
					$ie.button(:value,"Get Count").click
					sleep 55
					$html_contents=$ie.html
                        $html_array = $html_contents.split(/\n/)
                        0.upto($html_array.size - 1) { |index|
                            if($html_array[index] =~ /# of members from uSamp Panel/)
                                        
                                    $new_mem_count = $html_array[index+2]
                                  break
                            else
                                    next
                            end
                        }
                    puts "************"
                    $new_mem_count = $new_mem_count.to_s
                    $ln = $new_mem_count.length
                    puts $new_mem_count
                    $new_mem_count = $new_mem_count.slice(25..$ln-1)
                    puts $new_mem_count
                    $new_mem_count = $new_mem_count.to_i
                    puts $new_mem_count 
					$st = '16'
					$test_description = "Member comes in QG Get count when member pub options mismatch"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					if($new_mem_count == $mem_count)
						puts "GET COUNT PASS"
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                    else
						puts "GET COUNT FAIL"
					    $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                    end
					$ie.link(:text,'Logout').click
					$ie.close
=begin					
				rescue => e
						puts e.message
						puts e.backtrace.inspect
						#$obj.Close_all_windows
						$ie.close
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
					
				end	
=end					
		
		end
		
		def test_05_qg_reset
		
			#begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)	
				#$pub_enc_id = Base64.encode64($pub_id)
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
				$ie.text_field(:id, "txtSurveyName").set("AUTO TEST SURVEY")
				$ie.button(:value,"Save Group").click
				$ie.link(:text, "Criteria").click
				sleep 2
				$ie.checkbox(:id, "chkCanadaGeoTarget").clear
				sleep 2
				$ie.button(:value,"Save Group").click
                sleep 2
				#$ie.link(:text, "Profile Criteria").click
				#$ie.select_list(:name, "optProfileId1").set("--Select Profile--")
                #sleep 3
                #$ie.button(:value,"Save Group").click
                sleep 3
				$ie.link(:text, "Criteria").click
				sleep 2
				$ie.select_list(:name, "optCountryId").select("United States")
                $ie.select_list(:name, "optIncomeLevels[]").select($inc_level)
                $ie.select_list(:name, "optNationalityId[]").select($origin)
                $ie.select_list(:name, "optEducationLevels[]").select($education)
				sleep 3
                $ie.button(:value,"Save Group").click
				sleep 2
				$ie.link(:text, "Member/Pub Options").click
				sleep 5
				$ie.checkbox(:id, "chkDoubleOpted").clear
				$ie.checkbox(:name, "chkExcludeMembersFromThisClient").clear
				$ie.checkbox(:name, "chkCompletedAnySurvey").clear
				sleep 2
				$ie.button(:value,"Save Group").click
				sleep 3
				$ie.link(:text,"Logout").click
				$ie.close
=begin			
			rescue => e
						puts e.message
						puts e.backtrace.inspect
						#$obj.Close_all_windows
						$ie.close
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
					
			end
=end		
		end
end