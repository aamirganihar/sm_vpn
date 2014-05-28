# PR INVOCING WORK FLOW 

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
require 'Input Repository\Test_70_PR_invoicing_Input.rb'

class Test_70_PR_invoicing < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_2_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_2_ID.txt"
			$qg_id_file_path_2 = $wd+"/Input Repository/Copied_QG_2_ID.txt"
			$mem_email_file_path_1 = $wd+"/Input Repository/CPI_MEM_1_EMAIL_ID.txt"
			$token1_path = $wd+"/Config Management/PR_INV_TOKEN_1.txt"
			$token2_path = $wd+"/Config Management/PR_INV_TOKEN_2.txt"
			$token3_path = $wd+"/Config Management/PR_INV_TOKEN_3.txt"
			$zip_fl = $wd+"/Config Management/closing_confirmation.zip"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "70 - "
				$test_description = "Test Case: "+$t.to_s+" PR INVOICING "
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
	  end
=begin	  
	  def test_02_register_survey_click
	  
				$st = '1'
				$test_description = "Register a click"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				
				$ff = $obj.Surveyhead_login($mem_email,$mem_passwd)
				sleep 30
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
                $ff1 = FireWatir::Firefox.attach(:title,'TEST_AUTOMATION_SURVEY')
				$url = $ff1.url
                #$ff1.goto($sc_red_url)
				sleep 2
				if($ff1.contains_text(/THIS IS A TEST AUTOMATION SURVEY/))
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff1.close
				$ff.goto("p.surveyhead.com/index.php?mode=logout")
				$ff.close
				$url= $url.to_s
				$length=$url.length
				puts $length
				$url=$url.slice(49..$length)
				puts $url
				File.open($token3_path, 'w') do |f1| 
				  f1.puts $url
				end
	  end
=end	  
	  def test_03_project_status_change
				
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				
				@pid = Process.create(
                        :app_name  => 'ruby popup_closer_IE.rb',
                        :creation_flags  => Process::DETACHED_PROCESS
                        ).process_id
                at_exit{ Process.kill(9,@pid) }
				
				$file_1 = File.open($proj_id_file_path)
				$prj_id = $file_1.gets
				puts $prj_id
				$file_1.close;
				
				$st = '2'
				$test_description = "Change Project status to BILLING DEPT"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				
				$prj_n = Base64.encode64($prj_id)
				
				$ie.goto("http://p.usampadmin.com/add_project.php?project_id=#{$prj_n}")
				sleep 2
				$ie.select_list(:id, "optProjectStatus").set("Billing Dept")
				$ie.button(:value,"Save").click
				if($ie.contains_text(/Upload or paste completed tokens for crediting/))
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$st = '3'
				$test_description = "Review Project in admin"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$file_2 = File.open($token1_path)
				$pr_tk1 = $file_2.gets
				puts $pr_tk1
				$file_2.close;
				
				$file_3 = File.open($token2_path)
				$pr_tk2 = $file_3.gets
				puts $pr_tk2
				$file_3.close;
				
				$file_4 = File.open($token3_path)
				$pr_tk3 = $file_4.gets
				puts $pr_tk3
				$file_4.close;
				
				$tok_list = "#{$pr_tk1.chomp}" + "," + "#{$pr_tk3.chomp}" +"," + "#{$pr_tk2.chomp}"
				puts $tok_list
				
				#$ie.text_field(:id, "txtTokens").set($tok_list)
				#$ie.button(:value,"Check Tokens").click
				#sleep 10
				#$ie.button(:value,"Upload Tokens >>").click
				sleep 10
				$zip_fl = $zip_fl.gsub("/", "\\")
				puts $zip_fl
				#$ie.file_field(:id, ).set($zip_fl)
				#$ie.file_field(:name, $zip_fl).set($zip_fl)
				
				sleep 5
				$ie.select_list(:id, "optBillingCode1").set($billing_code)
				$ie.select_list(:id, "optBillingCode2").set($billing_code)
				$ie.select_list(:id, "optMonthId").set("November")
				$ie.select_list(:id, "optYearId").set("2011")
				$ie.button(:value,"Review Invoice>>").click
				sleep 5
				$ie.button(:value,"Submit to Accounting").click
				sleep 10
				
				if($ie.contains_text(/Your project has been successfully submitted/))
					puts "Pass - reviewed"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
					puts "Fail - not reviewed"
				end
				$ie.link(:text,"Logout").click
				$ie.close
				
				
	  end
	  
	  
	  
end