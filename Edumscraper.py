from selenium import webdriver
import time
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException as TE
from selenium.webdriver.common.by import By
import pandas as pd
car_vec=pd.read_csv("clean_Vech.csv")
filename="cars3.csv"
f=open(filename,"a")
header="Year,Brand,vec_name,style,engine,hp,curbweight,index,dropindex\n"
year=car_vec.Year
Brand=car_vec.Brand
vec_name=car_vec.vec_name
#need to find where values start
guess='\n'
x=input("Edumscraper.py")
#chromo driver is open
driver = webdriver.Chrome()
#loop through range of year
for i in range(int(x),len(year)):
    my_url="https://www.edmunds.com/"+Brand[i]+"/"+vec_name[i]+"/"+str(year[i])+"/features-specs/"
    #my_url="https://www.edmunds.com/lexus/nx/2016/features-specs/"
    print(i)
    j=1 
    while j<30:
        #start=time.time()
        driver = webdriver.Chrome()
       # wait to see if page has loaded
        try:
            driver.set_page_load_timeout(35)
            driver.get(my_url)
            elem = driver.find_elements_by_xpath('/html/body/div[1]/div/div[3]/div[2]/div[2]/p[2]/a[1]')
            #pages that don't exist
            if len(elem)>0:
               i=i+1
               driver.close()
               break
            #waits to do anything until the xpath is loaded in
            WebDriverWait(driver,5).until(EC.presence_of_element_located((By.XPATH, "//*[@id='Overview-section-title-content']")))
            #check if advertizement is loaded and close it if there is any if not keeps the loop running
            try:
                driver.find_element_by_xpath("/html/body/div[1]/div/div[2]/div[2]/div/span").click()
            except:
                pass
            #scrolls down so the drop down menu could be seen fully by the script
            driver.execute_script("window.scrollTo(0, 150)") 
            # opens drop down menu
            driver.find_element_by_xpath("//*[@id='Overview-section-title-content']/table/thead/tr/th[2]/div[1]/button").click()
            #try catch need so when the while loop reachs the end it could break out of the loop
            try:
                #since the first value is already loaded in needs special condition
                if j==1:
                   #grabs text information of the item
                    driver.find_element_by_xpath('/html/body/div[1]/div/main/div[1]/div[3]/div/table/thead/tr/th[2]/div[1]/div/button['+str(j)+']')
                    car_P= driver.find_element_by_id('Overview-section-title-content').text
                    #grabs horse power
                    hp=driver.find_element_by_xpath('//*[@id="Engine-section-title-content"]/table/tbody/tr[3]/td[1]').text
                   #grabs curbwieght
                    curbw=driver.find_element_by_xpath('//*[@id="Measurements-section-title-content"]/table/tbody/tr[3]/td[1]').text
                    #use /n to find where information need is stored then grabs that information
                    indices = [k for k, a in enumerate(car_P) if a == guess]
                    sty=car_P[indices[1]+1:indices[2]]
                    eng=car_P[indices[2]+1:indices[3]]
                    print(sty)
                elif j>1:
                    #goes through the drop down list and grabs infromtion till it breaks
                    driver.find_element_by_xpath('/html/body/div[1]/div/main/div[1]/div[3]/div/table/thead/tr/th[2]/div[1]/div/button['+str(j)+']').click()
                    time.sleep(5)
                    car_ps= driver.find_element_by_id('Overview-section-title-content').text
                    hp=driver.find_element_by_xpath('//*[@id="Engine-section-title-content"]/table/tbody/tr[3]/td[1]').text
                    curbw=driver.find_element_by_xpath('//*[@id="Measurements-section-title-content"]/table/tbody/tr[3]/td[1]').text
                    indice = [k for k, a in enumerate(car_ps) if a == guess]
                    sty=car_ps[indice[0]+1:indice[1]]
                    eng=car_ps[indice[1]+1:indice[2]]
                    print(sty)
                time.sleep(5) 
            except:
                driver.close()
                break
            #close the broswer to save memory 
            driver.close()
            #write all the informtion garther form the while loop to csv file
            f.write(str(year[i]))
            f.write((",")+Brand[i])
            f.write((",")+vec_name[i])
            f.write((",")+sty)
            f.write((",")+eng)
            f.write((",")+hp)
            f.write((",")+curbw)
            f.write((",")+str(i))
            f.write((",")+str(j)+'\n')
            j=j+1  
        except TE:
        #checki if its nor running
                isrunning=0
                driver.close()