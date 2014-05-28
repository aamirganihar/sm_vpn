# REFLECTION OF CUSTOM REWARD 

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
require 'Input Repository\Test_20_Custom_reward_Input.rb'

class Test_20_Custom_reward < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "20 - "
				$test_description = "Test Case: "+$t.to_s+"  REFLECTION OF CUSTOM REWARD ON DASHBOARD V2.0"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_custom_reward
	  
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
				$ie.goto($site_det_url)
                $ie.radio(:value, "V2").set
                $ie.radio(:id, "rdRewardGridCustom").set                          
                $ie.button(:value,"Update").click
				$ff = $obj.Focusline_login($m_email,$m_passwd)
				sleep 10
				$st = '1'
				$test_description = "Reflection of custom reward on site with dashboard version V2.0"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$flg=1
				$html_contents=$ff.html
                    $html_array = $html_contents.split(/\n/)
                    0.upto($html_array.size - 1) { |index|
                        if($html_array[index] =~ /uSamp Custom Reward content/)
                                puts "PASS"
                                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                $flg=0
                                break
                        else
                                next
                        end
                    }
				if($flg==1)
                    puts "FAIL"
                    $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                end
				$ff.link(:text,"Logout").click
                $ff.close
				$ie.goto($site_det_url)
                $ie.radio(:value, "V1").set
                $ie.button(:value,"Update").click
                $ie.link(:text,'Logout').click
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