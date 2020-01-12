from selenium import webdriver
import time
import pandas as pd
from selenium.webdriver.common.keys import Keys
#open csv and grab vin 
car_vin=pd.read_csv("clean_Vins.csv")
new_vin=car_vin['Vin']
#create new file to write information 
filename="cars2.csv"
f=open(filename,"a")
header="Vin,Style,Brand\n"
f.write(header)
# create a input to start application where informtion 
x=input("scraper.py")
# create open google webdriver 
for i in range(int(x),len(new_vin)):
    vin=new_vin[i]
    f.write(vin)
    my_url="https://vpic.nhtsa.dot.gov/decoder/Decoder"
    #opens a connection to grab the page
    driver = webdriver.Chrome()
    driver.get(my_url)
    #find element in html
    search= driver.find_element_by_name("VIN")
    #send the value from list to be search up
    search.send_keys(new_vin[i])
    search.send_keys(Keys.RETURN)
    #find elements by xpath 
    style=driver.find_element_by_xpath('/html/body/div[2]/div[3]/div[2]/div/div[2]/div[2]/div[1]/p[6]')
    make=driver.find_element_by_xpath('/html/body/div[2]/div[3]/div[2]/div/div[2]/div[2]/div[1]/p[4]')
    car_style=style.text
    car_make=make.text
    #write the element to csv file
    f.write((",")+car_style)
    f.write((",")+car_make.replace(",","")+'\n')
    # waits so vaules could be copied
    time.sleep(10)
    driver.close()