# SUCCESS/FAIL/OVERQUOTA REWARDS AT SITE LEVEL

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
require './Input Repository\Test_61_Rewards_at_site_level_Input.rb'

class Test_61_Rewards_at_site_level < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = '61 - '
				$test_description = "Test Case: "+$t.to_s+"  SUCCESS/FAIL/OVERQUOTA REWARDS AT PL SITE LEVEL"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
				
	  end
	  
	  def test_02_set_pl_rewards
  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
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
					
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")	
				sleep 2
				$ie.select_list(:name, "optQuotaStatus").select("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				$enc_site_id = Base64.encode64($site_id)
				$ie.goto("http://q.usampadmin.com/add_site.php?site_id=#{$enc_site_id}")
				sleep 3
				$ie.checkbox(:id, "cbCustomIncentiveGrid").set
				sleep 8
				$ie.link(:text,"Set Incentive Values").click
				sleep 12
				$ie.text_field(:id, "txtIncentive_upto_5_mins").set("0.75")
				$ie.text_field(:id, "txtIncentive_upto_10_mins").set("1")
				$ie.text_field(:id, "txtIncentive_upto_20_mins").set("1.25")
				$ie.text_field(:id, "txtIncentive_upto_30_mins").set("1.5")
				$ie.text_field(:id, "txtIncentive_upto_45_mins").set("1.75")
				$ie.text_field(:id, "txtIncentive_upto_60_mins").set("2")
				$ie.text_field(:id, "txtIncentive_more_than_60_mins").set("2.25")
				sleep 5
				$ie.button(:name,"btnUpdate").click
				sleep 5
				$ie.button(:value,"Close Window").click
				$ie.button(:id,"Refine").click
				$st = '1'
				$test_description = "Success reward set at PL level "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.checkbox(:id, "cbCustomIncentiveGrid").set?)
					puts "PASS"
                    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
                    $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ie.checkbox(:id, "chkFailOverquotaFlag").set
				$ie.text_field(:id, "txtMaxSurveysPerDay").set("3")
				$ie.radio(:id, "rdCashtype").set
				$ie.text_field(:id, "txtFailOverquotaAmount").set("0.25")
				$ie.button(:value,"Update").click
				$st = '2'
				$test_description = "Setting default Fail/Overquota reward at PL level "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if($ie.checkbox(:id, "chkFailOverquotaFlag").set? && $ie.radio(:id, "rdCashtype").set?)
					puts "PASS"
                    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "FAIL"
                    $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
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
	  
	  def test_03_success_reward
	  
			begin		
					$file_2 = File.open($qg_id_file_path)
					$qg_id = $file_2.gets
					puts $qg_id
					$file_2.close;
					
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ff = $obj.Surveyhead_login($m1_email,$m1_passwd)
					sleep 5
					puts "## Waiting for surveys to load ##"
					
				$survey_link  = Base64.encode64($qg_id)
                    $survey_link = "link"+$survey_link
                    $survey_link = $survey_link.chomp
                    puts $survey_link
                    sleep 10
                    $ff.link(:id, $survey_link).click
                    sleep 2
                    $ff.button(:value,"START SURVEY").click
                    sleep 10
					$ff.window(:title,"Survey").use do
                    #$ff1=FireWatir::Firefox.attach(:title,/Survey/)
                    $ff.goto($sc_red_url)
				    sleep 2
				#$ff1.close


         $ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				
					#@pid = Process.create(
                                        #:app_name  => 'ruby popup_closer_IE.rb',
                                        #:creation_flags  => Process::DETACHED_PROCESS
                                       # ).process_id
                                     #at_exit{ Process.kill(9,@pid) }
					
					$enc_mem_id = Base64.encode64($m1_mid)
					$ie.goto("http://q.usampadmin.com/member_activity_log.php?member_id=#{$enc_mem_id}")
					sleep 3
						$ie.checkbox(:xpath, "//input[@name='chkMemberSurveyClickIds[]']").set
                    $ie.button(:value,"Mark As Earned").click
		    $ie.alert.exists?
		    $ie.alert.ok
                    sleep 2
			
					$html_contents=$ie.html
                    $html_array = $html_contents.split(/\n/)
					
					0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /#{$qg_id}/)
						       
             
                            puts "***"
                            puts $html_array[index+8]
                            $html_array[index+8].scan(/[A-Za-z]+</){
                            if ($html_array[index+8] =~ /Earned/)
									puts "PASS"
                            else
                                    puts "FAIL"
                            end
                            }
                            break
                    else
                            next
                    end
                    }
                    

			
	#$ff.attach(:url,"https://www.p.ipoll.com/dashboard.php")
             #  $ff.link(:url,/my_rewards.php/).click
#$ff.goto("http://www.p.ipoll.com/my_rewards.php")
 $ff.window(:url,"https://www.q.ipoll.com/dashboard.php").use do
                    $ff.goto("https://www.q.ipoll.com/my_rewards.php")
