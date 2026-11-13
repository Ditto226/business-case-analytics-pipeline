![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Power Automate](https://img.shields.io/badge/Power_Automate-0078D4?style=for-the-badge&logo=microsoft-power-automate&logoColor=white)

# Customer Experience Management (CEM) Analytics & Automation Platform

An end-to-end operational dashboard and automated pipeline solution designed to track, analyze, and resolve customer complaints efficiently. 

---

## 🚀 Project Overview
* **Timeline:** ~2 Months (Design, Development, ETL, and Automation)
* **Goal:** Replace manual tracking spreadsheets with a synchronized automated pipeline and interactive Power BI executive dashboard to monitor complaint resolution metrics and identify recurring issues.
* **Data Privacy:** All data utilized in this repository is completely synthetic/mock data (`MOCK_data.xlsx`) to ensure strict adherence to PII/PNC privacy protocols.

---

## 🎥 Demo Preview
![Dashboard Demo Preview](https://raw.githubusercontent.com/Ditto226/cem-analytics-automation-platform/main/demo_dashboard.gif)
![Automate Demo Preview](https://raw.githubusercontent.com/Ditto226/cem-analytics-automation-platform/main/demo_automate.gif)
> Note: The waiting delay (~10s) and dataset refresh action (~2m) have been trimmed for demo purposes.

---

## 🏗️ System Architecture & Workflow

This project integrates data automation with business intelligence to form a seamless workflow:

1. **Ingestion & Automation (`/automation`):** A Power Automate cloud flow manages data refresh and daily reporting/cases escalation.
2. **Transformation (`/dashboard/query`):** Power Query (M code) cleans, shapes, and handles custom business logic such as business day calculation and repeated cases logic.
3. **Data Modeling (`/dashboard/model`):** A structured star schema connects fact and dimension tables.
4. **Calculations (`/dashboard/dax`):** Various DAX measures including custom business KPIs like Complaint Index and Resolution Times.
5. **Visualization (`/dashboard/CEM.pbix`):** Interactive reporting surfaces insights to stakeholders.

> 📌 **Note on Data Ingestion:** Due to production database access constraints and security compliance, the ingestion pipeline utilizes a **staged hybrid approach**:
> * **Extraction & Staging (Semi-Automated):** Source data is manually exported and securely uploaded to a SharePoint staging directory.
> * **Downstream Automation (Fully Automated):** Once staged in SharePoint, Power Automate triggers the dataset refresh, Power Query executes transformation logic, and automated reporting/case escalations run seamlessly.
---


## 📊 Key Dashboard Pages & Metrics

| Dashboard Page | Description | Sample Visual |
| :--- | :--- | :--- |
| **Complaint Index** | Measures overall complaint volume, current and normalized monthly complaint index, weekly/daily volume spike based on cases Type, Subarea and Category. | ![Complaint Index](https://raw.githubusercontent.com/Ditto226/cem-analytics-automation-platform/main/dashboard/samples/dashboard_complaint_index.png) |
| **Resolution Time** | Tracks monthly/weekly/daily SLA adherence, volume of cases to close to meet SLA for daily and monthly, potential and failed cases, as well as active cases bottleneck departments. It is divided into 2 categories Complain Resolution Time (CRT) & Complain Resolution Time Tail-End (CRT-TE) | ![Resolution Time](https://raw.githubusercontent.com/Ditto226/cem-analytics-automation-platform/main/dashboard/samples/dashboard_complaint_resolution_time.png) |
| **Repeated Issues** | Identifies recurring customer tickets and systemic root causes. The logic is by detecting customer account no. frequency within 90 days and within a specific rule. The specific rule is divided into 2 categories, repeated by Type, Subarea and Category (LOV) or repeated only by Type. | ![Repeated Issues](https://raw.githubusercontent.com/Ditto226/cem-analytics-automation-platform/main/dashboard/samples/dashboard_repeated.png) |

---

## 🛠️ Repository Structure

```text
├── dashboard/
│   ├── dax/                  # Core DAX measures (Index, Resolution Time, etc.)
│   ├── query/                # Power Query (M) scripts and custom functions
│   ├── model/                # Data model relationship diagrams
│   ├── samples/              # High-res static images of report pages
│   └── CEM.pbix              # Main Power BI report file
│
├── automation/
│   ├── automate.jpeg         # Workflow architecture / flow builder screenshot
│   ├── automate.json         # Exported Power Automate definition
│   └── samples/              # Automated report outputs / notifications
│
├── data/
│   └── MOCK_data.xlsx        # Sanitized sample dataset (PII/PNC safe)
│
└── README.md                 # Project documentation
