import json
import os

def process_weather_data(input_path='scraping/rawData.json', output_path='scraping/useableData.json'):
    try:
        with open(input_path, 'r', encoding='utf-8') as file:
            data = json.load(file)
    except FileNotFoundError:
        print(f"error: no input?")
        return
    except json.JSONDecodeError:
        print("error: json syntax issue")
        return

    if not data.get('apambiente'):
        print("error: apambiente info empty")
        return
        
    apa_info = data['apambiente'][0]
    data_ref = apa_info.get('Data')
    hora_ref = apa_info.get('Hora')  

    apa_cleaned = {k: v for k, v in apa_info.items() if k not in ['Data', 'Hora']}

    try:
        hora_numerica = int(hora_ref.split(':')[0])
        hora_ipma_target = f"{hora_numerica:02d}h"
    except (ValueError, IndexError, AttributeError):
        print(f"error: apambiente time format invalid '{hora_ref}'")
        return
    
    ipma_filtered = []
    for item in data.get('ipma', []):
        if item.get('Hora') == hora_ipma_target:
            ipma_cleaned = {k: v for k, v in item.items() if k != 'Hora'}
            ipma_filtered.append(ipma_cleaned)
            break  

    usable_data = {
        "date": data_ref,
        "time": hora_ref,
        "apambiente": [apa_cleaned],
        "ipma": ipma_filtered
    }

    with open(output_path, 'w', encoding='utf-8') as file:
        json.dump(usable_data, file, ensure_ascii=False, indent=4)
        
    print(f"json file updated!")

#"Am I the main script being run right now?"
if __name__ == '__main__':
    process_weather_data()