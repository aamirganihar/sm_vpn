@REM OFF

cd /d D:\SampleMarket\automation_improvements\automation_improvements\

rspec --format h -o Report_prod.html --tag ~datacreation --tag ~temp --tag ~inprogress test_production_script.rb

