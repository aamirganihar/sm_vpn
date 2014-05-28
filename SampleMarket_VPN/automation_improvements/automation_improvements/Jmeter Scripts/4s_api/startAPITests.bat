@REM OFF
cd /d D:\jakarta-jmeter-2.3.4\bin\
del D:\jakarta-jmeter-2.3.4\bin\4SAPI\Results\Results.csv

cd /d D:\jakarta-jmeter-2.3.4\bin\
java -jar ApacheJMeter.jar -n -t D:\jakarta-jmeter-2.3.4\bin\4SAPI\Ver2\2_All_APIs_One_Click.jmx

cd /d D:\jakarta-jmeter-2.3.4\bin\4SAPI\
ruby email.rb

echo today is %DATE% %TIME% 

