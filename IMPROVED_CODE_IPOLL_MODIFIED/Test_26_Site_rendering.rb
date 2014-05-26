# SITE RENDERING IN MULTIPLE LANGUAGES
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
require './Input Repository\Test_26_SH_rendering_Input.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

class Test_26_SH_rendering < Test::Unit::TestCase

			$wd=Dir.pwd
			#$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			#$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "26 - "
				$test_description = "Test Case: "+$t.to_s+"  SITE RENDERING IN MULTIPLE LANGUAGES"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_spanish
				
			begin
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                $ff = Watir::Browser.new driver
				$ff.goto("http://www.q.ipoll.com/?L=10")
				sleep 2
				$st = '1'
				$test_description = "Site rendering in SPANISH language"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ff.text.include?("Se han destinado MILLONES de"))
					  puts "Espanol Test Passed"
					  $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					  puts "Espanol Test Failed"
					  $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end	
				$ff.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				$ff.close
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end	
				
	  end
	  
	  def test_03_deutch
				
			begin
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                $ff = Watir::Browser.new driver
				$ff.goto("http://www.q.ipoll.com/?L=4")
				sleep 2
				$st = '2'
				$test_description = "Site rendering in DEUTCH language"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ff.text.include?("Unternehmen in der ganzen Welt sind bereit"))
					  puts "Deutch Test Passed"
					  $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					  puts "Deutch Test Failed"
					  $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end	
				$ff.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				$ff.close
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end	
				
	  end
	  
	  def test_04_french
				
			begin
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                $ff = Watir::Browser.new driver
				$ff.goto("http://www.q.ipoll.com/?L=3")
				sleep 2
				$st = '3'
				$test_description = "Site rendering in FRENCH language"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ff.text.include?("Des entreprises du monde entier sont"))
					  puts "French Test Passed"
					  $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					  puts "French Test Failed"
					  $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end	
				$ff.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				$ff.close
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end	
				
	  end
	  
	  def test_05_italian
				
			begin
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                $ff = Watir::Browser.new driver
				$ff.goto("http://www.q.ipoll.com/?L=5")
				sleep 2
				$st = '4'
				$test_description = "Site rendering in ITALIAN language"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ff.text.include?("Le aziende di tutto il mondo sono disposte a"))
					  puts "Italian Test Passed"
					  $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					  puts "Italian Test Failed"
					  $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end	
				$ff.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				$ff.close
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end	
				
	  end
	  
	  def test_06_portuguse
				
			begin
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                $ff = Watir::Browser.new driver
				$ff.goto("http://www.q.ipoll.com/?L=13")
				sleep 2
				$st = '1'
				$test_description = "Site rendering in PORTUGUESE language"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				if ($ff.text.include?("As empresas do mundo todo"))
					  puts "Portuguese Test Passed"
					  $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					  puts "Portuguese Test Failed"
					  $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end	
				$ff.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end	
				
	  end

end