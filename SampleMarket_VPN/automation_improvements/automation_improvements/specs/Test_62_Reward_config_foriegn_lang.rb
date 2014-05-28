# CONFIGURING REWARD IN FOREIGN LANGUAGE

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
require 'Input Repository\Test_62_Reward_config_foriegn_lang_Input.rb'

class Test_62_Reward_config_foriegn_lang < Test::Unit::TestCase

			$wd=Dir.pwd
			$Don_name_file_path = $wd+"/Input Repository/DON_REWARD.txt"
			$Don_id_file_path = $wd+"/Input Repository/DON_REWARD_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "62 - "
				$test_description = "Test Case: "+$t.to_s+"  REWARD CONFIGURATION IN FOREIGN LANGUAGE"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
					
	  end
	  
	  def test_02_reward_config_spanish
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				
				$file_1 = File.open($Don_id_file_path)
				$don_id = $file_1.gets
				puts $don_id
				$file_1.close;
				
				$don_rew_id = Base64.encode64($don_id)
				
				$ie.goto("http://p.usampadmin.com/add_reward_type.php?rid=#{$don_rew_id}")
				sleep 4
				$ie.select_list(:name, "optLanguageId").set("Spanish")
				sleep 5
				$don_spn = 'Donacion espanola'
				$ie.text_field(:id, "txtTitle").set("Spanish Donation")
				$ie.execute_script("CKEDITOR.instances['txtCatalogDesc'].setData('<p> Nombre de recompensa : %%rewardname%% 	Nombre de pila : %%firstname%% 	</p>');") 
				sleep(2)
				$ie.execute_script("CKEDITOR.instances['txtDescription'].setData('<p> Nombre de recompensa : %%rewardname%% 	Nombre de pila : %%firstname%%  </p>');") 
				sleep(1)
				$ie.execute_script("CKEDITOR.instances['txtRedemption'].setData('<p> regalo codigo : %%giftcode%% 	Cantidad de regalos : %%giftamount%% 	regalo Url : %%gifturl%% </p>');")
				$ie.text_field(:id, "txtSubject").set("Solicitud de donación espanola")
				$ie.execute_script("CKEDITOR.instances['txtEmailDesc'].setData('<p> Querido %%firstname%% </p>');")
				$ie.button(:value,"Update").click
				$st = '1'
				$test_description = "Configuring reward in foreign language (Spanish)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.contains_text(/Reward Type has been updated successfully/))
					puts "passed"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					pust "failed"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$st = '2'
				$test_description = "Reward Update"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				$ie.text_field(:id, "txtTitle").set($don_spn)
				$ie.button(:value,"Update").click
				sleep 2
				$str = $ie.text_field(:id, "txtTitle").value
				puts $str
				if($str == $don_spn)
					puts "passed"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					pust "failed"
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
	  
	  def test_03_check_rew_desc
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ff = $obj.Surveyhead_login($mem_em,$mem_passwd)
				sleep 5
				$ff.goto("http://www.p.surveyhead.com/reward_catalog.php?type=donation")
				sleep 5
				$ff.select_list(:id, "optRewardDonationIncr").set(/\$1.23/)
				sleep 8
				sleep 3
				$st = '3'
				$test_description = "Reward description shown on reward catlog page"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff.contains_text($don_spn) && $ff.contains_text(/Nombre de recompensa/))  
					puts "desc_pl_passed"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "desc_pl_failed"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("http://www.p.surveyhead.com/my_rewards.php")
				$ff.button(:id,"donate_out").click
				sleep 5
				$ff.select_list(:id, "optRewardDonationIncr").set(/\$1.23/)
				sleep 8
				#$ff.link(:text, "Last").click
				sleep 3
				$st = '4'
				$test_description = "Reward description shown on reward cash out page"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ff.contains_text($don_spn) && $ff.contains_text(/Nombre de recompensa/))
					puts "don_pl_passed"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "don_pl_failed"
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
	  
end