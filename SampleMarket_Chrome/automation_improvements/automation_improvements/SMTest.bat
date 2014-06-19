@REM OFF

cd /d D:\SampleMarket_Chrome\automation_improvements\automation_improvements

rspec --format h -o Report.html --tag ~datacreation --tag ~temp --tag ~inprogress 4s_specs\*
