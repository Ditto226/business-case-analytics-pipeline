# 📊 Telecom Case Management ETL & Dashboard

A comprehensive end-to-end Business Intelligence project demonstrating data engineering, robust ETL pipelines, and interactive analytics using masked Malaysian telecom operational data. The file use safely masked, pre-loaded mock data.

## 👁️ Dashboard Preview & Demo

<table border="0">
  <tr>
    <td>
      <img width="300" height="375" alt="Dashboard View 1" src="https://github.com/user-attachments/assets/91f7e276-4342-4e67-a86a-e950a94df908" />
    </td>
    <td>
      <img width="300" height="375" alt="Dashboard View 2" src="https://github.com/user-attachments/assets/326b5957-c689-4bbf-aefe-a7f661affda2" />
    </td>
  </tr>
  <tr>
    <td>
      <img width="300" height="375" alt="Dashboard View 3" src="https://github.com/user-attachments/assets/1e3408e4-ee35-44be-8d59-a8e8fd397d1a" />
    </td>
    <td>
      <img width="300" height="375" alt="Dashboard View 4" src="https://github.com/user-attachments/assets/c688813e-5284-47f8-9432-6170955cd981" />
    </td>
  </tr>
</table>

## 🛠️ How to Inspect This Project

### 👁️ Option 1: Quick View (Recommended)

1. To explore the layout, architecture, and DAX measures without setting up a data source:

2. Download and open Telecom_Demo.pbix in Power BI Desktop.

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
