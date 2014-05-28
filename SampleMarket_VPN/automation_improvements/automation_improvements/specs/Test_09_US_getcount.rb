# US GET COUNT CASE

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
require 'Input Repository\Test_09_US_getcount_Input.rb'

class Test_09_US_getcount < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
		
		def test_01_report_head
	  
				$t = "9 - "
				$test_description = "Test Case: "+$t.to_s+"  US GET COUNT"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
									  
		end
		
		def test_02_US_getcount
		
				begin
				
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
						$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
						$ie.select_list(:name, "optQuotaStatus").set("Open")
						$ie.checkbox(:id, "chkShowSurvey").set
						$ie.text_field(:id, "txtSurveyName").set("US GETCOUNT SURVEY")
						$ie.button(:value,"Save Group").click
						$ie.goto("p.usampadmin.com/add_quota_group_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
						sleep 6
						#$area_code_path = $area_code_path.gsub("/", "\\")
                        #$zip_code_path = $zip_code_path.gsub("/", "\\")
						$ie.select_list(:id, "optCountryId").set("United States")
						$ie.select_list(:id, "optLanguageId").set("English")
						$ie.button(:value,"Save Group").click
						sleep 3
						$ie.select_list(:name, "optEthnicity[]").set($ethnicity)
                        $ie.select_list(:name, "optIncomeLevels[]").set($inc_level)
                        $ie.select_list(:name, "optNationalityId[]").set($origin)
                        $ie.select_list(:name, "optEducationLevels[]").set($education)
                        $ie.checkbox(:id, "chkUSGeoTarget").set
                        $ie.select_list(:id, "optUSDataPoint_1").set("Area Code")
                        #$ie.radio(:id, "rdUSAreaCodeDataUpload").set
                        #$ie.file_field(:id, "fileAreaCodeName").set($area_code_path)
						$ie.text_field(:id, "txtAreaCodeList").set($area_code)
						sleep 5
                        $ie.link(:id, "addDataPointLink").click
                        $ie.select_list(:id, "optUSDataPoint_2").set("CBSA")
                        #$ie.radio(:id, "rdUSCBSADataInput").set
                        $ie.text_field(:id, "txtCBSAList").set($cbsa)
                        $ie.link(:id, "addDataPointLink").click
                        $ie.select_list(:id, "optUSDataPoint_3").set("County FIPS")
                        #$ie.radio(:id, "rdUSCountyFIPSDataInput").set
                        $ie.text_field(:id, "txtCountyFIPSList").set($country_fips)
                        $ie.link(:id, "addDataPointLink").click
                        $ie.select_list(:id, "optUSDataPoint_4").set("DMA")
                        #$ie.radio(:id, "rdUSDMADataInput").set
                        $ie.text_field(:id, "txtDMAList").set($dma)
                        $ie.link(:id, "addDataPointLink").click
                        $ie.select_list(:id, "optUSDataPoint_5").set("Miles / radius around zip code")
                        $ie.text_field(:id, "txtMiles").set($miles)
                        $ie.text_field(:id, "txtZipRadiusList").set($miles_zip)
                        $ie.link(:id, "addDataPointLink").click
                        $ie.select_list(:id, "optUSDataPoint_6").set("MSA / PMSA")
                        #$ie.radio(:id, "rdUSMSADataInput").set
                        $ie.text_field(:id, "txtMSAList").set($msa_pmsa)
                        $ie.link(:id, "addDataPointLink").click
                        $ie.select_list(:id, "optUSDataPoint_7").set("Region")
                        $ie.checkbox(:id, "chkDiv1").set
                        $ie.checkbox(:id, "chkDiv2").set
                        $ie.checkbox(:id, "chkDiv3").set
                        $ie.checkbox(:id, "chkDiv4").set
                        $ie.checkbox(:id, "chkDiv5").set
                        $ie.checkbox(:id, "chkDiv6").set
                        $ie.checkbox(:id, "chkDiv7").set
                        $ie.checkbox(:id, "chkDiv8").set
                        $ie.checkbox(:id, "chkDiv9").set
                        $ie.link(:id, "addDataPointLink").click
                        $ie.select_list(:id, "optUSDataPoint_8").set("State / County / City")
                        $ie.select_list(:id, "optState_1").set($state)
                        sleep 5
                        $ie.select_list(:id, "optCounty_1").set($county)
                        sleep 5
                        $ie.select_list(:id, "optCity_1").set($city)
                        $ie.link(:id, "addDataPointLink").click
                        $ie.select_list(:id, "optUSDataPoint_9").set("State FIPS")
                        #$ie.radio(:id, "rdUSStateFIPSDataInput").set
                        $ie.text_field(:id, "txtStateFIPSList").set($state_fips)
                        $ie.link(:id, "addDataPointLink").click
                        $ie.select_list(:id, "optUSDataPoint_10").set("Zip Code")
                        #$ie.radio(:id, "rdUSZipDataUpload").set
                        #$ie.file_field(:id, "fileZipName").set($zip_code_path)
						$ie.text_field(:id, "txtZipList").set($zip_code)
            #$ie.checkbox(:id, "chkInfiniDBGetCount").clear
						sleep 5
                        $ie.button(:value,"Save Group").click
                        sleep 3
                        #$ie.checkbox(:id, "chkInfiniDBGetCount").clear
                        sleep 2
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
                        $mem_count = $mem_count+1
						#Member sign up
						$ff = FireWatir::Firefox.new
						  $ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
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
						  $ff.button(:value, "NEXT").click
						  sleep 5
						  #$file1 = File.open($mem_email_file_path_1, 'w');
						  #puts $mem_1
						  #$file1.print $mem_1;
						  #$file1.close;
						  puts "**** Waiting for surveys to load ****"
						  sleep 45
						  $st = '1'
						  $test_description = "Survey shown on dashboard after US targeting criteria match"
						  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						  if ($ff.contains_text("US GETCOUNT SURVEY"))
                                 
                                  $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                  puts "PASS"
                          else
                                  $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                                  puts "FAIL"
                          end
						  sleep 3
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
								
								$ff.goto('http://sm.p.surveyhead.com/index.php?mode=logout')
								sleep 2
								$ff.close
								
								#MEMBER 2
								
								$extension = Time.new
                                $extension = $extension.to_s
                                $extension = $extension.slice(0..18)
                                $mail_address="auto_test.des"+$extension+"@mailop.com"
                                $mail_address = $mail_address.gsub(/:/, "")
                                $mail_address = $mail_address.gsub(/\s/, "")
                                $mem_2 = $mail_address
                                
                                ff = FireWatir::Firefox.new
                                #Maximizing the window
                                ff.maximize
								ff.goto('http://www.p.surveyhead.com/recaptcha_automation_proxy.php?mode=test') # setting test mode to bypass RE-CAPTCHA
                                # Opening p.surveyhead.com site
                                $ff.goto("sm.p.surveyhead.com/registration_step1.php")
                                #Opening the registration page
                                #ff.link(:text, "Free Registration").click
                                #Entering the users First Name
                                ff.text_field(:name, "txtFname").set("TEST AUTO MEMBER")
                                #Entering the users Last Name
                                ff.text_field(:name, "txtLname").set("TEST AUTO MEMBER")
                                #Entering the users Country Name
                                ff.select_list(:name, "optCountryId").set($country)
                                #Entering the users Language
                                ff.select_list(:name, "optLanguageId").set($lang)
                                #Need to wait for the states to get generated
                                sleep 7
                                #Entering the users state
                                ff.select_list(:name, "optStateId").set($state_mismatch)
                                sleep 2
                                ff.text_field(:name, "txtZipPostal").set($zip_match)
                                #Entering the users Date of birth
                                ff.select_list(:name, "optNonUSDayId").set($day)
                                #Entering the users Month of Birth
                                ff.select_list(:name, "optNonUSMonthId").set($month)
                                #Entering the users Year of birth
                                ff.select_list(:name, "optNonUSYearId").set($year)
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
                                ff.select_list(:name, "optAnnualHouseholdIncomeId").set($inc_level)
                                #Entering the users Education status
                                ff.select_list(:name, "optEducationLevelId").set($education)
                                #Entering the users employment status
                                ff.select_list(:name, "optEmploymentStatusId").set($employment)
                                #Entering the users maritial status
                                ff.select_list(:name, "optMaritalStatusId").set($marrital_status)
                                ff.select_list(:name, "optEthnicityId").set($ethnicity)
                                #Entering the users Nationality
                                ff.select_list(:name, "optNationalityId").set($origin)
                                #Setting the radio button to N
                                ff.radio(:value, "N").set
                                #Setting the radio button to I do not have a preference in the maximum number of emails I receive each week.
                                #ff.radio(:value, "0").set
                                ff.button(:value, "NEXT").click
                                sleep 5
                                $st = '3'
								$test_description = "Survey not shown for non-matching member"
								$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
								$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                                sleep 45
                               if (ff.contains_text("US GETCOUNT SURVEY"))
									$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
									puts "FAIL"
							   else
									$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
									puts "PASS"
                               end
                               ff.goto('http://sm.p.surveyhead.com/index.php?mode=logout')
							   ff.goto('http://www.p.surveyhead.com/recaptcha_automation_proxy.php?mode=normal') # setting normal mode
                               ff.close
							   
							   #PROFILE CRITERIA
							   
							   $ie.link(:text, "Profile Criteria").click
                               sleep 2
                               $ie.select_list(:name, "optProfileId1").set($prof_nm)
                               sleep 3
                               $ie.select_list(:name, "optQuestionId1").set($quest)
                               sleep 3
                               $ie.select_list(:name, "optAnswerId1[]").set($ans)
                               $ie.button(:value,"Save Group").click
                               sleep 3
                               #$ie.checkbox(:id, "chkInfiniDBGetCount").clear
                               sleep 2
                               $ie.button(:value,"Get Count").click
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
                                $mem_count = $mem_count+1
								$ff= $obj.Focusline_login($mem_1,$mem_1)
								$ff.link(:text, "Profiles").click
								$ff.link(:text, /Casinos & Gambling/).click
								sleep 3
								$ff.radio(:index, "1").set
								$ff.button(:value,"Next").click
								$ff.link(:text, "Surveys").click
								$st = '4'
								$test_description = "Survey shown on dashboard for member matching profile criteria"
								$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
								$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
								sleep 35
								if ($ff.contains_text("US GETCOUNT SURVEY"))
									$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
									puts "PASS"
								else
									$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
									puts "FAIL"
								end
								
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
                                $st = '5'
								$test_description = "Member matching profile criteria comes in QG get count"
								$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
								$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                                
                                if($new_mem_count == $mem_count)
									puts "PRF GET COUNT PASS"
                                    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                else
                                    puts "PRF GET COUNT FAIL"
                                    $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                                end
								$ff.link(:text, "Profiles").click
								$ff.link(:text, /Casinos & Gambling/).click
								sleep 3
								$ff.radio(:index, "3").set
								$ff.button(:value,"Next").click
								$ff.link(:text, "Surveys").click
								$st = '6'
								$test_description = "Member not matching profile criteria is not shown the survey"
								$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
								$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
								if ($ff.contains_text("US GETOUNT SURVEY"))
									$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
									puts "FAIL"
								else
									$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
									puts "PASS"
								end
								$ff.goto('http://sm.p.surveyhead.com/index.php?mode=logout')
								sleep 2
								$ff.close
								$ie.link(:text,'Logout').click
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
		
		def test_03_qg_reset_prof_criteria
		
					begin	
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
						$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
						#$ie.text_field(:id, "txtSurveyName").set("AUTO TEST SURVEY")
						#$ie.button(:value,"Save Group").click
						$ie.link(:text, "Criteria").click
                        sleep 2
						#$ie.checkbox(:id, "chkUSGeoTarget").clear
						#$ie.button(:value,"Save Group").click
						$ie.link(:text, "Profile Criteria").click
						$ie.select_list(:name, "optProfileId1").set("--Select Profile--")
                        sleep 5
                        $ie.button(:value,"Save Group").click
                        sleep 3
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
		
		def test_04_us_getcnt_mempub
		
					begin
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
						$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
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
                        #$mem_count = $mem_count+1
						$ff = FireWatir::Firefox.new
						$ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
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
						  $ff.button(:value, "NEXT").click
						  sleep 5
						puts "**** Waiting for surveys to load ****"
						  sleep 45
						  $st = '7'
						  $test_description = "Survey not shown on dashboard when member pub options mismatch"
						  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						  if ($ff.contains_text("US GETCOUNT SURVEY"))
                                 
                                  $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                                  puts "FAIL"
								  
                          else
                                  $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                  puts "PASS"
                          end
						  
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
								$st = '8'
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
								
								$ff.goto('http://sm.p.surveyhead.com/index.php?mode=logout')
								sleep 2
								$ff.close  
								
								$ie.goto("http://p.usampadmin.com/list_members.php")
                                sleep 2
                                $ie.text_field(:name, "txtFirstName").set("AUTO FNAME")
                                $ie.text_field(:name,'txtEmail').set($mem_1)
                                  $ie.text_field(:name,'txtPassword').set($mem_1)
                                  $ie.select_list(:id, 'optPLSites').select("FocuslineSurveys")
                                  sleep 2
                                  $ie.button(:value,'Search').click
                                  sleep 5
                                  $ie.link(:text, /M[0-9]/).click
                                  $ie.link(:text, "Member Details").click
                                  $ie.radio(:name, "rdMemberAccountConfirmed", "Y").click
                                  $ie.button(:value,"Save Details").click
								  sleep 3
								  
								  $ff = $obj.Focusline_login($mem_1,$mem_1)
								  sleep 5
								  puts "Waiting for surveys to load..."
								  sleep 35
								$st = '9'
							  $test_description = "Survey shown on dashboard when member pub options match"
							  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
							  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
							  if ($ff.contains_text("US GETCOUNT SURVEY"))
									$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
									  puts "PASS" 
									
									  
							  else
									$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
									puts "FAIL"  
							  end
							  $ff.goto('http://sm.p.surveyhead.com/index.php?mode=logout')
							  sleep 2
							  $ff.close
							  
							  $mem_count = $mem_count+1
							  $ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
							  sleep 3
							  $ie.link(:text, "Criteria").click
							  sleep 2
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
								$st = '10'
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
							rescue => e
									puts e.message
									puts e.backtrace.inspect
									$obj.Close_all_windows
									$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
									$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
									$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
											
							end	
		end
		
		def test_05_qg_reset
					
				begin	
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
					$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
					$ie.text_field(:id, "txtSurveyName").set("AUTO TEST SURVEY")
					$ie.button(:value,"Save Group").click
					$ie.link(:text, "Criteria").click
                    sleep 2
					$ie.checkbox(:id, "chkUSGeoTarget").clear
					$ie.button(:value,"Save Group").click
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
				rescue => e
						puts e.message
						puts e.backtrace.inspect
						$obj.Close_all_windows
								
				end	
		
		end

		
end