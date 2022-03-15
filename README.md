# data-viz-class

This repo contains Python scripts and SQL queries that are used in the "Applied Data Analysis &amp; Visualization" class

## Software

### Required:

- [PostgreSQL + PostGIS](https://www.postgresql.org/download/windows/)
- [DBeaver](https://dbeaver.com/download/lite/)
- [QGIS](https://www.qgis.org/en/site/forusers/download.html)

### Not required, but recommended:

- [miniconda](https://docs.conda.io/en/latest/miniconda.html)
- [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab)

## Data Setup

[DVRPC employees can access all files related to this course on GoogleDrive](https://drive.google.com/drive/folders/1AXb63VM86_tGUSMjDmcSJlTRUWtsKUTA?usp=sharing).

### Create your database

- Open up `DBeaver` from your start menu
- If this is your first time opening it:
  - connect to your local PostgreSQL cluster by clicking the plug icon with a plus sign overlay
  - click on `PostgreSQL`
  - add the password under the `Authentication` section
  - click on the tab named `PostgreSQL` and then check the box that says `Show all databases` under the `Settings` section
  - click `Finish` in the bottom-right corner
  - you'll then have a new connection under the `Database Navigator` on the left side of your screen
- Right click on your `localhost` connection and click on `Create` and then `Database`
- Name your new database `data_viz`
- Expand the `Databases` entry under your `localhost` connection and right click, the click `SQL Editor` and then `New SQL script`
- In the new text editor window that appears, write the following SQL code: `CREATE EXTENSION postgis;`
- Run this SQL code by pressing the orange play button in the top-left corner of the text editor window, or using the keyboard shortcut `CTRL` + `ENTER`

### Import Spatial Data

County and municipal polygons were downloaded as shapefiles from [DVRPC's open data portal](https://dvrpc-dvrpcgis.opendata.arcgis.com/) and placed in the `data` subfolder within the shared GoogleDrive folder. To import these shapefiles into your database as spatial data:

- Open the `PostGIS Shapefile Import/Export Manager` from the Start menu
- Click `View connection details...`, fill out the information in the popup, and the click `OK`
- Click `Add File`
- Use the popup file picker to navigate to the `data` subfolder and then double-click on `County_Boundaries_(polygon).shp`
- Repeat this process for `Municipal_Boundaries_(polygon).shp`
- Under the `Table` heading, edit the tablename for each shapefile by deleting the `_(polygon)` from the name
- Under the `SRID` heading, change the number from `0` to `4326`
- Click the `Import` button

### Import Tabular Data

#### Manual process

If you'd prefer not to use Python, you can import the tabular data manually:

- Copy the `data` subfolder from GoogleDrive to your local Desktop
- Follow the instructions in the slides that show how to clean and prep your local Excel files
- Use DBeaver to import the tables into PostgreSQL

#### Automated process

If you'd like to use Python to automate the process of importing data tables into your database, start by creating an environment with `conda`:

```
conda env create -f .\environment.yml
```

After everything is installed, activate the environment with:

```
conda activate data-viz
```

You can now run the Python script with:

```
python .\python-scripts\import_xlsx_files.py
```

## Spatial Visualization

Connect QGIS to your PostgreSQL database to view your data in a familiar desktop GIS environment:

- Open `QGIS` from your Start menu
- In the `Browser` on the left side of your screen, right-click on `PostGIS` and then `New Connection`
- Fill out the following fields:
  - `Name` is how the entry will appear in the QGIS browser. Name it whatever you want
  - `Host` should be `localhost`
  - `Database` should be `data_viz`
  - Under `Authentication` click `Basic`, and then fill out the `User Name` and `Password`. Next to each one click the `Store` checkbox.
  - Click the `OK` button at the bottom of the popup

You only need to connect to your database once, and whenever you open QGIS in the future it'll show up in the list under `PostGIS`.
