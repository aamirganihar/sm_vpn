# PUBLISHER MARGIN PERCENTAGE

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
require './Input Repository\Test_08_Publisher_margin_%__Input.rb'
require './Input Repository\surveyurl.rb'

class Test_08_Publisher_margin_percentage < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			#$mem_email_file_path_2 = $wd+"/Input Repository/MEM_2_EMAIL_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
		
		def test_01_report_head
	  
				$t = "8 - "
				$test_description = "Test Case: "+$t.to_s+"  PUBLISHER MARGIN PERCENTAGE"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
		end
		
		def test_02_publisher_margin_match
		
			begin
			
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)	
					$pub_enc_id = Base64.encode64($pub_id)
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
					$ie.select_list(:name, "optQuotaStatus").select("Open")
					$ie.checkbox(:id, "chkShowSurvey").set
					$ie.text_field(:id, "txtSurveyName").set("PUB MARGIN PER SURVEY")
					$ie.button(:value, "Save Group").click
					sleep 2
					$ie.goto("http://q.usampadmin.com/add_publisher_settings.php?hdMode=settings&publisher_id=#{$pub_enc_id}")
					$ie.link(:text, "Revenue Setup").click
					#$ie.checkbox(:id, "chkFutureOpp").set
					sleep 5
					$ie.radio(:id, "chkRecRev1").set
					$ie.text_field(:id, "txtRecRev").set($fixed_payout)
					$ie.text_field(:id, "txtReqMargin").set($margin)
					$ie.button(:value,"Save").click
					
					$st = '1'
					$test_description = "Publisher margin percentage matching"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					
					$ff = $obj.Focusline_login($m_eml,$m_pswd)
					sleep 5
					if ($ff.text.include?("PUB MARGIN PER SURVEY"))
							$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
					else
							$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
					end
					#$ff.goto("http://s.pl1.ipoll.com/index.php?mode=logout")
					$ff.goto("http://www.sm.q.surveyhead.com/index.php?mode=logout")
					$ff.close
					$ie.link(:text,'Logout').click
					$ie.close			
			
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					$obj.Close_all_windows
					#$ie.close
					#$ff.close
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
		
			end
		end
		
		def test_03_publisher_margin_mismatch
		
				begin
						
						$obj = Usamp_lib.new
						$obj.Delete_cookies()
						$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)	
						$pub_enc_id = Base64.encode64($pub_id)
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
						
						$ie.goto("http://q.usampadmin.com/add_publisher_settings.php?hdMode=settings&publisher_id=#{$pub_enc_id}")
						$ie.link(:text, "Revenue Setup").click
						$ie.text_field(:id, "txtReqMargin").set($margin_mismatch)
						$ie.button(:value,"Save").click
						
						$st = '2'
						$test_description = "Publisher margin percentage mismatching"
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						
						$ff = $obj.Focusline_login($m_eml,$m_pswd)
						sleep 8
						#puts $ff.text
						if ($ff.html.include?("PUB MARGIN PER SURVEY"))
								$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
						else
								$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
						end
						#$ff.goto("http://s.pl1.ipoll.com/index.php?mode=logout")
						$ff.goto("http://www.sm.q.surveyhead.com/index.php?mode=logout")
						$ff.close
						$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
						$ie.select_list(:name, "optQuotaStatus").select("Open")
						$ie.checkbox(:id, "chkShowSurvey").set
						$ie.text_field(:id, "txtSurveyName").set("AUTO TEST SURVEY")
						$ie.button(:value,"Save Group").click
						sleep 2
						$ie.goto("http://q.usampadmin.com/add_publisher_settings.php?hdMode=settings&publisher_id=#{$pub_enc_id}")
						$ie.link(:text, "Revenue Setup").click
						$ie.text_field(:id, "txtReqMargin").set("0") #Setting default value to zero
						$ie.button(:value,"Save").click
						sleep 5
						$ie.link(:text,"Logout").click
						$ie.close
							
				rescue => e
						puts e.message
						puts e.backtrace.inspect
						$obj.Close_all_windows
						#$ie.close
						#$ff.close
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
				
				end
 
		end
 
 end