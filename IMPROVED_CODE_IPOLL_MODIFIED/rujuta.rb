# PUBLISHER AUTo-ADD & QG CPI TYPES CHECKS (FCPI/STANDARD) 

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
require 'Input Repository\new_cpi_cases.rb'



			$wd=Dir.pwd
			$proj_id_file_path = $wd+"/Input Repository/Project_2_ID.txt"
			$qg_id_file_path = $wd+"/Input Repository/QG_2_ID.txt"
			$qg_id_file_path_3 = $wd+"/Input Repository/Copied_QG_3_ID.txt"


puts "creating copy of qg for both cases"
$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
					
				@pid = Process.create(
                        :app_name  => 'ruby popup_closer_IE.rb',
                        :creation_flags  => Process::DETACHED_PROCESS
                        ).process_id
                at_exit{ Process.kill(9,@pid) }
									 
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
				$ie.link(:text,"Copy Selected Quota Group").click
				sleep 3
					
				if($ie.contains_text(/Quota Group details has been copied successfully/))
					puts "QG COPIED"
				else
					puts "QG COPY FAILED"
				end
					
				$date=Time.now.strftime("%Y-%m-%d")
				$SECONDS_PER_DAY = 60 * 60 * 24
				$date_added_1=(Time.now + 10*$SECONDS_PER_DAY).localtime.strftime("%Y-%m-%d") 
				puts $date_added_1
					
				$ie.select_list(:name, "optQuotaStatus").set("Open")
				$ie.text_field(:name , 'txtQuotaCloseDate').value = $date_added_1
				$file1 = File.open($qg_id_file_path_3, 'w');
				$qg_id_3= /GROUP DETAILS: QG(\d+)/.match($ie.text)
				$qg_id_3= $qg_id_3.to_s
				$length=$qg_id_3.length
                                puts $length
				$qg_id_3=$qg_id_3.slice(17..$length)
				puts $qg_id_3
				$file1.print $qg_id_3;
				$file1.close;
					
				$qg_n2 = Base64.encode64($qg_id_3)		
				$ie.button(:name,"btnSave").click
				sleep 2
				$ie.checkbox(:id, "chkShowSurvey").set
				$ie.text_field(:id, "txtSurveyName").set("QG CPI SURVEY")
				$ie.button(:name,"btnSave").click
				$ie.link(:text,"Logout").click
				$ie.close


$obj =  Usamp_lib.new
$obj.Delete_cookies()
$ie=$obj.Usampadmin_login($admin_email, $admin_passwd)

@pid = Process.create(
                        :app_name  => 'ruby popup_closer_IE.rb',
                        :creation_flags  => Process::DETACHED_PROCESS
                        ).process_id
                at_exit{ Process.kill(9,@pid) }

puts "setting publisher settings for % of whole cpi"

$enc_pub_id = Base64.encode64($pub_id)
$ie.goto("http://p.usampadmin.com/add_publisher_revenue.php?hdMode=revenue_setup&publisher_id=#{$enc_pub_id}")
sleep 4


$ie.radio(:id, "chkRecRev2").set
$ie.text_field(:id, "txtCpiPerc").set($std_us_perc)
$ie.text_field(:id, "txtCpiPercNonUS").set($std_non_us_perc)
$ie.radio(:value, "perc_whole_cpi").set
$ie.button(:value,"Save").click
$val1 = $ie.text_field(:id, "txtCpiPerc").value
$val2 = $ie.text_field(:id, "txtCpiPercNonUS").value
$val4 = $ie.text_field(:id, "txtCapAmount").value
$ie.link(:text,"Logout").click
$ie.close




$obj = Usamp_lib.new
				$obj.Delete_cookies()
puts "survey taking for % of whole cpi"
#$ff = FireWatir::Firefox.new
$ff = $obj.Surveyhead_login($em_id,$em_id)

				sleep 5
				$file_2 = File.open($qg_id_file_path_3)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
				$survey_link  = Base64.encode64($qg_id)
        puts $survey_link
                $survey_link = "link"+$survey_link
                $survey_link = $survey_link.chomp
                puts $survey_link
                sleep 20
                $ff.link(:id, $survey_link).click
                sleep 5
                $ff.button(:value,"START SURVEY").click
                sleep 10
                $ff1 = FireWatir::Firefox.attach(:title,'Survey')
				$url = $ff1.url
                $ff1.goto($sc_red_url)
				sleep 2
				if($ff1.contains_text(/Congratulations, you've just completed the survey/))
          puts "pass"
					
				else
					puts "fail"
				end


$ff1.close
				  
				$ff.goto("p.ipoll.com/index.php?mode=logout")

$ff.close





$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 2
				$file_1 = File.open($proj_id_file_path)
				$prj_id = $file_1.gets
				puts $prj_id
				$file_1.close;
			
				$file_2 = File.open($qg_id_file_path_3)
				$qg_id = $file_2.gets
				puts $qg_id
				$file_2.close;
					
					
				$prj_n = Base64.encode64($prj_id)
				$qg_n = Base64.encode64($qg_id)
					
				$ie.goto("p.usampadmin.com/add_quota_group.php?project_id=#{$prj_n}&quota_group_id=#{$qg_n}")	
				sleep 2
				$ie.link(:url,/list_quota_group_publishers.php/).click
				$ie.frame(:name,"quota_group_publisher_iframe").select_list(:id,"optPublisherType").set("Show Auto Added Publishers")
				sleep 3
				
				
				$flg = 1;
				$html_contents=$ie.frame(:name,"quota_group_publisher_iframe").html
				$html_array = $html_contents.split(/\n/)      
                0.upto($html_array.size - 1) { |index|
                    if($html_array[index] =~ /Standard/)
                        puts "***"
                        puts $html_array[index+7]
                        $html_array[index].scan(/[A-Za-z]+/){
                            if ($html_array[index+7] =~ /\$2.90/)
                                puts "PASS"
                               
                                break
                            else
                                puts "FAIL"
                            end
						}
						break
                    else
                        next
					
					end
                }
				if ($flg == 0)
					
				end
				$ie.link(:text,"Logout").click
				$ie.close
				





