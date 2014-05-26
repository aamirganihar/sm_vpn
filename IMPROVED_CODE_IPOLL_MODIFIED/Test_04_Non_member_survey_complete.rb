# NON MEMBER SURVEY COMPLETE/FAIL/OVER-QUOTA

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
require './Input Repository\Test_04_Non_member_survey_complete_Input.rb'
require './Input Repository\surveyurl.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

class Test_04_Non_Member_Survey_Complete < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "4 - "
				$test_description = "Test Case: "+$t.to_s+"  NON MEMBER SURVEY COMPLETE/FAIL/OVER-QUOTA (EX=5)"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_non_member_survey_complete
				
				$st = "1"
				$test_description = "Non member survey complete"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
	  
			begin
				
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
					
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
					$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
					$ie.select_list(:name, "optQuotaStatus").select("Open")
					$ie.button(:name,"btnSave").click
					sleep 2
					$ie.goto("http://q.usampadmin.com/quota_group_statistics.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
					sleep 3
                    $html_contents=$ie.html
                    $html_array = $html_contents.split(/\n/)
                    0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /# of Completes:/)
                            #puts $html_array[index+1]
                            $html_array[index+1].scan(/[0-9]+</){$completes =$&; $completes=$completes.to_i;}
                            break
                    else
							next
                    end
                    }
                    $completes = $completes + 1
					#$ie.link(:url,/list_quota_group_publishers.php/).click
					 $ie.goto("q.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
                    sleep 3
                    $ie.frame(:name, "quota_group_publisher_iframe").link(:text,'GO').click
		    #$c=$ie
                    sleep 20
                    $ie.window(:title,"Survey").use do
                    #$ie1.speed = :fast
		    #$ie1 = Watir::IE.attach(:title, 'Survey')
                    $ie.goto('http://q.u-samp.com/redirect.php?S=1')
		    sleep 10
		   end
	    
		#$ie.window(:title,"uSamp.com").use do
                    #$ie.speed = :fast
                    sleep 2
					$ie.goto("http://q.usampadmin.com/quota_group_statistics.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
					sleep 3					
					$html_contents=$ie.html
                    $html_array = $html_contents.split(/\n/)
                    0.upto($html_array.size - 1) { |index|
                        if($html_array[index] =~ /# of Completes:/)
                                #puts $html_array[index+1]
                                $html_array[index+1].scan(/[0-9]+</){$new_completes =$&; $new_completes=$new_completes.to_i;}
                                break
                        else
                                next
                        end
                    }
					
					if ($new_completes == $completes)
                            $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                    else 
                            $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                    end
					$ie.link(:text,'Logout').click
                    $obj.Delete_cookies
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
			
			def test_03_non_member_survey_fail
				
				$st = '2'
				$test_description = "Non member survey fail out"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
	  
					begin
						
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
							
							$obj = Usamp_lib.new
							$obj.Delete_cookies()
							$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
							$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
							$ie.select_list(:name, "optQuotaStatus").select("Open")
							$ie.button(:name,"btnSave").click
							sleep 2
							$ie.goto("http://q.usampadmin.com/quota_group_statistics.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
							sleep 3
							$html_contents=$ie.html
							$html_array = $html_contents.split(/\n/)
							0.upto($html_array.size - 1) { |index|
								if($html_array[index] =~ /# of Fails:/)
									#puts $html_array[index+1]
									$html_array[index+1].scan(/[0-9]+</){$fails =$&; $fails=$fails.to_i;}
									break
								else
									next
								end
							}
							$fails= $fails + 1
							#$ie.link(:url,/list_quota_group_publishers.php/).click
							 $ie.goto("q.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
							sleep 3
							$ie.frame(:name, "quota_group_publisher_iframe").link(:text,'GO').click
							sleep 20
							$ie.window(:title,'Survey').use do
							#$ie1.speed = :fast
							$ie.goto('http://q.u-samp.com/redirect.php?S=2')
							sleep 10
							#$ie.close
							end
							#$ie.window(:title,'uSamp.com').use do
							#$ie.speed = :fast
							#sleep 2
							$ie.goto("http://q.usampadmin.com/quota_group_statistics.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
							sleep 3					
							$html_contents=$ie.html
							$html_array = $html_contents.split(/\n/)
							0.upto($html_array.size - 1) { |index|
							if($html_array[index] =~ /# of Fails:/)
								#puts $html_array[index+1]
								$html_array[index+1].scan(/[0-9]+</){$new_fails =$&; $new_fails=$new_fails.to_i;}
								break
							else
								next
							end
							}
							if ($new_fails == $fails)
									$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
							else 
									$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
							end
							$ie.link(:text,'Logout').click
							$obj.Delete_cookies
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
		
		def test_03_non_member_survey_overquota
				
				$st = '3'
				$test_description = "Non member survey overquota"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
	  
					begin
						
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
							
							$obj = Usamp_lib.new
							$obj.Delete_cookies()
							$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
							$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
							$ie.select_list(:name, "optQuotaStatus").select("Open")
							$ie.button(:name,"btnSave").click
							sleep 2
							$ie.goto("http://q.usampadmin.com/quota_group_statistics.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
							sleep 3
							$html_contents=$ie.html
                            $html_array = $html_contents.split(/\n/)
                            0.upto($html_array.size - 1) { |index|
                            if($html_array[index] =~ /# of Over:/)
                                #puts $html_array[index+1]
                                $html_array[index+1].scan(/[0-9]+</){$overqt =$&; $overqt=$overqt.to_i;}
                                break
                            else
                                next
                            end
                            }
                            $overqt= $overqt + 1
							#$ie.link(:url,/list_quota_group_publishers.php/).click
							$ie.goto("q.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
							sleep 3
							$ie.frame(:name, "quota_group_publisher_iframe").link(:text,'GO').click
							sleep 20
							
							$ie.window(:title,'Survey').use do
							#$ie1.speed = :fast
							$ie.goto('http://q.u-samp.com/redirect.php?S=3')
							sleep 10
							end
							#$ie.window(:title,'uSamp.com').use do
							#$ie.speed = :fast
							sleep 2
							$ie.goto("http://q.usampadmin.com/quota_group_statistics.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
							sleep 3					
							$html_contents=$ie.html
                            $html_array = $html_contents.split(/\n/)
                            0.upto($html_array.size - 1) { |index|
                            if($html_array[index] =~ /# of Over:/)
                                #puts $html_array[index+1]
                                $html_array[index+1].scan(/[0-9]+</){$new_overqt=$&; $new_overqt=$new_overqt.to_i;}
                                break
                            else
                                next
                            end
                            }
							if ($new_overqt == $overqt)
                                      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                            else 
                                      $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                            end
							$ie.link(:text,'Logout').click
							$obj.Delete_cookies
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
		
	  
end