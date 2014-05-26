require 'win32ole'
#websiteName = "www.p.surveyhead.com"
begin
    autoit = WIN32OLE.new('AutoItX3.Control')
    loop do
       autoit.winActivate("Security Warning")
       autoit.Send("{ENTER}") if(autoit.WinWait("Security Warning",'',2) == 1)
       autoit.Send("{ENTER}") if(autoit.WinWait("Security Warning",'',2) == 1)
	  end
    
rescue Exception => e
    puts e
end 