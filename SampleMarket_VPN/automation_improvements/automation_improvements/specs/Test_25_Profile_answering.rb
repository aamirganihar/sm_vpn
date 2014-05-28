# ANSWERING PROFILE

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
require 'Input Repository\Test_25_Profile_answering_Input.rb'

class Test_25_Profile_answering < Test::Unit::TestCase

			$wd=Dir.pwd
			$prof_name_path = $wd+"/Input Repository/Profile_Name.txt"
			$prof_id_path = $wd+"/Input Repository/Profile_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "25 - "
				$test_description = "Test Case: "+$t.to_s+"  PROFILE ANSWERING"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_mapping_profile
				
			begin	
				$file_1 = File.open($prof_name_path)
				$prf_nm = $file_1.gets
				puts $prf_nm
				$file_1.close;
			
				$file_2 = File.open($prof_id_path)
				$prf_id = $file_2.gets
				puts $prf_id
				$file_2.close;
				
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$enc_site_id = Base64.encode64($site_id)
                $enc_site_id = $enc_site_id.chomp
                $site_det_url = "http://p.usampadmin.com/add_site.php?site_id=#{$enc_site_id}"
                $site_det_url=$site_det_url.chomp
				$ie.goto($site_det_url)
				$ie.link(:text,"Profiles").click
				$ie.checkbox(:value,$prf_id).set
				$ie.button(:name,"Update").click
				$st = '1'
				$test_description = "Mapping Profile on site"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
        sleep 3
				if ($ie.contains_text('Profiles are added into site successfully') && $ie.checkbox(:value,$prf_id).isSet?)
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
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
	  
	  
	  def test_03_answer_profile
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Focusline_login($m1_email,$m1_passwd)
				sleep 25
				$enc_prof_id  = Base64.encode64($prf_id)
				puts $enc_prof_id
				$ff.goto("http://sm.p.surveyhead.com/profile.php?PrId=#{$enc_prof_id}&PrLId=Mg==")
				$ff.checkbox(:index, 1).set(false)
				$ff.checkbox(:index, 2).set
				$ff.checkbox(:index, 3).set(false)
				$ff.checkbox(:index, 4).set(false)
				  
				$ff.select_list(:index,1).select("July")
				$ff.select_list(:index,2).select("04")
				$ff.select_list(:index,3).select("1985")
				$ff.button(:name,"Next").click
				  
				$ff.select_list(:index, 1).select("FRENCH")
				  
				$ff.radio(:index,1).set
				$ff.radio(:index,5).set
				$ff.radio(:index,9).set
				  
				$ff.button(:name,"Next").click
				  
				$ff.text_field(:index,1).set("YES")
				$ff.text_field(:index,2).set("By Train")
				  
				$ff.button(:name,"Next").click
				$ff.radio(:index,1).set
				$ff.select_list(:index,1).select("Vista Irrigation District")
				$ff.button(:name,"Next").click
				  
				$ff.select_list(:index,1).select("Alameda Hospital")
				$ff.select_list(:index,2).select("Pacific Gas & Electric")
				  
				$ff.button(:name,"Next").click
				$ff.select_list(:index,1).select("SAN DIEGO GAS & ELECTRIC")
				  
				$ff.button(:name,"Submit").click
				
				$st = '2'
				$test_description = "Answering Profile"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				if $ff.contains_text(/Thank you for your participation/) 
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("http://www.sm.p.surveyhead.com/index.php?mode=logout")
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