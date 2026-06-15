# 📊 Business Case Management ETL & Dashboard

A comprehensive end-to-end Business Intelligence project demonstrating data engineering, robust ETL pipelines, and interactive analytics using masked company operational data. 

## 👁️ Dashboard Preview & Demo

<table border="0">
  <tr>
    <td>
      <img width="300" height="375" alt="Dashboard View 1" src="https://github.com/user-attachments/assets/91192415-4afa-4aa8-9692-7cf4da850eef" />
    </td>
    <td>
      <img width="300" height="375" alt="Dashboard View 2" src="https://github.com/user-attachments/assets/b8d8dc63-53b5-4f6f-bac4-aeb8cae8351f" />
    </td>
  </tr>
  <tr>
    <td>
      <img width="300" height="375" alt="Dashboard View 3" src="https://github.com/user-attachments/assets/8369e054-dad0-4035-8ee5-4699b4d4a594" />
    </td>
    <td>
      <img width="300" height="375" alt="Dashboard View 4" src="https://github.com/user-attachments/assets/6b17c23e-96fc-41f4-a6ec-ae52f0188daf" />
    </td>
  </tr>
</table>

## 🛠️ How to Inspect This Project

### 👁️ Option 1: Quick View (Recommended)

1. To explore the layout, architecture, and DAX measures without setting up a data source:

2. Download and open Demo.pbix in Power BI Desktop.

⚠️ Important: Do not click the Refresh button upon opening.

### 🔌 Option2: Connecting to Your Own SharePoint Directory

1. Upload the files from the /data folder in this repository to your SharePoint directory. Ensure your directory mirrors this folder structure:

        ├── 📁 DATA/
        │   └── Mock_Data.xlsx
        └── 📁 MAPPING/
            ├── PARENT_UNIT.xlsx
            └── HOLIDAY.xlsx
            └── PRODUCT.xlsx

    
2. In Power BI Desktop, click **Transform Data** to open the Power Query Editor.
3. Locate the **Source** query/parameter step and update the URL path string to match your SharePoint directory link.
