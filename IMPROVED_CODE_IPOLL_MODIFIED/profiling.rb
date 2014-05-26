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
require 'Input Repository\Test_05_Member_registration_Input.rb'
require 'Input Repository\Test_25_Profile_answering_Input.rb'
require 'Input Repository\Test_06_Survey_complete_Input.rb'
require 'Input Repository\surveyurl.rb'

class Test_01_Project_QG_Create < Test::Unit::TestCase
  $wd=Dir.pwd
  $proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
  $qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
  $mem_email_file_path_1 = $wd+"/Input Repository/MEM_1_EMAIL_ID.txt"
  $mem_email_file_path_2 = $wd+"/Input Repository/MEM_2_EMAIL_ID.txt"
  $prof_name_path = $wd+"/Input Repository/Profile_Name.txt"
  $prof_id_path = $wd+"/Input Repository/Profile_ID.txt"
  $out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"

  def test_01_report_head
    $t = "5 - "
    $test_description = "Test Case: "+$t.to_s+"  MEMBER REGISTRATION (SURVEYHEAD/FOCUSLINE)"
    $obj = Usamp_lib.new
    $obj.Test_report($test_description)
  end

  def test_02_member_signup_SH
    $st = '1'
    $test_description = "Member Registration on ipoll"
    $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
    $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
		begin
    $ff = FireWatir::Firefox.new
    $ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
    $ff.goto("http://www.p.ipoll.com/index.php")
    $ff.goto("http://www.p.ipoll.com/registration_step1.php?P=#{$pub_id}&MID=#{$mid}&S=#{$s}&SP=#{$sp}")
    $ff.text_field(:name, "txtFname").set("AUTO FNAME")
    $ff.text_field(:name, "txtLname").set("AUTO LNAME")
    $ff.select_list(:name, "optLanguageId").set($lang)
    #$ff.select_list(:name, "optNonUSDayId").set($day)
    $ff.select_list(:name, "optDayId").set($day)
    #$ff.select_list(:name, "optNonUSMonthId").set($month)
    $ff.select_list(:name, "optMonthId").set($month)
    #$ff.select_list(:name, "optNonUSYearId").set($year)
    $ff.select_list(:name, "optYearId").set($year)
    $ff.radio(:value, "Male").set
    $ff.select_list(:name, "optCountryId").set($country)
    sleep 4
    $ff.select_list(:name, "optStateId").set($state)
    $ff.text_field(:name, "txtZipPostal").set($zip_match)
    sleep 3
    $extension = Time.new
    $extension = $extension.to_s
    $extension = $extension.slice(0..16)
    $mail_address="auto_test22.desnew"+$extension+"@mailinator.com"
    $mail_address = $mail_address.gsub(/:/, "")
    $mail_address = $mail_address.gsub(/\s/, "")
    $mem_1 = $mail_address
    sleep 3
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
    $ff.select_list(:name, "optEthnicityId").set($ethnicity)
    $ff.select_list(:name, "optNationalityId").set($origin)
    $ff.radio(:value, "N").set
    $ff.button(:value, "NEXT").click
    sleep 10
    $file1 = File.open($mem_email_file_path_1, 'w');
    puts $mem_1
    $file1.print $mem_1;
    $file1.close;
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
  		rescue => e
    puts e.message
    puts e.backtrace.inspect
    $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
    $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
    $myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"	
  end
end


	def test_03_survey_taking
	$st = '1'
				$test_description = "Dashboard Survey Complete"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
	  
			begin
			
				  $obj = Usamp_lib.new
				  $obj.Delete_cookies()
				  $file_1 = File.open($mem_email_file_path_1)
				  $em_id = $file_1.gets
				  puts $em_id
				  $file_1.close;
				  #$ff = $obj.Surveyhead_login($em_id,$em_id)
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
                  sleep 5
                  $ff.button(:value,"START SURVEY").click
                  sleep 10
                  $ff1 = FireWatir::Firefox.attach(:title,'Survey')
                  $ff1.goto($sc_red_url)
				  sleep 2
				  if($ff1.contains_text(/Congratulations, you've just completed the survey/))
							$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				  else
							$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				  end
				  
          $ff1.close
          
        $ff.goto("https://www.p.ipoll.com/profile.php?PrId=MTEwMQ==&PrLId=Mg==")
				$ff.radio(:index, 1).set
				$ff.radio(:index, 4).set
        $ff.button(:name,"Next").click
        $ff.radio(:index, 2).set
        sleep 5
				$ff.radio(:index, 3).set
        sleep 5
				$ff.radio(:index, 5).set
        sleep 5
        $ff.text_field(:index,1).set("Test")
        $ff.button(:name,"Submit").click
        
          $ff.goto("https://www.p.ipoll.com/my_rewards.php")
          sleep 2
				  $ff.goto("https://www.p.ipoll.com/my_account.php")
          $ff.text_field(:name,"txtZipPostal").set("90002")
          $ff.button(:name,"btnSubmit").click
          
				  $ff.goto("p.ipoll.com/index.php?mode=logout")
				  $ff.close
				  
			rescue => e
				  puts e.message
				  puts e.backtrace.inspect
				  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				  $myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
				  
			end
	end
=begin
		  def test_04_mapping_profile
				
			begin	
				$file_1 = File.open($prof_name_path)
				$prf_nm = $file_1.gets
				puts $prf_nm
				$file_1.close;
			
				$file_2 = File.open($prof_id_path)
				$prf_id = $file_2.gets
				puts $prf_id
				$file_2.close;
				
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$enc_site_id = Base64.encode64($site_id)
                $enc_site_id = $enc_site_id.chomp
                $site_det_url = "http://p.usampadmin.com/add_site.php?site_id=#{$enc_site_id}"
                $site_det_url=$site_det_url.chomp
				$ie.goto("http://p.usampadmin.com/add_site_profiles.php?site_id=MA==")
				$ie.link(:text,"Profiles").click
				$ie.checkbox(:value,$prf_id).set
				$ie.button(:name,"Update").click
				$st = '1'
				$test_description = "Mapping Profile on site"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
        sleep 3
				if ($ie.contains_text('Profiles are added into site successfully') && $ie.checkbox(:value,$prf_id).isSet?)
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
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
	  
=begin
	  def test_05_answer_profile
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Focusline_login($m1_email,$m1_passwd)
				sleep 5
				$enc_prof_id  = Base64.encode64($prf_id)
				puts $enc_prof_id
				$ff.goto("https://www.p.ipoll.com/profile.php?PrId=MTEwMQ==&PrLId=Mg==")
				$ff.radio(:index, 1).set
				$ff.radio(:index, 4).set
        $ff.button(:name,"Next").click
        $ff.radio(:index, 1).set
				$ff.radio(:index, 3).set
				$ff.radio(:index, 5).set
        $ff.text_field(:index,1).set("Test")
        $ff.button(:name,"Submit").click
				
				$st = '2'
				$test_description = "Answering Profile"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				if $ff.contains_text(/Thank you for your participation/) 
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("http://www.sm.p.surveyhead.com/index.php?mode=logout")
				$ff.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				$obj.Close_all_windows
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
				
      end
=end
	  
end