# MERGE FIELD IN SURVEY URL

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
require 'Input Repository\surveyurl.rb'
require 'Input Repository\Test_31_Merge_field_survey_url_Input.rb'

class Test_31_Merge_field_survey_url < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "31 - "
				$test_description = "Test Case: "+$t.to_s+"  MERGE FIELD IN SURVEY URL"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_update_QG
			
		begin	
			$obj = Usamp_lib.new
			$obj.Delete_cookies()
			$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
			sleep 3
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
			puts $prj_n
			puts $qg_n
			$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
			sleep 3
			$ie.select_list(:name, "optQuotaStatus").set("Open")
			sleep 2
			$ie.text_field(:id, "txtSurveyURL").set("http://www.s.instant.ly/s/Nxxv2?SHA=%%sha%%&MEM_NO=%%memberno%%&ENC_MEM_NO=%%encryptedmemberno%%&AGE=%%age%%&CHILDRN=%%children%%&ETHNICITY=%%ethnicity%%&EDUC=%%education%%&GEN=%%gender%%&INCOME=%%income%%&MAR_STATUS=%%marital%%&ZIP=%%zip%%&PID=%%pid%%&SP_ID=%%sp%%&EMAIL=%%emailaddress%%&COUNTY=%%countyfips%%&STATE=%%statefips%%&DMA=%%dma%%&TOKEN=%%token%%")
			sleep 2
			$ie.button(:value,"Save Group").click
			sleep 3
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
	  
	  def test_03_check_merge_fields
			
		begin	
			$obj = Usamp_lib.new
			$obj.Delete_cookies()
			$ff = $obj.Surveyhead_login($pl_email,$pl_passwd)
			sleep 5
			
			$file_2 = File.open($qg_id_file_path)
			$qg_id = $file_2.gets
			puts $qg_id
			$file_2.close;
			$qg_n = Base64.encode64($qg_id)
			$survey_link = "link"+$qg_n
			$survey_link = $survey_link.chomp
			puts $survey_link
			$ff.link(:id, $survey_link).click
			sleep 6
			$ff.button(:value,"START SURVEY").click
			sleep 10
			$ff1=FireWatir::Firefox.attach(:title,/Survey/)
			$url= $ff1.url
			puts $url
			length = $url.length
			length-=33
			$url = $url.slice(0..length)
			puts $url
			$url.chomp
			$url.to_s
			$st = '1'
			$test_description = "Merge Fields in survey URL"
			$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
			$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
			if ($url == "http://www.s.instant.ly/s/Nxxv2?SHA=218dc9724725dfc0f1ba4d3da606ee266d3ade60&MEM_NO=10598227&ENC_MEM_NO=Y4vwDOmmu&AGE=37&CHILDRN=2&ETHNICITY=9&EDUC=6&GEN=1&INCOME=22&MAR_STATUS=1&ZIP=90001&PID=0&SP_ID=&EMAIL=gsk@hk.com&COUNTY=06037&STATE=06&DMA=803&TOKEN=") 
				puts "pass"
				$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
			else
				$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>" 
				puts "fail"											
			end
			$ff1.close
			$ff.goto("http://www.p.ipoll.com/index.php?mode=logout")
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
	  
	  def test_04_reset_QG
			
		begin	
			$obj = Usamp_lib.new
			$obj.Delete_cookies()
			$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
			sleep 3
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
			puts $prj_n
			puts $qg_n
			$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
			sleep 3
			$ie.select_list(:name, "optQuotaStatus").set("Open")
			sleep 2
			$ie.text_field(:id, "txtSurveyURL").set("http://www.s.instant.ly/s/Nxxv2")
			sleep 2
			$ie.button(:value,"Save Group").click
			sleep 3
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
end