import requests
from bs4 import BeautifulSoup
import re
import json
import os

#coimbra & figueira URLs
URLS = {
    "aguieira": "https://infoagua.apambiente.pt/pt/cheias/cheia-detalhe/1627743384", #aguieira Mondego
    "raiva": "https://infoagua.apambiente.pt/pt/cheias/cheia-detalhe/1627759328", #raiva Mondego
    "coimbra": "https://infoagua.apambiente.pt/pt/cheias/cheia-detalhe/1627743374", #coimbra Mondego
    "figueira": "https://www.ipma.pt/pt/maritima/costeira/index.jsp?selLocal=33&idLocal=33&print=true" #direct official IPMA feed
}

def scrape_data():
    #data.json structure
    scraped_data = {
        "aguieira": [],
        "raiva": [],
        "coimbra": [],
        "figueira": []
    }
    headers = {'User-Agent': 'Mozilla/5.0'}
    
    # ---> aguieira !!!
    try:
        response1 = requests.get(URLS["aguieira"], headers=headers)
        soup1 = BeautifulSoup(response1.text, 'html.parser')
        selector1 = ".right-header-column .text-container"
        selector2 = ".right-header-column .additional-info .text-container" 
        info_containers = soup1.select(selector1) 
        dateTime_containers = soup1.select(selector2) 
        
        aguieira_metrics = {}
        for container in info_containers:
            title_element = container.select_one(".title")
            value_element = container.select_one(".value")
            if title_element and value_element:
                title = title_element.text.strip()
                numeric_match = re.findall(r"[-+]?\d*\.\d+|\d+", value_element.text) #only numbers no text and stuff
                if numeric_match:
                    aguieira_metrics[title] = numeric_match[0]
                    
        for container in dateTime_containers:
            date_element = container.select_one(".title")
            time_element = container.select_one(".text")
            
            if date_element and time_element:
                title1 = "Data"
                title2 = "Hora"
                
                date_text = date_element.text.strip()
                time_text = time_element.text.strip()
                
                date_match = re.search(r"\d+\s+[a-zA-Zçíúâêôãõáéó]+\s+\d+", date_text) 
                time_match = re.search(r"\d{2}:\d{2}", time_text)
                
                if date_match:
                    aguieira_metrics[title1] = date_match.group()
                    
                if time_match:
                    aguieira_metrics[title2] = time_match.group()
                    
        
        if aguieira_metrics:
            scraped_data["aguieira"].append(aguieira_metrics)
            
    except Exception as e:
        print(f"error scraping aguieira: {e}") 
        
        # ---> raiva !!!
    try:
        response1 = requests.get(URLS["raiva"], headers=headers)
        soup1 = BeautifulSoup(response1.text, 'html.parser')
        selector1 = ".right-header-column .text-container"
        selector2 = ".right-header-column .additional-info .text-container" 
        info_containers = soup1.select(selector1) 
        dateTime_containers = soup1.select(selector2) 
        
        raiva_metrics = {}
        for container in info_containers:
            title_element = container.select_one(".title")
            value_element = container.select_one(".value")
            if title_element and value_element:
                title = title_element.text.strip()
                numeric_match = re.findall(r"[-+]?\d*\.\d+|\d+", value_element.text) #only numbers no text and stuff
                if numeric_match:
                    raiva_metrics[title] = numeric_match[0]
                    
        for container in dateTime_containers:
            date_element = container.select_one(".title")
            time_element = container.select_one(".text")
            
            if date_element and time_element:
                title1 = "Data"
                title2 = "Hora"
                
                date_text = date_element.text.strip()
                time_text = time_element.text.strip()
                
                date_match = re.search(r"\d+\s+[a-zA-Zçíúâêôãõáéó]+\s+\d+", date_text) 
                time_match = re.search(r"\d{2}:\d{2}", time_text)
                
                if date_match:
                    raiva_metrics[title1] = date_match.group()
                    
                if time_match:
                    raiva_metrics[title2] = time_match.group()
                    
        
        if raiva_metrics:
            scraped_data["raiva"].append(raiva_metrics)
            
    except Exception as e:
        print(f"error scraping raiva: {e}")
    
    # ---> coimbra !!!
    try:
        response1 = requests.get(URLS["coimbra"], headers=headers)
        soup1 = BeautifulSoup(response1.text, 'html.parser')
        selector1 = ".right-header-column .text-container:nth-of-type(n+2)"
        selector2 = ".right-header-column .additional-info .text-container" 
        info_containers = soup1.select(selector1) 
        dateTime_containers = soup1.select(selector2) 
        
        coimbra_metrics = {}
        for container in info_containers:
            title_element = container.select_one(".title")
            value_element = container.select_one(".value")
            if title_element and value_element:
                title = title_element.text.strip()
                numeric_match = re.findall(r"[-+]?\d*\.\d+|\d+", value_element.text) #only numbers no text and stuff
                if numeric_match:
                    coimbra_metrics[title] = numeric_match[0]
                    
        for container in dateTime_containers:
            date_element = container.select_one(".title")
            time_element = container.select_one(".text")
            
            if date_element and time_element:
                title1 = "Data"
                title2 = "Hora"
                
                date_text = date_element.text.strip()
                time_text = time_element.text.strip()
                
                date_match = re.search(r"\d+\s+[a-zA-Zçíúâêôãõáéó]+\s+\d+", date_text) 
                time_match = re.search(r"\d{2}:\d{2}", time_text)
                
                if date_match:
                    coimbra_metrics[title1] = date_match.group()
                    
                if time_match:
                    coimbra_metrics[title2] = time_match.group()
                    
        
        if coimbra_metrics:
            scraped_data["coimbra"].append(coimbra_metrics)
            
    except Exception as e:
        print(f"error scraping coimbra: {e}")

   # ---> figueira !!!
    try:
        response2 = requests.get(URLS["figueira"], headers=headers)
        soup2 = BeautifulSoup(response2.text, 'html.parser')
        
        table_rows = soup2.select('table.tablelist tr[class^="bkg_"]')
        
        seen_hours = set()
        
        for row in table_rows:
            cells = row.find_all('td')
            if len(cells) >= 10:  
                hora = cells[0].text.strip()
                
                if hora == "00h" and "00h" in seen_hours:
                    break  
                
                seen_hours.add(hora)
                
                scraped_data["figueira"].append({
                    "Hora": hora,
                    "Ondulacao": cells[2].text.strip(),
                    "Periodo Onda": cells[4].text.strip(),
                    "Periodo Pico": cells[5].text.strip(),
                    "Temperatura": cells[9].text.strip()  
                })
                
    except Exception as e:
        print(f"error scraping figueira: {e}")

    #check if anything was actually collected before proceeding
    if not scraped_data["coimbra"] and not scraped_data["figueira"]:
        return {}

    # print(scraped_data)
    return scraped_data

def save_if_changed(new_data):
    if not new_data:
        print("no data collected from the websites.")
        return

    file_path = "scraping/rawData.json"
    
    if os.path.exists(file_path):
        with open(file_path, 'r', encoding='utf-8') as f:
            try:
                old_data = json.load(f)
            except json.JSONDecodeError:
                old_data = {}
    else:
        old_data = {}

    if old_data != new_data:
        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(new_data, f, indent=4, ensure_ascii=False)
        print("data updated!")
    else:
        print("no changes detected.")

#run
#urrent_data = scrape_data()
#save_if_changed(current_data)

def process_scraping():
    current_data = scrape_data()
    save_if_changed(current_data)

if __name__ == '__main__':
    process_scraping()