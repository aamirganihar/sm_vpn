# PUBLISHER MARGIN PERCENTAGE

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
require './Input Repository\Test_75_reward_based_on_publisher_cpi_Input.rb'

class Test_75_reward_based_on_publisher_cpi < Test::Unit::TestCase
  $wd=Dir.pwd
  $proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
	$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
	#$mem_email_file_path_2 = $wd+"/Input Repository/MEM_2_EMAIL_ID.txt"
	$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
  def test_01_report_head
    $t = "75 - "
		$test_description = "Test Case: "+$t.to_s+"  PUBLISHER MARGIN PERCENTAGE"
		$obj = Usamp_lib.new
		$obj.Test_report($test_description)
  end

  def test_02_project_and_group_creation
    begin
    $obj = Usamp_lib.new
    $obj.Delete_cookies()
    $ie = $obj.Usampadmin_login($admin_email,$admin_passwd)	
    $ie.goto("http://q.usampadmin.com/configuration_settings.php")
    $ie.text_field(:id,"txtPubTransactionFeePerc").set("12.00")
    $ie.button(:name,"bt_submit").click
    $obj = Usamp_lib.new
    $obj.Delete_cookies()
    #$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
    $ie.goto("q.usampadmin.com/add_project.php")
    prj_name= Time.now
    prj_name = prj_name.to_s
    prj_name = prj_name.slice(0..18)
    prj_name = "Test Automation Project_"+prj_name
    $ie.select_list(:name, "optProjectStatus").select($proj_status)
    $ie.text_field(:name, "txtProjectName").set(prj_name)
    $ie.select_list(:name, "optProjectType").select($proj_type)
    sleep 2
    #$ie.text_field(:name , 'txtSampleEndDate').value = $proj_end_date
	 $ie.image(:xpath, ".//*[@id='autoOpenDateTime']/td[2]/a/img").click
    $ie.button(:xpath, ".//*[@id='datepicker']/table/tbody/tr[1]/td[3]/button").click
    $ie.td(:xpath, ".//*[@id='datepicker']/table/tbody/tr[6]/td[4]").click
	
    $ie.text_field(:id, "txtBidnumber").set($bid_no)
    #$ie.select_list(:id, "optBookedMonth").set($booked_month)
    #$ie.select_list(:id, "optBookedYear").set($booked_year)
    $ie.text_field(:id, "txtBookedRev").set($booked_rev)
    $ie.text_field(:id, "txtProjectedRev").set($proj_rev)
    #$ie.select_list(:id, "optMonthId").set($exp_close_month)
    #$ie.select_list(:id, "optYearId").set($exp_close_year)
    #$ie.checkbox(:name,"chkAutoClose").set
    $ie.select_list(:name, "optClient").select($client)
    sleep 5
    $ie.select_list(:name, "optSalesRep1").select($sales_rep)
    $ie.select_list(:id, "optClientPM").select($client_pm)
    $ie.checkbox(:id, "chkRelevantID_ON").clear
    sleep 2
    $ie.button(:value, "Save & Add Quota Group").click
    sleep 10
    project_id=/PR(\d+)/.match($ie.text)
    #puts project_id[0]
    $proj_id = project_id.to_s()
    $ln = $proj_id.length
    $ln -= 1
    $proj_id = $proj_id.slice(2..$ln)
    puts $proj_id
    $prj_n = Base64.encode64($proj_id)
    $ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}")
    $ie.select_list(:name, "optQuotaStatus").select($qg_status)
    #$date=Time.now.strftime("%Y-%m-%d")
    #$SECONDS_PER_DAY = 60 * 60 * 24
    #$date_added_1=(Time.now + 10*$SECONDS_PER_DAY).localtime.strftime("%Y-%m-%d") 
    #puts $date_added_1
    #$ie.text_field(:name , 'txtQuotaCloseDate').value = $date_added_1
    qg_name= Time.now
    qg_name = qg_name.to_s
    qg_name = qg_name.slice(0..18)
    qg_name = "Test Automation QG_"+qg_name # Appending time stamp to NAME of TEST QG 
    $ie.text_field(:name, "txtGroupName").set(qg_name)
    $ie.text_field(:name, "txtSampleSize").set($n)
    $ie.text_field(:name, "txtIncidence").set($inc)
    $ie.radio(:name, "rdIncidenceRange").click
    $ie.select_list(:id, "optCategory").select($qg_cat)
    $ie.text_field(:name, "txtLengthTime").set($length)
    $ie.text_field(:name, "txtCPI").set($cpi)
    $ie.text_field(:id, "txtSurveyURL").set($survey_url)
    sleep 2
    $ie.button(:name,"btnSave").click
    sleep 10
    $qg_id= /GROUP DETAILS: QG(\d+)/.match($ie.text)
    $qg_id= $qg_id.to_s
    $length=$qg_id.length
    $qg_id=$qg_id.slice(17..$length)
    puts $qg_id
    $qg_n = Base64.encode64($qg_id)
    $ie.goto("q.usampadmin.com/add_quota_group_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
    sleep 6
    $ie.text_field(:name, "txtLowerAge1").set("10")
    $ie.text_field(:name, "txtUpperAge1").set("99")
    $ie.radio(:name, "rdGender").click
    sleep 2
    $ie.select_list(:name, "optEthnicity[]").select($ethnicity)
    $ie.select_list(:name, "optIncomeLevels[]").select($inc_level)
    $ie.select_list(:name, "optNationalityId[]").select($origin)
    $ie.select_list(:name, "optEducationLevels[]").select($education)
    $ie.button(:value,"Save Group").click 
    sleep 3
    if ($ie.html.include?('Quota group criteria details have been saved successfully'))
      $gc = 1
    end
    $ie.goto("q.usampadmin.com/quota_member_pub_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
    sleep 5
    $ie.checkbox(:id, "chkDoubleOpted").clear
    $ie.checkbox(:name, "chkExcludeMembersFromThisClient").clear
    $ie.checkbox(:name, "chkCompletedAnySurvey").clear
    $ie.checkbox(:name, "chkExcludeMemberReceivedMailForAnyQG").clear
    $ie.button(:value,"Save Group").click
    #$ie.link(:text, "PanelShield").click
    sleep 2
    if ($ie.html.include?('Quota group Member Publisher details have been updated successfully'))
      $mpoc = 1
    end
    $ie.goto("q.usampadmin.com/quota_group_panelshield.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
    sleep 2
    $ie.checkbox(:name, "chkSpeederOption").clear
    $ie.checkbox(:name, "chkGeoIpLookup").clear
    $ie.checkbox(:name, "chkProxyDetection").clear
    $ie.checkbox(:id,"chkRelevantIdOption").clear
    $ie.checkbox(:name,"chkFingerPrintOption").clear
    $ie.text_field(:name, "txtNoOfEmailClicks").set("999")
    $ie.text_field(:name, "txtNoOfPublisherClicks").set("999")
    $ie.button(:value,"Save").click
    if ($ie.html.include?('Panelshield details have been updated successfully'))
      $psc = 1
    end
     $ie.goto("q.usampadmin.com/list_quota_group_publishers.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
    $ie.button(:value,"Add More Publishers").click
    $ie.select_list(:id, "optPublishers").select($pub_name)
    $ie.radio(:name, "rdCPI").click
    $ie.text_field(:name, "txtCPI").set("1")
    $ie.button(:value,"Add Publisher").click
    $ie.goto("q.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
    $ie.checkbox(:id, "chkShowSurvey").set
    $survey_name= Time.now
    $survey_name = $survey_name.to_s
    $survey_name = $survey_name.slice(0..18)
    $survey_name = "Testing Publisher setting "+$survey_name
    $ie.text_field(:id, "txtSurveyName").set("#{$survey_name}")
    sleep 2
    if ($rew_type == 'Cash')
      $ie.radio(:name, "rdRewardType").click
      $ie.text_field(:name, "txtRewardAmount").set($rew_amt)
      sleep 2
      else
        $ie.radio(:name, "rdRewardType").click
      end
      sleep 3		  
      $ie.button(:value,"Save Group").click
      $pub_enc_id = Base64.encode64($pub_id)
      $ie.goto("http://q.usampadmin.com/add_publisher_revenue.php?hdMode=revenue_setup&publisher_id=#{$pub_enc_id}")
      $ie.checkbox(:id,"chkFutureOpp").set
      $ie.radio(:id,"chkRecRev2").set
      $ie.text_field(:id,"txtCpiPerc").set("25")
      $ie.text_field(:id,"txtCpiPercNonUS").set("25")
      $ie.radio(:id,"rdCpiCalculation").set
      $ie.checkbox(:id,"chkRewardCal").set
      $ie.text_field(:id,"txtRewardPerc").set("43")
      $ie.button(:id,"btnSave").click
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
  
  def test_03_dashboard_version_1_reward_value_on_dashboard
    $ff = $obj.Focusline_login($m1_email,$m1_passwd)
    sleep 8
    $st = '1'
    $test_description = "Checking if survey is seen for a publisher member on dashboard version 1"
    $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
    $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
    begin
    if ($ff.text.include?("#{$survey_name}"))
      puts "survey seen"
      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
      else
        puts "survey not seen"
        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      end
      $st = '2'
      $test_description = "Checking if reward shown for the publisher member is as per the calculations on dashboard version 1"
      $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
      $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
      $html_contents=$ff.html
      puts "first"
      puts "first"
      puts "first"
      puts "first"
      puts "first"
      #puts $html_contents
      $html_array = $html_contents.split(/\n/)
      0.upto($html_array.size - 1) { |index|
      if($html_array[index] =~ /#{$survey_name}/)
        puts "index+4"
        puts $html_array[index+4]
        $reward = $html_array[index+4].slice(194..199)
        puts $reward
        if($reward =~ /\$0.95/)
          puts "reward pass"
          $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
          else 
            puts "reward fail"
            $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
          end
          #$html_array[index+1].scan(/[0-9]+</){$completes =$&; $completes=$completes.to_i;}
          break
          else
            next
          end
          }
          #end
          $survey_link  = Base64.encode64($qg_id)
          #$survey_link = "link"+$survey_link
          $survey_link = $survey_link.chomp
          puts $survey_link
          #puts "http://sm.p.surveyhead.com/dashboard_routing_question_check.php?TYPE=NON_4S&QGID=#{$survey_link}"
          $ff.goto("http://sm.q.surveyhead.com/dashboard_routing_question_check.php?TYPE=NON_4S&QGID=#{$survey_link}")
          sleep 2
          #$ff.link(:id, $survey_link).click
          sleep 3
          $st = '3'
          $test_description = "Checking if reward amount is shown correctly for a publisher member on the survey details page on version 1"
          $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
          $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
          #puts $ff.html
          if ($ff.text.include?('$1.25') && $ff.text.include?($qg_id))
            puts "survey details are correct"
            $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
            else
              puts "survey details are not correct"
              $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
            end
            sleep 2
            $ff.button(:value,"START SURVEY").click
            sleep 10
			$ff.window(:title,"Survey").use do
            #$ff1 = FireWatir::Firefox.attach(:title,/Survey/)
            $ff.goto('http://q.u-samp.com/redirect.php?S=1')
            sleep 3
	    end
            $ff.link(:text,"My Rewards").click
            #$survey_name="Testing Publisher setting Wed Feb 06 22:57:29"
            $html_contents=$ff.html
            puts "second"
            puts "second"
            puts "second"
            puts "second"
            puts "second"
            #puts $html_contents
            $html_array = $html_contents.split(/\n/)
            0.upto($html_array.size - 1) { |index|
            if($html_array[index] =~ /#{$survey_name}/)
              puts "index rewards +6"
              puts $html_array[index+6]
              $reward = $html_array[index+6].slice(90..96)
              puts $reward
              $st = '4'
              $test_description = "Checking if reward amount is shown correctly for a publisher member on the Rewards page on version 1"
              $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
              $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
              if($reward =~ /\$1.26/)
                puts "reward pass"
                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                else 
                  puts "reward fail"
                  $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                end
                #$html_array[index+1].scan(/[0-9]+</){$completes =$&; $completes=$completes.to_i;}
                break
                else
                  next
                end
                }
                $ff.goto("http://sm.q.surveyhead.com/index.php?mode=logout")
                #$ff1.close
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
              #end
            end
            

            def test_04_dashboard_version_2_reward_value_on_dashboard
              $ff = $obj.Surveyhead_login($m1_email_sh,$m1_passwd_sh)
              sleep 8
              #$qg_id = "107954"
              #$survey_name="Test Automation QG_Wed Feb 06 21:19:23"
              $st = '5'
              $test_description = "Checking if survey is seen for a publisher member  on dashboard version 2"
              $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
              $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
              begin
              if ($ff.text.include?("#{$qg_id}"))
                puts "survey seen"
                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                else
                  puts "survey not seen"
                  $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                end
                $st = '6'
                $test_description = "Checking if reward shown for the publisher member is as per the calculations on dashboard version 2"
                $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
                $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                $html_contents=$ff.html
                puts "third"
                puts "third"
                puts "third"
                puts "third"
                puts "third"
                puts "third"
                #puts $html_contents
                $html_array = $html_contents.split(/\n/)
                0.upto($html_array.size - 1) { |index|
                if($html_array[index] =~ /#{$qg_id}/)
                  puts "index+1"
                  puts $html_array[index+1]
                  $reward = $html_array[index+1].slice(29..33)
                  puts $reward
                  if($reward =~ /\$1.25/)
                    puts "reward pass"
                    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                    else 
                      puts "reward fail"
                      $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                    end
                    #$html_array[index+1].scan(/[0-9]+</){$completes =$&; $completes=$completes.to_i;}
                    break
                    else
                      next
                    end
                    }
                    #end
                    $survey_link  = Base64.encode64($qg_id)
                    $survey_link = "link"+$survey_link
                    $survey_link = $survey_link.chomp
                    puts $survey_link
                    sleep 10
                    $ff.link(:id, $survey_link).click
                    sleep 8
                    $st = '7'
                    $test_description = "Checking if reward amount is shown correctly for a publisher member on version 2"
                    $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
                    $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                    if ($ff.text.include?('$1.25') && $ff.text.include?($qg_id))
                      puts "survey seen"
                      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                      else
                        puts "survey not seen"
                        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                      end
                      sleep 2
                      $ff.button(:value,"START SURVEY").click
                      sleep 10
					  $ff.window(:title,"Survey").use do
                      #$ff1 = FireWatir::Firefox.attach(:title,/Survey/)
                      $ff.goto('http://q.u-samp.com/redirect.php?S=1')
                      sleep 3
		      end
                      $ff.link(:text,"Rewards").click
                      $html_contents=$ff.html
                      puts "fourth"
                      puts "fourth"
                      puts "fourth"
                      puts "fourth"
                      puts "fourth"
                      #puts $html_contents
                      $html_array = $html_contents.split(/\n/)
                      0.upto($html_array.size - 1) { |index|
                      if($html_array[index] =~ /#{$survey_name}/)
                        puts "index+6"
                        #puts $html_array[index+6]
                        puts $html_array[index+7]
                        $reward = $html_array[index+7].slice(148..156)
                        puts $reward 
                        #puts $reward
                        $st = '8'
                        $test_description = "Checking if reward amount is shown correctly for a publisher member on the Rewards page on version 2"
                        $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
                        $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                        if($reward =~ /\$1.26/)
                          puts "reward pass"
                          $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                          else 
                            puts "reward fail"
                            $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                          end
                          #$html_array[index+1].scan(/[0-9]+</){$completes =$&; $completes=$completes.to_i;}
                          break
                          else
                            next
                          end
                          }
                          $ff.goto("http://www.q.ipoll.com/index.php?mode=logout")
                          #$ff1.close
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
                        #end
                      end
                    
                      def test_05_member_activity_focusline
                        $ie = $obj.Usampadmin_login($admin_email,$admin_passwd)	
                        $qg_id="107978"
                        $ie.goto("http://q.usampadmin.com/member_activity_log.php?member_id=MTE5NDg2Mzk=")
                        $html_contents=$ie.html
                        puts "fifth"
                        puts "fifth"
                        puts "fifth"
                        puts "fifth"
                        #puts $html_contents
                        
                        $html_array = $html_contents.split(/\n/)
                        0.upto($html_array.size - 1) { |index|
                        if($html_array[index] =~ /#{$qg_id}/)
                          puts "fline index+7"
                          puts $html_array[index+7]
                          $reward = $html_array[index+7].slice(23..26)
                          puts $reward
                          $st = '9'
                          $test_description = "Checking if reward amount is shown correctly for a version 1 publisher member on the member activity page"
                          $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
                          $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                          if($reward =~ /1.26/)
                            puts "reward pass"
                            $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                            else 
                              puts "reward fail"
                              $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                            end
                            #$html_array[index+1].scan(/[0-9]+</){$completes =$&; $completes=$completes.to_i;}
                            break
                            else
                              next
                            end
                            }
                            $ie.goto("http://q.usampadmin.com/member_activity_log.php?member_id=MTE5NDg2NDA=")
                            $html_contents=$ie.html
                            puts "sixth"
                            puts "sixth"
                            puts "sixth"
                            puts "sixth"
                            puts "sixth"
                            #puts $html_contents
                            $html_array = $html_contents.split(/\n/)
                            0.upto($html_array.size - 1) { |index|
                            if($html_array[index] =~ /#{$qg_id}/)
                              puts "new index+7"
                              puts $html_array[index+7]
                              $reward = $html_array[index+7].slice(23..26)
                              #puts $reward
                              $st = '10'
                              $test_description = "Checking if reward amount is shown correctly for a version 2 publisher member on the member activity page"
                              $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
                              $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                              if($reward =~ /1.26/)
                                puts "reward pass"
                                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                else 
                                  puts "reward fail"
                                  $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                                end
                                #$html_array[index+1].scan(/[0-9]+</){$completes =$&; $completes=$completes.to_i;}
                                break
                                else
                                  next
                                end
                                }
                                $ie.goto("http://q.usampadmin.com/login.php?hdMode=logout")
                                $ie.close
                              end
                            end