puts "rewards page"
                    sleep 4
					$st = '3'
					$test_description = "Checking success reward earned on PL site"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                    $html_contents=$ff.html
                #    puts $html_contents
                  
                    $html_array = $html_contents.split(/\n/)
                    0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /#{$qg_id.chomp}/)
                      puts "** CHK AMT **"
                      puts $html_array[index+6]
                      puts $html_array[index+12]
                      puts "********"
                      if (($html_array[index+12] =~ /Earned/) && ($html_array[index+6] =~ /\$0.75/))
                        puts "PASS"
                        $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                        else
                          puts "FAIL"
                          $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                        end
                        break
                        else
                          next
                        end
                        }
		end
		end
                        $ff.goto("http://www.q.ipoll.com/index.php?mode=logout")
                        $ff.close
                        $ie.link(:text,"Logout").click
                        $ie.close
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					#$obj.Close_all_windows
					$ff.close
					$ie.close
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end	
	  end

	  def test_04_fail_reward

			begin		
					$file_2 = File.open($qg_id_file_path)
					$qg_id = $file_2.gets
					puts $qg_id
					$file_2.close;
					
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ff = $obj.Surveyhead_login($m2_email,$m2_passwd)
					sleep 5
					puts "## Waiting for surveys to load ##"
					
					$survey_link  = Base64.encode64($qg_id)
                    $survey_link = "link"+$survey_link
                    $survey_link = $survey_link.chomp
                    puts $survey_link
                    sleep 10
                    $ff.link(:id, $survey_link).click
                    sleep 2
                    $ff.button(:value,"START SURVEY").click
                    sleep 10
					$ff.window(:title,"Survey").use do
                    #$ff1=FireWatir::Firefox.attach(:title,/Survey/)
                    $ff.goto($fl_red_url)
				    sleep 2
					#$ff1.close
					
					#$ff.attach(:url,"https://www.p.ipoll.com/dashboard.php")
                    #$ff.link(:url,/my_rewards.php/).click
		     $ff.window(:url,"https://www.q.ipoll.com/dashboard.php").use do
                    $ff.goto("https://www.q.ipoll.com/my_rewards.php")
                    sleep 4
					$st = '4'
					$test_description = "Checking fail reward earned on PL site"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                    $html_contents=$ff.html
                    $html_array = $html_contents.split(/\n/)
                    0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /#{$qg_id.chomp}/)
							puts "** CHK AMT **"
							puts $html_array[index+5]
							puts $html_array[index+6]
							puts $html_array[index+7]
							puts $html_array[index+8]
							puts "********"
							if (($html_array[index+12] =~ /Earned/) && ($html_array[index+6] =~ /\$0.25/))
                                    puts "PASS"
                                    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                            else
                                    puts "FAIL"
                                    $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                            end
                            break
                    else
                            next
                    end
                    }
	    end
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
	  
	  def test_05_oq_reward
	  
			begin		
					$file_2 = File.open($qg_id_file_path)
					$qg_id = $file_2.gets
					puts $qg_id
					$file_2.close;
					
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ff = $obj.Surveyhead_login($m3_email,$m3_passwd)
					sleep 5
					puts "## Waiting for surveys to load ##"
					
					$survey_link  = Base64.encode64($qg_id)
                    $survey_link = "link"+$survey_link
                    $survey_link = $survey_link.chomp
                    puts $survey_link
                    sleep 10
                    $ff.link(:id, $survey_link).click
                    sleep 2
                    $ff.button(:value,"START SURVEY").click
                    sleep 10
					$ff.window(:title,"Survey").use do
                   # $ff1=FireWatir::Firefox.attach(:title,/Survey/)
                    $ff.goto($oq_red_url)
				    sleep 2
					#$ff1.close
					
					#$ff.attach(:url,"https://www.p.ipoll.com/dashboard.php")
                    #$ff.link(:url,/my_rewards.php/).click
		     $ff.window(:url,"https://www.q.ipoll.com/dashboard.php").use do
                    $ff.goto("https://www.q.ipoll.com/my_rewards.php")
                    sleep 4
					$st = '5'
					$test_description = "Checking Overquota reward earned on PL site"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                    $html_contents=$ff.html
                    $html_array = $html_contents.split(/\n/)
                    0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /#{$qg_id.chomp}/)
							puts "** CHK AMT **"
							puts $html_array[index+5]
							puts $html_array[index+6]
							puts $html_array[index+7]
							puts $html_array[index+8]
							puts "********"
							if (($html_array[index+12] =~ /Earned/) && ($html_array[index+6] =~ /\$0.25/))
                                    puts "PASS"
                                    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                            else
                                    puts "FAIL"
                                    $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                            end
                            break
                    else
                            next
                    end
                    }
	    end
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
	  
	  def test_06_reset_pl_rewards
	  
				begin	
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
					sleep 2
					$enc_site_id = Base64.encode64($site_id)
					$ie.goto("http://q.usampadmin.com/add_site.php?site_id=#{$enc_site_id}")
					sleep 3
					$ie.checkbox(:id, "cbCustomIncentiveGrid").clear
					sleep 2
					$ie.checkbox(:id, "chkFailOverquotaFlag").clear
					sleep 2
					$ie.button(:value,"Update").click
					$ie.link(:text,"Logout").click
					$ie.close
				rescue => e
					puts e.message
					puts e.backtrace.inspect
					#$obj.Close_all_windows
					$ie.close
				end
	  end


end

