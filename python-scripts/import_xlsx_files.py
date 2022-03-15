import pandas as pd
from pathlib import Path
from sqlalchemy import create_engine

data_folder = Path(r"G:\Shared drives\Mobility Analysis and Design Resource Library\Data Analysis & Viz Class\data")


def clean_up_column_names(df: pd.DataFrame) -> pd.DataFrame:
    """    
    Clean up column names inside a Pandas DataFrame. 
    SQL is easier to write if you column names are lower-cased
    and don't have any special characters other than letters, numbers and underscores.
    
    e.g. transform "Duration (Day-hh:mm)" to "duration__day_hh_mm_"
    """
    nice_column_names = [col.lower() for col in df.columns]
    replacements = [" ", "-", ":", "(", ")", "/"]
    for character in replacements:
        nice_column_names = [col.replace(character, "_") for col in nice_column_names]
        
    df.columns = nice_column_names

    return df


# Connect to the SQL database
sql_connection_string = "postgresql://postgres:sergt@localhost:5432/data_viz"
engine = create_engine(sql_connection_string)

# Repeat the import process for both states in our region
for state in ["NJ", "PA"]:

    # 1: Import the EVENTS table
    # --------------------------
    # 1A: Read the Excel file for this state from the data folder, skipping the non-data rows
    event_filepath = data_folder / f"{state}_Events.xlsx"
    df = pd.read_excel(event_filepath, skiprows=22)
    df = clean_up_column_names(df)

    # 1B: Import from Python to SQL
    df.to_sql(f"{state.lower()}_events", con=engine)


    # 2: Import the BOTTLENECKS table
    # -------------------------------
    # 2A: Read the Excel file for this state from the data folder. In this case headers are in the first row
    bottleneck_filepath = data_folder / f"{state} Bottlenecks.xlsx"
    df = pd.read_excel(bottleneck_filepath)
    df = clean_up_column_names(df)

    # 2B: Import from Python to SQL
    df.to_sql(f"{state.lower()}_bottlenecks", con=engine)

# Disconnect from SQL at the end of the script
engine.dispose()
