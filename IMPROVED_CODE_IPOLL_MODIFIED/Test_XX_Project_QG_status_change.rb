# PROJECT/QG STATUS CHANGE

require 'rubygems'
#require 'watir'
require './Usamp_lib'
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
require './Input Repository\Test_XX_Project_QG_status_change_Input.rb'

class Test_XX_Project_QG_status_change < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "XX - "
				$test_description = "Test Case: "+$t.to_s+"  PROJECT/QG STATUS CHANGE"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_QG_status_change
				
			begin	
				$st = "1"
				$test_description = "QG Status change (Setting Up)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
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
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$ie.select_list(:name, "optQuotaStatus").select("Setting Up")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.link(:text, "Stats").click
				sleep 3
				if ($ie.text.include?('Setting Up change status'))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$st = "2"
				$test_description = "QG Status change (Hold)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$ie.select_list(:name, "optQuotaStatus").select("Hold")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.link(:text, "Stats").click
				sleep 6
				if ($ie.text.include?('Hold change status'))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
				$st = "3"
				$test_description = "QG Status change (Closed)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$ie.select_list(:name, "optQuotaStatus").select("Closed")
				$ie.radio(:name, "rdClosedSurveyOptions").click
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.link(:text, "Stats").click
				sleep 3
				if ($ie.text.include?('Closed change status'))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
				$st = "4"
				$test_description = "QG Status change (Open)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$ie.select_list(:name, "optQuotaStatus").select("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.link(:text, "Stats").click
				sleep 3
				if ($ie.text.include?('Open change status'))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
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
	  
	  def test_03_Project_status_change
				
				
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
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				
				$st = "5"
				$test_description = "Project Status change (Escalated to Sales)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$ie.goto("http://q.usampadmin.com/add_project.php?project_id=#{$prj_n}")
				sleep 3
				$ie.select_list(:id, "optProjectStatus").select("Escalated to Sales")
				$ie.button(:value,"Save").click
				sleep 2
				$ie.goto("http://q.usampadmin.com/manage_projects.php?project_id=#{$prj_n}")
				sleep 3
				if ($ie.text.include?('Escalated to Sales'))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$st = "6"
				$test_description = "Project Status change (Billing Dept)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$ie.goto("http://q.usampadmin.com/add_project.php?project_id=#{$prj_n}")
				sleep 3
				$ie.select_list(:id, "optProjectStatus").select("Billing Dept")
				$ie.button(:value,"Save").click
				sleep 2
				if ($ie.html.include?('Upload Token File'))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.button(:value,"Cancel").click
				sleep 2
				
				$st = "7"
				$test_description = "Project Status change (Open)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$ie.goto("http://q.usampadmin.com/add_project.php?project_id=#{$prj_n}")
				sleep 3
				$ie.select_list(:id, "optProjectStatus").select("Open")
				$ie.button(:value,"Save").click
				sleep 2
				$ie.goto("http://q.usampadmin.com/manage_projects.php?project_id=#{$prj_n}")
				sleep 3
				if ($ie.text.include?('Open'))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
				$st = "8"
				$test_description = "Project Status change (Closed)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				$ie.goto("http://q.usampadmin.com/add_project.php?project_id=#{$prj_n}")
				sleep 3
				$ie.select_list(:id, "optProjectStatus").select("Closed")
				$ie.button(:value,"Save").click
				sleep 2
				$ie.goto("http://q.usampadmin.com/manage_projects.php?project_id=#{$prj_n}")
				sleep 3
				if ($ie.text.include?('Closed'))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
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