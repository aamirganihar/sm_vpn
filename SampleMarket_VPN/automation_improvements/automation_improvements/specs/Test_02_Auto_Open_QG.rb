# QG AUTO OPEN

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
require 'Input Repository\Test_02_Auto_Open_QG_Input.rb'

class Test_02_Auto_open_QG < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "2 - "
				$test_description = "Test Case: "+$t.to_s+"  AUTO OPEN QUOTA GROUP"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_auto_open
	  
				$st = '1'
				$test_description = "Auto open Quota group"
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
					$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
					$ie.select_list(:name, "optQuotaStatus").set("Setting Up")
					$ie.button(:name,"btnSave").click
					sleep 2
                    $date=Time.now.strftime("%Y-%m-%d")
					$ie.checkbox(:id, "chkAutoOpen").set
					$ie.text_field(:name , 'txtAutoOpenDate').value = $date
				    $stamp = Time.new
					$stamp = $stamp.to_s
					$hour = $stamp.slice(11..12)
					$min = $stamp.slice(14..15)
					$second = $stamp.slice(17..18)
					puts $hour
					puts $min
					puts $second
					if ($min.to_i < 58 && $min.to_i > 8) 
							$min = $min.to_i+2
					else 
						if ($min.to_i < 8) 
								$min1 = $min.to_i+2
								$min = "0"+$min1.to_s
						else
							if ($min.to_i == 58 && $hour.to_i >= 9 && $hour.to_i <23)
								  $min = $min.to_i+2
								  $min = 60 - $min.to_i
								  $hour = $hour.to_i+1
								  $min = $min.to_i+1
							else
								if ($min.to_i == 58 && $hour.to_i < 9)
									  $min = $min.to_i+2
									  $min = 60 - $min.to_i
									  $hour = $hour.to_i+1
									  $hour = "0"+$hour.to_s
									  $min = "0"+$min.to_s
								else
									if ($min.to_i > 58 && $hour.to_i >= 9 && $hour.to_i <23)
										  $min = $min.to_i+2
										  $min = $min.to_i - 60
										  $hour = $hour.to_i+1
									else
										if ($min.to_i > 58 && $hour.to_i < 9 )
											  $min = $min.to_i+2
											  $min = $min.to_i - 60
											  $hour = $hour.to_i+1
											  $hour = "0"+$hour.to_i
										else
											if ($min.to_i == 58 && $hour.to_i == 23)
												  $min = $min.to_i+2
												  $min = 60 - $min.to_i
												  $hour = "00"
											else
												if ($min.to_i > 58 && $hour.to_i == 23)
													  $min = $min.to_i+2
													  $min = $min.to_i - 60
													  $hour = "00"
												end
											end
										end
									end
								end
							end
						end
					end
					puts $hour
					puts $min
					puts $second
					$ie.select_list(:name, "optHours").set($hour)
					$ie.select_list(:name, "optMinutes").set($min)
					$ie.button(:value,"Save Group").click	
					sleep 200 # Waiting for CRON to update QG status
					$ie.link(:text, "Stats").click
					sleep 3
					if ($ie.contains_text('Open change status'))
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
					$obj.Close_all_windows
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			
			
			end
	    
	  
	  end
	    
	  
	  
end