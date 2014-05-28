# VERIFY SCHEDULED BROADCAST

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
require 'Input Repository\Test_XX_Verify_scheduled_bcast_Input.rb'

class Test_XX_Verify_scheduled_bcast < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "XX - "
				$test_description = "Test Case: "+$t.to_s+"  VERIFY SCHEDULED BROACAST EMAIL DELIVERY "
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_verify_scheduled_bcast_in_admin
	  
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
				sleep 3
				$ie.goto("http://p.usampadmin.com/query_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&type=new&static=")
				sleep 3
				$b_subj = "Sch_Bcast:" + "#{$qg_id}"
				$ie.link(:text, "Sent Broadcasts").click
				sleep 3
				$ie.refresh
				sleep 3
				$st = '1'
				$test_description = "Checking transaction in Sent Broadcast link in admin "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.contains_text($b_subj))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	
				end
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
	  
	  def test_03_verify_email_delivery
		
			begin	
				$st = '2'
				$test_description = "Checking email delivery"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$ff = FireWatir::Firefox.new
				$ff.goto("http://www.rediff.com")
				sleep 3
				$ff.maximize
				$ff.link(:text,"Sign in").click
				sleep 5
				$ff.text_field(:id,"c_uname").set($redf_uname)
				$ff.text_field(:id,"c_pass").set($redf_pass)
				$ff.button(:id,"btn_login").click
				sleep 10
				$b_subj = "Sch_Bcast:" + "#{$qg_id}"
				if ($ff.contains_text($b_subj))
					puts "PASS"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL:TAKING TOO LONG"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED(Mail sending taking too long)</font></td></tr>"
				end
				$ff.link(:text,"Signout").click
				$ff.close_all
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