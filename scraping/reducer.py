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

    if not data.get('aguieira'):
        print("error: aguieira info empty")
        return
        
    aguieira_info = data['aguieira'][0]
    data_ref = aguieira_info.get('Data')
    hora_ref = aguieira_info.get('Hora')  
    
    raiva_info = data['raiva'][0]
    coimbra_info = data['coimbra'][0]
    
    aguieira_cleaned = {k: v for k, v in aguieira_info.items() if k not in ['Data', 'Hora']}
    raiva_cleaned = {k: v for k, v in raiva_info.items() if k not in ['Data', 'Hora']}
    coimbra_cleaned = {k: v for k, v in coimbra_info.items() if k not in ['Data', 'Hora']}

    try:
        hora_numerica = int(hora_ref.split(':')[0])
        hora_figueira_target = f"{hora_numerica:02d}h"
    except (ValueError, IndexError, AttributeError):
        print(f"error: aguieira time format invalid '{hora_ref}'")
        return
    
    figueira_filtered = []
    for item in data.get('figueira', []):
        if item.get('Hora') == hora_figueira_target:
            figueira_cleaned = {k: v for k, v in item.items() if k != 'Hora'}
            figueira_filtered.append(figueira_cleaned)
            break  

    usable_data = {
        "date": data_ref,
        "time": hora_ref,
        "aguieira": [aguieira_cleaned],
        "raiva": [raiva_cleaned],
        "coimbra": [coimbra_cleaned],
        "figueira": figueira_filtered
    }

    with open(output_path, 'w', encoding='utf-8') as file:
        json.dump(usable_data, file, ensure_ascii=False, indent=4)
        
    print(f"json file updated!")

#"Am I the main script being run right now?"
if __name__ == '__main__':
    process_weather_data()