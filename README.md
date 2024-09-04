# Terraform Modules for Azure

Welcome to the repository of Terraform modules for Azure! These modules are designed to help you easily deploy and customize Azure resources with Terraform. They are built with flexibility and ease of use in mind, making it simple to get started with Azure infrastructure as code.

## Overview

Deploying infrastructure on Azure can be complex and time-consuming, especially when dealing with individual service configurations. To streamline this process, I've created Terraform modules specifically for Azure. These modules are designed to be easily deployable and customizable, enabling users to tailor them to their specific requirements.

As of now, I have uploaded the Terraform Azure Storage Account module and its dependent Azure Private Endpoint module. These modules aim to reduce the complexity associated with setting up Azure services, allowing you to focus on your core application development and infrastructure needs.

## Available Modules

### 1. Azure Storage Account Module

This module helps you deploy an Azure Storage Account with all the necessary configurations. It includes attributes and parameters that allow you to customize the deployment to meet your specific needs.

#### Features:
- **Account Tier**: Select between `Standard` and `Premium` tiers.
- **Replication**: Choose the replication strategy (`LRS`, `GRS`, `RA-GRS`, etc.).
- **Network Rules**: Configure network access rules for secure access.
- **Tags**: Apply tags for better resource management.


### 2. Azure Private Endpoint Module

This module allows you to create a private endpoint for your Azure resources, enhancing security by restricting public access and routing traffic through a private network.

#### Features:
- **Private Link Service**: Secure your connection between your virtual network and Azure services.
- **Subnet Association**: Associate the private endpoint with a specific subnet.
- **DNS Integration**: Seamless DNS configuration within your private network.

## Getting Started

1. **Clone the Repository**: 
   ```bash
   git clone https://github.com/your-repo/terraform-azure-modules.git

## Navigate to the Module

Navigate to the specific module directory within the repository to access the Terraform configuration files.

## Customize and Deploy

Modify the `variables.tf` file to match your requirements, and then deploy the module using Terraform. Adjust the variable values to align with your specific infrastructure needs before running the Terraform commands.

## Contribution

Contributions are welcome! If you have suggestions for improvements or new modules, feel free to open an issue or submit a pull request.
