# MEMBER SEARCH/EDIT

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
require './Input Repository\Test_41_Member_search_Input.rb'

class Test_41_Member_search < Test::Unit::TestCase

			$wd=Dir.pwd
			#$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			#$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			#$pub_id_file_path = $wd+"/Input Repository/PUB_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "41 - "
				$test_description = "Test Case: "+$t.to_s+"  MEMBER SEARCH/EDIT DETAILS"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_search_edit_member
				
			begin	
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Member search in admin "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin1_login($admin_email,$admin_passwd)
				$ie.goto("http://q.usampadmin.com/list_members.php")
				sleep 2
				#$ie.link(:text, "Members").click
				$ie.text_field(:name, "txtMemberId").set($mid)
				$ie.text_field(:name, "txtFirstName").set($fname)
				$ie.text_field(:name, "txtLastName").set($lname)
				$ie.text_field(:name, "txtEmail").set($email)
				$ie.text_field(:name, "txtPassword").set($passwd)
				$ie.select_list(:id, "optPLSites").select($site)
				sleep 2
				$ie.button(:value,"Search").click
				sleep 5
				$ie.link(:text,/M(\d)+/).click
				sleep 5
				#if($ie.text.include?($mid) )
				if($ie.html.include?('Activity Log') && $ie.text.include?($mid) )
					puts 'Pass1'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail1'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				sleep 2
				$st = "2"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Edit member details in admin "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				$ie.link(:text, "Member Details").click
				sleep 5
				$ie.select_list(:name, "optMonthId").select("July")
				#$ie.text_field(:name, "txtConfirmNewPwd").set("temp pswd")
				$ie.button(:value,"Save Details").click
				sleep 5
				$pswd = $ie.select_list(:name, "optMonthId").value
				#puts $pswd
				sleep 5
				if($ie.html.include?('Member details have been updated successfully') && $pswd == "07") #07 is the value for July
					puts 'Pass2'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail2'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				#$ie.link(:text, "Member Details").click
				sleep 5
				$ie.select_list(:name, "optMonthId").select("May")
				$ie.button(:value,"Save Details").click
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