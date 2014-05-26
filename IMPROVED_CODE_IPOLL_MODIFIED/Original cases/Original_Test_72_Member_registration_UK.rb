# MEMBER REGISTRATION (SURVEYHEAD/FOCUSLINE)

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
require 'Input Repository\surveyurl.rb'
require 'Input Repository\Test_72_Member_registration_UK_Input.rb'

class Test_01_Project_QG_Create < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$mem_email_file_path_1 = $wd+"/Input Repository/MEM_1_EMAIL_ID.txt"
			$mem_email_file_path_2 = $wd+"/Input Repository/MEM_2_EMAIL_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "72 - "
				$test_description = "Test Case: "+$t.to_s+"  UK MEMBER REGISTRATION (SURVEYHEAD/FOCUSLINE)"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
  
	  def test_02_member_signup_SH
				
				$st = '1'
				$test_description = "Member Registration on Surveyhead"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
			
			begin
			
				$ff = FireWatir::Firefox.new
				  $ff.goto("p.ipoll.com/recaptcha_automation_proxy.php?mode=test")
				  $ff.goto("p.ipoll.com/registration_step1.php?P=#{$pub_id}&MID=#{$mid}&S=#{$s}&SP=#{$sp}")
				  $ff.text_field(:name, "txtFname").set("AUTO FNAME")
				  $ff.text_field(:name, "txtLname").set("AUTO LNAME")
                  $ff.select_list(:name, "optCountryId").set($country)
                  $ff.select_list(:name, "optLanguageId").set($lang)
                  sleep 7
                  #$ff.select_list(:name, "optStateId").set($state)
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
				  $ff.text_field(:id, "txtEmail").set($mail_address)
                  sleep 5
                  $ff.text_field(:name, "txtConfirmEmail").set($mail_address)
                  $ff.text_field(:id, "txtPassword").set($mail_address)
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
                  #$ff.select_list(:name, "optEthnicityId").set($ethnicity)
                  $ff.select_list(:name, "optNationalityId").set($origin)
                  $ff.radio(:value, "N").set
                  $ff.button(:value, "NEXT").click
                  sleep 5
				  $file1 = File.open($mem_email_file_path_1, 'w');
				  puts $mem_1
				  $file1.print $mem_1;
				  $file1.close;
				  puts "**** Waiting for surveys to load ****"
				  sleep 30
				  if ($ff.contains_text(/Logout/))
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				  else
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				  end
				  
				  $ff.goto("p.ipoll.com/index.php?mode=logout")
				  $ff.goto("p.ipoll.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
                  $ff.close
			
			
			rescue => e
					
					puts e.message
					puts e.backtrace.inspect
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"	
			
			end
	  end
	  
	  def test_03_member_in_admin_SH
	  
					$st = '2'
					$test_description = "Checking Member in Admin"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
	  
			begin
			
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
					#@pid = Process.create(
                    #:app_name  => 'ruby popup_closer_IE.rb',
                    #:creation_flags  => Process::DETACHED_PROCESS
                    #).process_id
                    #at_exit{ Process.kill(9,@pid) }
					
					$file_1 = File.open($mem_email_file_path_1)
					$mb_1_id = $file_1.gets
					puts $mb_1_id
					$file_1.close;
					
					
					$ie.goto("http://p.usampadmin.com/list_members.php")
					$ie.text_field(:name,'txtEmail').set($mb_1_id)
                    $ie.text_field(:name,'txtPassword').set($mb_1_id)
                    $ie.select_list(:id, 'optPLSites').select("iPoll")
                    sleep 2
                    $ie.button(:value,'Search').click
					sleep 5
					$mem_1_id = /M(\d+\d)/.match($ie.text)
					$mem_1_id = $mem_1_id.to_s
					$mem_1_id = $mem_1_id.chomp
					puts $mem_1_id
					$ie.link(:text,$mem_1_id).click
					if ($ie.contains_text($mem_1_id))
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
					else
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
					end	
					$ie.link(:text,"Logout").click
					$ie.close
				
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			
			end	  
	  
	  end
	  
	  def test_04_mail_SH
	  
				$st = '3'
				$test_description = "Registration Mail Delivery (SURVEYHEAD)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
			begin
				
				$file_1 = File.open($mem_email_file_path_1)
				$mbr_1_id = $file_1.gets
				puts $mbr_1_id
				$file_1.close;
				sleep 5
				$mbr_1_id = $mbr_1_id.slice(0..26)
        sleep 5
				$ff1 = FireWatir::Firefox.new
				$ff1.goto("http://www.mailinator.com/maildir.jsp?email=#{$mbr_1_id}")
				sleep 2
				if ($ff1.contains_text(/Confirm Your Surveyhead Account/))
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"	
				else
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	
				end
			    $ff1.close
			
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			
			end  
	  
       end
  
		def test_05_member_signup_Focusline
					
					$st = '4'
					$test_description = "Member Registration on Focusline"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				begin
				
					$ff = FireWatir::Firefox.new
					  $ff.goto("sm.p.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
					  $ff.goto("sm.p.surveyhead.com/registration_step1.php?P=#{$pub_id}&MID=#{$mid}&S=#{$s}&SP=#{$sp}")
					  $ff.text_field(:name, "txtFname").set("AUTO FNAME")
					  $ff.text_field(:name, "txtLname").set("AUTO LNAME")
					  $ff.select_list(:name, "optCountryId").set($country)
					  $ff.select_list(:name, "optLanguageId").set($lang)
					  #sleep 7
					  #$ff.select_list(:name, "optStateId").set($state)
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
					  $mem_2 = $mail_address
					  $ff.text_field(:id, "txtEmail").set($mail_address)
					  sleep 5
					  $ff.text_field(:name, "txtConfirmEmail").set($mail_address)
					  $ff.text_field(:id, "txtPassword").set($mail_address)
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
					  #$ff.select_list(:name, "optEthnicityId").set($ethnicity)
					  $ff.select_list(:name, "optNationalityId").set($origin)
					  $ff.radio(:value, "N").set
					  $ff.button(:value, "NEXT").click
					  sleep 5
					  $file1 = File.open($mem_email_file_path_2, 'w');
					  puts $mem_2
					  $file1.print $mem_2;
					  $file1.close;
					  puts "**** Waiting for surveys to load ****"
					  sleep 30
					  if ($ff.contains_text(/Logout/))
							$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
					  else
							$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
					  end
					  
					  $ff.goto("sm.p.surveyhead.com/index.php?mode=logout")
					  $ff.goto("sm.p.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
					  $ff.close
				
				
				rescue => e
						
						puts e.message
						puts e.backtrace.inspect
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"	
				
				end
		  end
		  
		    
	  

		  
		def test_06_member_in_admin_Focusline
	  
					$st = '5'
					$test_description = "Checking Focusline Member in Admin"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
	  
			begin
			
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
					#@pid = Process.create(
                    #:app_name  => 'ruby popup_closer_IE.rb',
                    #:creation_flags  => Process::DETACHED_PROCESS
                    #).process_id
                    #at_exit{ Process.kill(9,@pid) }
					
					$file_1 = File.open($mem_email_file_path_2)
					$mb_2_id = $file_1.gets
					puts $mb_2_id
					$file_1.close;
					
					
					$ie.goto("http://p.usampadmin.com/list_members.php")
					$ie.text_field(:name,'txtEmail').set($mb_2_id)
                    $ie.text_field(:name,'txtPassword').set($mb_2_id)
                    $ie.select_list(:id, 'optPLSites').select("iPoll")
                    sleep 2
                    $ie.button(:value,'Search').click
					sleep 5
					$mem_2_id = /M(\d+\d)/.match($ie.text)
					$mem_2_id = $mem_2_id.to_s
					$mem_2_id = $mem_2_id.chomp
					puts $mem_2_id
					$ie.link(:text,$mem_2_id).click
					if ($ie.contains_text($mem_2_id))
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
					else
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
					end	
					$ie.link(:text,"Logout").click      
					$ie.close
				
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			
			end	  
	  
	  end

		
		
		  def test_07_mail_Focusline
	  
				$st = '6'
				$test_description = "Registration Mail Delivery (FOCUSLINE)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
			begin
				
				$file_1 = File.open($mem_email_file_path_2)
				$mbr_2_id = $file_1.gets
				puts $mbr_2_id
				$file_1.close;
				sleep 5
				$mbr_2_id = $mbr_2_id.slice(0..26)
				sleep 5
				$ff1 = FireWatir::Firefox.new
				$ff1.goto("http://www.mailinator.com/maildir.jsp?email=#{$mbr_2_id}")
				sleep 3
        #puts $ff1.text
				if ($ff1.contains_text("Your FocuslineSurveys Account."))
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"	
				else
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	
				end
			    $ff1.close
			
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			
			end  
	  
       end
  
	  
	  
end