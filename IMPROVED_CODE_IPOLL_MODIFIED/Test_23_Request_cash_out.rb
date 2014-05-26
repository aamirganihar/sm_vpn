# REQUEST CASH OUT

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
require './Input Repository\Test_23_Request_cash_out_Input.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

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
				$ff.goto("http://www.q.ipoll.com/my_rewards.php")
				sleep 5
				$ff.button(:id,"btnCashOut").click
				sleep 5
				$ff.select_list(:id, "optRewardDonationIncr").select("$0.01")
				sleep 8
				$ff.radio(:xpath, "//input[@id='rdRewardDonationCashout[]']").set
				$ff.button(:id,"btnProceedToCashout").click
				sleep 7
				$ff.button(:name,"btnCashOut").click
				sleep 4
				$st = '1'
				$test_description = "Gift cash out request"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ff.html.include?("You have successfully cashed out for the following:"))
						puts "Pass"
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
						puts "Fail"
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("http://www.q.ipoll.com/index.php?mode=logout")
				$ff.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
				$ff.close
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
				$ff.goto("http://www.q.ipoll.com/my_rewards.php")
				sleep 2
				$ff.button(:id,"donate_out").click
				sleep 3
				$ff.select_list(:id, "optRewardDonationIncr").select("$0.02")
				sleep 8
				$ff.radio(:xpath, "//input[@id='rdRewardDonationCashout[]']").set
				$ff.button(:id,"btnProceedToCashout").click
				$ff.button(:id,"btnCashout").click
				sleep 4
				$st = '2'
				$test_description = "Donation cash out request"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ff.html.include?("You have successfully donated for the following"))
						puts "Pass"
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
						puts "Fail"
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("http://www.q.ipoll.com/index.php?mode=logout")
				$ff.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
				$ff.close
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
				$ff.goto("http://www.q.ipoll.com/my_rewards.php")
				sleep 2
				$st = '3'
				$test_description = "Checking Donation request on My Rewards page"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$html_contents=$ff.html
        #puts $html_contents
                $html_array = $html_contents.split(/\n/)
                0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /#{$don_nm.chomp}/)
                            
                            #$html_array[index+10].scan(/[A-Za-z]+</){
                            puts "printing Donation request on My Rewards page"
                            puts $html_array[index+8]
                            puts $html_array[index+9]
                            puts $html_array[index+10]
                            puts $html_array[index+11]
                            
                            if ($html_array[index+10] =~ /requested/)
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
                            if ($html_array[index+10] =~ /requested/)
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
              $ff.goto("http://www.q.ipoll.com/index.php?mode=logout")
              $ff.close
		rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
				$ff.close
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
				$ff.goto("http://www.q.ipoll.com/my_rewards.php")
				$ff.button(:id,"btnCashOut").click
				sleep 5
				$ff.select_list(:id, "optRewardDonationIncr").select("$0.02")
				sleep 8
				$ff.radio(:xpath, "//input[@id='rdRewardDonationCashout[]']").set
				$ff.button(:id,"btnProceedToCashout").click
				sleep 5
				$ff.button(:id,"btnCashOut").click
				sleep 4
				
				if ($ff.text.include?("You have successfully cashed out for the following"))
						puts "2nd Gift Pass"
						
				else
						puts "2nd Gift Fail"
						
				end
				$ff.goto("http://www.q.ipoll.com/index.php?mode=logout")
				$ff.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
				$ff.close
				
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
				$ff.goto("http://www.q.ipoll.com/my_rewards.php")
				sleep 2
				$ff.button(:value,"Donate Now").click
				sleep 3
				$ff.select_list(:id, "optRewardDonationIncr").select("$0.02")
				sleep 8
				$ff.radio(:xpath, "//input[@id='rdRewardDonationCashout[]']").set
				$ff.button(:id,"btnProceedToCashout").click
				sleep 5
				$ff.button(:id,"btnCashOut").click
				sleep 4

				if ($ff.text.include?("You have successfully donated for the following"))
						puts "2nd Don Pass"
						
				else
						puts "2nd Don Fail"
						
				end
				$ff.goto("http://www.q.ipoll.com/index.php?mode=logout")
				$ff.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
				$ff.close
			end
	   end
	   	  
end