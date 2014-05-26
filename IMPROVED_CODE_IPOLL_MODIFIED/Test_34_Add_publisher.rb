# ADD NEW PUBLISHER

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
require './Input Repository\Test_34_Add_publisher_Input.rb'

class Test_34_Add_publisher < Test::Unit::TestCase

			$wd=Dir.pwd
			$pub_id_file_path = $wd+"/Input Repository/PUB_ID.txt"
			$pub_name_file_path = $wd+"/Input Repository/PUB_NAME.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "34 - "
				$test_description = "Test Case: "+$t.to_s+"  ADD NEW PUBLISHER"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end

	  def test_02_add_new_pub
				
			begin	
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "New Publisher addition "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				$ext = Time.new
				$ext = $ext.to_s
				$ext_1 = $ext.slice(13..18)
				$pub_company = "TEST AUTO PUB_"+$ext_1
				$pub_company = $pub_company.gsub(/:/, "")
				
			    File.open($pub_name_file_path, 'w') do |f1| 
			      f1.puts $pub_company
			    end
								
				$ext_2 = $ext.slice(0..18)
				$pub_mail_adr="auto_test_pub.des"+$ext_2+"@mailinator.com"
                $pub_mail_adr = $pub_mail_adr.gsub(/:/, "")
                $pub_mail_adr = $pub_mail_adr.gsub(/\s/, "")
				$ie.goto("http://q.usampadmin.com/add_publisher.php")
				sleep 3
				$ie.text_field(:name,"txtCompany").set($pub_company)
				$ie.text_field(:name,"txtFname").set($fname)
				$ie.text_field(:name,"txtLname").set($lname)
				$ie.text_field(:name,"txtEmail").set($pub_mail_adr)
				$ie.select_list(:name, "optCountryId").select($country)
				#$ie.text_field(:name,"txtPassword").set($passwd)
				$ie.button(:name,"btnSave").click
				sleep 5
				if ($ie.html.include?('Publisher details have been added successfully.'))
						puts 'Pass'
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
						puts 'Fail'   
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
					end
			sleep 5
        $ie.link(:text, "Settings").click
				sleep 2
				$ie.checkbox(:id, "chkBiddingPub").set
				$ie.button(:value,"Save").click  
                                
				sleep 6
				$ie.link(:text,'Publishers').click
				sleep 3
			    $Pub_id= /PU(\d+)/.match($ie.text)
			    $Pub_id[0].to_s()
			    $Pub_id[0].chomp!
			    File.open($pub_id_file_path, 'w') do |f1| 
			      f1.puts $Pub_id[0]
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


				
	  def test_03_search_pub
			
			begin
				$st = "2"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Search publisher in admin "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin1_login($admin_email,$admin_passwd)
				$file_1 = File.open($pub_name_file_path)
				$pub_company = $file_1.gets
				puts $pub_company
				$file_1.close;
        
				$file_2 = File.open($pub_id_file_path)
				$pub_id = $file_2.gets
				puts $pub_id
				$file_2.close;
			    $ie.goto("http://q.usampadmin.com/list_publishers.php")
			    $ie.text_field(:name,'txtPublisherId').set($pub_id)
			    sleep 5
			   # $ie.text_field(:name,'txtCompany').set($pub_company)
			   # sleep 5
			    #$ie.text_field(:name,'txtFname').set($fname)
			    #sleep 5
			    #$ie.text_field(:name,'txtLname').set($lname)
			   # sleep 5
			    #$ie.text_field(:name,'txtEmail').set($pub_mail_adr)
			    #$ie.select_list(:name,"optAllEmpRep").set($)
			    #$ie.select_list(:name,"optCountryId[]").select($country)
			   # sleep 5
			    #$ie.select_list(:name,"optPublisherGroupsOptionId").set($Publisher_Group)
				#$ie.button(:name,"btnSearch").click
				#sleep 5

				#a=$ie.td(:xpath,".//*[@id='frmAddPublisher']/table/tbody/tr[4]/td").text
				#a={$pub_id.chomp}
				#if($ie.html.include?("Publisher Management for"))
				#if($ie.html.include?("Publisher Management for #{$pub_company.chomp} \(#{$pub_id.chomp}\)"))
				if($ie.html.include?("Publisher Management for #{$pub_company.chomp}"))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$st = "3"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Edit publisher in admin "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				#$enc_pubid = Base64.encode64($pub_id)
        #puts $enc_pubid
				#$ie.goto("http://p.usampadmin.com/add_publisher.php?hdMode=accountinfo&publisher_id=#{$enc_pubid}")
				sleep 5
				$ie.text_field(:id, "txtLname").set("TEMP NAME")
				$ie.button(:value,"Save").click
				$lst_name = $ie.text_field(:id, "txtLname").value
				if($ie.html.include?('Publisher details have been updated successfully') && $lst_name == "TEMP NAME")
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.text_field(:id, "txtLname").set($lname)
				$ie.button(:value,"Save").click
				
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