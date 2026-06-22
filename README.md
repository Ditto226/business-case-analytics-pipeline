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

1.  Upload the Data: Upload the files from in this repository to your SharePoint directory. Ensure your directory mirrors this folder structure:

        ├── 📁 DATA/
        │   └── Mock_Data.xlsx
        └── 📁 MAPPING/
            ├── PARENT_UNIT.xlsx
            └── HOLIDAY.xlsx
            └── PRODUCT.xlsx

2.  Open the Template: Download and open Project_Template.pbit in Power BI Desktop
3.  Input Parameters: Upon opening, a pop-up window will prompt you for your environment details. Enter your paths into the provided fields:

### _SharePointURL_: https://{your-tenant}.sharepoint.com/sites/{your-site}

### _DocumentLibrary_: The name of your SharePoint library (e.g., Shared Documents).

### _TargetFolder_: The name of the root folder holding your data (e.g., DATA_FOLDER).

4. Load Data: Click Load. Power BI will establish the connection, run the entire M-code ETL pipeline, and populate the interactive dashboards automatically.
