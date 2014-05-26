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
require './Input Repository\new_cpi_cases.rb'

require './Input Repository\surveyurl.rb'
require './Input Repository\Test_01_Project_QG_Create_Input.rb'


class Test_XX_Feasibility_Report < Test::Unit::TestCase
  $wd=Dir.pwd
  $out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
  
$t = "XX - "
				$test_description = "Test Case: "+$t.to_s+"  FEASIBILITY REPORT "
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)


  def test_01_age_basic_criteria

begin

    $obj = Usamp_lib.new
    $obj.Delete_cookies()
    $ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
    
    $ie.goto("http://p.usampadmin.com/reports.php")
$ie.select_list(:id, "optReportsId").select "Feasibility Report"
sleep 2
$ie.checkbox(:id, "chkGetCountMethodOpt").set

$ie.link(:text => "Add basic criteria").click

sleep 4
$ie.select_list(:id, "optGeneralCriteriaId1").select "Age"
sleep 2
$ie.text_field(:id, "txtLowerAge1").set "20"
$ie.text_field(:id, "txtUpperAge1").set "30"

$ie.link(:text => "Add age range").click


sleep 2
$ie.text_field(:id, "txtLowerAge2").set "31"
$ie.text_field(:id, "txtUpperAge2").set "40"

$ie.checkbox(:id, "rdGroupByGeneral1").set

$ie.button(:id, "Refine").click


sleep 40

$text=$ie.frame(:id, "report_content").text
puts $text
$text_array = $text.split(/\n/)

				$st = '1'
				$test_description = "Group by: Basic criteria-age(InfiniDB) "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"

0.upto($text_array.size - 1) { |index|
if($text_array[index+1] =~ /InfiniDB Stats \(Time taken: \d{2}:\d{2}:\d{2}\)/)
  puts "infi found"
  if($text_array[index+3] =~ /TOTAL COUNT\d+/&&$text_array[index+5] =~ /20 - 30+\d+/&&($text_array[index+6] =~ /31 - 40+\d+/))
    puts "infi PASS"
    puts $text_array[index+5]
    
    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
    break
    else 
      puts "infi FAIL"
      					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	

    end
    break
  else
      puts "infi not found"
    end
    }
    
    				$st = '2'
				$test_description = "Group by: Basic criteria-age(Traditional) "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
    
$text=$ie.frame(:id, "report_content").text
puts $text
$text_array = $text.split(/\n/)
0.upto($text_array.size - 1) { |index|
if($text_array[index+1] =~ /Traditional Stats \(Time taken: \d{2}:\d{2}:\d{2}\)/)
  puts "trad found"
   if($text_array[index+3] =~ /TOTAL COUNT\d+/&&$text_array[index+5] =~ /20 - 30+\d+/&&($text_array[index+6] =~ /31 - 40+\d+/))
     puts "trad PASS"
     $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"

    break
    else 
      puts "trad FAIL"
      $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	
    end
    else
      puts "not found"
    end
    }
    
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

        def test_02_profile_criteria
          begin

    $obj = Usamp_lib.new
    $obj.Delete_cookies()
    $ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
    
    $ie.goto("http://p.usampadmin.com/reports.php")
$ie.select_list(:id, "optReportsId").select "Feasibility Report"
sleep 2
$ie.checkbox(:id, "chkGetCountMethodOpt").set

$ie.link(:id, "addProfileQuestion").click

sleep 10

$ie.select_list(:id, "optProfileId1").select "P1101:* Test company profile->Radio buttons"


$ie.select_list(:id, "optQuestionId1").select "Q21482: new2radio"
sleep 2

$ie.select_list(:id, "optAnswerId1").select "a"
$ie.select_list(:id, "optAnswerId1").select "c"
$ie.select_list(:id, "optAnswerId1").select "d"


#$ie.checkbox(:id, "rdGroupByGeneral1").set

$ie.button(:id, "Refine").click

sleep 40

$text=$ie.frame(:id, "report_content").text
puts $text
$text_array = $text.split(/\n/)

				$st = '3'
				$test_description = "Group by: Profile criteria(InfiniDB) "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"

0.upto($text_array.size - 1) { |index|
if($text_array[index+1] =~ /InfiniDB Stats \(Time taken: \d{2}:\d{2}:\d{2}\)/)
  puts "infi found"
  if($text_array[index+3] =~ /TOTAL COUNT\d+/)
    puts "infi PASS"
    puts $text_array[index+5]
    
    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
    break
    else 
      puts "infi FAIL"
      					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	

    end
    break
  else
      puts "infi not found"
    end
    }
    
    				$st = '4'
				$test_description = "Group by: Profile criteria(Traditional) "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
    
