# ADD NEW EMPLOYEE

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
require './Input Repository\Test_38_Add_employee_Input.rb'

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
				$ie.goto("http://q.usampadmin.com/add_employee.php")
				sleep 2
				$ie.select_list(:name, "optDepartmentId").select($dept)
				$ie.text_field(:name, "txtFname").set($fname)
				$ie.text_field(:name, "txtLname").set($lname)
				$ie.select_list(:id,"optCountryId").select($country)
				$ext = Time.new
				$ext = $ext.to_s
				$ext_2 = $ext.slice(0..18)
				$emp_mail_adr="auto_test_emp.des"+$ext_2+"@mailop.com"
				$emp_mail_adr = $emp_mail_adr.gsub(/:/, "")
				$emp_mail_adr = $emp_mail_adr.gsub(/\s/, "")
				
				$ie.text_field(:name, "txtEmail").set($emp_mail_adr)
				#$ie.text_field(:name, "txtPassword").set($emp_mail_adr)
				$ie.text_field(:name, "txtCommision").set("2.0")
				$ie.checkbox(:name, "chbBroadcastPermission").set
				#sleep 2
				$ie.checkbox(:name, "chbClientsPermission").set
				#sleep 2
				$ie.checkbox(:name, "chbConfigurationPermission").set
				#$ie.checkbox(:name, "chbEmployeesPermission").set
				#$ie.checkbox(:name, "chbLanguagesPermission").set
				#$ie.checkbox(:name, "chbMembersPermission").set
				#$ie.checkbox(:name, "chbPanelShieldPermission").set
				#$ie.checkbox(:name, "chbProfileManagerPermission").set
				#$ie.checkbox(:name, "chbProjectsPermission").set
				#$ie.checkbox(:name, "chbRewardsPermission").set
				#$ie.checkbox(:name, "chbProxyLogPermission").set
				#$ie.checkbox(:name, "chbPublishersPermission").set
				#$ie.checkbox(:name, "chbQueuePermission").set
				#$ie.checkbox(:name, "chbReportsPermission").set
				#$ie.checkbox(:name, "chbSelfServePermission").set
				#$ie.checkbox(:name, "chbSegmentationPermission").set
				#$ie.checkbox(:name, "chbSegmentsQGPermission").set
				#$ie.checkbox(:name, "chbIgnoreUserInvitePrefPermission").set
				#$ie.checkbox(:name, "chbSiteManagerPermission").set
				sleep 5
				$ie.button(:name,"bt_submit").click
				sleep 3
				if($ie.html.include?("Employee details have been added successfully."))
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
				puts $emp_mail_adr
				$ie.goto("http://q.usampadmin.com/list_employees.php")
				$ie.text_field(:name, "txtFname").set($fname)
				$ie.text_field(:name, "txtLname").set($lname)
				$ie.text_field(:name, "txtEmail").set($emp_mail_adr)
				$ie.button(:value,"SEARCH").click
				sleep 2
				if($ie.html.include?($dept))
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
				$ie.link(:href => /employee_id/).click
				sleep 6
				$ie.checkbox(:name, "chbProxyLogPermission").clear
				$ie.button(:value,"UPDATE").click
				if($ie.checkbox(:name,"chbProxyLogPermission").set?)
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
				$ie.goto("http://q.usampadmin.com/login.php?hdMode=logout")
				#$ie.link(:text,'Logout').click
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