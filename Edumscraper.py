from selenium import webdriver
import time
import pandas as pd
car_vec=pd.read_csv("clean_Vech.csv")
filename="cars3.csv"
f=open(filename,"a")
header="Year,Brand,vec_name,style,engine,hp,curbweight,index,dropindex\n"
year=car_vec.Year
Brand=car_vec.Brand
vec_name=car_vec.vec_name
guess='\n'
x=input("Edumscraper.py")
for i in range(int(x),len(year)):
    my_url="https://www.edmunds.com/"+Brand[i]+"/"+vec_name[i]+"/"+str(year[i])+"/features-specs/"
    j=1
    while j<30:
        f.write(str(year[i]))
        f.write((",")+Brand[i])
        f.write((",")+vec_name[i])
        driver = webdriver.Chrome()
        driver.get(my_url)
        #driver.find_element_by_xpath("/html/body/div[1]/div/div[2]/div[2]/div/span").click()
        driver.execute_script("window.scrollTo(0, 150)") 
        driver.find_element_by_xpath("//*[@id='Overview-section-title-content']/table/thead/tr/th[2]/div[1]/button").click()
        try:
            if j==1:
                driver.find_element_by_xpath('/html/body/div[1]/div/main/div[1]/div[3]/div/table/thead/tr/th[2]/div[1]/div/button['+str(j)+']')
                car_P= driver.find_element_by_id('Overview-section-title-content').text
                hp=driver.find_element_by_xpath('//*[@id="Engine-section-title-content"]/table/tbody/tr[3]/td[1]').text
                curbw=driver.find_element_by_xpath('//*[@id="Measurements-section-title-content"]/table/tbody/tr[3]/td[1]').text
                indices = [k for k, a in enumerate(car_P) if a == guess]
                sty=car_P[indices[1]+1:indices[2]]
                eng=car_P[indices[2]+1:indices[3]]
                print(sty)
            elif j>1:
                driver.find_element_by_xpath('/html/body/div[1]/div/main/div[1]/div[3]/div/table/thead/tr/th[2]/div[1]/div/button['+str(j)+']').click()
                car_ps= driver.find_element_by_id('Overview-section-title-content').text
                hps=driver.find_element_by_xpath('//*[@id="Engine-section-title-content"]/table/tbody/tr[3]/td[1]').text
                curbws=driver.find_element_by_xpath('//*[@id="Measurements-section-title-content"]/table/tbody/tr[3]/td[1]').text
                indice = [k for k, a in enumerate(car_ps) if a == guess]
                styl=car_ps[indice[0]+1:indice[1]]
                engi=car_ps[indice[1]+1:indice[2]]
                print(styl)
        except:
            break
        time.sleep(10)
        driver.close()
        if j==1:
            f.write((",")+sty)
            f.write((",")+eng)
            f.write((",")+hp)
            f.write((",")+curbw)
        else:
            f.write((",")+styl)
            f.write((",")+engi)
            f.write((",")+hps)
            f.write((",")+curbws)
        f.write((",")+str(i))
        f.write((",")+str(j)+'\n')
        j=j+1
        