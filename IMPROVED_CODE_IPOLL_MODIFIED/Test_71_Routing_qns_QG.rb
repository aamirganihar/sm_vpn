# ROUTING QUESTION CASES 

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
require './Input Repository\Test_71_Routing_qns_QG_Input.rb'
#require 'Pop_up_kill.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"


class Test_71_Routing_qns_QG < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_2_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_2_ID.txt"
			#$qg_id_file_path_2 = $wd+"/Input Repository/Copied_QG_2_ID.txt"
			#$mem_email_file_path_1 = $wd+"/Input Repository/CPI_MEM_1_EMAIL_ID.txt"
			#$token1_path = $wd+"/Config Management/PR_INV_TOKEN_1.txt"
			#$token2_path = $wd+"/Config Management/PR_INV_TOKEN_2.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "71 - "
				$test_description = "Test Case: "+$t.to_s+" ROUTING QUESTIONS CASES "
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
				
	  end
	  
	  def test_02_set_routing_qn
	  
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
					
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 8
				$ie.radio(:id, "rdRoutingQuestion_Select").set
				sleep 3
				$ie.select_list(:id, "optProfile").select($prf)
				sleep 2
				$ie.image(:src => /add.gif/).click
				sleep 5
				$ie.checkbox(:value, $ans_id).set
				$ie.checkbox(:value, $ans_id).fire_event("onchange")
				sleep 2
				$ie.button(:value,"Save Group").click
				$st = '1'
				$test_description = "Saving routing question for QG "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.html.include?('Q4099') && $ie.checkbox(:value, "59546").set?)
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
  
	  def test_03_survey_on_dashboard_existing_member
				
			begin	
				$st = '2'
				$test_description = "Survey shown for already qualified existing member"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Surveyhead_login($mem_email,$mem_passwd)
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
				if($ff.text.include?($qg_id))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$st = '3'
				$test_description = "Survey complete (qualified existing member) "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$ff.link(:id, $survey_link).click
                sleep 5
                $ff.button(:value,"START SURVEY").click
                sleep 10
				$ff.window(:title,"Survey").use do
                #$ff = FireWatir::Firefox.attach(:title,'Survey')
				$url = $ff.url
                $ff.goto($sc_red_url)
				sleep 2
				if($ff.html.include?("Congratulations, you've just completed the survey"))
					puts "Pass"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "Fail"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				#$ff1.close
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
  
	  def test_04_survey_on_dashboard_new_member
				
			begin	
				#$ff = FireWatir::Firefox.new
				@driver = Selenium::WebDriver::Firefox::Profile.from_name "default"
				@driver.assume_untrusted_certificate_issuer=false
				@driver.secure_ssl = true
				$ff = Watir::Browser.new :firefox, :profile => @driver
				$ff.goto("q.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
				$pb_id = $pub_id.slice(2..5)
				puts $pb_id
				$ff.goto("q.u-samp.com/registration_step1.php?P=#{$pb_id}")
        if ($ff.text.include?('Logout'))
          $ff.goto("http://www.q.ipoll.com/index.php?mode=logout")
          $ff.goto("q.u-samp.com/registration_step1.php?P=#{$pb_id}")
        end
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
                $ff.button(:value, "NEXT").click
                sleep 5
				sleep 12
    puts "**** Waiting for surveys to load ****"
    if($ff.link(:id,"sb-nav-close").exists?)
      $ff.link(:id,"sb-nav-close").click
    end
    sleep 5
    timeout = 45
    start_time = Time.now
    if($ff.div(:id=>"loadingSurveys").exists?)
      while $ff.div(:id=>"loadingSurveys").visible? do
      sleep 0.5
      puts "waiting for surveys to load"
      if Time.now - start_time> timeout    
        raise RuntimeError, "Timed out after #{timeout} seconds"   
      end
    end
  end
  sleep 5
				#sleep 35
				$st = '4'
				$test_description = "Register a new member "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ff.html.include?('Logout'))
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
					puts "Reg:Pass"
				else
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
					puts "Reg:Fail"
				end
				$enc_prof_id  = Base64.encode64($prof_id)
				$ff.goto("http://www.q.ipoll.com/profile.php?PrId=#{$enc_prof_id}&PrLId=Mg==")
				puts "http://www.q.ipoll.com/profile.php?PrId=#{$enc_prof_id}&PrLId=Mg=="
				sleep 2
				$ff.radio(:index => 1).set
				$ff.button(:name,"Next").click
				sleep 2
				$ff.link(:text, "BACK TO DASHBOARD").click
				sleep 25
				$st = '5'
				$test_description = "Survey shown for new member"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				$survey_link  = Base64.encode64($qg_id)
                $survey_link = "link"+$survey_link
                $survey_link = $survey_link.chomp
                puts $survey_link
                sleep 10
				if($ff.text.include?($qg_id))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$st = '6'
				$test_description = "Survey complete (new member) "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$ff.link(:id, $survey_link).click
                sleep 5
                $ff.button(:value,"START SURVEY").click
                sleep 10
				$ff.window(:title,"Survey").use do
                #$ff1 = FireWatir::Firefox.attach(:title,'Survey')
				$url = $ff.url
                $ff.goto($sc_red_url)
				sleep 2
				if($ff.text.include?("Congratulations, you've just completed the survey"))
					puts "Pass"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "Fail"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				#$ff1.close
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
	  
	  def test_05_remove_routing_qn
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				#callPopupKillerIE()
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
				sleep 2
				$ie.button(:value,"Remove Question").click
				$ie.button(:value,"Save Group").click
				$st = '7'
				$test_description = "Removing routing question setting "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.html.include?('Q4099') && $ie.checkbox(:value, "59546").set?)
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
				  $ff.close
				  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				  $myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end	
	  end
	  
end