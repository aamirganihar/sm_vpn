require 'win32ole'
websiteName = "sm.p.surveyhead.com"
begin
    autoit = WIN32OLE.new('AutoItX3.Control')
    loop do
       autoit.winActivate("The page at http://#{websiteName} says:")
       autoit.Send("{ENTER}") if(autoit.WinWait("The page at http://#{websiteName} says:",'',2) == 1)
    end
rescue Exception => e
    puts e
end 