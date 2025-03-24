# Azure End-To-End Data Engineering Project

## Overview

This project demonstrates an end-to-end data engineering solution on Microsoft Azure, covering in-demand tools and technologies such as **Azure Data Factory**, **Azure Databricks**, **Azure Synapse Analytics**, and more . This project aims to provide a practical understanding of building data pipelines, performing transformations, and serving data for analysis. It goes beyond simple approaches by covering real-time scenarios.

This project follows a **Medallion architecture**, also known as bronze, silver, and gold layers. Data flows through these zones, undergoing increasing levels of refinement.

![Architecture](assets/architecture.png)


## Technologies Used

*   **Azure Data Factory (ADF)**: A powerful orchestration tool used for pulling data from sources (like APIs), building both static and dynamic pipelines with features like parameters and loops, and landing data into the bronze layer.
*   **Azure Data Lake Storage Gen2**: Used as the storage layer for the raw (bronze), transformed (silver), and served (gold) data.
*   **Azure Databricks**: A data analytics service used for performing transformations on the data in the silver layer using Spark.
*   **Azure Synapse Analytics**: A data warehouse solution used in the gold layer to serve processed data for analysis and reporting.
*   **Power BI**: Briefly covered to demonstrate establishing connections to Azure Synapse Analytics for data visualization.
*   **HTTP Connection**: Used to pull data directly from APIs, such as a GitHub account in this project.
*   **Managed Identities**: Used for secure API connections and for allowing Azure Synapse Analytics to access Azure Data Lake Storage.

## Project Structure

The project implements a multi-layered data architecture:

*   **Bronze Layer (Raw)**: Data is ingested from the source (GitHub API in this case) and landed in its raw format using Azure Data Factory.
*   **Silver Layer (Transformed)**: Data from the bronze layer is processed and transformed using Azure Databricks. This layer focuses on cleaning, shaping, and enriching the data. Data is stored in optimized formats like Parquet.
*   **Gold Layer (Serving)**: Cleaned and transformed data from the silver layer is loaded into Azure Synapse Analytics, where it can be modeled (e.g., using views) and queried for reporting and analysis by tools like Power BI.

## Data Ingestion (Azure Data Factory)

1.  **Create Linked Services**: In ADF, navigate to the "Manage" tab and then "Linked services".
    *   Create an **HTTP linked service** to connect to your data source (e.g., GitHub) [8, 22]. You'll need the base URL of the API. Authentication type can be Anonymous for public repositories.
    *   Create an **Azure Data Lake Storage Gen2 linked service** to connect to your data lake. You'll need to select your storage account name.
2.  **Create Datasets**: In the "Author" tab, create datasets.
    *   Create an **HTTP dataset** pointing to your source data (e.g., a CSV file on GitHub). Link it to the HTTP linked service and provide the relative URL of the file. Configure the file format (e.g., CSV) and indicate if the first row has a header.
    *   Create an **Azure Data Lake Storage Gen2 dataset** pointing to the bronze layer in your data lake. Link it to the Azure Data Lake Storage Gen2 linked service and specify the container (e.g., `bronze`).
3.  **Create Pipelines**: In the "Author" tab, create pipelines to move data.
    *   Use a **Copy activity** to move data from the HTTP source dataset to the Azure Data Lake Storage Gen2 sink dataset (bronze layer).
    *   The video also demonstrates building **dynamic pipelines** using parameters and loops to handle multiple files.

## Data Transformation (Azure Databricks)

1.  **Access Azure Databricks Workspace**: Launch your Databricks workspace from the Azure portal.
2.  **Create a Cluster**: If you don't have a running cluster, create one. Choose a compute configuration (e.g., Standard_DS3_v2) and configure auto-termination settings to save costs.
3.  **Create a Notebook**: In your workspace, create a new notebook (e.g., "SilverLayer") and attach it to your cluster.
4.  **Configure Data Access**: Use service principal authentication (application registration in Azure AD) to allow Databricks to access Azure Data Lake Storage.
    *   **Register an application** in Azure Active Directory (Microsoft Entra ID).
    *   **Grant the application** "Storage Blob Data Contributor" role on your Azure Data Lake Storage account.
    *   **Create a secret** for the registered application.
    *   Use code in your Databricks notebook to configure Spark to use your application's credentials to access the data lake.
5.  **Read and Transform Data**: Use PySpark (or Scala) code in your notebook to read data from the bronze layer, perform transformations, and write the transformed data to the silver layer in formats like Parquet.

## Data Warehousing (Azure Synapse Analytics)

1.  **Access Azure Synapse Analytics Workspace**: Launch your Synapse workspace from the Azure portal.
2.  **Grant Managed Identity Access**: Allow the Synapse Workspace's managed identity to access your Azure Data Lake Storage account (silver layer) with "Storage Blob Data Contributor" role.
3.  **Create a SQL Database**: In the "Data" hub, create a new serverless SQL database (e.g., `awdatabase`).
4.  **Create External Tables or Views**: In the "Develop" hub, create SQL scripts to define external tables or views over the data in the silver layer of your data lake using `OPENROWSET`. You might need to create a master key and database-scoped credential using the managed identity of the Synapse workspace.
5.  **Load Data to Gold Layer (Optional)**: The video also shows how to use `CETAS` (CREATE EXTERNAL TABLE AS SELECT) to move processed data from external tables to the gold layer in your data lake, potentially in a more structured format.

## Data Visualization (Power BI)

1.  **Install Power BI Desktop**: Download and install Power BI Desktop.
2.  **Connect to Azure Synapse Analytics**: In Power BI Desktop, use the "Get Data" option and select "Azure Synapse Analytics".
3.  **Provide SQL Endpoint**: Enter the serverless SQL endpoint of your Synapse workspace. You can find this in the Azure portal under your Synapse workspace overview.
4.  **Enter Credentials**: Provide the SQL administrator username and password you configured during the Synapse workspace creation.
5.  **Select Tables/Views**: Choose the views or external tables you created in Synapse (representing the gold layer data).
6.  **Build Visualizations**: Create reports and dashboards using the data imported from Synapse.

