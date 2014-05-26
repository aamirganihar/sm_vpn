# PUBLISHER AUTo-ADD & QG CPI TYPES CHECKS (FCPI/STANDARD) 

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
require './Input Repository\Test_68_QG_cpi_cases_Input.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

class Test_68_QG_cpi_cases < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_2_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_2_ID.txt"
			$qg_id_file_path_2 = $wd+"/Input Repository/Copied_QG_2_ID.txt"
			$mem_email_file_path_1 = $wd+"/Input Repository/CPI_MEM_1_EMAIL_ID.txt"
			$token1_path = $wd+"/Config Management/PR_INV_TOKEN_1.txt"
			$token2_path = $wd+"/Config Management/PR_INV_TOKEN_2.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "68 - "
				$test_description = "Test Case: "+$t.to_s+" PUBLISHER AUTO ADD & QG CPI CASES (FCPI/STANDARD) "
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
				
	  end

	  def test_02_make_QG_copy
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
					
				#@pid = Process.create(
				#:app_name  => 'ruby popup_closer_IE.rb',
				#:creation_flags  => Process::DETACHED_PROCESS
				#).process_id
				#at_exit{ Process.kill(9,@pid) }
									 
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
				sleep 5
				$ie.link(:text,"Copy Selected Quota Group").click
				#sleep 3
				$ie.alert.exists?
				$ie.alert.ok	
				sleep 10				
				if($ie.html.include?('Quota Group details has been copied successfully'))
					puts "QG COPIED"
				else
					puts "QG COPY FAILED"
				end
					
				#$date=Time.now.strftime("%Y-%m-%d")
				#$SECONDS_PER_DAY = 60 * 60 * 24
				#$date_added_1=(Time.now + 10*$SECONDS_PER_DAY).localtime.strftime("%Y-%m-%d") 
				#puts $date_added_1
				sleep 5
				$ie.select_list(:name, "optQuotaStatus").select("Open")
				#$ie.text_field(:name , 'txtQuotaCloseDate').value = $date_added_1
				$file1 = File.open($qg_id_file_path_2, 'w');
				sleep 35
				$qg_id_2= /GROUP DETAILS: QG(\d+)/.match($ie.text)
				$qg_id_2= $qg_id_2.to_s
				$length=$qg_id_2.length
				$qg_id_2=$qg_id_2.slice(17..$length)
				puts $qg_id_2
				$file1.print $qg_id_2;
				$file1.close;
					
				$qg_n2 = Base64.encode64($qg_id_2)		
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.checkbox(:id, "chkShowSurvey").set
				$ie.text_field(:id, "txtSurveyName").set("QG CPI TYPES SURVEY")
				$ie.button(:name,"btnSave").click
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
  
	  def test_03_make_pub_revenune_settings
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$enc_pub_id = Base64.encode64($pub_id)
				$ie.goto("http://q.usampadmin.com/add_publisher_revenue.php?hdMode=revenue_setup&publisher_id=#{$enc_pub_id}")
				sleep 4
				$ie.radio(:id, "chkRecRev2").set
				$ie.text_field(:id, "txtCpiPerc").set($std_us_perc)
				$ie.text_field(:id, "txtCpiPercNonUS").set($std_non_us_perc)
				$ie.radio(:value, "perc_whole_cpi").set
				$ie.text_field(:id, "txtFirstRouterCpi").set($fcpi_perc)
				#$ie.text_field(:id, "txtCapAmount").set($cap_amt)
				$ie.button(:value,"Save").click
				$val1 = $ie.text_field(:id, "txtCpiPerc").value
				$val2 = $ie.text_field(:id, "txtCpiPercNonUS").value
				$val3 = $ie.text_field(:id, "txtFirstRouterCpi").value
				#$val4 = $ie.text_field(:id, "txtCapAmount").value
				$st = '1'
        puts $val1
        puts $val2
        puts $val3
       # puts $val4
				$test_description = "Saving Publisher revenue settings "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				sleep 10
				if($ie.html.include?('Publisher Revenue Details have been updated successfully') && $ie.radio(:id, "chkRecRev2").set? && $ie.radio(:value, "perc_whole_cpi").set? && $val1 == $std_us_perc && $val2 == $std_non_us_perc && $val3 == $fcpi_perc)
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
	  
	  def test_04_signup_member
	  
			begin	  
				  #$ff = FireWatir::Firefox.new
				  driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                  $ff = Watir::Browser.new driver
				  $ff.goto("q.ipoll.com/recaptcha_automation_proxy.php?mode=test")
				  $pb_id = $pub_id.slice(2..5)
				  puts $pb_id
				  $ff.goto("q.u-samp.com/registration_step1.php?P=#{$pb_id}")
				  $ff.text_field(:name, "txtFname").set("AUTO FNAME")
				  $ff.text_field(:name, "txtLname").set("AUTO LNAME")
                  $ff.select_list(:name, "optCountryId").select($country)
                  $ff.select_list(:name, "optLanguageId").select($lang)
                  sleep 7
                  $ff.select_list(:name, "optStateId").select($state)
                  sleep 2
                  $ff.text_field(:name, "txtZipPostal").set($zip_match)
                  $ff.select_list(:name, "optDayId").select($day)
                  $ff.select_list(:name, "optMonthId").select($month)
                  $ff.select_list(:name, "optYearId").select($year)
                  $ff.radio(:value, "Male").set
				  $extension = Time.new
                  $extension = $extension.to_s
                  $extension = $extension.slice(0..18)
                  $mail_address="auto_test.des"+$extension+"@mailinator.com"
                  $mail_address = $mail_address.gsub(/:/, "")
                  $mail_address = $mail_address.gsub(/\s/, "")
                  $mem_1 = $mail_address
				  $ff.text_field(:id, "txtEmail").set($mail_address)
                  sleep 5
                  $ff.text_field(:id, "txtConfirmEmail").set($mail_address)
                  $ff.text_field(:id, "txtPassword").set($mail_address)
                  $ff.text_field(:id, "txtConfirmPassword").set($mail_address)
                  $ff.checkbox(:name, "chbTermsAndConditions").set
				  sleep 1
                  $code= "test string"
                  puts $code
				  $ff.text_field(:name,"recaptcha_response_field").set($code)
                  $ff.button(:value, "Submit").click
				  $ff.select_list(:name, "optAnnualHouseholdIncomeId").select($inc_level)
                  $ff.select_list(:name, "optEducationLevelId").select($education)
                  $ff.select_list(:name, "optEmploymentStatusId").select($employment)
                  $ff.select_list(:name, "optMaritalStatusId").select($marrital_status)
                  $ff.select_list(:name, "optEthnicityId").select($ethnicity)
                  $ff.select_list(:name, "optNationalityId").select($origin)
                  $ff.radio(:value, "N").set
                  $ff.button(:value, "NEXT").click
                  sleep 5
				  $file1 = File.open($mem_email_file_path_1, 'w');
				  puts $mem_1
				  $file1.print $mem_1;
				  $file1.close;
				  puts "**** Waiting for surveys to load ****"
				  sleep 35
				  $st = '2'
				  $test_description = "Register a new member "
				  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				  if ($ff.html.include?('Logout'))
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				  else
						$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				  end
				  
				  $ff.goto("q.ipoll.com/index.php?mode=logout")
				  $ff.goto("q.ipoll.com/recaptcha_automation_proxy.php?mode=normal") # setting normal mode
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
	  
	  
	  def test_05_update_QG_urls
	  
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
				
				$file_3 = File.open($qg_id_file_path_2)
				$qg_id_2 = $file_3.gets
				puts $qg_id_2
				$file_3.close;
					
					
				$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
				$qg_n_2 = Base64.encode64($qg_id_2)
					
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")	
				sleep 2
				$ie.text_field(:id, "txtSurveyURL").set("http://www.instant.ly/s/gxZWu?TOKEN=%%token%%")
				$ie.select_list(:name, "optQuotaStatus").select("Open")
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n_2}")	
				sleep 2
				$ie.text_field(:id, "txtSurveyURL").set("http://www.instant.ly/s/gxZWu?TOKEN=%%token%%")
				$ie.select_list(:name, "optQuotaStatus").select("Open")
				sleep 5
				$ie.button(:name,"btnSave").click
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
	  
	  
	  def test_06_first_survey
	  
			begin	
				$st = '3'
				$test_description = "First Survey Complete"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$file_1 = File.open($mem_email_file_path_1)
				$em_id = $file_1.gets
				puts $em_id
				$file_1.close;
				$ff = $obj.Surveyhead_login($em_id,$em_id)
        puts "Logged in to iPoll for case 3"
				sleep 5
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				$survey_link  = Base64.encode64($qg_id)
                $survey_link = "link"+$survey_link
                $survey_link = $survey_link.chomp
                puts $survey_link
                sleep 10
                $ff.link(:id, $survey_link).click
                sleep 5
                $ff.button(:value,"START SURVEY").click
                sleep 10
				$ff.window(:title,"Survey").use do
                #$ff1 = FireWatir::Firefox.attach(:title,'Survey')
				$url = $ff.url
                $ff.goto($sc_red_url)
                sleep 1
                #$ff.button(:name, "Submit").click
				sleep 2
				if($ff.html.include?("Congratulations, you've just completed the survey"))
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
          puts "PASS for case 3"
				else
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
          puts "FAIL for case 3"
				end
				 
                #$ff1.close
				  end
				$ff.goto("q.ipoll.com/index.php?mode=logout")
				$ff.close
				
				$url= $url.to_s
				$length=$url.length
				puts $length
				$url=$url.slice(49..$length)
				puts $url
				File.open($token1_path, 'w') do |f1| 
				  f1.puts $url
				end
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

	  def test_07_check_pub_fcpi
	  
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
				$ie.goto("q.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$st = '4'
				$test_description = "Publisher auto addition"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$ie.frame(:name,"quota_group_publisher_iframe").select_list(:id,"optPublisherType").select("Show Auto Added Publishers")
				sleep 3
				if ($ie.frame(:name,"quota_group_publisher_iframe").text.include?($pub_name))
					puts "Pass"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "Fail"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$st = '5'
				$test_description = "Publisher earns FCPI for first survey complete "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$flg = 1;
				$html_contents=$ie.frame(:name,"quota_group_publisher_iframe").html
				$html_array = $html_contents.split(/\n/)      
                0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /First CPI/)
                        puts "***"
                        puts $html_array[index+1]
                        $html_array[index].scan(/[A-Za-z]+/){
                            if ($html_array[index+1] =~ /\$0.44/)
                                puts "PASS for case 5"
                                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                break
                            else
                                puts "FAIL for case 5"
                                $flg = 0
                            end
						}
						break
                    else
                        next
					
					end
                }
				if ($flg == 0)
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
	  
	  def test_08_second_survey
 			
			begin	
				$st = '6'
				$test_description = "Second Survey Complete"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$file_1 = File.open($mem_email_file_path_1)
				$em_id = $file_1.gets
				puts $em_id
				$file_1.close;
				$ff = $obj.Surveyhead_login($em_id,$em_id)
				sleep 5
				$file_2 = File.open($qg_id_file_path_2)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				$survey_link  = Base64.encode64($qg_id)
                $survey_link = "link"+$survey_link
                $survey_link = $survey_link.chomp
                puts $survey_link
                sleep 10
                $ff.link(:id, $survey_link).click
                sleep 5
                $ff.button(:value,"START SURVEY").click
                sleep 10
				$ff.window(:title,"Survey").use do
                #$ff = FireWatir::Firefox.attach(:title,'Survey')
				$url = $ff.url
                $ff.goto($sc_red_url)
                #$ff.button(:value, "Submit").click
				sleep 2
				if($ff.html.include?("Congratulations, you've just completed the survey"))
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				 
                #$ff1.close
				  end
				$ff.goto("q.ipoll.com/index.php?mode=logout")
				$ff.close
				
				$url= $url.to_s
				$length=$url.length
				puts $length
				$url=$url.slice(49..$length)
				puts $url
				File.open($token2_path, 'w') do |f1| 
				  f1.puts $url
				end
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
	  
	  def test_09_check_pub__stdcpi
	  
			begin	
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$file_1 = File.open($proj_id_file_path)
				$prj_id = $file_1.gets
				puts $prj_id
				$file_1.close;
			
				$file_2 = File.open($qg_id_file_path_2)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
					
					
				$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
					
				$ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")	
				sleep 2
				$ie.goto("q.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				$ie.frame(:name,"quota_group_publisher_iframe").select_list(:id,"optPublisherType").select("Show Auto Added Publishers")
				sleep 3
				
				$st = '7'
				$test_description = "Publisher earns Standard CPI for first survey complete "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$flg = 1;
				$html_contents=$ie.frame(:name,"quota_group_publisher_iframe").html
				$html_array = $html_contents.split(/\n/)      
                0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /Standard/)
                        puts "***"
                        puts $html_array[index+7]
                        $html_array[index].scan(/[A-Za-z]+/){
                            if ($html_array[index+7] =~ /\$0.26/)
                                puts "PASS for case 7"
                                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                break
                            else
                                puts "FAIL for case 7"
                                $flg = 0
                            end
						}
						break
                    else
                        next
					
					end
                }
				if ($flg == 0)
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
	  
end