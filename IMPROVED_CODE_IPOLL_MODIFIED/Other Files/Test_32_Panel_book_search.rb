# PANEL BOOK SEARCH

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
require './Input Repository\Test_32_Panel_book_search_Input.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

class Test_32_Panel_book_search < Test::Unit::TestCase

			$wd=Dir.pwd
			#$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
			#$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "32 - "
				$test_description = "Test Case: "+$t.to_s+"  PANEL BOOK SEARCH ON CORP SITE"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_panel_search
				
			begin	
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Panel book search"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				#$ff = FireWatir::Firefox.new
				driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                $ff = Watir::Browser.new driver
				$ff.goto("http://www.usamp.com/panel_book_search_results.php")  # Pointed to production as it is just a search
				#$ff.link(:text,/New to Panel Book Search/).click
				$ff.text_field(:id, "panel_search_box_result").set($search_string)
				sleep 2
				$ff.button(:class,"subBut").click
				sleep 5
				if ($ff.html.include?('What brands of energy drinks have you purchased in the past 12 months'))
					puts "Pass"
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts "Fail"
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				#$obj.Close_all_windows
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end
	  end
end