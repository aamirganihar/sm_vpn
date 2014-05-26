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

class Test_01_Project_QG_Create < Test::Unit::TestCase
  $wd=Dir.pwd
  $proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
  $qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
  $mem_email_file_path_1 = $wd+"/Input Repository/MEM_1_EMAIL_ID.txt"
  $mem_email_file_path_2 = $wd+"/Input Repository/MEM_2_EMAIL_ID.txt"
  $out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
  def test_01_report_head
    $t = "5 - "
    $test_description = "Test Case: "+$t.to_s+"  MEMBER REGISTRATION (SURVEYHEAD/FOCUSLINE)"
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
    $ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
    $ff.goto("p.surveyhead.com/registration_step1.php?P=1774")
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
  #puts $ff.text
  if ($ff.contains_text(/Logout/))
    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
    puts "pass"
    else
      $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      puts "fail"
    end
    $ff.goto("p.surveyhead.com/index.php?mode=logout")
    $ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
    $ff.close
		rescue => e
    puts e.message
    puts e.backtrace.inspect
    $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
    $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
    $myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"	
  end
end

	  
  def test_03_member_signup_SH
    $st = '1'
    $test_description = "Member Registration on Surveyhead"
    $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
    $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
		begin
    $ff = FireWatir::Firefox.new
    $ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
    $ff.goto("p.surveyhead.com/registration_step1.php?P=1774")
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
  #puts $ff.text
  if ($ff.contains_text(/Logout/))
    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
    puts "pass"
    else
      $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      puts "fail"
    end
    $ff.goto("p.surveyhead.com/index.php?mode=logout")
    $ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
    $ff.close
		rescue => e
    puts e.message
    puts e.backtrace.inspect
    $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
    $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
    $myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"	
  end
end

  def test_04_member_signup_SH
    $st = '1'
    $test_description = "Member Registration on Surveyhead"
    $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
    $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
		begin
    $ff = FireWatir::Firefox.new
    $ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
    $ff.goto("p.surveyhead.com/registration_step1.php?P=1774")
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
  #puts $ff.text
  if ($ff.contains_text(/Logout/))
    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
    puts "pass"
    else
      $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      puts "fail"
    end
    $ff.goto("p.surveyhead.com/index.php?mode=logout")
    $ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
    $ff.close
		rescue => e
    puts e.message
    puts e.backtrace.inspect
    $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
    $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
    $myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"	
  end
end


  def test_05_member_signup_SH
    $st = '1'
    $test_description = "Member Registration on Surveyhead"
    $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
    $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
		begin
    $ff = FireWatir::Firefox.new
    $ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=test")
    $ff.goto("p.surveyhead.com/registration_step1.php?P=1774")
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
  #puts $ff.text
  if ($ff.contains_text(/Logout/))
    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
    puts "pass"
    else
      $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      puts "fail"
    end
    $ff.goto("p.surveyhead.com/index.php?mode=logout")
    $ff.goto("p.surveyhead.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
    $ff.close
		rescue => e
    puts e.message
    puts e.backtrace.inspect
    $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
    $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
    $myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"	
  end
end

	  
	  
end