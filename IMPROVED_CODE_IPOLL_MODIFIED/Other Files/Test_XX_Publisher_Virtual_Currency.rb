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
#require 'Input Repository\Test_68_QG_cpi_cases_Input.rb'

require './Input Repository\surveyurl.rb'
require './Input Repository\Test_01_Project_QG_Create_Input.rb'



class Test_XX_Publisher_Virtual_Currency < Test::Unit::TestCase
  $wd=Dir.pwd
  $out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  $qg_id_file_path = $wd+"/Input Repository/QG_2_ID.txt"
  $mem_email_file_path_1 = $wd+"/Input Repository/new_cpi_cases.rb"

  
  
$t = "XX - "
				$test_description = "Test Case: "+$t.to_s+"  FEASIBILITY REPORT "
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)

=begin
def test_01_add_virtual_currency

begin

    $obj = Usamp_lib.new
    $obj.Delete_cookies()
    $ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
    





$ie.goto("http://p.usampadmin.com/add_publisher_settings.php?hdMode=settings&publisher_id=UFUxNjgy")
sleep 5
$ie.text_field(:id, "txtVirtualCurrencyName").set "autoCrr"

$ie.text_field(:id, "txtVirtualCurrencyPoints").set "10"

$ie.button(:id, "btnSave").click
		$st = '1'
				$test_description = "Adding pub virtual curr"
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"

if($ie.html.include?('Publisher Settings have been updated successfully'))
puts "PASS"


else
puts "FAIL"
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

=end

def test_02_remove_virtual_currency
  begin
  
	$obj = Usamp_lib.new
				$obj.Delete_cookies()
			#$file_1 = File.open($mem_email_file_path_1)
    	#$em_id = $file_1.gets
			 #puts $em_id
				#$file_1.close;
        #$em = "test27augb@mailinator.com"
				$ff = $obj.Surveyhead_login($em_id,$em_id)
        puts "Logged in to iPoll for case 2"
				sleep 5
				$file_2 = File.open($qg_id_file_path)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
        
        
        
        

$text=$ff.table(:class => "table1").html
#puts $text
$text_array = $text.split(/\n/)

				$st = '2'
				$test_description = "Group by: Basic criteria-age(InfiniDB) "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"



if($ff.text.include?  'qg_id')
  puts "includes text qg id"
  
else
  puts "does not include text"
  end



0.upto($text_array.size - 1) { |index|
puts $text_array[index+1]
if($text_array[index+1] =~ /#{$qg_id}/)
puts $text_array[index+1]
  if($text_array[index+3] =~ /TOTAL COUNT\d+/&&$text_array[index+5] =~ /20 - 30+\d+/&&($text_array[index+6] =~ /31 - 40+\d+/))
    puts "infi PASS"
    puts $text_array[index+2]
    
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

        
        
        
=begin        
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
                $ff.button(:name, "Submit").click
				sleep 2
				if($ff.html.include?('Congratulations, you've just completed the survey'))
          puts "PASS for case 2"
				else
					
          puts "FAIL for case 2"
				end
				 
                #$ff1.close
				  end
				$ff.goto("p.ipoll.com/index.php?mode=logout")
				$ff.close
				
				$url= $url.to_s
				$length=$url.length
				puts $length
				$url=$url.slice(49..$length)
				puts $url
				File.open($token1_path, 'w') do |f1| 
				  f1.puts $url
				end
=end
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

=begin

  def test_02_remove_virtual_currency

begin

    $obj = Usamp_lib.new
    $obj.Delete_cookies()
    $ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
    





$ie.goto("http://p.usampadmin.com/add_publisher_settings.php?hdMode=settings&publisher_id=UFUxNjgy")
sleep 5
$ie.text_field(:id, "txtVirtualCurrencyName").set ""

$ie.text_field(:id, "txtVirtualCurrencyPoints").set ""

$ie.button(:id, "btnSave").click


		$st = '2'
				$test_description = "Group by: Basic criteria-age(InfiniDB) "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"

if($ie.html.include?('Publisher Settings have been updated successfully'))
puts "PASS"
$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"

else
puts "FAIL"
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

=end