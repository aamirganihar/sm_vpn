# CLIENT PANELSHIELD RULES PROCESSING

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
require './Input Repository\Test_12_CP_rule_processing_Input.rb'
require './Input Repository\surveyurl.rb'
gem "selenium-client"
require "selenium/client"
require "selenium-webdriver"
require "watir-webdriver"
require "watir-webdriver/extensions/wait"

class Test_12_CP_Rule_processing < Test::Unit::TestCase
  $wd=Dir.pwd
  #$proj_id_file_path = $wd+"/Input Repository/Project_ID.txt"
  #$qg_id_file_path = $wd+"/Input Repository/QG_ID.txt"
  $out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
  def test_01_report_head
    $t = "12 - "
    $test_description = "Test Case: "+$t.to_s+"  CLIENT PANELSHIELD RULES PROCESSING"
    $obj = Usamp_lib.new
    $obj.Test_report($test_description)
  end
  
  def test_02_create_cp_project
    begin
    $obj.Delete_cookies
    sleep 5
    $ff = $obj.Network_site_login($email,$passwd,$type)
    sleep 5
    cpp_name= Time.now
    cpp_name = cpp_name.to_s
    cpp_name = cpp_name.slice(0..18)
    cpp_num = "Test_CP_NUM_"+cpp_name # Appending time stamp to NAME of TEST CP PROJECT
    cpp_name = "Test_CP_PROJ_"+cpp_name # Appending time stamp to NAME of TEST CP PROJECT
    $ff.goto("https://q.network.u-samp.com/pshield/ps_project_details.php")
    $ff.text_field(:id, "projectName").set(cpp_name)
    $ff.text_field(:id, "projectNumber").set(cpp_num)
    $ff.select_list(:id, "allGeoIPCountries").select($country)
    $ff.button(:value," >> ").click
    $ff.select_list(:id, "surveyLength").select($survey_length)
    $ff.button(:name,"Submit").click
    sleep 5
    if ($ff.html.include?('Suppliers') && $ff.html.include?(cpp_name) )
      puts "Project created"
      else
        puts "Project creation failed"
      end
      rescue => e
      puts e.message
      puts e.backtrace.inspect
	  $ff.close
    end
  end
  
  def test_03_supplier_add
    begin
    $ff.link(:text, "Suppliers").click
    $ff.select_list(:id, "supplierList").select($sup_name)
    sleep 2
    $ff.text_field(:id, "surveyUrl").set($sup_allowed_link)
    sleep 2
    $ff.text_field(:id, "rejectionUrl").set($sup_reject_link)
    sleep 2
    $ff.button(:value,"Add this supplier").click    
    sleep 3
    if ($ff.text.include?($sup_name))
      puts "Supplier added"
      else
        #puts "supplier addition failed"
      end			
      rescue => e
      puts e.message
      puts e.backtrace.inspect
	  $ff.close
    end	  
  end
  
  def test_04_rule_process
    begin
    $ff.link(:text,'Stats').click
    sleep 2
    $html_contents=$ff.html
    $html_array = $html_contents.split(/\n/)
    0.upto($html_array.size - 1) { |index|
    if($html_array[index] =~ /Maximum/)
      $html_array[index+9].scan(/[0-9]+</){$mx_clicks =$&; $mx_clicks=$mx_clicks.to_i;}
      break
      else
        next
      end
      }
      $mx_clicks = $mx_clicks.to_i
      $mx_clicks = $mx_clicks + 1
      puts "**** 5656 *****"
      puts $mx_clicks
      $html_contents=$ff.html
      $html_array = $html_contents.split(/\n/)
      0.upto($html_array.size - 1) { |index|
      if($html_array[index] =~ /Duplicate Panel/)
        $html_array[index+9].scan(/[0-9]+</){$dup_pnl =$&; $dup_pnl=$dup_pnl.to_i;}
        break
        else
          next
        end
        }
        puts $dup_pnl
        $dup_pnl = $dup_pnl + 1
        $html_contents=$ff.html
        $html_array = $html_contents.split(/\n/)
        0.upto($html_array.size - 1) { |index|
        if($html_array[index] =~ /Duplicate Survey/)
          $html_array[index+9].scan(/[0-9]+</){$dup_survey_comp =$&; $dup_survey_comp=$dup_survey_comp.to_i;}
          break
          else
            next
          end
          }
          puts $dup_survey_comp
          $dup_survey_comp= $dup_survey_comp + 1
          $html_contents=$ff.html
          $html_array = $html_contents.split(/\n/)
          0.upto($html_array.size - 1) { |index|
          if($html_array[index] =~ /Geo-IP/)
            $html_array[index+9].scan(/[0-9]+</){$geo_ip =$&; $geo_ip=$geo_ip.to_i;}
            break
            else
              next
            end
            }
            puts $geo_ip
            $geo_ip= $geo_ip + 1
            $html_contents=$ff.html
            $html_array = $html_contents.split(/\n/)
            0.upto($html_array.size - 1) { |index|
            if($html_array[index] =~ /Proxies/)
              $html_array[index+9].scan(/[0-9]+</){$proxy =$&; $proxy=$proxy.to_i;}
              break
              else
                next
              end
              }
              puts $proxy
              $proxy= $proxy + 1
              $html_contents=$ff.html
              $html_array = $html_contents.split(/\n/)
              0.upto($html_array.size - 1) { |index|
              if($html_array[index] =~ /Professionals/)
                $html_array[index+9].scan(/[0-9]+</){$prof =$&; $prof=$prof.to_i;}
                break
                else
                  next
                end
                }
                puts $prof
                $prof= $prof + 1
                $ff.link(:text, "Control Panel").click
                #$ff.checkbox(:id, "chbMaximumClicksOption").set
		$ff.checkbox(:xpath,".//*[@id='chbMaximumClicksOption']").set
                $ff.select_list(:id, "selMaximumClicks").select("1")
                $ff.button(:value,"SAVE changes").click
                $shield_id = /Test_CP_PROJ_(.)*/.match($ff.text)
                $ln = $shield_id.to_s.length
                if ($ln == 74)
                  $shield_id = $shield_id.to_s.slice(71..74)
                end
                if ($ln == 75)
                  $shield_id = $shield_id.to_s.slice(71..75)
                end
                $enc_shield_id = Base64.encode64($shield_id)
                $enc_shield_id = $enc_shield_id
                $survey_url = "http://q.mr1mr.com/?pr=#{$enc_shield_id}&su=#{$sup_id}&id=&id2=&id3=&id4=&id5=&id6=&id7=&id8="
                $survey_url=$survey_url
                #MAX CLICKS RULE
		driver = Selenium::WebDriver.for :ie #, :profile => "Selenium"
                    $ie1 = Watir::Browser.new driver
                #$ie1 = Watir::IE.new
                sleep 2
                # Click on the link 
                $ie1.goto($survey_url)
                sleep 10
                $ie1.close
                # Second click
                #$ie1 = Watir::IE.new
		driver = Selenium::WebDriver.for :ie #, :profile => "Selenium"
                    $ie1 = Watir::Browser.new driver
                sleep 2
                $ie1.goto($survey_url)
                sleep 10
                $st = '1'
                $test_description = "Max clicks rule"
                $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
                $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                if ($ie1.html.include?('This is the test client panelshield rejection page'))
                  puts "MAX_CLICKS: PASS"
                  $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                  else
                    puts "MAX_CLICKS: FAIL"
                    $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                  end
                  $ie1.close
                  # DUPLICATE PANEL ACCOUNT RULE
                  $ff.link(:text, "Control Panel").click
                  $ff.checkbox(:id, "chbMaximumClicksOption").clear
                  $ff.checkbox(:id, "chbRejectDuplicatePanelAccountOption").set
                  $ff.select_list(:id, "selDuplicatePanelAccounts").select("1")
                  $ff.button(:value,"SAVE changes").click
                  sleep 2
                  $ff.link(:text, "Suppliers").click
                  $ff.select_list(:id, "supplierList").select($sup_name_2)
                  sleep 2
                  $ff.text_field(:id, "surveyUrl").set($sup_allowed_link)
                  sleep 2
                  $ff.text_field(:id, "rejectionUrl").set($sup_reject_link)
                  sleep 2
                  $ff.button(:value,"Add this supplier").click    
                  sleep 3
                  $survey_url2 = "http://q.mr1mr.com/?pr=#{$enc_shield_id}&su=#{$sup_id2}&id=&id2=&id3=&id4=&id5=&id6=&id7=&id8="
                  $survey_url2=$survey_url2.chomp
                  #$ie1 = Watir::IE.new
		  driver = Selenium::WebDriver.for :ie #, :profile => "Selenium"
                    $ie1 = Watir::Browser.new driver
                  sleep 2
                  # Click on the link
                  $ie1.goto($survey_url2)
                  sleep 10
                  $st = '2'
                  $test_description = "Duplicate panel account rule"
                  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
                  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                  if ($ie1.html.include?('This is the test client panelshield rejection page'))
                    puts "DUP PANEL ACC: PASS"
                    $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                    else
                      puts "DUP PANEL ACC: FAIL"
                      $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                    end
                    $ie1.close
                    $ff.link(:text, "Control Panel").click
                    $ff.checkbox(:id, "chbRejectDuplicatePanelAccountOption").clear
                    $ff.button(:value,"SAVE changes").click
                    sleep 2
                    # DUPLICATE SURVEY COMPLETE
                    $ff.link(:text, "Control Panel").click
                    $ff.checkbox(:name, "chbRejectionStatusForDuplicateSurveyAttempts").set
                    $ff.button(:value,"SAVE changes").click
                    sleep 2
		    driver = Selenium::WebDriver.for :ie #, :profile => "Selenium"
                    $ie1 = Watir::Browser.new driver
                    #$ie1 = Watir::IE.new
                    sleep 2
                    # Click on the link and complete the survey
                    $ie1.goto($survey_url)
                    sleep 10
                    $ie1.goto("http://q.mr1mr.com/redirect.php?S=1&PRID=#{$enc_shield_id}&ID=")
                    sleep 1
                    $ie1.close
                    #$ie2 = Watir::IE.new
		     driver = Selenium::WebDriver.for :ie #, :profile => "Selenium"
                    $ie2 = Watir::Browser.new driver
                    sleep 2
                    # Click on the link and complete the survey
                    $ie2.goto($survey_url2)
                    sleep 10
                    $st = '3'
                    $test_description = "Duplicate survey complete rule"
                    $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
                    $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                    if ($ie2.html.include?('This is the test client panelshield rejection page'))
                      puts "DUP COMPL: PASS"
                      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                      else
                        puts "DUP COMPL: FAIL"
                        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                      end
                      $ie2.close
                      # GEO-IP RULE
                      $ff.link(:text, "Control Panel").click
                      $ff.checkbox(:name, "chbRejectionStatusForDuplicateSurveyAttempts").clear
                      $ff.checkbox(:name, "chbGeoIPStatus").set
                      $ff.button(:value,"SAVE changes").click
                      sleep 2
                      #$ie1 = Watir::IE.new
		       driver = Selenium::WebDriver.for :ie #, :profile => "Selenium"
                    $ie1 = Watir::Browser.new driver
                      sleep 2
                      # Click on the link
                      $ie1.goto($survey_url)
                      sleep 10
                      $st = '4'
                      $test_description = "Geo-IP rule"
                      $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
                      $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                      if($ie1.html.include?('This is the test client panelshield rejection page'))
                        $ff.link(:text, "Project Details").click
                        $ff.select_list(:id, "selectedGeoIPCountries").select($country)
                        $ff.button(:value," << ").click
                        $ff.select_list(:id, "allGeoIPCountries").select("CANADA")
                        $ff.button(:value," >> ").click
                        $ff.button(:value,"SAVE").click
                        #$ie2 = Watir::IE.new
			 driver = Selenium::WebDriver.for :ie #, :profile => "Selenium"
                    $ie2 = Watir::Browser.new driver
                        $ie2.goto($survey_url)
                        sleep 8
                        if ($ie2.html.include?('This is the test client panelshield rejection page'))
                          puts "GEO_IP: PASS"
                          $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                          else
                            $ff.link(:text, "Project Details").click
                            $ff.select_list(:id, "selectedGeoIPCountries").select("CANADA")
                            $ff.button(:value," << ").click
                            $ff.select_list(:id, "allGeoIPCountries").select($country)
                            $ff.button(:value," >> ").click
                            $ff.button(:value,"SAVE").click 
                            puts "GEO_IP: FAIL"
			$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                          end
                          $ie2.close
                          else
                            puts "GEO_IP: FAIL"
                            $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                          end
                          $ie1.close
                          # PROFESSIONAL RULE
                          $ff.link(:text, "Control Panel").click
                          $ff.checkbox(:name, "chbGeoIPStatus").clear
                          $ff.checkbox(:id, "chbRejectProfessional").set
                          $ff.select_list(:id, "professionalSurveyCount").select("1")
                          $ff.button(:value,"SAVE changes").click
                          sleep 2
                          #$ie1 = Watir::IE.new
			   driver = Selenium::WebDriver.for :ie #, :profile => "Selenium"
                           $ie1 = Watir::Browser.new driver
                          sleep 2
                          # Click on the link 
                          $ie1.goto($survey_url)
                          sleep 10
                          $st = '5'
                          $test_description = "Professional rule"
                          $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
                          $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                          if ($ie1.html.include?('This is the test client panelshield rejection page'))
                            puts "PROF:PASS"
                            $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                            else
                              puts "PROF:FAIL"
                              $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                            end
                            $ie1.close
                            #PROXY RULE
                            $ff.link(:text, "Control Panel").click
                            $ff.checkbox(:id, "chbRejectProfessional").clear
                            $ff.checkbox(:name, "chbRejectSuspiciousProxies").set
                            $ff.checkbox(:name, "chbRejectAllProxies").set
                            $ff.button(:value,"SAVE changes").click
                            sleep 2
                            #$ff1 = FireWatir::Firefox.new
			    driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                            $ff1 = Watir::Browser.new driver
                            $ff1.goto($survey_url)
                            sleep 8
                            $st = '6'
                            $test_description = "Proxy rule"
                            $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
                            $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                            #if ($ff1.html.include?('This is the test client panelshield rejection page'))
			    if($ff1.html.include?('This is the test client panelshield survey page'))
                              puts "PROXY:PASS"
                              $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                              else
                                puts "PROXY:FAIL" 
                                $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
			end
			      #driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                            #$ff = Watir::Browser.new driver
			      $ff1.window(:title,"CP_SURVEY_PAGE").use do
				      sleep 2
				end
		              $ff1.close
		                #driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                            #$ff = Watir::Browser.new driver
                              #$ff = FireWatir::Firefox.attach(:title,/uSamp/)
			      #$ff.window(:title,"uSamp").use do
                              $ff.link(:text, "Control Panel").click
                              $ff.checkbox(:name, "chbRejectSuspiciousProxies").clear
                              $ff.checkbox(:name, "chbRejectAllProxies").clear
                              $ff.button(:value,"SAVE changes").click
			      #end
                              sleep 2
                              #SPAMMER
                              #$ie1 = Watir::IE.new
			       driver = Selenium::WebDriver.for :ie #, :profile => "Selenium"
                              $ie1 = Watir::Browser.new driver
                              sleep 2
                              for x in 1..21 do
                                $ie1.goto($survey_url)
                                sleep 5
                              end
                              $st = '7'
                              $test_description = "Spammer rule"
                              $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
                              $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                              if($ie1.html.include?('The survey you have attempted is now closed'))
                                puts "SPAMMER:PASS"
                                $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
                                else
                                  puts "SPAMMER:FAIL"
                                  $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
                                end
                                $ie1.close
                                rescue => e
                                puts e.message
                                puts e.backtrace.inspect
                                #$obj.Close_all_windows
				$ff.close
                                $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
                                $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
                                $myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
                              end
                            end
                            
                            def test_05_project_close
                              begin
			       #driver = Selenium::WebDriver.for :firefox #, :profile => "Selenium"
                              #$ff = Watir::Browser.new driver
                              #$ff.window(:title,"uSamp").use do
			      #$ff = FireWatir::Firefox.attach(:title,/uSamp/)
                              $ff.link(:text, "Project Details").click
                              $ff.select_list(:id, "projectStatus").select("CLOSED")
                              $ff.button(:value,"SAVE").click
			      #end
                              sleep 2
                              #$ff.link(:text,'Log Out').click
                              $ff.goto("https://q.network.u-samp.com/login.php?hdMode=logout")
                              $ff.close
                              rescue => e
                              puts e.message
                              puts e.backtrace.inspect
				$ff.close
                            end
                          end
                        end
                        