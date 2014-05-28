# SURVEY COMPLETE

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
require 'Input Repository\Test_06_Survey_complete_Input.rb'

class Test_06_Survey_complete < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$mem_email_file_path_1 = $wd+"/Input Repository/MEM_1_EMAIL_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = '6 - '
				$test_description = "Test Case: "+$t.to_s+"  DASHBOARD SURVEY COMPLETE"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	
	  def test_02_survey_complete
	  
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
				  $ff = $obj.Surveyhead_login($em_id,$em_id)
				  sleep 25
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
                  $ff1 = FireWatir::Firefox.attach(:title,'TEST_AUTOMATION_SURVEY')
                  $ff1.goto($sc_red_url)
				  sleep 2
				  if($ff1.contains_text(/Congratulations, you've just completed the survey/))
							$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				  else
							$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				  end
				  
                  $ff1.close
				  
				  $ff.goto("p.surveyhead.com/index.php?mode=logout")
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