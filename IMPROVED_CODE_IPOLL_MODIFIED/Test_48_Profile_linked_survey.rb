# PROFILE LINKED SURVEY

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
require './Input Repository\Test_48_Profile_linked_survey_Input.rb'

class Test_48_Profile_linked_survey < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$prof_name_path = $wd+"/Input Repository/Profile_Name.txt"
			$prof_id_path = $wd+"/Input Repository/Profile_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "48 - "
				$test_description = "Test Case: "+$t.to_s+"  PROFILE LINKED SURVEY"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_mapping_profile
				
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
				$site_det_url = "http://q.usampadmin.com/add_site.php?site_id=#{$enc_site_id}"
				$site_det_url=$site_det_url.chomp
				$ie.goto($site_det_url)
				$ie.link(:text,"Profiles").click
				$ie.checkbox(:value,$prf_id).set
				$ie.button(:name,"Update").click
				$st = '1'
				$test_description = "Mapping Profile on site"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if $ie.text.include?('Profiles are added into site successfully') && $ie.checkbox(:value,$prf_id).set?
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
	  
	  def test_03_setting_profile_link
				
			begin	
				$st = "2"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Setting profile link at QG level "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
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
				
				$file_3 = File.open($prof_name_path)
				$prf_nm = $file_3.gets
				puts $prf_nm
				$file_3.close;
					
				$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
				
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$ie.select_list(:name, "optQuotaStatus").select("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.radio(:id, "rdSurveyURLType3").set
				$ie.select_list(:id, "optProfileLinkId").select($prf_nm)
				$ie.button(:value,"Save Group").click
				
				if($ie.radio(:id, "rdSurveyURLType3").set?)
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.goto("q.usampadmin.com/add_quota_group_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 6
=begin		 $ie.select_list(:name, "optEthnicity[]").clear
                $ie.select_list(:name, "optIncomeLevels[]").clear
                $ie.select_list(:name, "optNationalityId[]").clear
                $ie.select_list(:name, "optEducationLevels[]").clear
			 $ie.button(:value,"Save Group").click 
			 sleep 
=end        
        
        
				$ie.select_list(:name, "optEducationLevels[]").select "High school graduate"
				$ie.select_list(:name, "optEthnicity[]").select "African American"
				$ie.select_list(:name, "optNationalityId[]").select "Mayotte"
				$ie.select_list(:name, "optIncomeLevels[]").select "Prefer not to answer"
				$ie.button(:value, "Save Group").click         
				$ie.link(:text,'Logout').click
				$obj.Delete_cookies
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
	  
	  def test_04_complete_survey
				
			begin	
				$st = '3'
				$test_description = "Profile linked Survey Complete"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				$ff = $obj.Surveyhead_login($SH_email,$SH_passwd)
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
				sleep 10
				$ff.checkbox(:index => 1).set(false)
				$ff.checkbox(:index => 2).set
				$ff.checkbox(:index => 3).set(false)
				$ff.checkbox(:index => 4).set(false)
				  
				$ff.select_list(:index => 1).select("July")
				$ff.select_list(:index => 2).select("04")
				$ff.select_list(:index => 3).select("1985")
				$ff.button(:name,"Next").click
				  
				$ff.select_list(:index => 1).select("FRENCH")
				  
				$ff.radio(:index => 1).set
				$ff.radio(:index => 5).set
				$ff.radio(:index => 9).set
				  
				$ff.button(:name,"Next").click
				  
				$ff.text_field(:index => 1).set("YES")
				$ff.text_field(:index => 2).set("By Train")
				  
				$ff.button(:name,"Next").click
				$ff.radio(:index => 1).set
				$ff.select_list(:index => 1).select("Vista Irrigation District")
				$ff.button(:name,"Next").click
				  
				$ff.select_list(:index => 1).select("Alameda Hospital")
				$ff.select_list(:index => 2).select("Pacific Gas & Electric")
				  
				$ff.button(:name,"Next").click
				$ff.select_list(:index => 1).select("SAN DIEGO GAS & ELECTRIC")
				  
				$ff.button(:name,"Submit").click
				if $ff.html.include?('Thank you for your participation') 
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("http://s.pl1.ipoll.com/index.php?mode=logout")
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
	  
	  def test_05_revert_QG_settings
				
			begin	
				$st = '4'
				$test_description = "Reverting QG settings"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
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
				$ie.radio(:id, "rdSurveyURLType1").set
				$ie.text_field(:id, "txtSurveyURL").set("http://www.instant.ly/s/gxZWu")
				$ie.button(:value,"Save Group").click
				if($ie.radio(:id, "rdSurveyURLType1").set?)
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
				$ie.goto("q.usampadmin.com/add_quota_group_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 6
				$ie.select_list(:name, "optEthnicity[]").select("Native American, Eskimo, Aleutian")
				$ie.select_list(:name, "optIncomeLevels[]").select("Prefer not to answer")
				$ie.select_list(:name, "optNationalityId[]").select("Mayotte")
				$ie.select_list(:name, "optEducationLevels[]").select("Advanced degree")
				$ie.button(:value,"Save Group").click 
				sleep 3
				
				$ie.link(:text,'Logout').click
				$obj.Delete_cookies
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