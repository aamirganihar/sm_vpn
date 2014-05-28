# PUBLISHER CATEGORY FILTER

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
require 'Input Repository\Test_07_Publisher_category_filer_Input.rb'

class Test_07_Publisher_filter_category < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			#$mem_email_file_path_2 = $wd+"/Input Repository/MEM_2_EMAIL_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "7 - "
				$test_description = "Test Case: "+$t.to_s+"  PUBLISHER CATEGORY FILTER"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_publisher_category_filter_match
				
				$st = '1'
				$test_description = "Publisher category matching QG category"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
	  	  
			begin
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)	
					$pub_enc_id = Base64.encode64($pub_id)
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
					$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
					$ie.select_list(:name, "optQuotaStatus").set("Open")
					$ie.checkbox(:id, "chkShowSurvey").set
				    $ie.text_field(:id, "txtSurveyName").set("PUB CAT TEST SURVEY")
                    $ie.button(:value,"Save Group").click
					sleep 2
					$ie.goto("http://p.usampadmin.com/add_publisher_settings.php?hdMode=settings&publisher_id=#{$pub_enc_id}")
					$ie.checkbox(:id, "chkSurveyCategories").set
                    sleep 2
                    $ie.select_list(:id, "optCategoryId").set($match_cat)
                    $ie.button(:index,"3").click
                    sleep 2
                    $ie.button(:value,"Save").click
					$ff = $obj.Focusline_login($m_eml,$m_pswd)
					sleep 20
					if ($ff.contains_text("PUB CAT TEST SURVEY"))
							$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
					else
							$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
					end
					$ff.goto("http://www.sm.p.surveyhead.com/index.php?mode=logout")
					$ff.close
					$ie.link(:text,'Logout').click
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
	  
	  def test_03_publisher_category_filter_mismatch
				
				$st = '2'
				$test_description = "Publisher category not matching QG category"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
	  	  
			begin
					$obj = Usamp_lib.new
					$obj.Delete_cookies()
					$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
          sleep 2
					$pub_enc_id = Base64.encode64($pub_id)
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
					
					$ie.goto("http://p.usampadmin.com/add_publisher_settings.php?hdMode=settings&publisher_id=#{$pub_enc_id}")
					sleep 2
					$ie.select_list(:id, "optSelectedCategoryId").set($match_cat)
                    $ie.button(:index,"4").click
                    sleep 1
                    $ie.select_list(:id, "optCategoryId").set($mismatch_cat)
                    $ie.button(:index,"3").click
                    sleep 1
                    $ie.button(:value,"Save").click
                    sleep 2
					$ff = $obj.Focusline_login($m_eml,$m_pswd)
					sleep 20
					if ($ff.contains_text("PUB CAT TEST SURVEY"))
							$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
					else
							$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
					end
					$ff.goto("http://www.sm.p.surveyhead.com/index.php?mode=logout")
					$ff.close
					$ie.select_list(:id, "optSelectedCategoryId").set($mismatch_cat)
                    $ie.button(:index,"4").click
                    sleep 1
                    $ie.checkbox(:id, "chkSurveyCategories").clear
                    sleep 1
                    $ie.button(:value,"Save").click
                    sleep 2
					$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")
					$ie.select_list(:name, "optQuotaStatus").set("Open")
					$ie.checkbox(:id, "chkShowSurvey").set
				    $ie.text_field(:id, "txtSurveyName").set("AUTO TEST SURVEY")
                    $ie.button(:value,"Save Group").click
					sleep 2
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


