require 'win32ole' 
begin

  autoit = WIN32OLE.new('AutoItX3.Control')
  loop do
    autoit.ControlClick("Windows Internet Explorer",'', 'OK')
    autoit.ControlClick("Security Information",'', '&Yes')
    autoit.ControlClick("Security Alert",'', '&Yes')
    autoit.ControlClick("Security Warning",'', 'Yes')
    autoit.ControlClick("Message from webpage",'', 'OK')
    autoit.ControlClick("The page at http://www.p.surveyhead.com ...",'', 'OK')
    autoit.ControlClick("The page at http://p.usampadmin.com ...",'', 'OK')
    autoit.ControlClick("Opening member_cashouts",'', 'OK')
    autoit.ControlClick("http://p.usampadmin.com/member_cashouts_csv.php",'', 'OK')
    autoit.ControlClick("File Download",'', 'Save')
    autoit.ControlClick("Application Removed",'', 'Okay')
    # other options can be included here
    sleep 3
  end

rescue Exception => e
  puts e

end