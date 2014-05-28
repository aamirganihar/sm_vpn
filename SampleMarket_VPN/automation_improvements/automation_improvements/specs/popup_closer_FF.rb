require 'win32ole'
websiteName = "www.p.surveyhead.com"
begin
    autoit = WIN32OLE.new('AutoItX3.Control')
    loop do
       autoit.winActivate("The page at http://www.p.surveyhead.com says:")
       autoit.Send("{ENTER}") if(autoit.WinWait("The page at http://www.p.surveyhead.com says:",'',2) == 1)
       autoit.Send("{ENTER}") if(autoit.WinWait("The page at http://sm.p.surveyhead.com says:",'',2) == 1)
	  end
    
rescue Exception => e
    puts e
end 