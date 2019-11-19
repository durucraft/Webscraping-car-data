from selenium import webdriver
import time
import pandas as pd
from selenium.webdriver.common.keys import Keys
car_vin=pd.read_csv("clean_Vins.csv")
new_vin=car_vin['Vin']
filename="cars2.csv"
f=open(filename,"w")
header="Vin,Style,Brand\n"
f.write(header)
for i in range(len(new_vin)):
    vin=new_vin[i]
    f.write(vin)
    my_url="https://vpic.nhtsa.dot.gov/decoder/Decoder"
    #opens a connection to grab the pag
    driver = webdriver.Chrome()
    driver.get(my_url)
    search= driver.find_element_by_name("VIN")
    search.send_keys(new_vin[i])
    search.send_keys(Keys.RETURN)
    #html parsing
    style=driver.find_element_by_xpath('/html/body/div[2]/div[3]/div[2]/div/div[2]/div[2]/div[1]/p[6]')
    make=driver.find_element_by_xpath('/html/body/div[2]/div[3]/div[2]/div/div[2]/div[2]/div[1]/p[4]')
    car_style=style.text
    car_make=make.text
    f.write((",")+car_style)
    f.write((",")+car_make.replace(",","")+'\n')
    time.sleep(10)
    driver.close()