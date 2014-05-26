# PROFILE CRITERIA TEST & ACTIVE/INACTIVE CASES

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
require 'base64'
#require 'daemons'
require './Input Repository\surveyurl.rb'
require './Input Repository\Test_52_Profile_criteria_cases_Input.rb'




class Test_52_Profile_criteria_cases < Test::Unit::TestCase
  
				$wd=Dir.pwd
				$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
				$prof_name_path = $wd+"/Input Repository/Profile_Name.txt"
				$prof_id_path = $wd+"/Input Repository/Profile_ID.txt"
				$prof_2_name_path = $wd+"/Input Repository/Profile_2_Name.txt"
				$prof_2_id_path = $wd+"/Input Repository/Profile_2_ID.txt"
      
            
	def test_01_report_head
	  
				$t = "52 - "
				$test_description = "Test Case: "+$t.to_s+"  PROFILE CRITERIA TEST & ACTIVE/INACTIVE CASES"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	end
	
	def test_02_prof_create_add_questions
	
			begin	
				  $obj.Delete_cookies
				  #$obj.Close_all_windows
				  $ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				  
				  $ext = Time.new
				  $ext = $ext.to_s
				  $ext = $ext.slice(0..18)
				  $ext = $ext.gsub(/\s/, "_")
				  $ext = $ext.gsub(/:/, "")
				  
				  $prf_nm = "Test_Profile_2_"+$ext
				  $file1 = File.open($prof_2_name_path, 'w');
				  $file1.print $prf_nm;
				  puts $prf_nm
				  $file1.close;
				  
				  $ie.link(:text,"Profile Mgmt").click
				  sleep 5
				  $ie.link(:text,'Create New Profile').click
				  sleep 3
				  #$ie.goto("http://p.usampadmin.com/add_profile.php")
				  $ie.text_field(:name, "txtProfileName").set($prf_nm)
				  #Category name
				  #$ie.text_field(:name, "txtCategoryName").set($prf_cat)
				  #Reading value for profile reward from file. Currently set as 2 in the file
				  $ie.text_field(:name, "txtProfileReward").set($prf_rew)
				  #Reading value for Questions per page from file. Currently set as 2 in the file
				  $ie.text_field(:name, "txtProfileQuestionPerPage").set($qn_per_page)
				  #checking the checkbox for profile expiry
				  $ie.checkbox(:name, "chkSetProfileExpiry").set
				  sleep 2
				  
				 #	 @pid = Process.create(
				 # :app_name  => 'ruby popup_closer_IE.rb',
				 # :creation_flags  => Process::DETACHED_PROCESS
				 # ).process_id
					 
				 #at_exit{ Process.kill(9,@pid) }
				  #
				  #setting the profile expiry to 0
				  $ie.text_field(:name, "txtProfileExpiry").set($prof_exp)
				  sleep 3
				  $ie.button(:name, "Refine").click
				  sleep 2
				  $ie.radio(:name, "rdSelectCountry").set
				  #setting the lower age limit to 10 years
				  $ie.text_field(:name, "txtProfileLowerAge").set($age_min)
				  #setting the upper age limit to 90 years
				  $ie.text_field(:name, "strProfileUpperAge").set($age_max)
				  #setting the criteria to accept both male and female gender
				  $ie.radio(:value, "Both").set
				  #Setting Industry to Aerospace & Defense, Agribusiness, Airline
				  $ie.select_list(:name, "optIndustry[]").select($ind_opt1)
				  #Setting Ethnicity to African American, Asian (non Pacific Islander), Caucasian
				  $ie.select_list(:name, "optEthnicityId[]").select($ethnic)
				  #Setting role to Administration / Management, Construction / Maintenance / Real Estate, Executives
				  $ie.select_list(:name, "optRole[]").select($role)
				  #Setting Education Details to High school graduate, Some college or university, College graduate with a 4 year degree
				  $ie.select_list(:name, "optEducationLevels[]").select($edu)
				  #Setting employment details to Full-Time Employee, Homemaker, Part-Time Employee
				  $ie.select_list(:name, "optEmploymentStatus[]").select($employment)
				  #Setting maritial status to Never married, Married, Living with Partner
				  $ie.select_list(:name, "optMaritalStatus[]").select($marital)
				  $ie.button(:name, "Refine").click
				  
				  $file_1 = File.open($prof_name_path)
				  $prf_name = $file_1.gets
				  puts $prf_name
				  $file_1.close;
				  sleep 5
				  $ie.button(:value, "Next").click
				#$ie.button(:name, "Submit").click
				
				$st = '1'
				$test_description = "Add question from existing profile"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				sleep 2
				$ie.select_list(:id, "existing_profile").select($prf_name)
				sleep 5
				$ie.select_list(:id, "existing_question").select($exs_quest)
				sleep 2
				$ie.button(:value,"Add").click
				if($ie.html.include?('Question added successfully') && $ie.text.include?($exs_quest))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
				    puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
				#$ie.button(:value, "Add a New Question").click
				$ie.button(:name, "Submit").click
				#Adding a question text 
				$ie.text_field(:name, "strQuestion").set("TEST DROPDOWN??")
				$ie.text_field(:name, "strDisplayName").set("TEST DROPDOWN??")
				$ie.select_list(:name, "optType").select("Drop Down")
				$ie.text_field(:name, "strQuickLoad").set('A')
				$ie.button(:name, "btnQuickLoad").click
				#sleep 1
				$ie.text_field(:name, "strQuickLoad").set('B')
				$ie.button(:name, "btnQuickLoad").click
				#sleep 1
				$ie.text_field(:name, "strQuickLoad").set('C')
				$ie.button(:name, "btnQuickLoad").click
				#sleep 1
				$ie.text_field(:name, "strQuickLoad").set('D')
				$ie.button(:name, "btnQuickLoad").click
				#sleep 1
				$ie.button(:value, "Add").click
				sleep 4
				$ie.button(:value, "Add a New Question").click
				#Adding a question text
				sleep 5
				$ie.text_field(:name, "strQuestion").set("TEST CHECKBOX??")
				$ie.text_field(:name, "strDisplayName").set("TEST CHECKBOX??")
				#Selecting the answer type to be Check Boxes
				$ie.select_list(:name, "optType").select("Check Boxes")
				#Setting the answers
				$ie.text_field(:name,'strQuickLoad').set("1\n2\n3\n4")
				$ie.button(:name, "btnQuickLoad").click
				$temp = $ie.text_field(:name,"strQuickLoad").value      
			  
				$ie.button(:value, "Add").click
				sleep 4
				$ie.button(:value, "Add a New Question").click
				#Adding a question text 
				$ie.text_field(:name, "strQuestion").set("TEST INPUT FIELD??")
				$ie.text_field(:name, "strDisplayName").set("TEST INPUT FIELD??")
				$ie.select_list(:name, "optType").select("Input Field")
				$ie.button(:value, "Add").click
				sleep 4
				$ie.button(:value, "Add a New Question").click
				#Adding a question text 
				$ie.text_field(:name, "strQuestion").set("TEST OPENENDED?")
				$ie.text_field(:name, "strDisplayName").set("TEST OPENENDED?")
				$ie.select_list(:name, "optType").select("Open Ended")
				$ie.button(:value, "Add").click
				sleep 4
				$ie.link(:text, "Manage Questions").click
				#getting profile number
				sleep 5
				$Profile_no=/P\s(\d+)/.match($ie.text)
				$Profile_no[0].to_s()
				$Profile_no[0].chomp!
				$Profile_number=$Profile_no[0][2..5]
				  
				myfile = File.open($prof_2_id_path, 'w');
				myfile.print $Profile_number;
				myfile.close
				
				$ie.button(:value, "Language Options").click
				sleep 5
				$ie.text_field(:name, "txtLangProfileName").set($prf_nm+"-ENG")
				$ie.checkbox(:name, "chkCopyLang").set
				sleep 10
				$ie.button(:name, "Submit").click
				sleep 5
				$st = '2'
				$test_description = "Add profile critieria"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				$ie.button(:value,"Back").click
				$ie.button(:value,"Back").click

				$ie.select_list(:name, "optProfileId").select(/#{$prf_name}/)
				$ie.select_list(:id, "optProfileQuestionId").select(/#{$crit_quest}/)
				$ie.select_list(:id, "optAnswerId[]").select("MERC")
				sleep 2
				$ie.button(:value,"Add").click
				sleep 5
				if($ie.text.include?($crit_quest))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
				    puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end				
				$ie.button(:value,"Next").click
				
				$st = '3'
				$test_description = "Set SKIP-TO logic"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				sleep 3
				$ie.link(:text => /Q(\d)+/, :index => 3).click
				sleep 2
				$ie.button(:value,"Add New Option Row").click
				$ie.text_field(:id, "strValue5").set("5")
				$ie.link(:name => "setActionLink", :index => 5).click
				sleep 3
				$ie.select_list(:id, "setActionType").select("SKIP TO")
				$ie.radio(:index => 4).set
				sleep 3
				$ie.button(:value,"Save").click
				sleep 5
				$ie.button(:value,"Update").click
				sleep 3
				if($ie.html.include?('Question updated successfully'))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
				    puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.goto("http://p.usampadmin.com/login.php?hdMode=logout")
				sleep 2
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
	
	def test_03_mapping_profile
	
			begin	
				$file_1 = File.open($prof_2_name_path)
				$prf_nm = $file_1.gets
				puts $prf_nm
				$file_1.close;
			
				$file_2 = File.open($prof_2_id_path)
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
				$ie.goto($site_det_url)
				$ie.link(:text,"Profiles").click
				$ie.checkbox(:value,$prf_id).set
				$ie.button(:name,"Update").click
				$st = '4'
				$test_description = "Mapping Profile on site"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if $ie.html.include?('Profiles are added into site successfully') && $ie.checkbox(:value,$prf_id).set?
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
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
	
	def test_04_checking_on_pl
	
			begin	
				$file_1 = File.open($prof_name_path)
				$prf_nm = $file_1.gets
				puts $prf_nm
				$file_1.close;
			
				$file_2 = File.open($prof_id_path)
				$prf_id = $file_2.gets
				puts $prf_id
				$file_2.close;
				
				$file_3 = File.open($prof_2_name_path)
				$prf_2_nm = $file_3.gets
				puts $prf_2_nm
				$file_3.close;
			
				$file_4 = File.open($prof_2_id_path)
				$prf_2_id = $file_4.gets
				puts $prf_2_id
				$file_4.close;
				
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Focusline_login($m1_email,$m1_passwd)
				sleep 5
				$enc_prof_id  = Base64.encode64($prf_id)
				puts $enc_prof_id
				$ff.goto("http://sm.p.surveyhead.com/profiles.php")
				sleep 3
				$st = '5'
				$test_description = "Profile criteria mismatch"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff.text.include?($prf_2_nm))
						puts "FAIL"
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
						puts "PASS"
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
				$ff.goto("http://sm.p.surveyhead.com/profile.php?PrId=#{$enc_prof_id}&PrLId=Mg==")
				$ff.checkbox(:index => 3).set
				$ff.button(:name,"Next").click
				$ff.goto("http://sm.p.surveyhead.com/profiles.php")
				sleep 3
				$st = '6'
				$test_description = "Profile criteria match"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff.text.include?($prf_2_nm))
						puts "PASS"
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
						puts "FAIL"
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$enc_prof_2_id  = Base64.encode64($prf_2_id)
				puts $enc_prof_2_id
				$ff.goto("http://sm.p.surveyhead.com/profile.php?PrId=#{$enc_prof_2_id}&PrLId=Mg==")
				sleep 2
				$st = '7'
				$test_description = "Question from existing profile displayed on site"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff.text.include?($exs_quest))
						puts "PASS"
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
						puts "FAIL"
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.text_field(:id,'QN').set("Yes")
				$ff.button(:value,"Next").click
				$ff.select_list(:id,'QN').select("A")
				$ff.button(:value,"Next").click
				$ff.checkbox(:index, "4").set
				$ff.button(:value,"Next").click
				$st = '8'
				$test_description = "Checking SKIP-TO logic"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff.html.include?('TEST OPENENDED'))
						puts "PASS"
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
						puts "FAIL"
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("http://www.sm.p.surveyhead.com/index.php?mode=logout")
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
	
	def test_05_act_inact
				
			begin	
				$file_3 = File.open($prof_2_name_path)
				$prf_2_nm = $file_3.gets
				puts $prf_2_nm
				$file_3.close;
			
				$file_4 = File.open($prof_2_id_path)
				$prf_2_id = $file_4.gets
				puts $prf_2_id
				$file_4.close;
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies
				#$obj.Close_all_windows
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$enc_prof_2_id  = Base64.encode64($prf_2_id)
				puts $enc_prof_2_id
				$ie.goto("http://p.usampadmin.com/add_profile.php?intProfileId=#{$enc_prof_2_id}")
				$ie.radio(:value, "INACTIVE").click
				$ie.button(:value,"Update & Next").click
				$ff = $obj.Focusline_login($m1_email,$m1_passwd)
				sleep 5
				$ff.goto("http://sm.p.surveyhead.com/profiles.php")
				sleep 3
				$st = '9'
				$test_description = "Inactive profile not shown on site"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff.text.include?($prf_2_nm))
						puts "FAIL"
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
						puts "PASS"
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
				$ie.button(:value,"Back").click
				$ie.radio(:value, "ACTIVE").click
				$ie.button(:value,"Update & Next").click
				$st = '10'
				$test_description = "Active profile shown on site"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$ff.goto("http://sm.p.surveyhead.com/profiles.php")
				sleep 3
				if($ff.text.include?($prf_2_nm))
						puts "PASS"
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
						puts "FAIL"
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
				$ie.goto("http://p.usampadmin.com/list_questions.php?PrId=#{$enc_prof_2_id}")
				$ie.checkbox(:index => 2).set
				$ie.button(:value,"Make Selected Questions Inactive").click
				$st = '11'
				$test_description = "Question marked as inactive in admin"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.html.include?('TEST DROPDOWN'))
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
				$ff.goto("http://sm.p.surveyhead.com/profiles.php")
				sleep 3
				$ff.goto("http://sm.p.surveyhead.com/profile.php?PrId=#{$enc_prof_2_id}&PrLId=Mg==")
				sleep 2
				$st = '12'
				$test_description = "Inactive question not shown on site "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$ff.button(:value,"Next").click
				if($ff.html.include?('TEST DROPDOWN'))
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
				$ie.goto("http://p.usampadmin.com/list_questions.php?PrId=#{$enc_prof_2_id}")
				$ie.select_list(:id, "optStatus").select("Hidden Questions")
				sleep 2
				$ie.checkbox(:index => 1).set
				$ie.button(:value,"Make Selected Questions Active").click
				sleep 2
				$ie.select_list(:id, "optStatus").select("Active Questions")
				$st = '13'
				$test_description = "Question marked as active in admin"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.html.include?('TEST DROPDOWN'))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("http://sm.p.surveyhead.com/profiles.php")
				sleep 3
				$ff.goto("http://sm.p.surveyhead.com/profile.php?PrId=#{$enc_prof_2_id}&PrLId=Mg==")
				sleep 2
				$ff.button(:value,"Next").click
				sleep 2
				$ff.button(:value,"Next").click
				sleep 2
				$ff.button(:value,"Next").click
				sleep 2
				$st = '14'
				$test_description = "Active question shown on site "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				#$ff.button(:value,"Next").click
				if($ff.html.include?('TEST DROPDOWN'))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
				$ff.goto("http://sm.p.surveyhead.com/profiles.php")
				sleep 3
				$file_2 = File.open($prof_id_path)
				$prf_id = $file_2.gets
				puts $prf_id
				$file_2.close;
				$enc_prof_id  = Base64.encode64($prf_id)
				puts $enc_prof_id
				
				
				$ff.goto("http://sm.p.surveyhead.com/profile.php?PrId=#{$enc_prof_id}&PrLId=Mg==")
				sleep 2
				$ff.checkbox(:index => 3).clear
				$ff.button(:value,"Next").click
				sleep 2
				$ff.goto("http://www.sm.p.surveyhead.com/index.php?mode=logout")
				$ff.close
				$ie.goto("http://p.usampadmin.com/login.php?hdMode=logout")
				sleep 2
				$ie.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
				$ie.close
				$ff.close
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end	
	end
	
end