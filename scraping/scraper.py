import requests
from bs4 import BeautifulSoup
import re
import json
import os

#apambiente & ipma URLs
URLS = {
    "apambiente": "https://infoagua.apambiente.pt/pt/cheias/cheia-detalhe/1627743374",
    "ipma": "https://www.ipma.pt/pt/maritima/costeira/index.jsp?selLocal=33&idLocal=33&print=true" #IPMA's direct raw data feed
}

def scrape_data():
    #data.json structure
    scraped_data = {
        "apambiente": [],
        "ipma": []
    }
    headers = {'User-Agent': 'Mozilla/5.0'}
    
    # ---> APAMBIENTE !!!
    try:
        response1 = requests.get(URLS["apambiente"], headers=headers)
        soup1 = BeautifulSoup(response1.text, 'html.parser')
        selector1 = ".right-header-column .text-container:nth-of-type(n+2)"
        relevant_containers = soup1.select(selector1) 
        
        apambiente_metrics = {}
        for container in relevant_containers:
            title_element = container.select_one(".title")
            value_element = container.select_one(".value")
            if title_element and value_element:
                title = title_element.text.strip()
                numeric_match = re.findall(r"[-+]?\d*\.\d+|\d+", value_element.text) #only numbers no text and stuff
                if numeric_match:
                    apambiente_metrics[title] = numeric_match[0]
        
        if apambiente_metrics:
            scraped_data["apambiente"].append(apambiente_metrics)
            
    except Exception as e:
        print(f"Error scraping Apambiente: {e}")

   # ---> IPMA !!!
    try:
        response2 = requests.get(URLS["ipma"], headers=headers)
        soup2 = BeautifulSoup(response2.text, 'html.parser')
        
        table_rows = soup2.select('table.tablelist tr[class^="bkg_"]')
        
        for row in table_rows:
            cells = row.find_all('td')
            if len(cells) >= 9:
                scraped_data["ipma"].append({
                    "Hora": cells[0].text.strip(),
                    "Ondulacao": cells[2].text.strip(),
                    "Temperatura": cells[9].text.strip()  
                })
                
    except Exception as e:
        print(f"Error scraping IPMA: {e}")

    #check if anything was actually collected before proceeding
    if not scraped_data["apambiente"] and not scraped_data["ipma"]:
        return {}

    print(scraped_data)
    return scraped_data

def save_if_changed(new_data):
    if not new_data:
        print("No data collected from the websites.")
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
        print("Data updated!")
    else:
        print("No changes detected.")

#run
current_data = scrape_data()
save_if_changed(current_data)