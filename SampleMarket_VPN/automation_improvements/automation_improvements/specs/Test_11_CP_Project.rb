# CLIENT PANELSHIELD PROJECT CREATION

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
require 'Input Repository\Test_11_CP_Project_Input.rb'

class Test_01_Project_QG_Create < Test::Unit::TestCase

			$wd=Dir.pwd
			#$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			#$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "11 - "
				$test_description = "Test Case: "+$t.to_s+"  CLIENT PANELSHIELD PROJECT CREATION"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_create_cp_project
	  
			begin
			
					$obj.Delete_cookies
                    
					$ff = $obj.Network_site_login($email,$passwd,$type)
					cpp_name= Time.now
                    cpp_name = cpp_name.to_s
                    cpp_name = cpp_name.slice(0..18)
                    cpp_num = "Test_CP_NUM_"+cpp_name # Appending time stamp to NAME of TEST CP PROJECT
                    cpp_name = "Test_CP_PROJ_"+cpp_name # Appending time stamp to NAME of TEST CP PROJECT
					$ff.goto("https://p.network.u-samp.com/pshield/ps_project_details.php")
					$ff.text_field(:id, "projectName").set(cpp_name)
                    $ff.text_field(:id, "projectNumber").set(cpp_num)
                    $ff.select_list(:id, "allGeoIPCountries").set($country)
                    $ff.button(:value," >> ").click
                    $ff.select_list(:id, "surveyLength").set($survey_length)
                    $ff.button(:name,"Submit").click
                    sleep 5
					$st = '1'
					$test_description = "Client Panelshield Project Creation"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					if ($ff.contains_text('Suppliers') && $ff.contains_text(cpp_name) )
							$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
					else
							$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
					end
			
			
			rescue => e
			
					puts e.message
					puts e.backtrace.inspect
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
				
			end
	   
	  end
	  
	  def test_03_supplier_add
	  
			begin
			
					$ff.link(:text, "Suppliers").click
                    $ff.select_list(:id, "supplierList").set($sup_name)
                    sleep 2
                    $ff.text_field(:id, "surveyUrl").set($sup_allowed_link)
                    sleep 2
                    $ff.text_field(:id, "rejectionUrl").set($sup_reject_link)
                    sleep 2
                    $ff.button(:value,"Add this supplier").click    
                    sleep 3
					$st = '2'
					$test_description = "Addition of supplier to CP Project"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					if ($ff.contains_text($sup_name))
							$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
					else
							$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
					end			
			
			rescue => e
					
					puts e.message
					puts e.backtrace.inspect
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			
			end	  
	  end
	  
	  def test_04_cp_survey_complete
	  
			begin
					$shield_id = /Test_CP_PROJ_(.)*/.match($ff.text)
                    $ln = $shield_id.to_s.length
                    if ($ln == 74)
                        $shield_id = $shield_id.to_s.slice(71..74)
                    end
                    if ($ln == 75)
                        $shield_id = $shield_id.to_s.slice(71..75)
                      end
                    
                    $ff.link(:text,'Stats').click
                    sleep 2
                    $html_contents=$ff.html
                     $html_array = $html_contents.split(/\n/)
                       0.upto($html_array.size - 1) { |index|
                          if($html_array[index] =~ /# Completes/)
                                 $html_array[index+9].scan(/[0-9]+</){$completes =$&; $completes=$completes.to_i;}
                                          break
                                            else
                                                  next
                                            end
                                          }
                      $completes = $completes + 1
                      
                      $html_contents=$ff.html
                     $html_array = $html_contents.split(/\n/)
                       0.upto($html_array.size - 1) { |index|
                          if($html_array[index] =~ /# Fails/)
                                 $html_array[index+9].scan(/[0-9]+</){$fails =$&; $fails=$fails.to_i;}
                                          break
                                            else
                                                  next
                                            end
                                          }
                      $fails = $fails + 1
                      
                      $html_contents=$ff.html
                     $html_array = $html_contents.split(/\n/)
                       0.upto($html_array.size - 1) { |index|
                          if($html_array[index] =~ /# Over Quota/)
                                 $html_array[index+9].scan(/[0-9]+</){$qf =$&; $qf=$qf.to_i;}
                                          break
                                            else
                                                  next
                                            end
                                          }
                      $qf = $qf + 1
                  
                  $enc_shield_id = Base64.encode64($shield_id)
                  $enc_shield_id = $enc_shield_id.chomp
                  $survey_url = "http://p.mr1mr.com/?pr=#{$enc_shield_id}&su=#{$sup_id}&id=&id2=&id3=&id4=&id5=&id6=&id7=&id8="
                  $survey_url=$survey_url.chomp
                  $ie1 = Watir::IE.new
                  $ie1.speed = :fast
                  sleep 2
                # Click on the link and complete the survey
                  $ie1.goto($survey_url)
                  sleep 10
                  $ie1.goto("http://p.mr1mr.com/redirect.php?S=1&PRID=#{$enc_shield_id}&ID=")
                  sleep 4
                  
                  $ff.link(:text,'Stats').click
                  sleep 2
                  $html_contents=$ff.html
                     $html_array = $html_contents.split(/\n/)
                       0.upto($html_array.size - 1) { |index|
                          if($html_array[index] =~ /# Completes/)
                                 $html_array[index+9].scan(/[0-9]+</){$new_completes =$&; $new_completes=$new_completes.to_i;}
                                          break
                                            else
                                                  next
                                            end
                                          }
				$st = '3'
				$test_description = "Client Panelshiel survey complete"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($new_completes == $completes)
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
				$obj.Delete_cookies 
                  sleep 5
                  $ie1.close
									
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				$obj.Close_all_windows
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
						
			end
			
			begin
			
				$ie2 = Watir::IE.new
                 $ie2.speed = :fast
                  #click on the link and screen out the survey 
                  $ie2.goto($survey_url)
                  sleep 8
                  $ie2.goto("http://p.mr1mr.com/redirect.php?S=2&PRID=#{$enc_shield_id}&ID=")
                  sleep 4
                 $ff.link(:text,'Stats').click
                  sleep 2
                 $html_contents=$ff.html
                     $html_array = $html_contents.split(/\n/)
                       0.upto($html_array.size - 1) { |index|
                          if($html_array[index] =~ /# Fails/)
                                 $html_array[index+9].scan(/[0-9]+</){$new_fails =$&; $new_fails=$new_fails.to_i;}
                                          break
                                            else
                                                  next
                                            end
                                          }
                 $st = '4'
				$test_description = "Client Panelshiel survey fail"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                 
                 if ($new_fails == $fails)
                        $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                  else
                         $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                  end
				
				$obj.Delete_cookies 
                  sleep 5
                  $ie2.close
				
			rescue => e
					puts e.message
					puts e.backtrace.inspect
					$obj.Close_all_windows
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			
			end
			
			
			begin
			
					  $ie3 = Watir::IE.new
					  $ie3.speed = :fast
					  $ie3.goto($survey_url)
					  sleep 10
					  
					  $ie3.goto("http://p.mr1mr.com/redirect.php?S=3&PRID=#{$enc_shield_id}&ID=")
					  sleep 4
					  $ff.link(:text,'Stats').click
					  sleep 2
					  $html_contents=$ff.html
						 $html_array = $html_contents.split(/\n/)
						   0.upto($html_array.size - 1) { |index|
							  if($html_array[index] =~ /# Over Quota/)
									 $html_array[index+9].scan(/[0-9]+</){$new_qf =$&; $new_qf=$new_qf.to_i;}
											  break
												else
													  next
												end
											  }
                $st = '5'
				$test_description = "Client Panelshiel survey overquota"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                
                 if ($new_qf == $qf)
                          $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                  else
                         $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                       end
			    $obj.Delete_cookies
                  sleep 5
                  $ie3.close
				  $ff.goto("https://p.network.u-samp.com/login.php?hdMode=logout")
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
	  
	  def test_05_cp_project_admin
	  
			begin
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
					$ie.goto("http://p.usampadmin.com/ps_projects_listing.php")
					sleep 2
					$ie.select_list(:id, "clientId").set($client)
                    $ie.button(:value,"Search").click
					$st = '6'
					$test_description = "Searching Client panelshield project in admin"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					if($ie.contains_text(/Test_CP_PROJ_/))
							puts "Search Passed"
							$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"                    
							$ie.link(:text, /Test_CP_NUM/).click
							$ie.link(:text, "Project Details").click
							$ie.select_list(:id, "surveyLength").set("6")
							$ie.button(:value,"Save Project").click
							$st = '8'
							$test_description = "Updating Client panelshield project in admin"
							$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
							$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
							if ($ie.text_field(:id,"surveyLength").value == "6")
								   puts "Project Update passed"
								   $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
								   $ie.select_list(:id, "surveyLength").set($survey_length)
								   sleep 5
								   $ie.button(:name,"Submit").click
							else
								  puts "Project Update failed"
								  $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
									  
							end
							#$ie.link(:href,/ps_project_suppliers/).click
							$ie.goto("http://p.usampadmin.com/ps_project_suppliers.php?project_id=#{$enc_shield_id}&client_id=#{$enc_cid}&client_contact_id=#{$enc_ccid}")
							sleep 5
							$ie.select_list(:name, "supplierList").set($sup_name_2)
							$ie.text_field(:id, "surveyUrl").set($sup_allowed_link)
							$ie.text_field(:id, "rejectionUrl").set($sup_reject_link)
							sleep 3
							$ie.button(:value,"Add This Supplier").click
							$st = '7'
							$test_description = "Adding Supplier to Client panelshield project in admin"
							$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
							$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
							if($ie.contains_text($sup_name_2))
                      
										puts "Supplier add passed"
										$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                      
							else
                      
										puts "Supplier add failed"
										$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                      
							end
							$ie.link(:text,'Stats').click
							sleep 2
							$html_contents=$ie.html
							 $html_array = $html_contents.split(/\n/)
							   0.upto($html_array.size - 1) { |index|
								  if($html_array[index] =~ /# Completes/)
										 $html_array[index+9].scan(/[0-9]+</){$completes =$&; $completes=$completes.to_i;}
												  break
													else
														  next
													end
												  }
							   
							  $html_contents=$ie.html
							 $html_array = $html_contents.split(/\n/)
							   0.upto($html_array.size - 1) { |index|
								  if($html_array[index] =~ /# Fails/)
										 $html_array[index+9].scan(/[0-9]+</){$fails =$&; $fails=$fails.to_i;}
												  break
													else
														  next
													end
												  }
													
							  $html_contents=$ie.html
							 $html_array = $html_contents.split(/\n/)
							   0.upto($html_array.size - 1) { |index|
								  if($html_array[index] =~ /# Over Quota/)
										 $html_array[index+9].scan(/[0-9]+</){$qf =$&; $qf=$qf.to_i;}
												  break
													else
														  next
													end
												  }
							$st = '8'
							$test_description = "Checking Client panelshield project stats in admin"
							$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
							$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
							if ($new_completes == $completes && $new_fails == $fails && $new_qf == $qf)
                        
									puts "Stats passed"
									$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
							
							else
							
									puts "Stats failed"
									$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
						  
							end 
					else
					
							puts "Search failed"
                      $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
					
					end		
			
			rescue => e
			
					puts e.message
					puts e.backtrace.inspect
					$obj.Close_all_windows
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end  
			
	  end
	  
	  def test_06_project_close
	  
			begin
					  $ie.goto("http://p.usampadmin.com/ps_projects_listing.php")
					  sleep 2
					  $ie.select_list(:id, "clientId").set($client)
                      $ie.button(:value,"Search").click
					  if($ie.contains_text(/Test_CP_PROJ_/))
							puts "Search Passed"
							$ie.link(:text, /Test_CP_NUM/).click
							  $ie.link(:text, "Project Details").click
							  $ie.select_list(:id, "projectStatus").set("CLOSED")
							  sleep 3
							  $ie.button(:value,"Save Project").click
							  $ie.link(:text,'Logout').click
							  $obj.Delete_cookies
							  $ie.close	
					  else
					  
							puts "Project not found"
					  
					  end
			
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