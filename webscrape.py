#Dunick Voltaire
#Capstone
#webscrapping
from bs4 import BeautifulSoup as bs
from urllib.request import urlopen as UReq
import time
#opens a connection to grab the page
start_time=time.time()
filename="cars.csv"
f=open(filename,"w")
headers="Name ,Year ,Miles ,Location ,Extrior ,Style ,Interior ,MPG ,Engine ,Transmission ,DriveType ,FuelType ,Price ,Vin\n"
f.write(headers)
link=set()
for z in range(181,333):
    time.sleep(10)
    link.clear()
    my_url="https://www.truecar.com/used-cars-for-sale/listings/location-randolph-ma/?page="+str(z)+"&searchRadius=100&sort[]=distance_asc_script"
    #opens a connection to grab the pag
    uClient=UReq(my_url)
    page_html= uClient.read()
    uClient.close()
    #html parsing
    page_soup=bs(page_html,'html.parser')
    # gets each products
    Listing=page_soup.findAll("div",{"class":"flex-column flex-sm-row card margin-top-3 card_1hx6mcr"})
    #print(Listing[0])
    i=0 
    for lists in Listing:
        lists=Listing[i]
        i=i+1
        for links in lists.findAll('a'):
            link.add(links.get('href'))
    for links in link.copy():
        links=link
        used_url='https://www.truecar.com'+links.pop()
        time.sleep(20)
        uClients=UReq(used_url)
        page_htmls= uClients.read()
        use_url=bs(page_htmls,'html.parser')
        carslisting=use_url.findAll("div",{"class":"mainContainer_mm7knf"})
        for listing in carslisting:
            car_name=listing.findAll("div",{"class":"text-truncate heading-3 margin-right-2 margin-right-sm-3"})
            name=car_name[0].text
            car_type=listing.findAll("div",{"class":"text-truncate heading-4 text-muted"})
            ctype=car_type[0].text
            car_mile=listing.findAll("span",{"data-test":"usedVdpHeaderMiles"})
            miles=car_mile[0].text
            car_location=listing.findAll("span",{"data-test":"usedVdpHeaderLocation"})
            location=car_location[0].text
            f.write(name+","+ctype+","+miles.replace(",","")+","+location.replace(",",""))
            car_info=use_url.findAll("div",{"class":"row row-2 padding-2"})
            j=0
        for info in car_info:
            infos=info.findAll("div",{"class":"col_1or2vgx align-self-center col"})
            while j<=7:
                car_infos=infos[j].text
                f.write(","+car_infos)
                j+=1
        for pri in car_info:
            pric=pri.findAll("strong",{"data-test":"vehiclePrice"})
            if len(pric)==1:
                car_price=pric[0].text
                f.write(","+car_price.replace(",",""))
        car_v=use_url.findAll("div",{"class":"wrappable-1 padding-1 hidden-sm-down border-bottom galleryFooter_py3uvl"})
        for vi in car_v:
            vin=vi.findAll("li",{"class":"text-sm text-muted"})
            car_vin=vin[0].text
            f.write(","+car_vin+"\n")
        