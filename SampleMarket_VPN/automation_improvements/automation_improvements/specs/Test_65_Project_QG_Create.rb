# NEW PROJECT (WITH ONE REDIRECT)/QG CREATION 

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
require 'Input Repository\Test_65_Project_QG_Create_Input.rb'

class Test_65_Project_QG_Create < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_2_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_2_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "65 - "
				$test_description = "Test Case: "+$t.to_s+"  PROJECT CREATION (WITH ONE SET OF REDIRECTS)/QG CREATION & SAVING CRITERIA"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  
	  def test_02_Project_Create
	  
				#$t = 1
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Project Creation (With one set of redirects for ALL quota groups)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
  
			begin
			
				  $obj = Usamp_lib.new
				  $obj.Delete_cookies()
				  $ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				  $ie.goto("p.usampadmin.com/add_project.php")
				  prj_name= Time.now
				  prj_name = prj_name.to_s
				  prj_name = prj_name.slice(0..18)
				  prj_name = "Test Automation Project_2_"+prj_name
				  $ie.select_list(:name, "optProjectStatus").set($proj_status)
				  $ie.text_field(:name, "txtProjectName").set(prj_name)
				  $ie.select_list(:name, "optProjectType").set($proj_type)
				  $ie.text_field(:name , 'txtEndDate').value = $proj_end_date
				  $ie.text_field(:id, "txtBidnumber").set($bid_no)
				  $ie.select_list(:id, "optBookedMonth").set($booked_month)
				  $ie.select_list(:id, "optBookedYear").set($booked_year)
				  $ie.text_field(:id, "txtBookedRev").set($booked_rev)
				  $ie.text_field(:id, "txtProjectedRev").set($proj_rev)
				  $ie.select_list(:id, "optMonthId").set($exp_close_month)
				  $ie.select_list(:id, "optYearId").set($exp_close_year)
				  $ie.select_list(:name, "optClient").set($client)
				  sleep 5
				  $ie.select_list(:name, "optSalesRep1").set($sales_rep)
				  $ie.select_list(:id, "optClientPM").set($client_pm)
				  $ie.checkbox(:id, "chkRelevantID_ON").clear
				  $ie.radio(:value, "OneSet").click
				  sleep 2
				  $ie.button(:value, "Save & Add Quota Group").click
				  sleep 3
				  project_id=/PR(\d+)/.match($ie.text)
				  #puts project_id[0]
				  $proj_id = project_id.to_s()
				  $ln = $proj_id.length
				  $ln -= 1
				  $proj_id = $proj_id.slice(2..$ln)
				  puts $proj_id
				  File.open($proj_id_file_path, 'w') do |f1| 
				  f1.puts $proj_id
				  end
				  if ($ie.contains_text(prj_name) && $ie.contains_text('Project details have been added successfully'))
								$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				  else 
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

	  def test_03_QG_Create
	  
					$st = '2'
					$test_description = "Quota Group Creation"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
	  
			begin
				  $prj_n = Base64.encode64($proj_id)
				  $ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}")
				  $ie.select_list(:name, "optQuotaStatus").set($qg_status)
				  $date=Time.now.strftime("%Y-%m-%d")
				  $SECONDS_PER_DAY = 60 * 60 * 24
				  $date_added_1=(Time.now + 10*$SECONDS_PER_DAY).localtime.strftime("%Y-%m-%d") 
				  puts $date_added_1
				  $ie.text_field(:name , 'txtQuotaCloseDate').value = $date_added_1
				  qg_name= Time.now
				  qg_name = qg_name.to_s
				  qg_name = qg_name.slice(0..18)
				  qg_name = "Test Automation QG_"+qg_name # Appending time stamp to NAME of TEST QG 
				  $ie.text_field(:name, "txtGroupName").set(qg_name)
				  $ie.text_field(:name, "txtSampleSize").set($n)
				  $ie.text_field(:name, "txtIncidence").set($inc)
				  $ie.radio(:name, "rdIncidenceRange", $inc_range).click
				  $ie.select_list(:id, "optCategory").set($qg_cat)
				  $ie.text_field(:name, "txtLengthTime").set($length)
				  $ie.text_field(:name, "txtCPI").set($cpi)
				  #if ($rew_type == 'Cash')
						
						#$ie.radio(:name, "rdRewardType", $rew_type).click
						#$ie.text_field(:name, "txtRewardAmount").set($rew_amt)
						#$ie.checkbox(:id, "chkFailRewardStatus").set
						#$ie.radio(:id, "rdFailCashtype").set
						#$ie.text_field(:id, "txtFailRewardAmount").set($fail_rew_amt)
						#$ie.text_field(:id, "txtFailRewardAmount").set("2")
						#$ie.checkbox(:id, "chkOverQuotaRewardStatus").set
						#$ie.radio(:id, "rdOQCashtype").set
						#sleep 2
						#$ie.text_field(:id, "txtOverQuotaRewardAmount").set($oq_rew_amt)						
				  
				  #else
				  
						#$ie.radio(:name, "rdRewardType", $rew_type).click
				  
				  #end
				  $ie.text_field(:id, "txtSurveyURL").set($survey_url)
				  sleep 2
				  $ie.button(:name,"btnSave").click
				  if ($ie.contains_text(qg_name) && $ie.contains_text('Criteria'))
				  
						puts "QG CREATION PASS"
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
						$file1 = File.open($qg_id_file_path, 'w');
						$qg_id= /GROUP DETAILS: QG(\d+)/.match($ie.text)
						$qg_id= $qg_id.to_s
						$length=$qg_id.length
						$qg_id=$qg_id.slice(17..$length)
						puts $qg_id
						$file1.print $qg_id;
						$file1.close;
				  
				  else
				  
						puts "QG CREATION FAILED"
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
			
		def test_04_Save_criteria
				
					$st = '3'
					$test_description = "Saving Quota Group Criteria"
					$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
					$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
					$gc = 0
					$psc = 0
					$mpoc = 0
					
			begin
				
				  $qg_n = Base64.encode64($qg_id)
				  #$ie.link(:text, "Criteria").click
				  $ie.goto("p.usampadmin.com/add_quota_group_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				  sleep 6
				  $ie.text_field(:name, "txtLowerAge1").set("10")
				  $ie.text_field(:name, "txtUpperAge1").set("99")
				  $ie.radio(:name, "rdGender", "Both").click
				  sleep 2
				  $ie.select_list(:name, "optEthnicity[]").set($ethnicity)
                  $ie.select_list(:name, "optIncomeLevels[]").set($inc_level)
                  $ie.select_list(:name, "optNationalityId[]").set($origin)
                  $ie.select_list(:name, "optEducationLevels[]").set($education)
				  $ie.button(:value,"Save Group").click 
				  sleep 3
				  if ($ie.contains_text(/Quota group criteria details have been saved successfully/))
						$gc = 1
				  end
				  $ie.goto("p.usampadmin.com/quota_member_pub_criteria.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				  sleep 5
				  $ie.checkbox(:id, "chkDoubleOpted").clear
				  $ie.checkbox(:name, "chkExcludeMembersFromThisClient").clear
				  $ie.checkbox(:name, "chkCompletedAnySurvey").clear
				  $ie.checkbox(:name, "chkExcludeMemberReceivedMailForAnyQG").clear
				  $ie.button(:value,"Save Group").click
				  #$ie.link(:text, "PanelShield").click
				  sleep 2
				  if ($ie.contains_text(/Quota group Member Publisher details have been updated successfully/))
						$mpoc = 1
				  end
				  $ie.goto("p.usampadmin.com/quota_group_panelshield.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				  sleep 2
				  $ie.checkbox(:name, "chkSpeederOption").clear
				  $ie.checkbox(:name, "chkGeoIpLookup").clear
				  $ie.checkbox(:name, "chkProxyDetection").clear
				  $ie.checkbox(:id,"chkRelevantIdOption").clear
				  $ie.checkbox(:name,"chkFingerPrintOption").clear
				  $ie.text_field(:name, "txtNoOfEmailClicks").set("999")
				  $ie.text_field(:name, "txtNoOfPublisherClicks").set("999")
				  $ie.button(:value,"Save").click
				  if ($ie.contains_text(/Panelshield details have been updated successfully/))
						$psc = 1
				  end
				  $ie.link(:url,/list_quota_group_publishers.php/).click
				  $ie.button(:value,"Add More Publishers").click
				  $ie.select_list(:id, "optPublishers").set($pub_name)
				  $ie.radio(:name, "rdCPI", "Amount").click
				  $ie.text_field(:name, "txtCPI").set("1")
				  $ie.button(:value,"Add Publisher").click
				  $ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
				  #$ie.link(:text, "Group Details").click
				  $ie.checkbox(:id, "chkShowSurvey").set
				  $ie.text_field(:id, "txtSurveyName").set("AUTO TEST SURVEY 2")
				  sleep 2
				  if ($rew_type == 'Cash')
						
						$ie.radio(:name, "rdRewardType", $rew_type).click
						$ie.text_field(:name, "txtRewardAmount").set($rew_amt)
						#sleep 3
						#$ie.checkbox(:id, "chkFailRewardStatus").set
						#$ie.radio(:id, "rdFailCashtype").set
						#$ie.text_field(:id, "txtFailRewardAmount").set($fail_rew_amt)
						#$ie.text_field(:id, "txtFailRewardAmount").set("2")
						#$ie.checkbox(:id, "chkOverQuotaRewardStatus").set
						#$ie.radio(:id, "rdOQCashtype").set
						sleep 2
						#$ie.text_field(:id, "txtOverQuotaRewardAmount").set($oq_rew_amt)						
				  
				  else
				  
						$ie.radio(:name, "rdRewardType", $rew_type).click
				  
				  end
				  sleep 3		  
				  $ie.button(:value,"Save Group").click
				  $ie.link(:text,'Logout').click
				  $obj.Delete_cookies
				  $ie.close
				  if ($gc == 1 && $mpoc == 1 && $psc == 1)
				  
						$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				  
				  else
				  
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
  
		  
end