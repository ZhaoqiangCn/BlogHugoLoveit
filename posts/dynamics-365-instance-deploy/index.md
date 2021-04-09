# How to deploy instance in Dynamics 365


<!--more-->

## Setup Virtual Hard Disk package of Dynamics 365 for Operations

### Below are some of the _pre-requisites_ to be considered

* Access to a [Microsoft Dynamics Lifecycle Services \(LCS\)](https://lcs.dynamics.com/) and required license to access shared asset library data
* Virtualization technology enabled computers \(PC or Laptop\).
* Minimum 16 GB memory system.

### Below are the **steps to** download _‘Dynamics 365 for Operations’_ package

1. Login to [Microsoft Dynamics Lifecycle Services \(LCS\)](https://lcs.dynamics.com/)
2. On the right side of the portal, click on ‘Shared asset library’ tile but please note that partner license is required to access the resources in Shared asset library.
3. In the asset library, click on ‘Downloadable VHD’
4. All the VHD’s are directly available for download
5. Each file needs to be downloaded individually by clicking on ‘Name’ hyperlink
6. Double click on the **exe** file\(Usually part 1\)
7. Accept the Microsoft Software License Terms for a Virtual Hard Disk image
8. Select the destination folder where the Virtual Hard Disk will be placed and click on Extract

![01-VM Downloal v2.0](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/01-vm-downloal-v2.0.png)

![02-VM Downloal v2.0](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/02-vm-downloal-v2.0.png)

![03-VM Downloal v2.0.png to be used](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/03-vm-downloal-v2.0.png-to-be-used.png)

_Note: Once the extraction process is complete, the Virtual Hard Disk created in the destination folder._

### Setup Virtual machine using Microsoft Hyper-V Manager

It is recommended from Microsoft to give 16 gigabytes \(GB\) of memory and two virtual processors to VM, however with my experience 12 GB memory is fine. But don’t use dynamic memory allocation.

If you don’t have Microsoft Hyper-V Manager, please follow the instruction below to install

#### **Installation of Hyper-V in Windows Server 2012 or Windows server 2012 R2 by using PowerShell**

1. Click the Windows Start button and type **PowerShell**. Right-click PowerShell and click Run as Administrator.
2. Run the following command where _computer\_name_represents a remote computer on which you want to install Hyper-V. To install Hyper-V directly from a console session, do not include -ComputerName  in the command.

**Install-WindowsFeature –Name Hyper-V -ComputerName -IncludeManagementTools -Restart**

* Click [here](https://technet.microsoft.com/en-us/library/hh846766%28v=ws.11%29.aspx#BKMK_SERVER) for more information to enable Hyper-V role in Windows Server 2012 or Windows server 2012 R2

#### **Install the Hyper-V role on Windows 8 or Windows 8.1, Windows 10.0**

1. Click the Windows Start button and type PowerShell. Right-click PowerShell and Run as Administrator.
2. Run the following command.
3. When the installation is finished, reboot the computer.

**Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V –All**

* Click [here](https://technet.microsoft.com/en-us/library/hh846766%28v=ws.11%29.aspx#BKMK_CLIENT) for more information to enable Hyper-V role in Windows Server 2012 or Windows server 2012 R2
* Once we have the Hyper V-Manager ready, create Virtual switch for the network connection inside the VM

#### Create Virtual Switch:

1. Open Hyper-V Manager.
2. From the navigation pane of Hyper-V Manager, select the computer running Hyper-V.
3. From the Actions pane, click on Virtual Switch Manager
4. Select the External virtual switch, click on _‘Create Virtual Switch’_
5. Upon clicking the _‘Create Virtual Switch’,_ Enter name: _VIR\_SWITCH \(For this article\)_
6. _Select the External network Realtek PCIe GBE Family Controller_
7. _Mark ‘**Allow management operation system to share this network adapter’**_
8. Click on Apply and Ok

![10\_LCS\_Cloud\_Tool\_Locally\_Environment\_Virtual\_Switch](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/10_lcs_cloud_tool_locally_environment_virtual_switch.png)

![11\_LCS\_Cloud\_Tool\_Locally\_Environment\_Virtual\_Switch\_2](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/11_lcs_cloud_tool_locally_environment_virtual_switch_2.png)

Note: This is important step to access Dynamics 365 for Operations instance.

#### Create Virtual Machine:

1. Open Hyper-V Manager.
2. From the navigation pane of Hyper-V Manager, select the computer running Hyper-V.
3. From the Actions pane, click **New** &gt; **Virtual Machine**.
4. Click **Next** in the New Virtual Machine wizard.
5. On the Specify Name and Location page, type an appropriate name **‘D365TrainingMC’** \(Example for this article\), Click on Next
6. On the Specify Generation page, Choose Generation 1, Click on Next
7. On the Assign Memory page, specify memory between 12,288 – 16,384 MB
8. On the **Configure Networking** page, connect the virtual machine to the switch _**‘VIR\_SWITCH’**_ you created when you installed Hyper-V.
9. On the **Connect Virtual Hard Disk,** choose **Use an existing virtual hard disk and** select the VHD location
10. On the Summary page, verify your selections and then click **Finish**.

![12\_LCS\_Cloud\_Tool\_Locally\_Environment\_VM\_Wizard\_Name](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/12_lcs_cloud_tool_locally_environment_vm_wizard_name.png)

![13\_LCS\_Cloud\_Tool\_Locally\_Environment\_VM\_Wizard\_VHD](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/13_lcs_cloud_tool_locally_environment_vm_wizard_vhd.png)

![14\_LCS\_Cloud\_Tool\_Locally\_Environment\_VM\_Wizard\_Summary](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/14_lcs_cloud_tool_locally_environment_vm_wizard_summary2.png)

### Connecting to Virtual machine using Microsoft Hyper-V Manager

Before even connecting to virtual machine, make sure virtualization support is turned on in the BIOS settings of your computer or laptop. This setup varies from different computer\laptop brands.

Just do google search to enable virtualization support in your computer, for example if you are using HP laptop use keywords _‘Enable virtualization in HP laptop’_

Once the virtualization support is turned on in the BIOS settings successfully,

1. Open Hyper-V manager
2. Select _‘D365TrainingMC’_ VM just created, Right click and Start
3. Once VM is started and click on connect
4. Go to Action, Click the Ctrl+Alt+Delete button on the toolbar
5. Sign in to the VM by using the following credentials:
   * **User name: Administrator**
   * **Password: pass@word1**

![15\_LCS\_Cloud\_Tool\_Locally\_Environment\_VM\_Connect](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/15_lcs_cloud_tool_locally_environment_vm_connect.png)

![16\_LCS\_Cloud\_Tool\_Locally\_Environment\_VM\_Login](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/16_lcs_cloud_tool_locally_environment_vm_login.png)

![16.1\_LCS\_Cloud\_Tool\_Locally\_Environment\_VM\_Login](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/16-1_lcs_cloud_tool_locally_environment_vm_login.png)

### Access Dynamics 365 instance using base URL of the local application

#### **Provision the administrator user.**

Before accessing you must authenticate your credentials as administrator for the instance, please follow the steps below,

1. From the desktop, run the admin user provisioning tool as an administrator \(right-click the icon, and then click Run as administrator\).
2. Enter your email address \(Make sure it is Office365 ID or Azure AD credentials\), and then click Submit.

![17\_LCS\_Cloud\_Tool\_Locally\_Environment\_VM\_Provision\_User](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/17_lcs_cloud_tool_locally_environment_vm_provision_user.png)

#### _Access the instance using the URL of the local application_

The user authenticated in the above step can access the instance on the computer by navigating to the base URL: [https://usnconeboxax1aos.cloud.onebox.dynamics.com](https://usnconeboxax1aos.cloud.onebox.dynamics.com/).

1. Open internet explorer
2. Click on the link above
3. Enter your credentials authenticated in the step above
4. Now it’s all set to access ‘**Dynamics 365 for Operation’** instance

![18\_LCS\_Cloud\_Tool\_Locally\_Environment\_VM\_User\_credentials](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/18_lcs_cloud_tool_locally_environment_vm_user_credentials.png)

![19\_LCS\_Cloud\_Tool\_Locally\_Environment\_VM\_D365\_Ready](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/19_lcs_cloud_tool_locally_environment_vm_d365_ready.png)

### References:

| **TOPICS**                                             | **SOURCES**                                                  |
| :----------------------------------------------------- | :----------------------------------------------------------- |
| Access Microsoft Dynamics 365 for Operations instances | [https://ax.help.dynamics.com/en/wiki/access-microsoft-dynamics-ax-7-instances-2/](https://ax.help.dynamics.com/en/wiki/access-microsoft-dynamics-ax-7-instances-2/) |
| Installation of Hyper-V and creating virtual machine   | [https://technet.microsoft.com/enus/library/hh846766\(v=ws.11\)](https://technet.microsoft.com/enus/library/hh846766%28v=ws.11%29).aspx |