$text=$ie.frame(:id, "report_content").text
puts $text
$text_array = $text.split(/\n/)
0.upto($text_array.size - 1) { |index|
if($text_array[index+1] =~ /Traditional Stats \(Time taken: \d{2}:\d{2}:\d{2}\)/)
  puts "trad found"
   if($text_array[index+3] =~ /TOTAL COUNT\d+/)
     puts "trad PASS"
     $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"

    break
    else 
      puts "trad FAIL"
      $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	
    end
    else
      puts "not found"
    end
    }
    
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
      




  def test_03_zip_criteria

begin

    $obj = Usamp_lib.new
    $obj.Delete_cookies()
    $ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
    
    $ie.goto("http://p.usampadmin.com/reports.php")
$ie.select_list(:id, "optReportsId").select "Feasibility Report"
sleep 2
$ie.checkbox(:id, "chkGetCountMethodOpt").set

$ie.link(:text => "Add basic criteria").click

sleep 4
$ie.select_list(:id, "optGeneralCriteriaId1").select "Zip Code"
sleep 2

$ie.text_field(:id, "txtZipList").set "90001,90002,90004"


$ie.checkbox(:id, "rdGroupByGeneral1").set

$ie.button(:id, "Refine").click

sleep 40

$text=$ie.frame(:id, "report_content").text
puts $text
$text_array = $text.split(/\n/)

				$st = '5'
				$test_description = "Basic criteria-zip code(InfiniDB) "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"

0.upto($text_array.size - 1) { |index|
if($text_array[index+1] =~ /InfiniDB Stats \(Time taken: \d{2}:\d{2}:\d{2}\)/)
  puts "infi found"
  if($text_array[index+3] =~ /TOTAL COUNT\d+/&&$text_array[index+5] =~ /90002+\d+/&&($text_array[index+6] =~ /90004+\d+/)&&($text_array[index+7] =~ /90001+\d+/))
    puts "infi PASS"
    puts $text_array[index+5]
    
    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
    break
    else 
      puts "infi FAIL"
      					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	

    end
    break
  else
      puts "infi not found"
    end
    }
    
    				$st = '6'
				$test_description = "Basic criteria-zip code(Traditional) "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
    
$text=$ie.frame(:id, "report_content").text
puts $text
$text_array = $text.split(/\n/)
0.upto($text_array.size - 1) { |index|
if($text_array[index+1] =~ /Traditional Stats \(Time taken: \d{2}:\d{2}:\d{2}\)/)
  puts "trad found"
   
if($text_array[index+3] =~ /TOTAL COUNT\d+/&&$text_array[index+5] =~ /90001+\d+/&&$text_array[index+6] =~ /90002+\d+/&&($text_array[index+7] =~ /90004+\d+/))

puts "trad PASS"
     $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"

    break
    else 
      puts "trad FAIL"
      $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"	
    end
    else
      puts "not found"
    end
    }
    
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
        
    
   def test_04_keyword_search 

begin
    $obj = Usamp_lib.new
    $obj.Delete_cookies()
    $ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
    
    $ie.goto("http://p.usampadmin.com/reports.php")
$ie.select_list(:id, "optReportsId").select "Feasibility Report"
sleep 2


$ie.link(:id, "addProfileQuestion").click

sleep 10
$ie.text_field(:id, "keyword_search").set "google"

$ie.button(:name, "search_keyword").click

				$st = '7'
				$test_description = "Profile search(Keyword)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"


sleep 40
if($ie.text.include? 'Promote this question')
  puts "keyword search pass"
   $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
  else 
    puts "keyword search fail"
     $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
    

end
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
      
      def test_05_keyword_search 


begin
    $obj = Usamp_lib.new
    $obj.Delete_cookies()
    $ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
    
    $ie.goto("http://p.usampadmin.com/reports.php")
$ie.select_list(:id, "optReportsId").select "Feasibility Report"
sleep 2


$ie.link(:id, "addProfileQuestion").click

sleep 10
$ie.text_field(:id, "keyword_search").set "Q1092"

$ie.button(:name, /search_keyword/).click

				$st = '8'
				$test_description = "Profile search(Question ID)"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"


sleep 40
if($ie.text.include? 'Promote this question')
  puts "question search pass"
   $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
  else 
    puts "keyword search fail"
     $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
  end
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

        
        


  
