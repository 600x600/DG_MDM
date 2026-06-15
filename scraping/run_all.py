# run_all.py
import scraper 
import reducer

def run_pipeline():
    print("--- STARTING PIPELINE ---")

    print("\n[1] Running scraper.py...")
    scraper.process_scraping() 

    print("\n[2] Running reducer.py...")
    reducer.process_weather_data()

    print("\n--- PIPELINE COMPLETED! ---")

if __name__ == "__main__":
    run_pipeline()