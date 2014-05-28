# CONFIRMIT CODE/URL RECONTACT CASES

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
require 'Input Repository\Test_59_Confirmit_code_url_recontact_Input.rb'

class Test_59_Confirmit_code_url_recontact < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/Copied_QG_ID.txt"
			$qg_id_file_path_2 = $wd+"/Input Repository/Copied_QG_ID_2.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
			$recontact_code_fl_path = $wd+"/Config Management/CODE_TOKEN_1.csv"
			$token1_path = $wd+"/Config Management/TOKEN_1.txt"
			$recontact_url_fl_path = $wd+"/Config Management/CODE_URL_1.csv"
			$token2_path = $wd+"/Config Management/TOKEN_2.txt"
			
			
      def test_01_report_head
	  
				$t = '59 - '
				$test_description = "Test Case: "+$t.to_s+"  CONFIRMIT CODE/URL RECONTACT STUDY CASES"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_copy_qg_change_reward
	  
			begin
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
					
					@pid = Process.create(
                                        :app_name  => 'ruby popup_closer_IE.rb',
                                        :creation_flags  => Process::DETACHED_PROCESS
                                        ).process_id
                                     at_exit{ Process.kill(9,@pid) }
									 
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
					$ie.link(:text,"Copy Selected Quota Group").click
					sleep 3
					
					if($ie.contains_text(/Quota Group details has been copied successfully/))
							puts "QG COPIED"
					else
							puts "QG COPY FAILED"
					end
					
					$date=Time.now.strftime("%Y-%m-%d")
					$SECONDS_PER_DAY = 60 * 60 * 24
					$date_added_1=(Time.now + 10*$SECONDS_PER_DAY).localtime.strftime("%Y-%m-%d") 
					puts $date_added_1
					
					$ie.select_list(:name, "optQuotaStatus").set("Open")
					$ie.text_field(:name , 'txtQuotaCloseDate').value = $date_added_1
					$file1 = File.open($qg_id_file_path_2, 'w');
					$qg_id_2= /GROUP DETAILS: QG(\d+)/.match($ie.text)
					$qg_id_2= $qg_id_2.to_s
					$length=$qg_id_2.length
					$qg_id_2=$qg_id_2.slice(17..$length)
					puts $qg_id_2
					$file1.print $qg_id_2;
					$file1.close;
					
					$qg_n2 = Base64.encode64($qg_id_2)		
					$ie.button(:name,"btnSave").click
					sleep 2
					$ie.checkbox(:id, "chkShowSurvey").set
				    $ie.text_field(:id, "txtSurveyName").set("CONFIRMIT RECON SURVEY")
					$ie.button(:name,"btnSave").click
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
	  
	  def test_03_confirmit_code__recon_qg_set
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$file_1 = File.open($proj_id_file_path)
				$prj_id = $file_1.gets
				puts $prj_id
				$file_1.close;
			
				$file_2 = File.open($qg_id_file_path_2)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
					
					
				$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
					
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")	
				sleep 2
				$ie.select_list(:name, "optQuotaStatus").set("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.text_field(:id, "txtSurveyURL").set($code_survey_url)
				$ie.checkbox(:id, "chkAppendClientCodes").set
				$ie.button(:value,"Save Group").click
				sleep 2
				$ie.checkbox(:id, "chkShowSurvey").set
				$ie.text_field(:id, "txtSurveyName").set("CONF CODE RECONTACT SURVEY")
				$ie.button(:value,"Save Group").click
				$st = '1'
				$test_description = "Saving Confirmit code settings for QG "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.checkbox(:id, "chkAppendClientCodes").isSet?)
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$file_3 = File.open($token1_path)
				$tk1 = $file_3.gets
				puts $tk1
				$file_3.close;
				
				$ie.goto("http://p.usampadmin.com/quota_member_pub_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&static=")
				sleep 5
				$ie.checkbox(:id, "chkIncludeExcludeMemberIdToken").set
				$ie.text_field(:id, "txtAreaMemberIdTokens").set($tk1)
				$ie.checkbox(:id, "chkRecontactStudy").set
				$ie.button(:value,"Save Group").click
				$st = '2'
				$test_description = "Saving Member-Pub options and recontact study settings for QG "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.checkbox(:id, "chkRecontactStudy").isSet?)
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				sleep 2
				# Creating a CODE-TOKEN file to be uploaded
				timeSpreadsheet = File.new($recontact_code_fl_path, "w")
				timeSpreadsheet.puts "CODE,TOKEN"
				timeSpreadsheet.puts $code1+","+$tk1
				timeSpreadsheet.close
				sleep 2
				$recontact_code_fl_path = $recontact_code_fl_path.gsub("/", "\\")
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 4
				$ie.button(:value,"Code/URL for Re-contact token").click
				sleep 5
				$ie.file_field(:name, "txtBrowseURLCSVFile").set($recontact_code_fl_path)
				sleep 3
				$ie.button(:value,"Upload").click
				sleep 3
				$st = '3'
				$test_description = "Uploading Confirmit code "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.contains_text(/File \(1 CODE\) has been succesfully uploaded/))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.button(:value,"Back To Group Details").click
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
	
	def test_04_invalid_member_not_shown_survey
	  
			begin	
				$file_2 = File.open($qg_id_file_path_2)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Surveyhead_login($m2_email,$m2_passwd)
				sleep 5
				puts "## Waiting for surveys to load ##"
				sleep 35
				$st = '4'
				$test_description = "Invalid member is not shown survey"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				#puts $url
				if($ff.contains_text($qg_id))
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
				$ff.goto("http://www.p.surveyhead.com/index.php?mode=logout")
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
	
	def test_05_confirmit_code_survey_complete
	  
			begin	
				$file_2 = File.open($qg_id_file_path_2)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Surveyhead_login($m1_email,$m1_passwd)
				sleep 5
				puts "## Waiting for surveys to load ##"
				sleep 35
				$survey_link  = Base64.encode64($qg_id)
                $survey_link = "link"+$survey_link
                $survey_link = $survey_link.chomp
                puts $survey_link
                sleep 10
                $ff.link(:id, $survey_link).click
                sleep 2
                $ff.button(:value,"START SURVEY").click
                sleep 10
				$ff1 = FireWatir::Firefox.attach(:title,/TEST_AUTOMATION_SURVEY/)
				sleep 2
				$url = $ff1.url
				$ff1.goto($sc_red_url)
				sleep 2
				$ff1.close
				sleep 1
				$st = '5'
				$test_description = "Checking confirmit code in survey URL"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				puts $url
				if($url =~ /#{$code1}/)
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("http://www.p.surveyhead.com/index.php?mode=logout")
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
	  
	  def test_06_confirmit_url_qg_set
	  
			begin
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$file_1 = File.open($proj_id_file_path)
				$prj_id = $file_1.gets
				puts $prj_id
				$file_1.close;
			
				$file_2 = File.open($qg_id_file_path_2)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
					
					
				$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
					
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")	
				sleep 2
				$ie.select_list(:name, "optQuotaStatus").set("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.radio(:id, "rdSurveyURLType2").set
				$ie.button(:value,"Save Group").click
				$st = '6'
				$test_description = "Saving Recontact confirmit URL settings for QG "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.radio(:id, "rdSurveyURLType2").isSet?)
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				sleep 2
				$file_3 = File.open($token2_path)
				$tk2 = $file_3.gets
				puts $tk2
				$file_3.close;
				
				$ie.goto("http://p.usampadmin.com/quota_member_pub_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&static=")
				sleep 5
				$ie.checkbox(:id, "chkIncludeExcludeMemberIdToken").set
				$ie.text_field(:id, "txtAreaMemberIdTokens").clear
				sleep 3
				$ie.text_field(:id, "txtAreaMemberIdTokens").set($tk2)
				$ie.checkbox(:id, "chkRecontactStudy").set
				$ie.button(:value,"Save Group").click
				$st = '7'
				$test_description = "Saving Member-Pub options and recontact study settings for QG "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.checkbox(:id, "chkRecontactStudy").isSet?)
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				sleep 2
				# Creating a CODE-TOKEN file to be uploaded
				timeSpreadsheet = File.new($recontact_url_fl_path, "w")
				timeSpreadsheet.puts "URL,TOKEN"
				timeSpreadsheet.puts $url1+","+$tk2
				timeSpreadsheet.close
				sleep 2
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 2
				$recontact_url_fl_path = $recontact_url_fl_path.gsub("/", "\\")
				$ie.button(:value,"Code/URL for Re-contact token").click
				sleep 4
				$ie.file_field(:name, "txtBrowseURLCSVFile").set($recontact_url_fl_path)
				sleep 2
				$ie.button(:value,"Upload").click
				sleep 3
				$st = '8'
				$test_description = "Uploading Confirmit URL file provided by client "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.contains_text(/File \(1 URL\) has been succesfully uploaded/))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.button(:value,"Back To Group Details").click
				$ie.link(:text,'Logout').click
				$obj.Delete_cookies
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
	   
	   def test_07_invalid_member_not_shown_survey
	  
			begin	
				$file_2 = File.open($qg_id_file_path_2)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Surveyhead_login($m4_email,$m4_passwd)
				sleep 5
				puts "## Waiting for surveys to load ##"
				sleep 35
				$st = '9'
				$test_description = "Invalid member is not shown survey"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				#puts $url
				if($ff.contains_text($qg_id))
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
				$ff.goto("http://www.p.surveyhead.com/index.php?mode=logout")
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
	   
	   def test_08_confirmit_url_survey_complete
	  
			begin	
				$file_2 = File.open($qg_id_file_path_2)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Surveyhead_login($m3_email,$m3_passwd)
				sleep 5
				puts "## Waiting for surveys to load ##"
				sleep 35
				$survey_link  = Base64.encode64($qg_id)
                $survey_link = "link"+$survey_link
                $survey_link = $survey_link.chomp
                puts $survey_link
                sleep 10
                $ff.link(:id, $survey_link).click
                sleep 2
                $ff.button(:value,"START SURVEY").click
                sleep 10
				$ff1 = FireWatir::Firefox.attach(:title,/TEST_CONFIRMIT_SURVEY/)
				sleep 2
				$url = $ff1.url
				$st = '8'
				$test_description = "Checking confirmit survey URL provided by client"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				puts $url
				if($ff1.contains_text(/THIS IS A TEST CONFIRMIT SURVEY/))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff1.goto($sc_red_url)
				sleep 2
				$ff1.close
				sleep 1
				$ff.goto("http://www.p.surveyhead.com/index.php?mode=logout")
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
	   
	   def test_09_close_qg
	   
			begin		
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$file_1 = File.open($proj_id_file_path)
				$prj_id = $file_1.gets
				puts $prj_id
				$file_1.close;
			
				$file_2 = File.open($qg_id_file_path_2)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
					
					
				$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
					
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")	
				sleep 2
				$ie.select_list(:name, "optQuotaStatus").set("Closed")
				$ie.button(:name,"btnSave").click
				sleep 2	
				$ie.link(:text,'Logout').click
				$obj.Delete_cookies
				$ie.close	
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					$obj.Close_all_windows
			end		
					
	   end
	  
end