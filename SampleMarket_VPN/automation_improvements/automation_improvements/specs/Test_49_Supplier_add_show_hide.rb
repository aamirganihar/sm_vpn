# SUPPLIER ADDITION/ SHOW/HIDE SUPPLIER

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
require 'Input Repository\Test_49_Supplier_add_show_hide_Input.rb'

class Test_49_Supplier_add_show_hide < Test::Unit::TestCase

			$wd=Dir.pwd
			$pub_id_file_path = $wd+"/Input Repository/PUB_ID.txt"
			$pub_name_file_path = $wd+"/Input Repository/PUB_NAME.txt"
			$out_fl_path = $wd+"/Output Repository/Non4S_Test_Report.html"
  
      def test_01_report_head
	  
				$t = "49 - "
				$test_description = "Test Case: "+$t.to_s+"  SUPPLIER ADDTION & SHOW/HIDE SUPPLIER"
				$obj = Usamp_lib.new
				$obj.Test_report($test_description)
								
	  
	  end
	  
	  def test_02_add_supplier
				
			begin	
				$st = "1"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Add supplier to global list "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
				$ie.goto("http://p.usampadmin.com/ps_add_supplier.php")
				$supplier_name="test_supplier"
				
				$ext = Time.new
				$ext = $ext.to_s
				$ext = $ext.slice(0..18)
				
				$supplier_name = "Test_Auto_Glob_Supp_"+$ext
				$supplier_name = $supplier_name.gsub(/:/, "")
				$supplier_name = $supplier_name.gsub(/\s/, "")
				puts $supplier_name
				
				$ie.text_field(:id, "txtSupplierName").set($supplier_name)
				sleep 3
				$ie.button(:value,"Save").click
				sleep 3
				$ie.link(:text,"Supplier ID").click
				sleep 3
				
				if($ie.contains_text($supplier_name))
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
				$ie.link(:text,"Logout").click
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
	  
	  def test_03_supplier_reflection
				
			begin	
				$st = "2"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Added supplier is reflected in network site "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies
                $ff = $obj.Network_site_login($email,$passwd,$type)
				sleep 5
				$ff.goto("https://p.network.u-samp.com/pshield/ps_welcome.php")
				$ff.goto("https://p.network.u-samp.com/pshield/ps_projects_listing.php?type=open")
				$enc_sheild_id = Base64.encode64($cp_sheild_id)
				$ff.goto("https://p.network.u-samp.com/pshield/ps_project_suppliers.php?hdPsPrjId=#{$enc_sheild_id}")
				$flg = 0
				
				$sup_ary = $ff.select_list(:id,"supplierList").getAllContents
                $ln = $sup_ary.length
                0.upto($ln - 1) { |index|
                    if($sup_ary[index] == $supplier_name)
                        $flg = 1
                        break
                    else
                        $flg = 0
                        next
                    end
                }
				if($flg == 1)
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("https://p.network.u-samp.com/login.php?hdMode=logout")
				$ff.close
			rescue => e
				puts e.message
				puts e.backtrace.inspect
				$obj.Close_all_windows
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$myfile.print "<td class=\"td3\"><font color=\"black\">NOT COMPLETED SUCCESSFULY!{Please check the log for details}</font></td></tr>"
			end	
	  end
	  
	  def test_04_show_hide
				
			begin	
				$st = "3"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Hide Supplier "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$obj = Usamp_lib.new
				$obj.Delete_cookies()
				$ie = $obj.Usampadmin_login($admin_email,$admin_passwd)
				sleep 3
				$ie.goto("http://p.usampadmin.com/ps_suppliers_listing.php")
				sleep 3
				$ie.link(:text,"Supplier ID").click
				sleep 3
				$ie.link(:text,"Hide").click
				sleep 3
				
				$ff = $obj.Network_site_login($email,$passwd,$type)
				sleep 5
				$ff.goto("https://p.network.u-samp.com/pshield/ps_welcome.php")
				$ff.goto("https://p.network.u-samp.com/pshield/ps_projects_listing.php?type=open")
				$enc_sheild_id = Base64.encode64($cp_sheild_id)
				$ff.goto("https://p.network.u-samp.com/pshield/ps_project_suppliers.php?hdPsPrjId=#{$enc_sheild_id}")
				$flg = 0
				
				$sup_ary = $ff.select_list(:id,"supplierList").getAllContents
                $ln = $sup_ary.length
                0.upto($ln - 1) { |index|
                    if($sup_ary[index] == $supplier_name)
                        $flg = 1
                        break
                    else
                        $flg = 0
                        next
                    end
                }
				if($flg == 0)
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				
				$st = "4"
				#$test_id = $t.to_s+"."+$st.to_s
				$test_description = "Show Supplier "
				$myfile.print "<tr><td class=\"td1\">"+$st+"</td>"
				$myfile.print "<td class=\"td2\">"+$test_description+"</td>"
				$ie.goto("http://p.usampadmin.com/ps_suppliers_listing.php")
				sleep 3
				$ie.link(:text,"Supplier ID").click
				sleep 3
				$ie.link(:text,"Show").click
				sleep 3
				$ie.link(:text,"Logout").click
				$ie.close
				
				$ff.goto("https://p.network.u-samp.com/pshield/ps_project_suppliers.php?hdPsPrjId=#{$enc_sheild_id}")
				$flg = 0
				
				$sup_ary = $ff.select_list(:id,"supplierList").getAllContents
                $ln = $sup_ary.length
                0.upto($ln - 1) { |index|
                    if($sup_ary[index] == $supplier_name)
                        $flg = 1
                        break
                    else
                        $flg = 0
                        next
                    end
                }
				if($flg == 1)
					puts 'Pass'
					$myfile.print "<td class=\"td3\"><font color=\"green\">TEST PASSED</font></td></tr>"
				else
					puts 'Fail'   
					$myfile.print "<td class=\"td3\"><font color=\"red\">TEST FAILED</font></td></tr>"
				end
				$ff.goto("https://p.network.u-samp.com/login.php?hdMode=logout")
				$ff.close
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