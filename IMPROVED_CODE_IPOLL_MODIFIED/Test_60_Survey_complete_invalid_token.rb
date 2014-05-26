# SURVEY COMPLETE WITH INVALID TOKEN

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
require './Input Repository\Test_60_Survey_complete_invalid_token_Input.rb'

class Test_60_Survey_complete_invalid_token < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "60 - "
				$test_description = "Test Case: "+$t.to_s+"  NON MEMBER SURVEY COMPLETE WITH INVALID TOKEN"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_survey_complete
	  
			begin	
				$st = "1"
				$test_description = "Survey complete with invalid token"
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
				$ie.select_list(:name, "optQuotaStatus").select("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.text_field(:id, "txtSurveyURL").set('http://www.instant.ly/s/gxZWu?TOKEN=%%token%%')
				$ie.button(:value,"Save Group").click
				sleep 2
				 $ie.goto("q.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
                sleep 3
                $ie.frame(:name, "quota_group_publisher_iframe").link(:text,'GO').click
                sleep 20
				$ie.window(:title => "Welcome Back!").use do
                #$ie1=Watir::IE.attach(:title,'Survey')
               # $ie1.speed = :fast
                $ie.goto("http://q.u-samp.com/redirect.php?S=1&QGID=#{$qg_n}&ID=#{$inv_token}")
				sleep 10
				if ($ie.html.include?('Welcome Back'))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				#$ie1.close
				#$ie=Watir::IE.attach(:title,'uSamp.com')
				end
				 $ie.goto("q.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
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
	  
	  def test_03_reset_qg_url
	  
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
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$ie.select_list(:name, "optQuotaStatus").select("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.text_field(:id, "txtSurveyURL").set('http://www.instant.ly/s/gxZWu')
				$ie.button(:value,"Save Group").click
				sleep 2
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