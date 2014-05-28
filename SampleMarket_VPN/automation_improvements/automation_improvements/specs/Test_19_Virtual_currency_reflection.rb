# REFLECTION OF VIRTUAL CURRENCY 

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
require 'Input Repository\Test_19_Virtual_curreccy_reflection_Input.rb'

class Test_19_Virtual_currency_reflection < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "19 - "
				$test_description = "Test Case: "+$t.to_s+"  REFLECTION OF VIRTUAL CURRENCY ON SITE"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end

	  def test_02_virt_currency_V1
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$enc_site_id = Base64.encode64($site_id)
                $enc_site_id = $enc_site_id.chomp
                $site_det_url = "http://p.usampadmin.com/add_site.php?site_id=#{$enc_site_id}"
                $site_det_url=$site_det_url.chomp
				$ie.goto($site_det_url)
                $ie.text_field(:name, "txtVirtualCurrencyName").set("usamp points")
                $ie.text_field(:name, "txtVirtualCurrencyPoints").set("2")
                $ie.radio(:value, "V1").set
                $ie.button(:value,"Update").click
				$ff = $obj.Focusline_login($m_email,$m_passwd)
				$st = '1'
				$test_description = "Reflection of virtual currency on site with dashboard version V1.0"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ff.contains_text('usamp points'))
                        $ff.link(:text,"My Rewards").click
                        if ($ff.contains_text('usamp points'))
                                puts "VC ON V1.0 PASS"
                                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                        else
                                puts "VC ON V1.0 FAIL (Rewards page)"
                                $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED(Rewards page)</font></td></tr>"
                        end
                else
                        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED (Dashboard page)</font></td></tr>"
                        puts "VC ON V1.0 FAIL (Dashboard page)"
                end
				$ff.goto("http://www.sm.p.surveyhead.com/index.php?mode=logout")
				$ff.close
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
	  
	  def test_03_virt_currency_V2
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$enc_site_id = Base64.encode64($site_id)
                $enc_site_id = $enc_site_id.chomp
                $site_det_url = "http://p.usampadmin.com/add_site.php?site_id=#{$enc_site_id}"
                $site_det_url=$site_det_url.chomp
				$ie.goto($site_det_url)
				$ie.radio(:value, "V2").set
                $ie.button(:value,"Update").click
				sleep 2
				$ff = $obj.Focusline_login($m_email,$m_passwd)
				$st = '2'
				$test_description = "Reflection of virtual currency on site with dashboard version V2.0"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ff.contains_text('usamp points'))
                        $ff.link(:text,"My Rewards").click
                        if ($ff.contains_text('usamp points'))
                                puts "VC ON V2.0 PASS"
                                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                        else
                                puts "VC ON V2.0 FAIL (Rewards page)"
                                $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED (Rewards page)</font></td></tr>"
                        end
                else
                        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED (Dashboard page)</font></td></tr>"
                        puts "VC ON V2.0 FAIL (Dashboard page)"
                end
				$ff.goto("http://www.sm.p.surveyhead.com/index.php?mode=logout")
				$ff.close
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
	  
	  def test_04_site_settings_reset
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$enc_site_id = Base64.encode64($site_id)
                $enc_site_id = $enc_site_id.chomp
                $site_det_url = "http://p.usampadmin.com/add_site.php?site_id=#{$enc_site_id}"
                $site_det_url=$site_det_url.chomp
				$ie.goto($site_det_url)
				$ie.text_field(:name, "txtVirtualCurrencyName").set("")
                $ie.text_field(:name, "txtVirtualCurrencyPoints").set("")
                $ie.radio(:value, "V1").set
                $ie.button(:value,"Update").click
				$ie.link(:text,"Logout").click
				$ie.close
			rescue => e
						puts e.message
						puts e.backtrace.inspect
						$obj.Close_all_windows
								
			end
	  end
	  
end