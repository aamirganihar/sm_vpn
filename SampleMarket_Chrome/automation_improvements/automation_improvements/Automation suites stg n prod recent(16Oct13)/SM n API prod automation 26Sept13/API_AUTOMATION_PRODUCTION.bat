@REM OFF
cd /d D:\API_AUTOMATION_PRODUCTION
del D:\API_AUTOMATION_PRODUCTION\Results_Production.csv

cd /d D:\jakarta-jmeter-2.3.4\bin\
java -jar ApacheJMeter.jar -n -t D:\API_AUTOMATION_PRODUCTION\4S_API_AUTOMATION_PRODUCTION_iPoll.jmx

cd /d D:\API_AUTOMATION_PRODUCTION
ruby api_email_production.rb

echo today is %DATE% %TIME% 