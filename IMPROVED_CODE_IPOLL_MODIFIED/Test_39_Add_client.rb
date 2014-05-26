# ADD NEW CLIENT/ SEARCH/ EDIT CLIENT DETAILS

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
require './Input Repository\Test_39_Add_client_Input.rb'

class Test_Test_39_Add_client < Test::Unit::TestCase

			$wd=Dir.pwd
			$pub_id_file_path = $wd+"/Input Repository/PUB_ID.txt"
			$pub_name_file_path = $wd+"/Input Repository/PUB_NAME.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "39 - "
				$test_description = "Test Case: "+$t.to_s+"  ADD NEW CLIENT & SEARCH/EDIT CLIENT DETAILS"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
=begin	  
	  def test_02_add_client
	  
			begin	
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "New Client addition "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				
				$ext = Time.new
				$ext = $ext.to_s
				$ext_1 = $ext.slice(13..18)
				$clnt_comp = "TEST AUTO CLIENT_"+$ext_1
				$clnt_comp = $clnt_comp.gsub(/:/, "")
								
				$ext_2 = $ext.slice(0..18)
				$clnt_mail_adr="auto_test_client.des"+$ext_2+"@mailinator.com"
				$clnt_mail_adr = $clnt_mail_adr.gsub(/:/, "")
				$clnt_mail_adr = $clnt_mail_adr.gsub(/\s/, "")
				sleep 2
				$ie.goto("http://p.usampadmin.com/add_client.php")
				$ie.text_field(:name, "txtCompany").set($clnt_comp)
				$ie.text_field(:name, "txtTerms").set($term)
				$ie.select_list(:name, "optAllEmpRep").select($rep)
				$ie.text_field(:id, "txtClientContactFName").set($fname)
				$ie.text_field(:id, "txtClientContactLName").set($lname)
				$ie.text_field(:id, "txtClientContactEmail").set($clnt_mail_adr)
				#$ie.text_field(:id, "txtClientContactPass").set($clnt_mail_adr)
				$ie.button(:value,"ADD").click
				sleep 2
				if($ie.html.include?("Client details have been added successfully."))
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
=end	  
	  def test_03_search_edit_client
	  
			begin	
				$st = "2"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Search Client in admin "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$ie.goto("http://q.usampadmin.com/list_clients.php")
				$ie.text_field(:name, "txtCompany").set($clnt_comp)
				#$ie.text_field(:name, "txtFname").set()
				$ie.text_field(:name, "txtLname").set($lname)
				$ie.text_field(:name, "txtEmail").set($clnt_mail_adr)
				$ie.select_list(:name, "optAllEmpRep").select($rep)
				$ie.button(:value,"SEARCH")
				sleep 2
				if($ie.html.include?($fname))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
				$st = "3"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Edit Client in admin "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				sleep 5
				$ie.link(:text => /C(\d)+/).click
				sleep 5
				$ie.text_field(:name, "txtCompany").set("TEST TEMP CLNT COMP")
				sleep 5
				$ie.button(:name,"bt_submit").click
				$clnt_n = $ie.text_field(:name, "txtCompany").value
				if($ie.html.include?('updated successfully') && $clnt_n == "TEST TEMP CLNT COMP")
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.text_field(:name, "txtCompany").set($clnt_comp)
				$ie.button(:value,"UPDATE").click
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