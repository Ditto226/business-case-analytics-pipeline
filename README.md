# 📊 Telecom Case Management ETL & Dashboard

A comprehensive end-to-end Business Intelligence project demonstrating data engineering, robust ETL pipelines, and interactive analytics using masked Malaysian telecom operational data.

👁️ Dashboard Preview & Demo


🛠️ How to Inspect This Project
👁️ Option 1: Quick View (Recommended)
1. To explore the layout, architecture, and DAX measures without setting up a data source:

2. Download and open Telecom_Demo.pbix in Power BI Desktop.

3. The file includes safely masked, pre-loaded mock data so you can interact with filters immediately.

⚠️ Important: Do not click the Refresh button upon opening, as the local source paths are not configured yet.

🔌 Option2: Connecting to Your Own SharePoint Directory
If you want to run a live data refresh locally, you can easily point the model to your own environment:

1. Upload the files from the /data folder in this repository to your SharePoint directory. Ensure your directory mirrors this folder structure:

        ├── 📁 DATA/
        │   └── Mock_Data.xlsx
        └── 📁 MAPPING/
            ├── PARENT_UNIT.xlsx
            └── HOLIDAY.xlsx
            └── PRODUCT.xlsx

    
2. In Power BI Desktop, click **Transform Data** to open the Power Query Editor.
3. Locate the **Source** query/parameter step and update the URL path string to match your SharePoint directory link.
