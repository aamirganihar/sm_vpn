#TRADITIONAL PIXEL CASES 

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
require './Input Repository\Test_14_Traditional_pixel_Input.rb'
require './Input Repository\surveyurl.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

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
				  $ie.goto("q.usampadmin.com/add_publisher.php?hdMode=accountinfo&publisher_id=#{$enc_pub_id}")
				  $ie.link(:text,"Redirects / Pixels").click
				  sleep 5
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
				  #$obj.Close_all_windows
				  $ie.close
				  
			end	  
	  
	  end
	  
	  def test_03_registration
	  
							
							
			begin
			      
				  #$ff = FireWatir::Firefox.new
				   driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                  $ff = Watir::Browser.new driver
				  $ff.goto("q.ipoll.com/recaptcha_automation_proxy.php?mode=test")
				  $ff.goto("q.ipoll.com/registration_step1.php?P=#{$pub_id}&MID=#{$mid}&S=#{$s}&SP=#{$sp}")
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
                  $mail_address="auto_test.des"+$extension+"@mailop.com"
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
				  $ff.select_list(:name, "optAnnualHouseholdIncomeId").select($inc_level)
                  $ff.select_list(:name, "optEducationLevelId").select($education)
                  $ff.select_list(:name, "optEmploymentStatusId").select($employment)
                  $ff.select_list(:name, "optMaritalStatusId").select($marrital_status)
                  $ff.select_list(:name, "optEthnicityId").select($ethnicity)
                  $ff.select_list(:name, "optNationalityId").select($origin)
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
				  sleep 5
				  if ($ff.html.include?($mid) && $ff.html.include?($s) && $ff.html.include?($sp))
							$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				  else
							$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				  end
				  sleep 3
				  $ff.goto("q.ipoll.com/index.php?mode=logout")
				  $ff.goto("q.ipoll.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
                  $ff.close
				  
				  		
			rescue => e
					
					puts e.message
					puts e.backtrace.inspect
					$ff.close
								
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
				  sleep 5
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
				   #driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                 #$ff1 = Watir::Browser.new driver
				 $ff.window(:title,'Survey').use do
                  #$ff1=FireWatir::Firefox.attach(:title,'Survey')
                  $ff.goto($sc_red_url)
				  sleep 2
				  $st = '2'
				  $test_description = "Traditional survey success pixel execution"
				  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				  
				  if ($ff.html.include?($pix_cpi) && $ff.html.include?($qg_dsc) && $ff.html.include?($pix_rew) && $ff.html.include?($qg_id))
							$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				  else
							$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				  end
				  
                  #$ff1.close
				  end
				  $ff.goto("p.ipoll.com/index.php?mode=logout")
				  $ff.close
				  
				  			  
				  
			rescue => e
					
					puts e.message
					puts e.backtrace.inspect
				    $ie.close
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
				$ie.goto("http://q.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}=&quota_group_id=#{$qg_n}")
				$ie.frame(:name, "quota_group_publisher_iframe").link(:text,'GO').click
                sleep 10
				 #driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                 #$ie1 = Watir::Browser.new driver
				 $ie.window(:title,'Survey').use do
               # $ie1=Watir::IE.attach(:title,'Survey')
                $ie.goto('http://q.u-samp.com/redirect.php?S=2')
                sleep 5
				$st = '3'
				$test_description = "Traditional survey fail pixel execution"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				sleep 5
				if ($ie.html.include?($qg_dsc) && $ie.html.include?($qg_id))
				   	$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
				   	$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
				#$ie1.close
				end
				 #$ie.window(:title,'Survey').use do
                #$ie=Watir::IE.attach(:title,'uSamp.com')
                sleep 2
				$ie.link(:text,'Logout').click
				$ie.close	
				
				
		
		rescue => e
				puts e.message
				puts e.backtrace.inspect	
				#$obj.Close_all_windows
				$ie.close
		
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
                  $prof_link = "https://www.q.ipoll.com/profile.php?PrId=81e6ffeed42b6a37c045da4d35fa7943&PrLId=b656998ee46e68cc2b18f7a1f82eec4f"
                  puts $prof_link
                  sleep 2
                  $ff.goto($prof_link)
                  $ff.radio(:index, 1).set
				  $ff.button(:value,"Submit").click		
				  $st = '4'
				  $test_description = "Traditional profile pixel execution"
				  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				  sleep 5
				  if ($ff.html.include?($pix_prof_dsc) && $ff.html.include?($pix_prof_rew) && $ff.html.include?($prof_id))
				  		$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				  else
							$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				  end
				  
				  $ff.goto("q.ipoll.com/index.php?mode=logout")
				  $ff.close
				  
				  
				  
			rescue => e
				  puts e.message
				  puts e.backtrace.inspect
				  $ff.close
				  
			end	  
	  
	  end
	  
	    
	  def test_08_pixel_reset
	  
			begin
			
				  $obj = Usamp_lib.new
				  $obj.Delete_cookies()
				  $ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				  $enc_pub_id = "PU#{$pub_id}"
				  $enc_pub_id = Base64.encode64($enc_pub_id)
				  $ie.goto("q.usampadmin.com/add_publisher.php?hdMode=accountinfo&publisher_id=#{$enc_pub_id}")
				  $ie.link(:text,"Redirects / Pixels").click
				  sleep 5
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
				  #$obj.Close_all_windows
				  $ie.close
				  
			end	  
	  
	  end

	  
	  
end