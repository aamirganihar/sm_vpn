# REWARD CREATION

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
require './Input Repository\Test_16_Reward_Create_Input.rb'
require './Input Repository\surveyurl.rb'

class Test_16_Reward_Create < Test::Unit::TestCase

			$wd=Dir.pwd
			$Don_name_file_path = $wd+"/Input Repository/DON_REWARD.txt"
			$Don_id_file_path = $wd+"/Input Repository/DON_REWARD_ID.txt"
			$Gift_name_file_path = $wd+"/Input Repository/GIFT_REWARD.txt"
			$Gift_id_file_path = $wd+"/Input Repository/GIFT_REWARD_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "16 - "
				$test_description = "Test Case: "+$t.to_s+"  NEW REWARD CREATION"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end

	  def test_02_reward_donation
	  
			begin
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
					$ie.goto("http://q.usampadmin.com/add_reward_type.php")
					$ext = Time.new
					$ext = $ext.to_s
					$ext = $ext.slice(0..18)
					
					$donation_name = "Donation_"+$ext
					puts $donation_name
					$ie.text_field(:id, "txtRewardname").set($donation_name)
					$ie.select_list(:id, "optRewardCategory").select("Donation")
					$ie.text_field(:id, "txtTitle").set($donation_name)
					$ie.execute_script("CKEDITOR.instances['txtCatalogDesc'].setData('<p> Reward Name : %%rewardname%% 	First name : %%firstname%% 	%% </p>');") 
					sleep(2)
					$ie.execute_script("CKEDITOR.instances['txtDescription'].setData('<p> Reward Name : %%rewardname%% 	First name : %%firstname%% 	%% </p>');") 
					sleep(1)
					$ie.execute_script("CKEDITOR.instances['txtRedemption'].setData('<p> Gift code : %%giftcode%% 	Gift Amount : %%giftamount%% 	Gift Url : %%gifturl%% </p>');") 
      
					$ie.select_list(:name, "optCountryId").select("Canada")
					$ie.button(:value,">>").click
					$ie.select_list(:name, "optCountryId").select("United States")
					$ie.button(:value,">>").click
					$ie.select_list(:name, "optPLSiteId").select("iPoll")
					sleep 2
					$ie.button(:name,"btnPLSiteAdd").click
					$ie.select_list(:name, "optPLSiteId").select("FocuslineSurveys")
					sleep 2
					$ie.button(:name,"btnPLSiteAdd").click
					$ie.checkbox(:id, "chkIncrement1").set
					$ie.text_field(:id, "txtIncrement1").set("1.23")
					$ie.checkbox(:id, "chkIncrement2").set
					$ie.text_field(:id, "txtIncrement2").set("2.46")
					$ie.button(:value,"Add").click
					$st = '1'
					$test_description = "Donation Reward Creation"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					if($ie.text.include?("Reward Type has been added sucessfully"))
							puts "Don_passed"
							$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
							File.open($Don_name_file_path, 'w') do |f1| 
							f1.puts  $donation_name
						   end
					else
							puts "Don_failed"
							$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
					end
					$Don_id= /(\d+)(\d+)/.match($ie.text)
					$Don_id[0].to_s()
					$Don_id[0].chomp!
					puts $Don_id
					File.open($Don_id_file_path, 'w') do |f1| 
            f1.puts $Don_id[0]
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
	  
	  def test_02_reward_gift_cert
	  
			begin
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
					$ie.goto("http://q.usampadmin.com/add_reward_type.php")
					$ext = Time.new
					$ext = $ext.to_s
					$ext = $ext.slice(0..18)
					
					$gift_name = "GIFT_CERT_"+$ext
					puts $gift_name
					
					$ie.text_field(:id, "txtRewardname").set($gift_name)
					$ie.select_list(:id, "optRewardCategory").select("Gift Certificates")
					$ie.text_field(:id, "txtTitle").set($gift_name)
					$ie.execute_script("CKEDITOR.instances['txtCatalogDesc'].setData('<p> Reward Name : %%rewardname%% 	First name : %%firstname%% 	%% </p>');") 
					sleep(2)
					$ie.execute_script("CKEDITOR.instances['txtDescription'].setData('<p> Reward Name : %%rewardname%% 	First name : %%firstname%% 	%% </p>');") 
					sleep(1)
					$ie.execute_script("CKEDITOR.instances['txtRedemption'].setData('<p> Gift code : %%giftcode%% 	Gift Amount : %%giftamount%% 	Gift Url : %%gifturl%% </p>');") 
					$ie.checkbox(:id, "chkCodeNo").set
					$ie.checkbox(:id, "chkAmount").set
					$ie.select_list(:id, "optAmount").select("2")
					$ie.text_field(:name,'txtDefaultUrl').set('http://www.google.co.in?code=%%code%%')
					$ie.select_list(:name, "optCountryId").select("Canada")
					$ie.button(:value,">>").click
					$ie.select_list(:name, "optCountryId").select("United States")
					$ie.button(:value,">>").click
					$ie.select_list(:name, "optPLSiteId").select("iPoll")
					sleep 2
					$ie.button(:name,"btnPLSiteAdd").click
					$ie.select_list(:name, "optPLSiteId").select("FocuslineSurveys")
					sleep 2
					$ie.button(:name,"btnPLSiteAdd").click
					$ie.checkbox(:id, "chkIncrement1").set
					$ie.text_field(:id, "txtIncrement1").set("1.23")
					$ie.checkbox(:id, "chkIncrement2").set
					$ie.text_field(:id, "txtIncrement2").set("2.46")
					$ie.button(:value,"Add").click
					$st = '2'
					$test_description = "Gift Reward Creation"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					if($ie.text.include?("Reward Type has been added sucessfully"))
							puts "Gift_passed"
							$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
							File.open($Gift_name_file_path, 'w') do |f1| 
							f1.puts  $gift_name
						   end
					else
							puts "Gift_failed"
							$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
					end
					$Gift_id= /(\d+)(\d+)/.match($ie.text)
					$Gift_id[0].to_s()
					$Gift_id[0].chomp!
					puts $Gift_id
					File.open($Gift_id_file_path, 'w') do |f1| 
					f1.puts $Gift_id[0]
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

	  def test_04_gift_on_pl

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
					$ff = $obj.Surveyhead_login($mem_em,$mem_passwd)
					sleep 5
					#$ff.goto("http://www.p.ipoll.com/my_rewards.php")
					#$ff.link(:text, "Rewards").click
          $ff.link(:text,"Rewards").click
          sleep 3
          $ff.link(:text,"Review My Reward Catalog").click
          sleep 3
          #$ff.goto("https://www.p.ipoll.com/reward_catalog.php?type=reward")
          #if($ff.div(:id=>"idDivLoaderImage").exists?)
                #while $ff.div(:id=>"idDivLoaderImage").visible? do
                #sleep 0.5
                puts "waiting for rewards1 to load"
              #end
            #end
            
          #$ff.goto("http://www.p.ipoll.com/reward_catalog.php?type=reward")
          sleep 5
					$ff.select_list(:id, "optRewardDonationIncr").select(/\$1.23/)
          sleep 1
          #if($ff.div(:id=>"idDivLoaderImage").exists?)
                #while $ff.div(:id=>"idDivLoaderImage").visible? do
                #sleep 0.5
                puts "waiting for rewards2 to load"
              #end
            #end
            
					$ff.link(:text, "Last").click
					sleep 4
					$st = '3'
					$test_description = "Gift reward shown on reward catlog page"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
          #puts $gift_nm
          #puts "-**************"
          #puts $ff.text
          #puts "HTML*****************"
          #puts $ff.html
	  sleep 4
          if($ff.text.include?($gift_nm))
            puts "gift_pl_passed1"
            $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
            else
              if($ff.link(:text,"Next").exists?)
                $ff.link(:text,"Next").click
                sleep 5
                if($ff.text.include?($gift_nm))
                  puts "gift_pl_passed2"
                  $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                  else
                    puts "gift_pl_failed1"
                    $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                  end
                end
              end
              
          #$ff.goto("http://www.p.ipoll.com/reward_catalog.php?type=donation")
          $ff.link(:text,"DONATIONS").click
          puts "Donation"
          sleep 2
          #if($ff.div(:id=>"idDivLoaderImage").exists?)
                #while $ff.div(:id=>"idDivLoaderImage").visible? do
               # sleep 0.5
                puts "waiting for rewards3 to load"
              #end
            #end
            sleep 3
					$ff.select_list(:id, "optRewardDonationIncr").select(/\$1.23/)
          sleep 1
          #if($ff.div(:id=>"idDivLoaderImage").exists?)
                #while $ff.div(:id=>"idDivLoaderImage").visible? do
                #sleep 0.5
                puts "waiting for rewards4 to load"
              #end
           # end
          sleep 4
					$ff.link(:text, "Last").click
					sleep 3
					$st = '4'
					$test_description = "Donation reward shown on reward catlog page"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
            sleep 5
            if($ff.text.include?($don_nm))
	    puts "donation_pl_passed3"
	    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
					else
            if($ff.link(:text,"Next").exists?)
              $ff.link(:text,"Next").click
              sleep 3
              if($ff.text.include?($don_nm))
                puts "donation_pl_passed4"
                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                else
                  puts "donation_pl_failed3"
                  $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                end
              end
            end
					#$ff.link(:text, "DONATIONS").click
          #$ff.link(:text,"Rewards").click
          #sleep 3
          #$ff.link(:text,"Review My Reward Catalog").click
          sleep 3
          $ff.goto("https://www.q.ipoll.com/my_rewards.php")
          sleep 1
          #if($ff.div(:id=>"idDivLoaderImage").exists?)
                #while $ff.div(:id=>"idDivLoaderImage").visible? do
                #sleep 0.5
                puts "waiting for surveys5 to load"
              #end
            #end
					
					$ff.button(:value,"Cash Out").click
          sleep 5
					$ff.select_list(:id, "optRewardDonationIncr").select(/\$1.23/)
          sleep 1
          #if($ff.div(:id=>"idDivLoaderImage").exists?)
               # while $ff.div(:id=>"idDivLoaderImage").visible? do
                #sleep 0.5
                puts "waiting for rewards6 to load"
              #end
            #end
            sleep 4
					$ff.link(:text, "Last").click
					sleep 3
					$st = '5'
					$test_description = "Gift reward shown on Cash out page"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					if($ff.text.include?($gift_nm))
            puts "gift_pl_passed5"
            $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
            else
              if($ff.link(:text,"Next").exists?)
                $ff.link(:text,"Next").click
                sleep 5
                if($ff.text.include?($gift_nm))
                  puts "gift_pl_passed6"
                  $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                  else
                    puts "gift_pl_failed5"
                    $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                  end
                end
              end
              
            
          #$ff.goto("http://www.p.ipoll.com/my_rewards.php")
          $ff.goto("https://www.q.ipoll.com/my_rewards.php")
          sleep 3
					$ff.button(:value,"Donate Now").click
          sleep 5
					$ff.select_list(:id, "optRewardDonationIncr").select(/\$1.23/)
          sleep 1
         # if($ff.div(:id=>"idDivLoaderImage").exists?)
                #while $ff.div(:id=>"idDivLoaderImage").visible? do
                #sleep 0.5
                puts "waiting for rewards7 to load"
              #end
            #end
          sleep 4
					$ff.link(:text, "Last").click
					sleep 3
          $st = '6'
          $test_description = "Donation reward shown on cash out page"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					if($ff.text.include?($don_nm))
							puts "donation_pl_passed7"
							$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
					else
            if($ff.link(:text,"Next").exists?)
              $ff.link(:text,"Next").click
              sleep 3
              if($ff.text.include?($don_nm))
                puts "donation_pl_passed8"
                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                else
                  puts "donation_pl_failed7"
                  $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                end
              end
            end
					
					$ff.goto("http://www.q.ipoll.com/index.php?mode=logout")
					$ff.close
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					$ff.close
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
	  end
	  
end