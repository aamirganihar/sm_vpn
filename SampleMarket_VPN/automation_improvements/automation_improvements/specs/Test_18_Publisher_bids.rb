# REQUESTING A BID

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
require 'digest/md5'
require "base64"
require 'firewatir'
require 'Input Repository\Test_18_Publisher_bid_Input.rb'

class Test_18_Publisher_bid < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/Copied_QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "18 - "
				$test_description = "Test Case: "+$t.to_s+"  PUBLISHER BIDS"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
	  
	  end
	  
	  def test_02_request_bid
	  
			begin	
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
				$pub_n = $pubid[2..5]
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
        sleep 3
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$ie.goto("http://p.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&static=")
				$ie.goto("http://p.usampadmin.com/bid_project_select_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
        sleep 3
				$ie.radio(:name, "rdbPublisher", "SelectedPublisher").click
				$ie.select_list(:name, "optPublisherId").set($pubname)
				$ie.button(:value,">>").click
				$ie.button(:value,"Show Publishers").click
				sleep 5
				$ie.checkbox(:id, "chkPublisher[]").set
				$ie.text_field(:id, "txtCPIRequest[1164]").set($cpi)
				$ie.checkbox(:name, "chkMailSendToExecutive").set
				$ie.select_list(:id, "optAccountExecutive").set("Rahul Halankar")
				$ie.checkbox(:name, "chkMailSendToSalesRep").set
				$ie.radio(:name, "rdbEmailNotify", "immediately").click
				$ie.button(:value,"Review Publisher Email and Send Invitations").click
				$ie.radio(:name, "rdbSendFrom", "UnitedSampleNetwork").click
				$ie.text_field(:id, "txtCCEmail[1164]").set("rahul_halankar@persistent.co.in")
				$ie.button(:value,"Send Publisher Invitations Now").click
				sleep 3
				$st = '1'
				$test_description = "Sending request for a bid"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				if ($ie.text.include?("The invitation has been sent to publisher(s) successfully."))
						 puts 'Pass'
						 $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
						  puts 'Fail'   
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
	  
	  def test_03_reject_bid
	  
			begin	
				$ff = $obj.Network_site_login($pub_email,$pub_pass,'Publisher')
				$ff.goto("https://p.network.u-samp.com/open_bids.php")	
				$ff.link(:url,/bid_live_projects_email.php/).click
				$ff.link(:text,"Pass on this Project").click
				$ff.select_list(:name,'optPassOnProject').select('Quantity needed too low')
				$ff.button(:name,"btnPass").click
				sleep(5)
				$st = '2'
				$test_description = "Reject a bid"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				if($ff.contains_text(/Welcome, AUTO BID PUB/))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("https://p.network.u-samp.com/login.php?hdMode=logout")
				$ff.close
			rescue => e
						puts e.message
						puts e.backtrace.inspect
						$obj.Close_all_windows
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
								
			end
	  end
	  
	  def test_04_check_admin
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
        sleep 3
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$ie.goto("http://p.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&static=")
				$ie.goto("http://p.usampadmin.com/bid_project_select_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
        sleep 3
				$ie.link(:href,/bid_project_rejected_publishers.php/).click
				sleep(5)
				$st = '3'
				$test_description = "Confirm bid rejection in admin"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
			    if($ie.contains_text($pubname))
				    puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.checkbox(:name, "chkPublisher[]").set
				sleep 3
				$ie.button(:value,"Remove Selected Publishers and Allow them to Submit Again").click
				sleep 2
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
	  
	  def test_05_request_second_bid
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
        sleep 2
        $ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
		$ie.goto("http://p.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&static=")
				$ie.goto("http://p.usampadmin.com/bid_project_select_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
        sleep 3
				$ie.radio(:name, "rdbPublisher", "SelectedPublisher").click
				$ie.select_list(:name, "optPublisherId").set($pubname)
				$ie.button(:value,">>").click
				$ie.button(:value,"Show Publishers").click
				sleep 5
				$ie.checkbox(:id, "chkPublisher[]").set
				$ie.text_field(:id, "txtCPIRequest[1164]").set($cpi)
				$ie.checkbox(:name, "chkMailSendToExecutive").set
				$ie.select_list(:id, "optAccountExecutive").set("Rahul Halankar")
				$ie.checkbox(:name, "chkMailSendToSalesRep").set
				$ie.radio(:name, "rdbEmailNotify", "immediately").click
				$ie.button(:value,"Review Publisher Email and Send Invitations").click
				$ie.radio(:name, "rdbSendFrom", "UnitedSampleNetwork").click
				$ie.text_field(:id, "txtCCEmail[1164]").set("rahul_halankar@persistent.co.in")
				$ie.button(:value,"Send Publisher Invitations Now").click
				
				$st = '4'
				$test_description = "Sending second request for a bid"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				if ($ie.text.include?("The invitation has been sent to publisher(s) successfully."))
						 puts 'Pass'
						 $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
						  puts 'Fail'   
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
	  
	  def test_06_respond_bid
	  
			begin	
				$ff = $obj.Network_site_login($pub_email,$pub_pass,'Publisher')
				$ff.goto("https://p.network.u-samp.com/open_bids.php")	
				$ff.link(:url,/bid_live_projects_email.php/).click
				$ff.link(:text,"Respond to this Bid").click
			    $ff.text_field(:name,'txtLowestPrice').set('1')
			    $ff.text_field(:name,'txtMaxCompletes').set('100')
			    $ff.select_list(:name,'optLeadTime').select('1 Day')
			    $ff.checkbox(:name,'chkBidResponse').click 
			    $ff.button(:name,"btnSaveBid").click
				sleep(5)
				$st = '5'
				$test_description = "Respond to a bid"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				if($ff.contains_text('Thank you. Based on your bid price, you have been assigned to Survey'))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("https://p.network.u-samp.com/login.php?hdMode=logout")
				$ff.close
			rescue => e
						puts e.message
						puts e.backtrace.inspect
						$obj.Close_all_windows
						$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
						$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
						$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
								
			end
	  end
	  
	  def test_07_check_admin
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
        sleep 2
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$ie.goto("http://p.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}&static=")
				$ie.goto("http://p.usampadmin.com/bid_project_select_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
        sleep 3
        sleep 3
				$ie.link(:href,/bid_project_responses.php/).click
				sleep(5)
				$st = '3'
				$test_description = "Confirm bid response in admin"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
        sleep 2
			    if($ie.contains_text($pubname))
				    puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else 
					puts 'Fail'   
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
	  
	  
end