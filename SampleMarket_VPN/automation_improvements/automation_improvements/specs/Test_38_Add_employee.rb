# ADD NEW EMPLOYEE

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
require 'Input Repository\Test_38_Add_employee_Input.rb'

class Test_38_Add_employee < Test::Unit::TestCase

			$wd=Dir.pwd
			$pub_id_file_path = $wd+"/Input Repository/PUB_ID.txt"
			$pub_name_file_path = $wd+"/Input Repository/PUB_NAME.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "38 - "
				$test_description = "Test Case: "+$t.to_s+"  ADD NEW EMPLOYEE"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_add_emp
	  
			begin	
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "New Employee addition "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$ie.goto("http://p.usampadmin.com/add_employee.php")
				$ie.select_list(:name, "optDepartmentId").set($dept)
				$ie.text_field(:name, "txtFname").set($fname)
			    $ie.text_field(:name, "txtLname").set($lname)
				$ext = Time.new
				$ext = $ext.to_s
				$ext_2 = $ext.slice(0..18)
				$emp_mail_adr="auto_test_emp.des"+$ext_2+"@mailinator.com"
                $emp_mail_adr = $emp_mail_adr.gsub(/:/, "")
                $emp_mail_adr = $emp_mail_adr.gsub(/\s/, "")
				
				$ie.text_field(:name, "txtEmail").set($emp_mail_adr)
				$ie.text_field(:name, "txtPassword").set($emp_mail_adr)
				$ie.text_field(:name, "txtCommision").set("2.0")
				$ie.checkbox(:name, "chbBroadcastPermission").set
				$ie.checkbox(:name, "chbClientsPermission").set
				$ie.checkbox(:name, "chbConfigurationPermission").set
				$ie.checkbox(:name, "chbEmployeesPermission").set
				$ie.checkbox(:name, "chbLanguagesPermission").set
				$ie.checkbox(:name, "chbMembersPermission").set
				$ie.checkbox(:name, "chbPanelShieldPermission").set
				$ie.checkbox(:name, "chbProfileManagerPermission").set
				$ie.checkbox(:name, "chbProjectsPermission").set
				$ie.checkbox(:name, "chbRewardsPermission").set
				$ie.checkbox(:name, "chbProxyLogPermission").set
				$ie.checkbox(:name, "chbPublishersPermission").set
				$ie.checkbox(:name, "chbQueuePermission").set
				$ie.checkbox(:name, "chbReportsPermission").set
				$ie.checkbox(:name, "chbSelfServePermission").set
				$ie.checkbox(:name, "chbSegmentationPermission").set
				$ie.checkbox(:name, "chbSegmentsQGPermission").set
				$ie.checkbox(:name, "chbIgnoreUserInvitePrefPermission").set
				$ie.checkbox(:name, "chbSiteManagerPermission").set
				$ie.button(:value,"ADD").click
				if($ie.contains_text("Employee details have been added successfully."))
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
				$obj.Close_all_windows
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
	  
	  end
	  
	  def test_03_search_edit_emp
				
			begin	
				$st = "2"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Search Employee in admin "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$ie.goto("http://p.usampadmin.com/list_employees.php")
				$ie.text_field(:name, "txtFname").set($fname)
				$ie.text_field(:name, "txtLname").set($lname)
				$ie.text_field(:name, "txtEmail").set($emp_mail_adr)
				$ie.button(:value,"SEARCH").click
				if($ie.contains_text($dept))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
				$st = "3"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Update Employee in admin "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$ie.link(:href,/employee_id/).click
				$ie.checkbox(:name, "chbProxyLogPermission").clear
				$ie.button(:value,"UPDATE").click
				if($ie.checkbox(:name,"chbProxyLogPermission").isSet?)
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
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
end