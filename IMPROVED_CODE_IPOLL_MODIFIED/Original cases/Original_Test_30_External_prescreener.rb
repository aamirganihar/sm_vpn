# EXTERNAL PRE-SCREENER

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
require 'Input Repository\surveyurl.rb'
require 'Input Repository\Test_30_External_prescreener_Input.rb'

class Test_30_External_prescreener < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "30 - "
				$test_description = "Test Case: "+$t.to_s+"  EXTERNAL PRE-SCREENER"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_set_prescreener_admin
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
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
				puts $prj_n
				puts $qg_n
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 3
				$ie.link(:text, "Pre-Screener").click
				sleep 2
				$ie.radio(:name, "rdPrescreenerOption", "EXTERNAL").click
                sleep 2
                $ie.text_field(:id, "txtPreSurveyURL").set("http://203.199.26.75/usamp/TEST_PRE_SURVEY.php")
                sleep 2
                $ie.button(:value,"Save").click
				sleep 3
				$st = '1'
				$test_description = "Saving External Pre-screener"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ie.contains_text('Pre-Survey redirect links'))
                        $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"  
                                      
                else
                        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"  
                end
				sleep 3
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
	  
	  def test_03_presurvey_complete
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
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
				puts $prj_n
				puts $qg_n
				
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 3
				$ie.link(:text, "Stats").click
                sleep 3
                $html_contents=$ie.html
                $html_array = $html_contents.split(/\n/)
                0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /# of Screener Clicks:/)
                    #puts $html_array[index+1]
                    $html_array[index+1].scan(/[0-9]+</){$scr_completes =$&; $scr_completes =$scr_completes .to_i;}
                        break
                    else
                        next
                    end
                }
                $scr_completes  = $scr_completes  + 1
				$ie.link(:url,/list_quota_group_publishers.php/).click
                sleep 3
                $ie.frame(:name, "quota_group_publisher_iframe").link(:text,'GO').click
                sleep 15
                $ie1=Watir::IE.attach(:title,'TEST_AUTOMATION_PRE_SURVEY')
                $ie1.speed = :fast
                $ie1.goto('http://p.u-samp.com/pre-redirect.php?S=1')
				sleep 5
				$ie1.close
				$ie=Watir::IE.attach(:title,'uSamp.com')
                $ie.speed = :fast
                sleep 2
                $ie.link(:text, "Stats").click
                sleep 3
				$html_contents=$ie.html
                    $html_array = $html_contents.split(/\n/)
                    0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /# of Screener Clicks:/)
                        #puts $html_array[index+1]
                        $html_array[index+1].scan(/[0-9]+</){$new_scr_completes =$&; $new_scr_completes =$new_scr_completes .to_i;}
                        break
                    else
                        next
                    end
                }
				$st = '2'
				$test_description = "External prescreener complete"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($new_scr_completes == $scr_completes)
                    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                else 
                    $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                end
				sleep 3
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
	  
	  def test_04_presurvey_fail
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
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
				puts $prj_n
				puts $qg_n
				
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 3
				$ie.link(:text, "Stats").click
                sleep 3
				$html_contents=$ie.html
                $html_array = $html_contents.split(/\n/)
                    0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /# of Screener Fails:/)
                        #puts $html_array[index+1]
                        $html_array[index+1].scan(/[0-9]+</){$scr_fails =$&; $scr_fails =$scr_fails .to_i;}
                        break
                    else
                        next
                    end
                }
                $scr_fails  = $scr_fails  + 1
				
				$ie.link(:url,/list_quota_group_publishers.php/).click
                sleep 3
                                
                $ie.frame(:name, "quota_group_publisher_iframe").link(:text,'GO').click
                sleep 15
                $ie1=Watir::IE.attach(:title,'TEST_AUTOMATION_PRE_SURVEY')
                $ie1.speed = :fast
                $ie1.goto('http://p.u-samp.com/pre-redirect.php?S=2')
                sleep 10
				$ie1.close
                $ie=Watir::IE.attach(:title,'uSamp.com')
                $ie.speed = :fast
                sleep 2
                $ie.link(:text, "Stats").click
                sleep 3
                # Get the new no of completes
                $html_contents=$ie.html
                $html_array = $html_contents.split(/\n/)
                    0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /# of Screener Fails:/)
                        #puts $html_array[index+1]
                        $html_array[index+1].scan(/[0-9]+</){$new_scr_fails =$&; $new_scr_fails =$new_scr_fails .to_i;}
                        break
                    else
                        next
                    end
                }
				$st = '3'
				$test_description = "External prescreener fail"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($new_scr_fails == $scr_fails)
                    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                else 
                    $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                end
				sleep 3
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
	  
	  def test_05_prescreener_reset
				
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
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
				puts $prj_n
				puts $qg_n
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				sleep 3
				$ie.link(:text, "Pre-Screener").click
				sleep 2
				$ie.radio(:name, "rdPrescreenerOption", "NO").click
                sleep 2
                $ie.button(:value,"Save").click
				sleep 3
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
end