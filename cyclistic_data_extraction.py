import os
import glob
import pandas as pd
from sqlalchemy import create_engine
import urllib.request
import zipfile
import shutil

# 1. Database Connection (Remember your password!)
db_connection_string = 'mysql+pymysql://ocran:EV48XHTVDco.@localhost/cyclistic_db'
engine = create_engine(db_connection_string)

# 2. Define the exact 12 months we want (March 2025 to February 2026)
target_months = [
    '202503', '202504', '202505', '202506', 
    '202507', '202508', '202509', '202510', 
    '202511', '202512', '202601', '202602'
]

base_url = "https://divvy-tripdata.s3.amazonaws.com/"
is_first_file = True
temp_folder = "temp_cyclistic_data"

print("Starting cloud data extraction pipeline...")

# Create a temporary folder to hold the extracted files
if not os.path.exists(temp_folder):
    os.makedirs(temp_folder)

# 3. Loop through each month: Download -> Extract -> Upload -> Delete
for month in target_months:
    zip_name = f"{month}-divvy-tripdata.zip"
    download_url = base_url + zip_name
    
    print(f"\nFetching {zip_name} from AWS S3...")
    
    try:
        # Download the zip file from the URL
        urllib.request.urlretrieve(download_url, zip_name)
        
        # Extract the zip file into our temporary folder
        with zipfile.ZipFile(zip_name, 'r') as zip_ref:
            zip_ref.extractall(temp_folder)
        
        # Find the CSV file inside the extracted folder
        csv_files = glob.glob(os.path.join(temp_folder, "*.csv"))
        
        for csv_file in csv_files:
            # Skip any hidden Mac files that sometimes get bundled in zip folders
            if "__MACOSX" in csv_file:
                continue
                
            print(f"Loading {os.path.basename(csv_file)} into MySQL...")
            
            # Read CSV as text to prevent formatting crashes
            df = pd.read_csv(csv_file, dtype=str)
            df.columns = df.columns.str.lower().str.strip().str.replace(' ', '_')
            
            # Push to database
            if is_first_file:
                df.to_sql(name='tripdata', con=engine, if_exists='replace', index=False, chunksize=10000)
                is_first_file = False
            else:
                df.to_sql(name='tripdata', con=engine, if_exists='append', index=False, chunksize=10000)
        
        # Clean up: Delete the zip file and empty the temp folder for the next month
        os.remove(zip_name)
        for file in glob.glob(os.path.join(temp_folder, "*")):
            if os.path.isfile(file):
                os.remove(file)
            elif os.path.isdir(file):
                shutil.rmtree(file)
                
        print(f"Successfully processed and cleaned up {month}.")

    except Exception as e:
        print(f"Error processing {month}: {e}")

# Final cleanup of the temp folder
os.rmdir(temp_folder)
print("\nSuccess! Your 12-month cloud pipeline is complete.")