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
#require 'daemons'
require 'Input Repository\Test_15_Profile_creation_Input.rb'




class Test_15_profile_creation < Test::Unit::TestCase
  
      $wd=Dir.pwd
      $out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
      $prof_name_path = $wd+"/Input Repository/Profile_Name.txt"
	  $prof_id_path = $wd+"/Input Repository/Profile_ID.txt"
      
            
	def test_01_report_head
	  
				$t = "15 - "
				$test_description = "Test Case: "+$t.to_s+"  PROFILE CREATION"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	end
 
    def test_02_profile_creation
    
      
      
    begin  
     
      #Login into United Sample Admin site
      $obj.Delete_cookies
      #$obj.Close_all_windows
      $ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
	  
	  $ext = Time.new
      $ext = $ext.to_s
      $ext = $ext.slice(0..18)
      $ext = $ext.gsub(/\s/, "_")
      $ext = $ext.gsub(/:/, "")
      
      $prf_nm = "Test_Profile"+$ext
	  $file1 = File.open($prof_name_path, 'w');
	  $file1.print $prf_nm;
	  puts $prf_nm
	  $file1.close;
	  
      $ie.link(:text,"Profile Mgmt").click
      $ie.link(:text,'Create New Profile').click
	  #$ie.goto("http://p.usampadmin.com/add_profile.php")
      $ie.text_field(:name, "txtProfileName").set($prf_nm)
	  #Category name
	  #$ie.text_field(:name, "txtCategoryName").set($prf_cat)
      #Reading value for profile reward from file. Currently set as 2 in the file
      $ie.text_field(:name, "txtProfileReward").set($prf_rew)
      #Reading value for Questions per page from file. Currently set as 2 in the file
      $ie.text_field(:name, "txtProfileQuestionPerPage").set($qn_per_page)
      #checking the checkbox for profile expiry
      $ie.checkbox(:name, "chkSetProfileExpiry").set
      sleep 2
      
                 @pid = Process.create(
         :app_name  => 'ruby popup_closer_IE.rb',
         :creation_flags  => Process::DETACHED_PROCESS
         ).process_id
         
      at_exit{ Process.kill(9,@pid) }
      


      #setting the profile expiry to 0
      $ie.text_field(:name, "txtProfileExpiry").set($prof_exp)
      sleep 3
      $ie.button(:name, "Refine").click
      sleep 2
      $ie.radio(:name, "rdSelectCountry").set
      #setting the lower age limit to 10 years
      $ie.text_field(:name, "txtProfileLowerAge").set($age_min)
      #setting the upper age limit to 90 years
      $ie.text_field(:name, "strProfileUpperAge").set($age_max)
      #setting the criteria to accept both male and female gender
      $ie.radio(:index, 5).set
      #Setting Industry to Aerospace & Defense, Agribusiness, Airline
      $ie.select_list(:name, "optIndustry[]").select($ind_opt1)
      #$ie.select_list(:name, "optIndustry[]").select($file_data[8])
      #$ie.select_list(:name, "optIndustry[]").select($file_data[9])
      
      #Setting Ethnicity to African American, Asian (non Pacific Islander), Caucasian
      $ie.select_list(:name, "optEthnicityId[]").select($ethnic)
      #$ie.select_list(:name, "optEthnicityId[]").select($file_data[11])
      #$ie.select_list(:name, "optEthnicityId[]").select($file_data[12])
      
      #Setting role to Administration / Management, Construction / Maintenance / Real Estate, Executives
      $ie.select_list(:name, "optRole[]").select($role)
      #$ie.select_list(:name, "optRole[]").select($file_data[14])
      #$ie.select_list(:name, "optRole[]").select($file_data[15])
      
      #Setting Education Details to High school graduate, Some college or university, College graduate with a 4 year degree
      $ie.select_list(:name, "optEducationLevels[]").select($edu)
      #$ie.select_list(:name, "optEducationLevels[]").select($file_data[17])
      #$ie.select_list(:name, "optEducationLevels[]").select($file_data[18])
      
      #Setting employment details to Full-Time Employee, Homemaker, Part-Time Employee
      $ie.select_list(:name, "optEmploymentStatus[]").select($employment)
      #$ie.select_list(:name, "optEmploymentStatus[]").select($file_data[20])
      #$ie.select_list(:name, "optEmploymentStatus[]").select($file_data[21])
      
      #Setting maritial status to Never married, Married, Living with Partner
      $ie.select_list(:name, "optMaritalStatus[]").select($marital)
      #$ie.select_list(:name, "optMaritalStatus[]").select($file_data[23])
      #$ie.select_list(:name, "optMaritalStatus[]").select($file_data[24])
      
      $ie.button(:name, "Refine").click
	  
      $t = "18"
      $st = '1'
	  $test_description = "Profile Creation"
	  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
	  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
      if $ie.contains_text('ADD/EDIT QUESTION CRITERIA')
        $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
        else
          $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
        end
         
      $ie.button(:value, "Next").click
      $ie.button(:name, "Submit").click

      #Adding a question text
      $ie.text_field(:name, "strQuestion").set($qn1)
	  $ie.text_field(:name, "strDisplayName").set($qn1)
      #Selecting the answer type to be Check Boxes
      $ie.select_list(:name, "optType").select("Check Boxes")
      #Setting the answers
      $ie.text_field(:name,'strQuickLoad').set("BMW\nAUDI\nMERC\nFERRARI")
      $ie.button(:name, "btnQuickLoad").click
      $temp = $ie.text_field(:name,"strQuickLoad").value      
      
      $ie.button(:value, "Add").click
      $st = '2'
	  $test_description = "Adding check box type of question"
	  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
	  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"    
      if($ie.contains_text("Question added successfully."))
      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
      else
        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      end
      
      puts $temp
      $st = '3'
	  $test_description = "Check ONE-WAY BULK LOAD feature"
	  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
	  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
	  
      if ($temp =~ /BMW/ && $temp =~ /AUDI/ && $temp =~ /MERC/ && $temp =~ /FERRARI/)
      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
      else
        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      end
        

      $st = '4'
	  $test_description = "Add Parent type of question"
	  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
	  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
      
      if($ie.contains_text("Question added successfully."))
      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
      else
        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      end
      
      $ie.button(:value, "Add a New Question").click
      #Adding a question text 
      $ie.text_field(:name, "strQuestion").set($qn2)
	  $ie.text_field(:name, "strDisplayName").set($qn2)
      #Selecting the answer type to be Date Filed
      $ie.select_list(:name, "optType").select("Date Field")
      
      $ie.button(:value, "Add").click
      $st = '5'
	  $test_description = "Add date field type of question"
	  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
	  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"      
      if($ie.contains_text("Question added successfully."))
      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
      else
        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      end
      
      $ie.button(:value, "Add a New Question").click
      #Adding a question text 
      $ie.text_field(:name, "strQuestion").set($qn3)
	  $ie.text_field(:name, "strDisplayName").set($qn3)
      $ie.select_list(:name, "optType").select("Drop Down")
      $ie.text_field(:name, "strQuickLoad").set($ans_3_1)
      $ie.button(:name, "btnQuickLoad").click
      #sleep 1
      $ie.text_field(:name, "strQuickLoad").set($ans_3_2)
      $ie.button(:name, "btnQuickLoad").click
      #sleep 1
      $ie.text_field(:name, "strQuickLoad").set($ans_3_3)
      $ie.button(:name, "btnQuickLoad").click
      #sleep 1
      $ie.text_field(:name, "strQuickLoad").set($ans_3_4)
      $ie.button(:name, "btnQuickLoad").click
      #sleep 1
      $ie.button(:value, "Add").click
      $st = '6'
	  $test_description = "Add drop down type of question"
	  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
	  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
	  
      if($ie.contains_text("Question added successfully."))
      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
      else
        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      end
            
      $ie.button(:value, "Add a New Question").click
      #Adding a question text 
      $ie.text_field(:name, "strQuestion").set($qn4)
	  $ie.text_field(:name, "strDisplayName").set($qn4)
      $ie.select_list(:name, "optType").select("Grid")
      #sleep 2
      $ie.select_list(:name, "optGridQuestionType").select("Radio Boxes")
      
      $ie.text_field(:name, "strGridQuickLoadRow").set($ans_1_1)
      $ie.text_field(:name, "strGridQuickLoadCol").set($ans_4_1)
      #sleep 2
      $ie.button(:name, "btnGenerateGrid").click
      #sleep 2
      $ie.text_field(:name, "strGridQuickLoadRow").set($ans_1_2)
      $ie.text_field(:name, "strGridQuickLoadCol").set($ans_4_2)
      #sleep 2
      $ie.button(:name, "btnGenerateGrid").click
      #sleep 2      
      $ie.text_field(:name, "strGridQuickLoadRow").set($ans_1_3)
      $ie.text_field(:name, "strGridQuickLoadCol").set($ans_4_3)
      #sleep 2
      $ie.button(:name, "btnGenerateGrid").click
      #sleep 2
      
      $ie.button(:value, "Add").click
      $st = '7'
	  $test_description = "Add grid type of question"
	  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
	  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
      
      if($ie.contains_text("Question added successfully."))
      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
      else
        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      end
            
      $ie.button(:value, "Add a New Question").click
      #Adding a question text 
      $ie.text_field(:name, "strQuestion").set($qn5)
	  $ie.text_field(:name, "strDisplayName").set($qn5)
      $ie.select_list(:name, "optType").select("Input Field")
      
      $ie.button(:value, "Add").click
      $st = '8'
	  $test_description = "Add input field type of question"
	  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
	  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"      
      if($ie.contains_text("Question added successfully."))
      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
      else
        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      end
         
      
      $ie.button(:value, "Add a New Question").click
      #Adding a question text 
      $ie.text_field(:name, "strQuestion").set($qn6)
	  $ie.text_field(:name, "strDisplayName").set($qn6)
      $ie.select_list(:name, "optType").select("Open Ended")
      
      $ie.button(:value, "Add").click
      $st = '9'
	  $test_description = "Add open ended type of question"
	  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
	  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
      
      if($ie.contains_text("Question added successfully."))
      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
      else
        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      end
           
      $ie.button(:value, "Add a New Question").click
      
      #Adding a question text 
      $ie.text_field(:name, "strQuestion").set($qn7)
	  $ie.text_field(:name, "strDisplayName").set($qn7)
      $ie.select_list(:name, "optType").select("Radio Boxes")
      $ie.text_field(:name, "strQuickLoad").set($ans_7_1)
      $ie.button(:name, "btnQuickLoad").click
      #sleep 3
      $ie.text_field(:name, "strQuickLoad").set($ans_7_2)
      $ie.button(:name, "btnQuickLoad").click
      #sleep 3
      $ie.button(:value, "Add").click
      $st = '10'
	  $test_description = "Add radio box type of question"
	  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
	  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"      
      if($ie.contains_text("Question added successfully."))
      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
      else
        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      end
            
      $ie.button(:value, "Add a New Question").click
      #Adding a question text 
      $ie.text_field(:name, "strQuestion").set($qn8)
	  $ie.text_field(:name, "strDisplayName").set($qn8)
      $ie.select_list(:name, "optType").select("State Question")
      $ie.text_field(:name, "strStateQuickLoad").set($ans_8)
      $ie.button(:value, "Add").click
      $st = '11'
	  $test_description = "Add State Question - STATE_WATRPWR type of question"
	  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
	  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"      
      if($ie.contains_text("Question added successfully."))
      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
      else
        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      end
            
      $ie.button(:value, "Add a New Question").click
      #Adding a question text 
      $ie.text_field(:name, "strQuestion").set($qn9)
	  $ie.text_field(:name, "strDisplayName").set($qn9)
      $ie.select_list(:name, "optType").select("State Question")
      $ie.text_field(:name, "strStateQuickLoad").set($ans_9)
      $ie.button(:value, "Add").click
      $st = '12'
	  $test_description = "Add State Question - STATE_HOSPITAL type of question"
	  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
	  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"      
      if($ie.contains_text("Question added successfully."))
      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
      else
        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      end
           
      $ie.button(:value, "Add a New Question").click
      #Adding a question text 
      $ie.text_field(:name, "strQuestion").set($qn10)
	  $ie.text_field(:name, "strDisplayName").set($qn10)
      $ie.select_list(:name, "optType").select("State Question")
      $ie.text_field(:name, "strStateQuickLoad").set($ans_10)
      $ie.button(:value, "Add").click
      $st = '13'
	  $test_description = "Add State Question - STATE_GAS type of question"
	  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
	  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"      
      if($ie.contains_text("Question added successfully."))
      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
      else
        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      end
            
      $ie.button(:value, "Add a New Question").click
      #Adding a question text 
      $ie.text_field(:name, "strQuestion").set($qn_11)
	  $ie.text_field(:name, "strDisplayName").set($qn_11)
      $ie.select_list(:name, "optType").select("State Question")
      $ie.text_field(:name, "strStateQuickLoad").set($ans_11)
      $ie.button(:value, "Add").click
      $st = '14'
	  $test_description = "Add State Question - STATE_UTILITY type of question"
	  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
	  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"      
      if($ie.contains_text("Question added successfully."))
      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
      else
        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      end
          
      
      $ie.button(:value, "Add a New Question").click
      #Adding a question text 
      $ie.text_field(:name, "strQuestion").set($qn_12)
	  $ie.text_field(:name, "strDisplayName").set($qn_12)
      $ie.select_list(:name, "isChild").select("CHILD 1")
      $ie.select_list(:name, "optType").select("Radio Boxes")
      $ie.text_field(:name, "strQuickLoad").set($ans_7_1)
      $ie.button(:name, "btnQuickLoad").click
      #sleep 3
      $ie.text_field(:name, "strQuickLoad").set($ans_7_2)
      $ie.button(:name, "btnQuickLoad").click
      #sleep 3
      $ie.button(:value, "Add").click
      $st = '15'
	  $test_description = "Add CHILD 1 type of question"
	  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
	  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"      
      if($ie.contains_text("Question added successfully."))
      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
      else
        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      end
        
      
      $ie.button(:value, "Add a New Question").click
      #Adding a question text 
      $ie.text_field(:name, "strQuestion").set($qn_13)
	  $ie.text_field(:name, "strDisplayName").set($qn_13)
      $ie.select_list(:name, "isChild").select("CHILD 1")
      $ie.select_list(:name, "optType").select("Radio Boxes")
      $ie.text_field(:name, "strQuickLoad").set($ans_7_1)
      $ie.button(:name, "btnQuickLoad").click
      #sleep 3
      $ie.text_field(:name, "strQuickLoad").set($ans_7_2)
      $ie.button(:name, "btnQuickLoad").click
      #sleep 3
      $ie.button(:value, "Add").click
      
      $ie.button(:value, "Add a New Question").click
      #Adding a question text 
      $ie.text_field(:name, "strQuestion").set($qn_14)
	  $ie.text_field(:name, "strDisplayName").set($qn_14)
      $ie.select_list(:name, "optType").select("Check Boxes")
      $ie.select_list(:name, "isChild").select("CHILD 2")
      #Setting the answers
      $ie.text_field(:name,'strQuickLoad').set("BMW\nAUDI\nMERC\nNone of the above")
      $ie.button(:name, "btnQuickLoad").click
      
      $ie.button(:value, "Add").click
      $st = '16'
	  $test_description = "Add CHILD 2 type of question"
	  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
	  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"      
      if($ie.contains_text("Question added successfully."))
      $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
      else
        $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
      end
            
      $ie.button(:value, "Add a New Question").click
      #Adding a question text 
      $ie.text_field(:name, "strQuestion").set($qn_15)
	  $ie.text_field(:name, "strDisplayName").set($qn_15)
      $ie.select_list(:name, "optType").select("Check Boxes")
      $ie.select_list(:name, "isChild").select("CHILD 2")
      #Setting the answers
      $ie.text_field(:name,'strQuickLoad').set("BMW\nAUDI\nMERC\nNone of the above")
      $ie.button(:name, "btnQuickLoad").click
      $ie.button(:value, "Add").click
      
      $ie.link(:text, "Manage Questions").click
      #getting profile number
      $Profile_no=/P\s(\d+)/.match($ie.text)
      $Profile_no[0].to_s()
      $Profile_no[0].chomp!
      $Profile_number=$Profile_no[0][2..5]
      
      myfile = File.open($prof_id_path, 'w');
      myfile.print $Profile_number;
      myfile.close
      
      $st = '17'
	  $test_description = "Check all types of questions are added"
	  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
	  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
      if $ie.contains_text('CHECKBOX') && $ie.contains_text('DATE') && $ie.contains_text('DROPDOWN') && $ie.contains_text('GRID') && $ie.contains_text('INPUT') && $ie.contains_text('OPENENDED') && $ie.contains_text('RADIO') && $ie.contains_text('STATEQUESTION')
        $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
        else
          $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
        end
         
      
      $ie.button(:value, "Language Options").click
      
      $ie.text_field(:name, "txtLangProfileName").set($prf_nm+"-ENG")
      $ie.checkbox(:name, "chkCopyLang").set
      sleep 10
      $ie.button(:name, "Submit").click
      sleep 5
      $st = '18'
	  $test_description = "Save Language settings"
	  $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
	  $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
      
      if $ie.contains_text('Language setting has been updated successfully')
        $myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
        else
          $myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
        end
        
      $ie.goto("http://p.usampadmin.com/login.php?hdMode=logout")
      sleep 2
      $ie.close
      
    rescue => e           
      puts e.message       
      $myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
      $myfile.print "<td class=\"td2\">"+$test_description+"</td>"
      $myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
      $obj.Close_all_windows 
    end  
   
    end

end


        