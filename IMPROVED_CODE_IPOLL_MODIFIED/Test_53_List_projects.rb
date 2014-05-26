# LISTING PROJECTS ON DASHBOARD

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
require './Input Repository\Test_53_List_projects_Input.rb'

class Test_53_List_projects < Test::Unit::TestCase

			$wd=Dir.pwd
			#$pub_id_file_path = $wd+"/Input Repository/PUB_ID.txt"
			#$pub_name_file_path = $wd+"/Input Repository/PUB_NAME.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "53 - "
				$test_description = "Test Case: "+$t.to_s+"  LIST PROJECTS ON DASHBOARD"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_list_open_proj
				
			begin	
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Listing OPEN projects "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$ie.goto("http://q.usampadmin.com/manage_projects.php")
				sleep 3
				$ie.select_list(:name, "optProjectManager").select($prj_mngr)
				sleep 3
				$ie.select_list(:name, "optSalesRep1").select($sales_rep1)
				sleep 3
				#$ie.select_list(:name, "optBusDevManager").set($buss_dev)
				#sleep 3
				$ie.button(:value,"Filter Projects").click
				sleep 6
				if($ie.html.include?("AUTO TEST PROJ # DON'T CHANGE!!"))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts 'Fail'   
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
	  
	  def test_03_list_closed_proj
				
			begin	
				$st = "2"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Listing CLOSED projects "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$ie.goto("http://q.usampadmin.com/manage_projects.php")
				sleep 3
				$ie.select_list(:name, "optProjectManager").select($prj_mngr)
				sleep 3
				$ie.select_list(:name, "optSalesRep1").select($sales_rep1)
				sleep 3
				#$ie.select_list(:name, "optBusDevManager").set($buss_dev)
				#sleep 3
				$ie.checkbox(:id, "open").clear
				$ie.checkbox(:id, "prelaunch").clear
				$ie.checkbox(:id, "closed").set
				sleep 2
				$ie.button(:value,"Filter Projects").click
				sleep 2
				if($ie.html.include?("AUTO TEST PROJ 2# DON'T CHANGE!!"))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts 'Fail'   
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
	  
	  def test_04_list_escalated_proj
				
			begin	
				$st = "3"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Listing ESCALATED projects "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$ie.goto("http://q.usampadmin.com/manage_projects.php")
				sleep 3
				$ie.select_list(:name, "optProjectManager").select($prj_mngr)
				sleep 3
				$ie.select_list(:name, "optSalesRep1").select($sales_rep1)
				#sleep 3
				#$ie.select_list(:name, "optBusDevManager").set($buss_dev)
				sleep 3
				$ie.checkbox(:id, "open").clear
				$ie.checkbox(:id, "prelaunch").clear
				$ie.checkbox(:id, "closed").clear
				$ie.checkbox(:id, "Escalated-to-sales").set
				sleep 2
				$ie.button(:value,"Filter Projects").click
				sleep 2
				if($ie.html.include?("AUTO TEST PROJ 3# DON'T CHANGE!!"))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts 'Fail'   
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