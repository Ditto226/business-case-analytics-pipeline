# 📊 Telecom Case Management ETL & Dashboard

A comprehensive end-to-end Business Intelligence project demonstrating data engineering, robust ETL pipelines, and interactive analytics using masked Malaysian telecom operational data.

🛠️ How to Inspect This Project
To explore the architecture, download and open Telecom_Demo.pbix in Power BI Desktop.

👁️ For Visuals & Dashboard Design
The file includes safely masked, pre-loaded mock data so you can view the layouts and interact with filters immediately.

⚠️ Important: Do not click the Refresh button upon opening the file, as the source paths point have not been setup yet.

🔌 Connecting to Your Own SharePoint Directory
If you want to run a live data refresh locally, you can easily point the model to your own environment:

Upload the files from the /data folder in this repository to your SharePoint directory. Ensure your directory mirrors this folder structure:

    ├── 📁 DATA/
    │   └── Mock_Data.xlsx
    └── 📁 MAPPING/
        ├── PARENT_UNIT.xlsx
        └── HOLIDAY.xlsx
        └── PRODUCT.xlsx

    
2. In Power BI Desktop, click **Transform Data** to open the Power Query Editor.
3. Locate the **Source** query/parameter step and update the URL path string to match your SharePoint directory link.
