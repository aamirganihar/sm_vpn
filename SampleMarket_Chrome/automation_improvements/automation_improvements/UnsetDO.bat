@REM OFF

cd /d D:\SampleMarket_Chrome\automation_improvements\automation_improvements

rspec --format h -o disable_do.html --tag ~datacreation --tag ~temp --tag ~inprogress Settings_set.rb
