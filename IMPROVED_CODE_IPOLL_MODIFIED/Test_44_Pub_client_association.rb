# PUBLISHER - CLIENT ASSOCIATION 

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
require './Input Repository\Test_44_Pub_client_association_Input.rb'

class Test_44_Pub_client_association < Test::Unit::TestCase

			$wd=Dir.pwd
			#$proj_id_file_path = $wd+"/Input Repository/Project_2_ID.txt"
			#$qg_id_file_path = $wd+"/Input Repository/QG_2_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "44 - "
				$test_description = "Test Case: "+$t.to_s+" PUBLISHER CLIENT ASSOCIATION IN ADMIN  "
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
				
	  end
	  
	  def test_02_make_pub_level_setting
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$enc_pub_id = Base64.encode64($pub_id)
				$ie.goto("http://q.usampadmin.com/add_publisher_settings.php?hdMode=settings&publisher_id=#{$enc_pub_id}")
				sleep 2
				$ie.checkbox(:id, "chbAssociatePub").set
				$flg = 0
				elem = Array.new
				elem = $ie.select_list(:id, "optAllassocClient").options
				#$pub_ary = $ie.select_list(:id,"optAllassocClient").options
				#$ln = $pub_ary.length
				$ln = elem.length
				0.upto($ln - 1) { |index|
				if(elem[index] == $client_name)
				$flg = 1
				break
				else
				$flg = 0
				next
				end
				}
				if($flg == 1)
					puts 'Publisher already added'
					$ie.button(:value,"Save").click
				else
					puts 'Publisher not added'   
					$ie.checkbox(:id, "chbAssociatePub").set
					$ie.select_list(:id, "optAllUnassocClient").select($client_name)
					$ie.button(:name, "btnAdd").click
					$ie.button(:value,"Save").click
				end
				$st = '1'
				$test_description = "Save publisher client association setting in admin"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				# To check it is added after saving
				$fl = 0
				elem = Array.new
				elem = $ie.select_list(:id, "optAllassocClient").options
				#$pub_ary = $ie.select_list(:id,"optAllassocClient").getAllContents
				#$ln = $pub_ary.length
				$ln = elem.length
				0.upto($ln - 1) { |index|
				if(elem[index] == $client_name)
				$fl = 1
				break
				else
					$fl = 0
					next
				end
				}
				sleep 2
				if ($ie.html.include?('Publisher Settings have been updated successfully') && $fl == 1)
					puts "Pass"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "Fail"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.link(:text,"Logout").click
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
	  
	  def test_03_check_client_panel_builder_setting
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$enc_client_id = Base64.encode64($client_id)
				$ie.goto("http://q.usampadmin.com/selfserve_panel.php?client_id=#{$enc_client_id}")
				sleep 2
				$st = '2'
				$test_description = "Check Publisher exists on Client panel builder after association "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				sleep 3
				if ($ie.text.include?($pub_id))
					puts "Pass"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "Fail"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.link(:text,"Logout").click
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
	  
	  def test_04_remove_pub_client_association
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$enc_pub_id = Base64.encode64($pub_id)
				$ie.goto("http://q.usampadmin.com/add_publisher_settings.php?hdMode=settings&publisher_id=#{$enc_pub_id}")
				sleep 2
				$ie.checkbox(:id, "chbAssociatePub").clear
				$ie.button(:value,"Save").click
				sleep 2
				$st = '3'
				$test_description = "Remove publisher client association setting in admin "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.checkbox(:id, "chbAssociatePub").set?)
					puts "Fail"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
					puts "Pass"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
				$ie.link(:text,"Logout").click
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
	  
	  def test_05_check_panel_builder_after_reverting_settings
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$enc_client_id = Base64.encode64($client_id)
				$ie.goto("http://q.usampadmin.com/selfserve_panel.php?client_id=#{$enc_client_id}")
				sleep 2
				$st = '2'
				$test_description = "Check Publisher does not exist on Client panel builder after disassociation "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				sleep 3
				if ($ie.text.include?($pub_id))
					puts "Fail"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				else
					puts "Pass"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				end
				$ie.link(:text,"Logout").click
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