# CONFIRMIT CODE/URL CASES

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
require './Input Repository\Test_58_Confirmit_code_url_Input.rb'

class Test_58_Confirmit_code_url < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/Copied_QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
			$code_fl_path = $wd+"/Config Management/CONF_CODE_1.csv"
			$token1_path = $wd+"/Config Management/TOKEN_1.txt"
			$url_fl_path = $wd+"/Config Management/CONF_URL_1.csv"
			$token2_path = $wd+"/Config Management/TOKEN_2.txt"
			
			
      def test_01_report_head
	  
				$t = '58 - '
				$test_description = "Test Case: "+$t.to_s+"  CONFIRMIT CODE/URL CASES"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_confirmit_code_qg_set
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
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
				sleep 2
				$ie.select_list(:name, "optQuotaStatus").select("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.text_field(:id, "txtSurveyURL").set($code_survey_url)
				$ie.checkbox(:id, "chkAppendClientCodes").set
				$ie.button(:value,"Save Group").click
				sleep 2
				$ie.checkbox(:id, "chkShowSurvey").set
				$ie.text_field(:id, "txtSurveyName").set("CONFIRMIT CODE SURVEY")
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
				sleep 2
				$code_fl_path = $code_fl_path.gsub("/", "\\")
				$ie.button(:value,"Code/URL Maintenance").click
				sleep 5
				$ie.file_field(:name, "txtBrowseURLCSVFile").set($code_fl_path)
				sleep 3
				$ie.button(:value,"Upload").click
				sleep 3
				$st = '2'
				$test_description = "Uploading Confirmit code "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.html.include?('File \(1 CODE\) has been succesfully uploaded'))
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
	  
	  def test_03_confirmit_code_survey_complete
	  
			begin	
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Surveyhead_login($m1_email,$m1_passwd)
				sleep 5
				puts "## Waiting for surveys to load ##"
				
				$survey_link  = Base64.encode64($qg_id)
                $survey_link = "link"+$survey_link
                $survey_link = $survey_link.chomp
                puts $survey_link
                sleep 10
                $ff.link(:id, $survey_link).click
                sleep 2
                $ff.button(:value,"START SURVEY").click
                sleep 10
				#$ff1 = FireWatir::Firefox.attach(:title,/Survey/)
				 $ff.window(:title,"Survey").use do
				sleep 2
				$url = $ff.url
				$ff.goto($sc_red_url)
				sleep 2
				#$ff1.close
				sleep 1
				$st = '3'
				$test_description = "Checking confirmit code in survey URL"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				puts $url
				if($url =~ /X422300003/)
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				end
				$ff.goto("http://www.p.ipoll.com/index.php?mode=logout")
				$ff.close
				
				$url= $url.to_s
				$length=$url.length
				puts $length
				$url=$url.slice(72..$length)
				puts $url
				File.open($token1_path, 'w') do |f1| 
				  f1.puts $url
				end
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					$obj.Close_all_windows
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end		
	  end
	  
	  def test_04_conf_code_qg_auto_close
	  
			begin	
				$file_1 = File.open($proj_id_file_path)
				$prj_id = $file_1.gets
				puts $prj_id
				$file_1.close;
				
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Surveyhead_login($m2_email,$m2_passwd)
				sleep 5
				puts "## Waiting for surveys to load ##"
				
				$survey_link  = Base64.encode64($qg_id)
                $survey_link = "link"+$survey_link
                $survey_link = $survey_link.chomp
                puts $survey_link
                sleep 10
                $ff.link(:id, $survey_link).click
                sleep 2
                $ff.button(:value,"START SURVEY").click
                sleep 10
				 $ff.window(:title,"Welcome Back").use do
				#$ff1 = FireWatir::Firefox.attach(:title,/Welcome Back/)
				sleep 2
				$st = '4'
				$test_description = "Member redirection to closed survey page when no unused codes exists"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff.html.include?('The survey you have attempted is now closed'))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				#$ff1.close
				end
				sleep 1
				$ff.goto("http://www.p.ipoll.com/index.php?mode=logout")
				$ff.close
				
				$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2	
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 1
				$ie.goto("http://p.usampadmin.com/quota_group_statistics.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&static=")
				sleep 5
				$st = '5'
				$test_description = "QG auto closed in admin"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.text.include?('Closed change status'))
					puts "Pass"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts "Fail"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
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
	  
	  def test_05_confirmit_url_qg_set
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
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
				sleep 2
				$ie.select_list(:name, "optQuotaStatus").select("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.radio(:id, "rdSurveyURLType2").set
				$ie.button(:value,"Save Group").click
				$st = '6'
				$test_description = "Saving Confirmit URL settings for QG "
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
				$url_fl_path = $url_fl_path.gsub("/", "\\")
				
				$ie.button(:value,"Code/URL Maintenance").click
				sleep 4
				$ie.file_field(:name, "txtBrowseURLCSVFile").set($url_fl_path)
				sleep 2
				$ie.button(:value,"Upload").click
				sleep 3
				$st = '7'
				$test_description = "Uploading Confirmit URL file provided by client "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.html.include?('File \(1 URL\) has been succesfully uploaded'))
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
	   
	   def test_06_confirmit_url_survey_complete
	  
			begin	
				$file_2 = File.open($qg_id_file_path)
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
				 $ff.window(:title,"TEST_CONFIRMIT_SURVEY").use do
				#$ff1 = FireWatir::Firefox.attach(:title,/TEST_CONFIRMIT_SURVEY/)
				sleep 2
				$url = $ff.url
				$st = '8'
				$test_description = "Checking confirmit survey URL provided by client"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				puts $url
				if($ff.html.include?('THIS IS A TEST CONFIRMIT SURVEY'))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto($sc_red_url)
				sleep 2
				#$ff1.close
				end
				sleep 1
				
				$ff.goto("http://www.p.ipoll.com/index.php?mode=logout")
				$ff.close
				
				$url= $url.to_s
				$length=$url.length
				puts $length
				$url=$url.slice(48..$length)
				puts $url
				File.open($token2_path, 'w') do |f1| 
				  f1.puts $url
				end
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					$obj.Close_all_windows
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end	
	   end
	   
	   
	   def test_07_conf_url_qg_auto_close
	  
			begin	
				$file_1 = File.open($proj_id_file_path)
				$prj_id = $file_1.gets
				puts $prj_id
				$file_1.close;
				
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Surveyhead_login($m4_email,$m4_passwd)
				sleep 5
				puts "## Waiting for surveys to load ##"
				
				$survey_link  = Base64.encode64($qg_id)
                $survey_link = "link"+$survey_link
                $survey_link = $survey_link.chomp
                puts $survey_link
                sleep 10
                $ff.link(:id, $survey_link).click
                sleep 2
                $ff.button(:value,"START SURVEY").click
                sleep 10
				 $ff.window(:title,"Welcome Back").use do
				#$ff1 = FireWatir::Firefox.attach(:title,/Welcome Back/)
				sleep 2
				$st = '4'
				$test_description = "Member redirection to closed survey page when no unused URLs exists"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff.html.include?('The survey you have attempted is now closed'))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				#$ff1.close
				end
				sleep 1
				$ff.goto("http://www.p.ipoll.com/index.php?mode=logout")
				$ff.close
				
				$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2	
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 1
				$ie.goto("http://p.usampadmin.com/quota_group_statistics.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&static=")
				sleep 5
				$st = '5'
				$test_description = "QG auto closed in admin (URLs)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.text.include?('Closed change status'))
					puts "Pass"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts "Fail"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
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
	  
	  def test_08_reset_qg
	  
			begin	
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
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2	
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 1
				$ie.radio(:id, "rdSurveyURLType1").set
				$ie.text_field(:id, "txtSurveyURL").set($def_srv_url)
				$ie.text_field(:id, "txtSurveyName").set("COPIED AUTO TEST SURVEY")
				$ie.button(:value,"Save Group").click
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
