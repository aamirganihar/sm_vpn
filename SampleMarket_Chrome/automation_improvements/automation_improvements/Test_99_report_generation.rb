require 'rubygems'

#Load WATIR
require 'optparse'
require 'fileutils'
# Load WIN32OLE library
require 'win32ole'
require 'Win32API'
#Load the win32 library
#require 'win32/clipboard'
#include Win32
require 'digest/md5'
require 'base64'
#require './automation.rb'
require 'YAML'
require 'watir-webdriver'

	
	$wd=Dir.pwd
	filename = $wd+"/Report.html"
	#filename = $wd+"/Report_mayu.html"
#filename = $wd+"/Report_prod.html"
	#driver = Selenium::WebDriver.for :firefox, :profile => "Selenium"
	ie = Watir::Browser.new :chrome
	#ie = FireWatir::Firefox.new
	ie.goto("file:///"+filename)

	sleep 3
	body_text = ie.text
	
	ie.close
	#puts body_text
	html_array = body_text.split(/\n/)
	0.upto(html_array.size - 1) { |index|
	if(html_array[index] =~ /examples/)
		@code = html_array[index+0]
		break
		else
			next
		end
		}
		@total = @code.slice(0..3)
		@total =/(\d+)/.match(@total)
		puts @total
		
		@fail = @code.slice(12..17)
		@fail=/(\d+)/.match(@fail)
		puts @fail
		
		@passed = @total.to_s.to_i-@fail.to_s.to_i#MatchData object needs to be converted  to  string, then convert the string to a number
	puts @passed
		test_result = {}
		test_result['total'] = @total.to_s
		test_result['fail'] = @fail.to_s
		test_result['passed'] = @passed.to_s
		File.open("InputRepository/results_stage.yml","w"){|file| YAML.dump(test_result,file)}
	