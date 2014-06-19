require 'rubygems'
require './automation'
#Load WATIR
require 'fileutils'
# Load WIN32OLE library
require 'win32ole'
require 'Win32API'
#Load the win32 library
#require 'win32/clipboard'

#include Win32 
require 'YAML'

require './InputRepository/Basic_data'

#include 'Suite'

#PRE REQUISITES :-
#Login Credentials, Project Creation data

describe "Test 09: Review Counts with Demographic Criteria, Geographic Criteria and matching panel book questions for focusline site" do

  before(:all) do
    #create an object of the UsampLib
    @obj = Usamp_lib.new
    #@ie = @obj.Network_site_login("nitin_kumar@persistent.co.in","test","Client")
    @browser = @obj.Network_site_login(BasicData::USAMP_NETWORK_LOGIN, BasicData::USAMP_NETWORK_PASSWORD ,"Client")
  end

    it "To create a new project to obtain review counts" do
    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
    @browser.link(:text,"Add a new project").click
    prj_name= Time.now
    prj_name = prj_name.to_s
    prj_name = prj_name.slice(0..18)

    @date=Time.now.strftime("%m/%d/%Y")
    @SECONDS_PER_DAY = 60 * 60 * 24
    @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
    @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")

    prj_name = "Test Automation Project_"+prj_name
    #project_name = {}
    #project_name['project'] = prj_name
    #File.open("InputRepository/projectname.yml","w"){|file| YAML.dump(project_name,file)}
    @browser.text_field(:id, "txtPrjName").set(prj_name)
    @browser.select_list(:id,"optPrjCat").select("Business")
    @date=Time.now.strftime("%m/%d/%Y")
    @SECONDS_PER_DAY = 60 * 60 * 24
    @date_added_1=(Time.now + 1*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
    @date_added_10=(Time.now + 10*@SECONDS_PER_DAY).localtime.strftime("%m/%d/%Y")
    @browser.text_field(:name ,'txtStartDate').set @date_added_1
    @browser.text_field(:name ,'txtEndDate').set @date_added_10
    @browser.select_list(:id,"optPM").select("Nitin Kumar")
    @browser.text_field(:id, "txtSurveyLength").set("10")
    #sleep 3
    @browser.link(:text,'Create Project').click
    #@browser.link(:text,'Create Project').click
    sleep 5
    body_text = @browser.text
    body_text.should include("Your project has been created")
  end

    it "Test to obtain Review Counts with only Demographic Criteria" do
#    @browser.goto("https://p.network.u-samp.com/SelfServe/index.php?mode=report/projectslanding")
#    project_name = File.open("InputRepository/projectname.yml"){|file| YAML::load(file)}
#    @browser.link(:text,/#{project_name['project'][1]}/).click
    @browser.link(:text,/Group Setup/).click
    sleep 5
    @browser.checkbox(:id,"PL[40]").set
    @browser.checkbox(:id,"PL[13]").set
    @browser.checkbox(:id,"PL[2]").set
    @browser.checkbox(:id,"PL[0]").set
    @browser.link(:text,/Demographic Targeting/).click
    while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 0.5
      puts "waiting for element"
    end
    sleep 3
    @browser.link(:text,/Age/).click
    while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 0.5
      puts "waiting for element"
    end
    sleep 5
    @browser.text_field(:id,"txtAgeRangeLower_1").set("50")
    @browser.text_field(:id,"txtAgeRangeUpper_1").set("75")
    @browser.link(:text,/Done/).click
    @browser.link(:text,/50-75/).should exist
    grp_name= Time.now
    grp_name = grp_name.to_s
    grp_name = grp_name.slice(0..18)
    grp_name = "Test Automation Group_"+grp_name
    @browser.text_field(:id,"txtGroupName").set(grp_name)
    @browser.text_field(:id,"txtSampleSize").set("20")
    @browser.text_field(:id,"txtIncidenceEst").set("50")
    #@browser.checkbox(:id,"PL[40]").set
    #@browser.checkbox(:id,"PL[13]").set
    #@browser.checkbox(:id,"PL[2]").set
    #@browser.checkbox(:id,"PL[0]").set
    @browser.link(:text,"Get Sample Counts").click
    while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
      sleep 1
    end
    sleep 5
    #@val = @browser:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]"
    #@browser.text should include
    #val = @browser.getValue("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
    #val = @browser.text_field(:xpath,"//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]").value
    body_text = @browser.html
    puts  "demo "
    puts body_text
    #body_text=ff.html
    #html_array = body_text.split(/\n/)
    html_array = body_text.split(/td><td/)
    #puts     $html_array
    0.upto(html_array.size - 1) { |index|
    if(html_array[index] =~ />FocuslineSurveys</)
    #if(html_array[index] =~ //)
      #puts "***"
      #puts html_array[index]
      @code = html_array[index+2]
      #puts html_array[index+2]
      break
        else
          next
        end
        }

    @code1 = @code.slice(25..29)
    @code1 = @code1.gsub(/,/, "")
    @number = @code1.to_i

    @number.should > 0
    @number.should < 15000
     sleep 2
    @browser.link(:text,"Trash").click
    #(@number > 5000 && @number < 15000)

    #val = @browser.get_text("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
#    puts val
    #@browser.link(:id,"next").click
end


    it "Test to obtain Review Counts with only Geo graphic Criteria" do
        @browser.link(:text,/Geographic Targeting/).click
        while @browser.div(:id=>"fancybox-loading").visible? do
            sleep 0.5
            puts "waiting for element"
        end
        sleep 5
	@browser.link(:text,/Zip Code/).click
        while @browser.div(:id=>"fancybox-loading").visible? do
          sleep 0.5
          puts "waiting for element"
  end
  sleep 4
        @browser.text_field(:id,"txtZipList").set("90001,90002,90003,90004,90005,90006,90007,90008,90009,90010")
	sleep 3
        @browser.link(:text,/Done/).click
        #@browser.link(:text,/90001/).should exist
	sleep 3
        @browser.link(:text,"Get Sample Counts").click
        while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
          sleep 1
        end
        #@val = @browser:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]"
        #@browser.text should include
        #val = @browser.getValue("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
        #val = @browser.text_field(:xpath,"//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]").value
	sleep 4
        body_text = @browser.html
        #puts body_text
        #body_text=ff.html
        #html_array = body_text.split(/\n/)
        html_array = body_text.split(/td><td/)
        #puts     $html_array
        0.upto(html_array.size - 1) { |index|
        if(html_array[index] =~ />FocuslineSurveys</)
        #if(html_array[index] =~ //)
          #puts "***"
          #puts html_array[index]
          @code = html_array[index+2]
          #puts html_array[index+2]
          break
            else
              next
            end
            }


        @code1 = @code.slice(25..26)
        @code1 = @code1.gsub(/,/, "")
        @number = @code1.to_i

        @number.should > 0
        @number.should < 500
        @browser.link(:text,"Trash").click
    end


    it "Test to obtain Review Counts with only Profile Criteria" do
      @browser.link(:text,/Profile Questions/).click
      while @browser.div(:id=>"fancybox-loading").visible? do
        sleep 0.5
        puts "waiting for element"
	end
	sleep 5
      @browser.select_list(:id,"profileSelOption").select("Sel_Automation")
    #sleep 4
    #@browser.select_list(:id,"profileSelOption").select("Travel")
    while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 0.5
      puts "waiting for element"
    end
    sleep 4
    #@browser.link(:text,/Which rental car companies have you used?/).click
    @browser.link(:text,/Select a number/).click
    sleep 2
    @browser.checkbox(:title,"1").set
    sleep 2
    @browser.link(:text,/Select an alphabet/).click
    sleep 3
    @browser.checkbox(:title,"a").set
    
	
#    @browser.checkbox(:title,"Advantage Rent A Car").set
    @browser.link(:text,/Done/).click
      sleep 3
      #@browser.link(:text,/Which rental car companies have you used?/).should exist

      @browser.link(:text,"Get Sample Counts").click
      while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
        sleep 1
	end
	sleep 4
      #@val = @browser:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]"
      #@browser.text should include
      #val = @browser.getValue("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
      #val = @browser.text_field(:xpath,"//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]").value
      body_text = @browser.html
      #puts body_text
      #body_text=ff.html
      #html_array = body_text.split(/\n/)
      html_array = body_text.split(/td><td/)
      #puts     $html_array
      0.upto(html_array.size - 1) { |index|
      if(html_array[index] =~ />FocuslineSurveys</)
      #if(html_array[index] =~ //)
        #puts "***"
        #puts html_array[index]
        @code = html_array[index+2]
        #puts html_array[index+2]
        break
          else
            next
          end
          }



      @code1 = @code.slice(25..29)
      puts @code1
      @code1 = @code1.gsub(/,/, "")
      @number = @code1.to_i
       puts @number
      @number.should > 0
      @number.should < 10000
      @browser.link(:text,"Trash").click
      sleep 3
      @browser.link(:text,"Trash").click
  end


    it "Test to obtain Review Counts with Demographic and Profile Criteria" do
        @browser.link(:text,/Profile Questions/).click
	sleep 3
        while @browser.div(:id=>"fancybox-loading").visible? do
          sleep 0.5
          puts "waiting for element"
        end
	sleep 5
        @browser.select_list(:id,"profileSelOption").select("Sel_Automation")
    #sleep 4
    #@browser.select_list(:id,"profileSelOption").select("Travel")
    while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 0.5
      puts "waiting for element"
    end
    sleep 4
    #@browser.link(:text,/Which rental car companies have you used?/).click
    @browser.link(:text,/Select a number/).click
    sleep 4
    @browser.checkbox(:title,"1").set
    sleep 2
    @browser.link(:text,/Select an alphabet/).click
    sleep 3
    @browser.checkbox(:title,"a").set
    
	
#    @browser.checkbox(:title,"Advantage Rent A Car").set
    @browser.link(:text,/Done/).click
      
        sleep 4
        @browser.link(:text,/Demographic Targeting/).click
        while @browser.div(:id=>"fancybox-loading").visible? do
          sleep 0.5
          puts "waiting for element"
  end
  sleep 5
        @browser.link(:text,/Age/).click
        while @browser.div(:id=>"fancybox-loading").visible? do
          sleep 0.5
          puts "waiting for element"
  end
  sleep 5
        @browser.text_field(:id,"txtAgeRangeLower_1").set("50")
        @browser.text_field(:id,"txtAgeRangeUpper_1").set("75")
        @browser.link(:text,/Done/).click
        @browser.link(:text,/50-75/).should exist
      #@browser.link(:text,/Which rental car companies have you used?/).should exist

      @browser.link(:text,"Get Sample Counts").click
      while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
        sleep 1
	end
	sleep 4
      #@val = @browser:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]"
      #@browser.text should include
      #val = @browser.getValue("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
      #val = @browser.text_field(:xpath,"//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]").value
      body_text = @browser.html
      #puts body_text
      #body_text=ff.html
      #html_array = body_text.split(/\n/)
      html_array = body_text.split(/td><td/)
      #puts     $html_array
      0.upto(html_array.size - 1) { |index|
      if(html_array[index] =~ />FocuslineSurveys</)
      #if(html_array[index] =~ //)
        #puts "***"
        #puts html_array[index]
        @code = html_array[index+2]
        #puts html_array[index+2]
        break
          else
            next
          end
          }



      @code1 = @code.slice(25..29)
      @code1 = @code1.gsub(/,/, "")
      @number = @code1.to_i

      @number.should > 0
      @number.should < 10000
      sleep 2
      @browser.link(:text,"Trash").click
      sleep 3
      @browser.link(:text,"Trash").click
      sleep 3
      @browser.link(:text,"Trash").click
      
  end
  
    it "Test to obtain Review Counts with Geo graphic and Demographic Criteria" do
	    	    @browser.link(:text,/Geographic Targeting/).click
	    while @browser.div(:id=>"fancybox-loading").visible? do
		    sleep 0.5
		    puts "waiting for element"
	    end
	    sleep 5
	    @browser.link(:text,/Zip Code/).click
	    while @browser.div(:id=>"fancybox-loading").visible? do
		    sleep 0.5
		    puts "waiting for element"
	    end
	    sleep 3
	    @browser.text_field(:id,"txtZipList").set("90001,90002,90003,90004,90005,90006,90007,90008,90009,90010")
	    sleep 2
	    @browser.link(:text,/Done/).click
	    sleep 5
	    @browser.link(:text,/Demographic Targeting/).click
	    while @browser.div(:id=>"fancybox-loading").visible? do
		    sleep 0.5
		    puts "waiting for element"
	    end
	    sleep 3
	    @browser.link(:text,/Age/).click
	    sleep 1
	    while @browser.div(:id=>"fancybox-loading").visible? do
		    sleep 0.5
		    puts "waiting for element"
	    end
	    sleep 6
	    @browser.text_field(:id,"txtAgeRangeLower_1").set("50")
	    @browser.text_field(:id,"txtAgeRangeUpper_1").set("75")
	    sleep 2
	    @browser.link(:text,/Done/).click
	    sleep 2
	    @browser.link(:text,/50-75/).should exist
        #@browser.link(:text,/90001/).should exist
        @browser.link(:text,"Get Sample Counts").click
        while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
          sleep 1
        end
        #@val = @browser:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]"
        #@browser.text should include
        #val = @browser.getValue("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
        #val = @browser.text_field(:xpath,"//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]").value
	sleep 4
        body_text = @browser.html
        #puts body_text
        #body_text=ff.html
        #html_array = body_text.split(/\n/)
        html_array = body_text.split(/td><td/)
        #puts     $html_array
        0.upto(html_array.size - 1) { |index|
        if(html_array[index] =~ />FocuslineSurveys</)
        #if(html_array[index] =~ //)
          #puts "***"
          #puts html_array[index]
          @code = html_array[index+2]
          #puts html_array[index+2]
          break
            else
              next
            end
            }


        @code1 = @code.slice(25..26)
        @code1 = @code1.gsub(/,/, "")
        @number = @code1.to_i
        puts @number
        @number.should > 0
        @number.should < 500
        @browser.link(:text,"Trash").click
        sleep 3
        @browser.link(:text,"Trash").click
    end



  it "Test to obtain Review Counts with Geo graphic, Demographic and Profile Criteria" do
      	@browser.link(:text,/Geographic Targeting/).click
        while @browser.div(:id=>"fancybox-loading").visible? do
            sleep 0.5
            puts "waiting for element"
        end
        sleep 7
	@browser.link(:text,/Zip Code/).click
        while @browser.div(:id=>"fancybox-loading").visible? do
          sleep 0.5
          puts "waiting for element"
        end
        sleep 3
	@browser.text_field(:id,"txtZipList").set("90001,90002,90003,90004,90005,90006,90007,90008,90009,90010")
	sleep 3
        @browser.link(:text,/Done/).click
        sleep 3
        @browser.link(:text,/Demographic Targeting/).click
        while @browser.div(:id=>"fancybox-loading").visible? do
          sleep 0.5
          puts "waiting for element"
	end
	sleep 3
        @browser.link(:text,/Age/).click
        while @browser.div(:id=>"fancybox-loading").visible? do
          sleep 0.5
          puts "waiting for element"
	end
	sleep 3
        @browser.text_field(:id,"txtAgeRangeLower_1").set("10")
        @browser.text_field(:id,"txtAgeRangeUpper_1").set("99")
        @browser.link(:text,/Done/).click
        sleep 3
        @browser.link(:text,/10-99/).should exist
        #@browser.link(:text,/90001/).should exist
        sleep 4
        @browser.link(:text,/Profile Questions/).click
        while @browser.div(:id=>"fancybox-loading").visible? do
          sleep 0.5
          puts "waiting for element"
  end
  sleep 5
        @browser.select_list(:id,"profileSelOption").select("Sel_Automation")
    #sleep 4
    #@browser.select_list(:id,"profileSelOption").select("Travel")
    while @browser.div(:id=>"fancybox-loading").visible? do
      sleep 0.5
      puts "waiting for element"
    end
    sleep 4
    #@browser.link(:text,/Which rental car companies have you used?/).click
    @browser.link(:text,/Select a number/).click
    sleep 2
    @browser.checkbox(:title,"1").set
    sleep 2
    @browser.link(:text,/Select an alphabet/).click
    sleep 3
    @browser.checkbox(:title,"a").set
    
	
#    @browser.checkbox(:title,"Advantage Rent A Car").set
    @browser.link(:text,/Done/).click
        sleep 2
        
        @browser.link(:text,"Get Sample Counts").click
        while @browser.div(:id=>"spanDisplayRefrStatsLoadingStatus").visible? do
          sleep 1
  end
  sleep 2
        #@val = @browser:xpath,".//*[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]"
        #@browser.text should include
        #val = @browser.getValue("//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]")
        #val = @browser.text_field(:xpath,"//div[@id='sample-counts']/table[1]/tbody/tr[4]/td[2]").value
	sleep 4
        body_text = @browser.html
        #puts body_text
        #body_text=ff.html
        #html_array = body_text.split(/\n/)
        html_array = body_text.split(/td><td/)
        #puts     $html_array
        0.upto(html_array.size - 1) { |index|
        if(html_array[index] =~ />FocuslineSurveys</)
        #if(html_array[index] =~ //)
          #puts "***"
          #puts html_array[index]
          @code = html_array[index+2]
          #puts html_array[index+2]
          break
            else
              next
            end
            }


        @code1 = @code.slice(25..26)
        @code1 = @code1.gsub(/,/, "")
        @number = @code1.to_i

        @number.should > 0
        @number.should < 500
        @browser.link(:text,"Trash").click
        sleep 3
        @browser.link(:text,"Trash").click
	sleep 3
        @browser.link(:text,"Trash").click
    end

    after(:all) do
      @browser.close
      puts "test 9 has completed"
    end
end