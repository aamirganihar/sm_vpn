# US GET COUNT CASE

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
require 'Input Repository\Test_09_US_getcount_Input.rb'

class Test_09_US_getcount < Test::Unit::TestCase

			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
		
		def test_01_report_head
	  
				$t = "9 - "
				$test_description = "Test Case: "+$t.to_s+"  US GET COUNT"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
									  
		end
		
		def test_02_US_getcount
        $obj = Usamp_lib.new
						$obj.Delete_cookies()
						$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)	
            $ie.goto("p.usampadmin.com/add_quota_group_criteria.php?project_id=MjIzMzEK&quota_group_id=MTAzOTc2")
            $ie.button(:value,"Get Count").click
						sleep 5
						puts "*** Waiting for count to load ***"
            sleep 8
            sleep 1 until $ie.text.include? "InfiniDB Get Count Stats"
            sleep 1 until $ie.text.include? "Traditional Get Count Stats"
            puts "Hello"
            
=begin            
             if($ie.div(:id=>"processingQGInfiniDBCount").exists?)
                  while $ie.div(:id=>"processingQGInfiniDBCount").visible? do
                  sleep 0.5
                  puts "waiting for Get counts to load 2"
                end
              end
              sleep 3
						if($ie.div(:id=>"processingQGCount").exists?)
                  while $ie.div(:id=>"processingQGCount").visible? do
                  sleep 05
                  puts "waiting for Get counts to load 1"
                end
              end
              sleep 2
=end             
              end
              

		
end