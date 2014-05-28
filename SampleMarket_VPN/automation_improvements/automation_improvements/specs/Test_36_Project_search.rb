# PROJECT SEARCH

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
require 'Input Repository\Test_36_Project_search_Input.rb'

class Test_36_Project_search < Test::Unit::TestCase

			$wd=Dir.pwd
			#$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			#$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			#$pub_id_file_path = $wd+"/Input Repository/PUB_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "34 - "
				$test_description = "Test Case: "+$t.to_s+"  PROJECT SEARCH"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_project_search
			
			begin	
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Project search in admin "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				$ie.goto("http://p.usampadmin.com/manage_projects.php")
				sleep 5
				$ie.link(:text,'Search').click
			    $ie.text_field(:name,"txtProjectId").set($prj_id)
			    $ie.select_list(:name,"optProject").set($prj_name)
			    $ie.select_list(:name,"optProjectStatus").set($status)
			    $ie.text_field(:name,"txtQuotaGroupId").set($qg_id)
			    $ie.select_list(:name, "optQuotaStatus").set($qg_status)
			    $ie.select_list(:name, "optCategory").set($qg_cat)
			    $ie.select_list(:name, "optSubCategory").set($sub_cat)
			    $ie.select_list(:name, "optClient").set($client)
			    #$ie.select_list(:name, "optClientPM").set(/#{$file_data[10]}/)
			    #$ie.select_list(:name, "optClientPM").set("Jason&nbsp;Deutsch")
			    #$ie.select(:xpath, "html/body/table/tbody/tr[4]/td/table/tbody/tr/td[3]/form/table/tbody/tr[4]/td/table/tbody/tr[9]/td[2]/select/option[259]").text
			    #$ie.text_field(:name,"txtClientProjectNo").set($file_data[11])
			    #$ie.text_field(:name,"txtClientQuotaGroupNo").set($file_data[12])
			    $ie.text_field(:name,"txtKeywords").set($prj_name)
			    $ie.radio(:value,"DateRange").set
			    $ie.text_field(:name , 'txtStartDate').value = $start_dt
			    $ie.text_field(:name , 'txtEndDate').value = $end_dt			  
			    $ie.button(:name,"btnSearch").click
				sleep 5
				if ($ie.contains_text($client) && $ie.contains_text($status) && $ie.contains_text($prj_name) && $ie.contains_text($qg_id))
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
end