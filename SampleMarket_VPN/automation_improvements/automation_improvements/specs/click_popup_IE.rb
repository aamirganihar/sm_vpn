require 'win32ole'

begin
    autoit = WIN32OLE.new('AutoItX3.Control')
    loop do
       autoit.ControlClick("Windows Internet Explorer",'', 'OK')
       autoit.ControlClick("Security Information",'', '&Yes')
       autoit.ControlClick("Security Alert",'', '&Yes')
       autoit.ControlClick("Security Warning",'', 'Yes')
       autoit.ControlClick("Message from webpage",'', 'OK')
	   #autoit.ControlClick("The page at http://p.usampadmin.com ...",'', 'OK')
       sleep 1
    end
rescue Exception > e
    puts e
end