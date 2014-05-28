# REQUEST CASH OUT

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
require 'Input Repository\Test_23_Request_cash_out_Input.rb'

class Test_23_Request_cash_out < Test::Unit::TestCase

			$wd=Dir.pwd
			$Don_name_file_path = $wd+"/Input Repository/DON_REWARD.txt"
			$Gift_name_file_path = $wd+"/Input Repository/GIFT_REWARD.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "23 - "
				$test_description = "Test Case: "+$t.to_s+"  REQUEST CASH OUT"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_request_gift_cert
	  
			begin	
				$file_2 = File.open($Gift_name_file_path)
				$gift_nm = $file_2.gets
				puts $gift_nm
				$file_2.close;
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Surveyhead_login($m1_email,$m1_passwd)
				sleep 5
				$ff.goto("http://www.p.surveyhead.com/my_rewards.php")
				$ff.button(:value,"Cash Out").click
				sleep 5
				$ff.select_list(:id, "optRewardDonationIncr").set("$1.23")
				sleep 8
				$ff.radio(:index, "1").set
				$ff.button(:value,"Proceed to Cash Out »").click
				$ff.button(:value,"Cash Out »").click
				sleep 4
				$st = '1'
				$test_description = "Gift cash out request"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ff.contains_text("You have successfully cashed out for the following") && $ff.contains_text($gift_nm))
						puts "Pass"
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
						puts "Fail"
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("http://www.p.surveyhead.com/index.php?mode=logout")
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
	  
	  def test_03_request_donation
	  
			begin	
				$file_1 = File.open($Don_name_file_path)
				$don_nm = $file_1.gets
				puts $don_nm
				$file_1.close;
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Surveyhead_login($m1_email,$m1_passwd)
				sleep 5
				$ff.goto("http://www.p.surveyhead.com/my_rewards.php")
				sleep 2
				$ff.button(:value,"Donate Now").click
				sleep 3
				$ff.select_list(:id, "optRewardDonationIncr").set("$1.23")
				sleep 8
				$ff.radio(:index, "1").set
				$ff.button(:value,"Proceed to Donate Now »").click
				$ff.button(:value,"Donate Now »").click
				sleep 4
				$st = '1'
				$test_description = "Donation cash out request"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ff.contains_text("You have successfully donated for the following") && $ff.contains_text($don_nm))
						puts "Pass"
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
						puts "Fail"
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("http://www.p.surveyhead.com/index.php?mode=logout")
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
	   
	   def test_04_requests_transaction_check
				
			begin	
				$file_1 = File.open($Don_name_file_path)
				$don_nm = $file_1.gets
				puts $don_nm
				$file_1.close;
          
				$file_2 = File.open($Gift_name_file_path)
				$gift_nm = $file_2.gets
				puts $gift_nm
				$file_2.close;
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Surveyhead_login($m1_email,$m1_passwd)
				sleep 5
				$ff.goto("http://www.p.surveyhead.com/my_rewards.php")
				sleep 2
				$st = '3'
				$test_description = "Checking Donation request on My Rewards page"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$html_contents=$ff.html
                $html_array = $html_contents.split(/\n/)
                0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /#{$don_nm.chomp}/)
                            
                            #$html_array[index+10].scan(/[A-Za-z]+</){
                            if ($html_array[index+10] =~ /Requested/)
                                puts "PASS"
                                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                break
                            else
                                puts "FAIL"
                                $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                            end
                            #}
                            #break
                    else
                            next
                    end
                }
				$st = '4'
				$test_description = "Checking Gift request on My Rewards page"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$html_contents=$ff.html
                $html_array = $html_contents.split(/\n/)
                0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /#{$gift_nm.chomp}/)
                            
                            puts $html_array[index+10]
                            #$html_array[index+10].scan(/[A-Za-z]+</){
                            if ($html_array[index+10] =~ /Requested/)
                                puts "PASS:GIFT"
                                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                break
                            else
                                puts "FAIL:GIFT"
                                $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                            end
                            #}
                            #break
                    else
                            next
                    end
                }
              $ff.goto("http://www.p.surveyhead.com/index.php?mode=logout")
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
	   
	   def test_05_request_gift_cert_for_rejection_later
	  
			begin	
				$file_2 = File.open($Gift_name_file_path)
				$gift_nm = $file_2.gets
				puts $gift_nm
				$file_2.close;
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Surveyhead_login($m1_email,$m1_passwd)
				sleep 5
				$ff.goto("http://www.p.surveyhead.com/my_rewards.php")
				$ff.button(:value,"Cash Out").click
				sleep 5
				$ff.select_list(:id, "optRewardDonationIncr").set("$1.23")
				sleep 8
				$ff.radio(:index, "1").set
				$ff.button(:value,"Proceed to Cash Out »").click
				$ff.button(:value,"Cash Out »").click
				sleep 4
				
				if ($ff.contains_text("You have successfully cashed out for the following") && $ff.contains_text($gift_nm))
						puts "2nd Gift Pass"
						
				else
						puts "2nd Gift Fail"
						
				end
				$ff.goto("http://www.p.surveyhead.com/index.php?mode=logout")
				$ff.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				$obj.Close_all_windows
				
			end
	  end
	  
	  def test_06_request_donation_for_rejection_later
	  
			begin	
				$file_1 = File.open($Don_name_file_path)
				$don_nm = $file_1.gets
				puts $don_nm
				$file_1.close;
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Surveyhead_login($m1_email,$m1_passwd)
				sleep 5
				$ff.goto("http://www.p.surveyhead.com/my_rewards.php")
				sleep 2
				$ff.button(:value,"Donate Now").click
				sleep 3
				$ff.select_list(:id, "optRewardDonationIncr").set("$1.23")
				sleep 8
				$ff.radio(:index, "1").set
				$ff.button(:value,"Proceed to Donate Now »").click
				$ff.button(:value,"Donate Now »").click
				sleep 4
				
				if ($ff.contains_text("You have successfully donated for the following") && $ff.contains_text($don_nm))
						puts "2nd Don Pass"
						
				else
						puts "2nd Don Fail"
						
				end
				$ff.goto("http://www.p.surveyhead.com/index.php?mode=logout")
				$ff.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				$obj.Close_all_windows
				
			end
	   end
	   	  
end