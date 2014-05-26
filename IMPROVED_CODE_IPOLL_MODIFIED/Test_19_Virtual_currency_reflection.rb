# REFLECTION OF VIRTUAL CURRENCY 

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
require './Input Repository\Test_19_Virtual_curreccy_reflection_Input.rb'

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
=begin
  	def test_02_Add_virt_currency
		
		begin
			$st = '1'
			$test_description = "Adding virtual currency"
			$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
			$myfile.print "<td class=\"td2\">"+$test_description+"</td>"			
			$obj = Usamp_lib.new
			$obj.Delete_cookies()
			$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
			sleep 2
			$enc_site_id = Base64.encode64($site_id)
			$enc_site_id = $enc_site_id.chomp
			$site_det_url = "http://p.usampadmin.com/add_site.php?site_id=#{$enc_site_id}"
			$site_det_url= $site_det_url.chomp
			$ie.goto($site_det_url)
			$ie.text_field(:name, "txtVirtualCurrencyName").set("usamp points")
			$ie.text_field(:name, "txtVirtualCurrencyPoints").set("100")
			$ie.radio(:value, "V2").set
			$ie.button(:name,"btnUpdateSite").click
			$enc_proj_id = Base64.encode64($proj_id)
			$enc_proj_id = $enc_proj_id.chomp
			$enc_qg_id = Base64.encode64($qg_id)
			$enc_qg_id = $enc_qg_id.chomp
			$ie.goto("http://p.usampadmin.com/add_quota_group.php?project_id=#{$enc_proj_id}&quota_group_id=#{$enc_qg_id}")
			sleep 5
			$ie.button(:value, "Save Group").click
			
			puts "VC ADDING: PASS"
			$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED(Rewards page)</font></td></tr>"
                        
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
	
		  def test_03_Reflection_virt_currency
	  
		begin
			$st = '2'
			$test_description = "Reflection of virtual currency on focusline site"
			$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
			$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
			$obj = Usamp_lib.new
			$obj.Delete_cookies()
			$ff = $obj.Focusline_login($m_email1,$m_passwd1)
			sleep 5
                        if ($ff.text.include? 'usamp points')
                                puts "VC PASS"
                                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED(Rewards page)</font></td></tr>"
                        else
                                puts "VC FAIL "
                                $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED (Rewards page)</font></td></tr>"
                        end
			#$ff.goto("https://sm.p.surveyhead.com/index.php?mode=logout")
			$ff.link(:text,"Logout").click
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
  def test_04_Verify_virt_currencyValue
		begin
			$st = '3'
			$test_description = "Reflection of virtual currency on focusline site"
			$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
			$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
			$obj = Usamp_lib.new
			$obj.Delete_cookies()
			$ff = $obj.Focusline_login($m_email1,$m_passwd1)

		
			if ($ff.text.include? '1000 usamp points')
				puts "VC Verified PASS"
                              $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED(Rewards page)</font></td></tr>"
                        else
                               puts "VC FAIL "
                               $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED (Rewards page)</font></td></tr>"
                       end
			#$ff.goto("https://sm.p.surveyhead.com/index.php?mode=logout")
			$ff.link(:text,"Logout").click
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
	
	def test_05_site_settings_reset
				
			begin	
				$st = '4'
				$test_description = "Reset settings for virtual currency"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
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

def test_06_Add_virt_currency_publisher
		
		begin
			$st = '1'
			$test_description = "Adding virtual currency:Publisher"
			$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
			$myfile.print "<td class=\"td2\">"+$test_description+"</td>"			
			$obj = Usamp_lib.new
			$obj.Delete_cookies()
			$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
			sleep 2
			$enc_pub_id = Base64.encode64($pub_id)
			$enc_pub_id = $enc_pub_id.chomp
			$site_det_url = "http://p.usampadmin.com/add_publisher_settings.php?hdMode=settings&publisher_id=#{$enc_pub_id}"
			$site_det_url= $site_det_url.chomp
			$ie.goto($site_det_url)
			$ie.text_field(:name, "txtVirtualCurrencyName").set("usamp points")
			$ie.text_field(:name, "txtVirtualCurrencyPoints").set("100")
			#$ie.radio(:value, "V2").set
			$ie.button(:name,"btnSave").click
			#$enc_proj_id = Base64.encode64($proj_id)
			#$enc_proj_id = $enc_proj_id.chomp
			#$enc_qg_id = Base64.encode64($qg_id)
			#$enc_qg_id = $enc_qg_id.chomp
			$ie.goto("http://p.usampadmin.com/add_quota_group.php?project_id=#{$enc_proj_id}&quota_group_id=#{$enc_qg_id}")
			#sleep 5
			#$ie.button(:value, "Save Group").click
			
			#puts "VC ADDING: PASS"
			#$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED(Rewards page)</font></td></tr>"
                        sleep 5
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
=end
			  def test_03_Reflection_virt_currency
	  
		begin
			$st = '2'
			$test_description = "Reflection of virtual currency on focusline site"
			$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
			$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
			$obj = Usamp_lib.new
			$obj.Delete_cookies()
			$ff = $obj.Focusline_login($m_email2,$m_passwd2)
			sleep 5
                        if ($ff.text.include? 'usamp points')
                                puts "VC PASS"
                                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED(Rewards page)</font></td></tr>"
                        else
                                puts "VC FAIL "
                                $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED (Rewards page)</font></td></tr>"
                        end
			#$ff.goto("https://sm.p.surveyhead.com/index.php?mode=logout")
			$ff.link(:text,"Logout").click
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