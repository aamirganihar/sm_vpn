#TRADITIONAL PIXEL CASES 

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
require 'Input Repository\Test_14_Traditional_pixel_Input.rb'

class Test_14_Traditional_Pixel < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$mem_email_file_path_1 = $wd+"/Input Repository/MEM_1_EMAIL_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "14 - "
				$test_description = "Test Case: "+$t.to_s+"  TRADITIONAL PIXEL EXECUTION"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_pixel_set
			
			begin
			
				  $obj = Usamp_lib.new
				  $obj.Delete_cookies()
				  $ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				  $enc_pub_id = "PU#{$pub_id}"
				  $enc_pub_id = Base64.encode64($enc_pub_id)
				  $ie.goto("p.usampadmin.com/add_publisher.php?hdMode=accountinfo&publisher_id=#{$enc_pub_id}")
				  $ie.link(:text,"Redirects / Pixels").click
				  $ie.text_field(:name, "txtPixel").set($sc_pix_code)
				  $ie.text_field(:name, "txtFailPixel").set($fl_oq_pix_code)
				  $ie.text_field(:name, "txtRegPixel").set($reg_pix_code)
				  $ie.radio(:id, "radioPixelAfterSignup").set
				  $ie.text_field(:name, "txtProfilePixel").set($prof_pix_code)
				  $ie.button(:id,"btnSave").click
				  puts "*** PIXEL SETTINGS DONE  ***"
				  $ie.link(:text,"Logout").click
				  $ie.close
			rescue => e
				  puts e.message
				  puts e.backtrace.inspect
				  $obj.Close_all_windows
				  
			end	  
	  
	  end
	  
	  def test_03_registration
	  
							
							
			begin
			
				  $ff = FireWatir::Firefox.new
				  $ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
				  $ff.goto("p.surveyhead.com/registration_step1.php?P=#{$pub_id}&MID=#{$mid}&S=#{$s}&SP=#{$sp}")
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
				  $file1 = File.open($mem_email_file_path_1, 'w');
				  puts $mem_1
				  $file1.print $mem_1;
				  $file1.close;
				  puts "**** Waiting for surveys to load ****"
				  sleep 35
				  puts "*** Check Pixels ***"
				  sleep 10
				  $st = '1'
				  $test_description = "Traditional registration pixel execution"
				  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				  if ($ff.contains_text($mid) && $ff.contains_text($s) && $ff.contains_text($sp))
							$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				  else
							$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				  end
				  sleep 3
				  $ff.goto("p.surveyhead.com/index.php?mode=logout")
				  $ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
                  $ff.close
				  
				  		
			rescue => e
					
					puts e.message
					puts e.backtrace.inspect
								
			end
	  end
	  
	  def test_04_survey_complete
	  
			begin
			
				  $obj = Usamp_lib.new
				  $obj.Delete_cookies()
				  $file_1 = File.open($mem_email_file_path_1)
				  $em_id = $file_1.gets
				  puts $em_id
				  $file_1.close;
				  $ff = $obj.Surveyhead_login($em_id,$em_id)
				  sleep 20
				  $file_2 = File.open($qg_id_file_path)
				  $qg_id = $file_2.gets
				  puts $qg_id
				  $file_2.close;
				  $survey_link  = Base64.encode64($qg_id)
                  $survey_link = "link"+$survey_link
                  $survey_link = $survey_link.chomp
                  puts $survey_link
                  sleep 10
                  $ff.link(:id, $survey_link).click
                  sleep 2
                  $ff.button(:value,"START SURVEY").click
                  sleep 5
                  $ff1=FireWatir::Firefox.attach(:title,'TEST_AUTOMATION_SURVEY')
                  $ff1.goto($sc_red_url)
				  sleep 2
				  $st = '2'
				  $test_description = "Traditional survey success pixel execution"
				  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				  
				  if ($ff1.contains_text($pix_cpi) && $ff1.contains_text($qg_dsc) && $ff1.contains_text($pix_rew) && $ff1.contains_text($qg_id))
							$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				  else
							$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				  end
				  
                  $ff1.close
				  
				  $ff.goto("p.surveyhead.com/index.php?mode=logout")
				  $ff.close
				  
				  			  
				  
			rescue => e
					
					puts e.message
					puts e.backtrace.inspect
								
			end	  
				  
	  end
	  
	  def test_06_survey_fail
	  
		begin
		
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
				$ie.goto("http://p.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}=&quota_group_id=#{$qg_n}")
				$ie.frame(:name, "quota_group_publisher_iframe").link(:text,'GO').click
                sleep 10
                $ie1=Watir::IE.attach(:title,'TEST_AUTOMATION_SURVEY')
                $ie1.goto('http://p.u-samp.com/redirect.php?S=2')
                sleep 5
				$st = '3'
				$test_description = "Traditional survey fail pixel execution"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				if ($ie1.contains_text($qg_dsc) && $ie1.contains_text($qg_id))
				   	$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
				   	$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
				$ie1.close
                $ie=Watir::IE.attach(:title,'uSamp.com')
                sleep 2
				$ie.link(:text,'Logout').click
				$ie.close	
				
				
		
		rescue => e
				puts e.message
				puts e.backtrace.inspect	
				$obj.Close_all_windows
		
		end
	  
	  
	  end
	  
	  def test_07_prof_complete
	  
			begin
			
				  $obj = Usamp_lib.new
				  $obj.Delete_cookies()
				  $file_1 = File.open($mem_email_file_path_1)
				  $em_id = $file_1.gets
				  puts $em_id
				  $file_1.close;
				  $ff = $obj.Surveyhead_login($em_id,$em_id)
				  sleep 5
				  $enc_prof_id  = Base64.encode64($prof_id)
                  $prof_link = "p.surveyhead.com/profile.php?PrId=#{$enc_prof_id}&PrLId=Mg=="
                  puts $prof_link
                  sleep 2
                  $ff.goto($prof_link)
                  $ff.radio(:index, "1").set
				  $ff.button(:value,"Submit").click		
				  $st = '4'
				  $test_description = "Traditional profile pixel execution"
				  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				  
				  if ($ff.contains_text($pix_prof_dsc) && $ff.contains_text($pix_prof_rew) && $ff.contains_text($prof_id))
				  		$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				  else
							$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				  end
				  
				  $ff.goto("p.surveyhead.com/index.php?mode=logout")
				  $ff.close
				  
				  
				  
			rescue => e
				  puts e.message
				  puts e.backtrace.inspect
				  
			end	  
	  
	  end
	  
	    
	  def test_08_pixel_reset
	  
			begin
			
				  $obj = Usamp_lib.new
				  $obj.Delete_cookies()
				  $ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				  $enc_pub_id = "PU#{$pub_id}"
				  $enc_pub_id = Base64.encode64($enc_pub_id)
				  $ie.goto("p.usampadmin.com/add_publisher.php?hdMode=accountinfo&publisher_id=#{$enc_pub_id}")
				  $ie.link(:text,"Redirects / Pixels").click
				  $ie.text_field(:name, "txtPixel").set("")
				  $ie.text_field(:name, "txtFailPixel").set("")
				  $ie.text_field(:name, "txtRegPixel").set("")
				  $ie.radio(:id, "radioPixelAfterSignup").set
				  $ie.text_field(:name, "txtProfilePixel").set("")
				  $ie.button(:id,"btnSave").click
				  puts "*** PIXEL RESETTINGS DONE  ***"
				  $ie.link(:text,"Logout").click
				  $ie.close
			rescue => e
				  puts e.message
				  puts e.backtrace.inspect
				  $obj.Close_all_windows
				  
			end	  
	  
	  end

	  
	  
end