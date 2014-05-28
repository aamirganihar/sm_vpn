# MEMBER ACCOUNT CLOSE

require 'rubygems'
require 'watir'
require 'Usamp_lib'
require 'test/unit'
#Load WATIR
require 'fileutils'
# Load WIN32OLE library
require 'win32ole' 
require 'Win32API'
require 'win32/process'
#Load the win32 library
require 'win32/clipboard'
include Win32
#include 'Suite'
require 'base64'
require 'Input Repository\Test_XX_Member_acc_close_Input.rb'
require 'Pop_up_kill.rb'

class Test_XX_Member_acc_close < Test::Unit::TestCase

			$wd=Dir.pwd
			$pub_id_file_path = $wd+"/Input Repository/PUB_ID.txt"
			$pub_name_file_path = $wd+"/Input Repository/PUB_NAME.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "XX - "
				$test_description = "Test Case: "+$t.to_s+"  MEMBER ACCOUNT CLOSE"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_memb_acc_close
				
			begin	
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Closing member account "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()				
        
				$ff = $obj.Focusline_login($FCLN_email,$FCLN_passwd)
				sleep 10
				
				callPopupKillerFF()
				
				$ff.link(:text, "My Account").click
				$ff.link(:text, "Click here.").click
				$ff.checkbox(:name, "chkCloseAcctReasons[]").set
				$ff.button(:value,"Remove all Earned Rewards from My account and close account").click
				sleep 4
				if($ff.contains_text(/Home/))
					puts "PASS - MEMBER LOGGED OUT "
					$ff.goto("sm.p.surveyhead.com")
                    $ff.text_field(:name, "txtEmail").set($FCLN_email)
                    $ff.text_field(:name, "txtPassword").set($FCLN_passwd)
                    $ff.button(:value,"Login").click
                    if ($ff.contains_text('Your account has been successfully closed.'))
                        $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                        puts "PASS"
                    else
                        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                        puts "FAIL1"
                    end
				else
					puts "FAIL - MEMBER NOT LOGGED OUT"
				end
				killPopupKiller()
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
	  
	  def test_03_reopen_memb_acc
				
			begin	
				$st = "2"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Reopening member account from admin "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
				$enc_mid = Base64.encode64($mid)
				$ie.goto("http://p.usampadmin.com/member_details.php?member_id=#{$enc_mid}")
				$ie.radio(:name, "rdMemberAccountClosed", "N").click
				$ie.button(:value,"Save Details").click
				if($ie.contains_text(/Member details have been updated successfully/) && $ie.radio(:name, "rdMemberAccountClosed", "N").isSet?)
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
	  
	  def test_04_login_after_acc_reopen
				
			begin	
				$st = "3"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Member login after reopening account "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Focusline_login($FCLN_email,$FCLN_passwd)
				sleep 25
				if($ff.contains_text(/Dashboard/))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("http://sm.p.surveyhead.com/index.php?mode=logout")
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
	  
end