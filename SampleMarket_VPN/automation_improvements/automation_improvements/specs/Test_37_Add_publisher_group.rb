# ADD NEW PUBLISHER GROUP

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
require 'Input Repository\Test_37_Add_publisher_group_Input.rb'

class Test_37_Add_publisher_group < Test::Unit::TestCase

			$wd=Dir.pwd
			$pub_id_file_path = $wd+"/Input Repository/PUB_ID.txt"
      $pub_name_file_path = $wd+"/Input Repository/PUB_NAME.txt"
			$pub_grp_name_file_path = $wd+"/Input Repository/PUB_GRP_NAME.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "37 - "
				$test_description = "Test Case: "+$t.to_s+"  ADD NEW PUBLISHER GROUP"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_add_pub_group
				
			begin	
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "New Publisher group addition "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$ie.goto("http://p.usampadmin.com/add_publisher_groups.php")
				$ext = Time.new
				$ext = $ext.to_s
				$ext_1 = $ext.slice(13..18)
				$pub_grp_nm = "TEST_PUB_GRP_"+$ext_1
				$pub_grp_nm = $pub_grp_nm.gsub(/:/, "")
				
			    File.open($pub_grp_name_file_path, 'w') do |f1| 
			      f1.puts $pub_grp_nm
			    end
				$ie.text_field(:name,'txtGroupName').set($pub_grp_nm)
				sleep 3
				$file_1 = File.open($pub_name_file_path)
				$pub_company = $file_1.gets
				puts $pub_company
				$file_1.close;
				
				$ie.select_list(:name,'optPublisherId').set($pub_company.chomp)
				$ie.button(:name,'btnAdd').click
				$ie.button(:name,"SUBMIT").click
				if ($ie.contains_text(/Publisher group has been created successfully/))
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

	  def test_03_search_edit_pub_group
				
			begin	
				$st = "2"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Search publisher group "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$ie.goto("http://p.usampadmin.com/list_publisher_groups.php")
				$file_1 = File.open($pub_grp_name_file_path)
				$pub_grp = $file_1.gets
				puts $pub_grp
				$file_1.close;
				
				$ie.select_list(:name,'optPublisherGroupsOptionId').set($pub_grp.chomp)
				$ie.button(:name,"btnSearch").click
				sleep(2)
				$ie.link(:text,/(\d)+/).click
				sleep 2
				$grp = $ie.text_field(:name,'txtGroupName').value
				puts $grp
				if($grp == $pub_grp.chomp)
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
				$st = "3"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Editing publisher group "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$ie.text_field(:name,'txtGroupName').set("TEST TEMP GROUP NAME")
				sleep 5
				$ie.select_list(:name,'optPublisherId').set($test_pub)
        sleep 3
				$ie.button(:name,'btnAdd').click
				$ie.button(:name,"SUBMIT").click
        sleep 4
				$grp = $ie.text_field(:name,'txtGroupName').value
				puts $grp
				#$gn = "TEST TEMP GRP NAME"
				if($ie.contains_text(/updated successfully/) && $grp == "TEST TEMP GROUP NAME")
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.text_field(:name,'txtGroupName').set($pub_grp)
				sleep 3
				$ie.select_list(:name,'optSelectedPublisherId').set($test_pub)
				$ie.button(:name,'btnRemove').click
				$grp = $ie.text_field(:name,'txtGroupName').value
				$ie.button(:name,"SUBMIT").click
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


				