# MEMBER ID REPORT

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
require 'Input Repository\Test_55_Member_ID_report_Input.rb'

class Test_55_Member_ID_report < Test::Unit::TestCase

			$wd=Dir.pwd
			#$pub_id_file_path = $wd+"/Input Repository/PUB_ID.txt"
			#$pub_name_file_path = $wd+"/Input Repository/PUB_NAME.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "55- "
				$test_description = "Test Case: "+$t.to_s+"  MEMBER ID REPORT"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_mem_id_rep_network
	  
			begin	
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Generate member ID report in network site "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$ff = $obj.Network_site_login($unet_email,$unet_pass,$type)
				sleep 5
				$ff.goto("https://p.network.u-samp.com/monthly_earning_report.php")
				sleep 2
				$ff.select_list(:name, "optReportType").set("Member ID Report")
				sleep 6
				$ff.checkbox(:name, "chkFails").set
				$ff.checkbox(:name, "chkOverQuota").set
				$ff.checkbox(:name, "chkDNComplete").set
				$ff.select_list(:id, "optDateRange").set("Today")
				sleep 3
				$ff.button(:value,"Generate Report").click
				sleep 5
				if($ff.contains_text(/#{$mid}/))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("https://p.network.u-samp.com/login.php?hdMode=logout")
				$ff.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end	
	  
	  end
	  
end
 