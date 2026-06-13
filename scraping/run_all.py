# run_all.py

print("--- STARTING PIPELINE ---")

print("\n[1] scraper.py...")
import scraper 

print("\n[2] reducer.py...")
import reducer
reducer.process_weather_data()

print("\n--- PIPELINE COMPLETED! ---")