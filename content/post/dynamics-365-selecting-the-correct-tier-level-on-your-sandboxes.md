---
author: "ZhaoQiang"
author_link: ""
title: "Dynamics 365 Selecting the Correct Tier Level on Your Sandboxes"
date: 2020-03-18T16:46:16+08:00
lastmod: 2020-03-18T16:46:16+08:00
draft: true
description: ""
show_in_homepage: true
description_as_summary: false
license: ""

tags: ["",
""
]
categories: ["",
""
]

featured_image: ""
featured_image_preview: ""

comment: true
toc: true
auto_collapse_toc: true
math: false
---

[![img](https://kurthatlevik.files.wordpress.com/2019/03/032719_1526_dynamics3654.png?w=538)](https://kurthatlevik.com/2019/03/27/dynamics-365-fo-selecting-the-correct-tier-level-on-your-sandboxes/)

When purchasing Dynamics 365 F&O, you a get of Microsoft managed (but self-service) environments that is included with the standard offer. (Production, Tier-2 Standard Acceptance Testing and a Tier-1 Develop/Build and test environment. Microsoft have described this on the [environment planning](https://docs.microsoft.com/en-us/dynamics365/unified-operations/fin-and-ops/imp-lifecycle/environment-planning) docs. I will not discuss Tier-1 environments here, as these environments is optimized for development experiences. Do not perform performance testing on a tier-1 environment.Tier-2+ environments is based on the same architecture as a production environment and uses the [Azure SQL](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-technical-overview) Database service.

When running an implementation project, it is common to purchase additional tier 2+ environment that is used of different purposes as shown in the table below (from Microsoft Docs)

![img](https://kurthatlevik.files.wordpress.com/2019/03/032719_1526_dynamics3651.png?w=950)

Selecting the correct level is important and is depending on what the environment is going to be used for. As a guidance, Microsoft have the following baseline recommendation:

![img](https://kurthatlevik.files.wordpress.com/2019/03/032719_1526_dynamics3652.png?w=950)

On the projects where I have been involved, we most often have 3 or 4 Tier 2+ environment and the purpose are changed through the project.

![img](https://kurthatlevik.files.wordpress.com/2019/03/032719_1526_dynamics3653.png?w=950)

The flow of data between these environments can be included into a Sprint Cycle. The process will start with defining the general parameters in the golden configuration environment (1). Here all system setup, number sequences, and master data will be uploaded/entered from the legacy systems. The Test/Stage/Migration environment (2) will be created based on the golden environment + transactional data packages/initial startup data. Then there will be a database refresh from Test (2) à UAT (2), where all test scripts will be run and approved. The results and configuration changes/master data are then fed into the golden environment ready for the next data movement cycle. The reason why we do this, is to ensure that the golden environment and the migration environment is not corrupted through testing. At Go Live, and when the UAT is approved (after a few iterations), then the Migration environment will be copied to the production environment. **This can only happen once**. Subsequent updates to the production environment must be done manually or using data packages.

(1)- Tier-2 Golden environment (before PROD have been deployed). This environment is often changed to become staging environment that contains an exact replica of the production environment. I prefer golden environments as a Tier-2, as this simplifies the transfer of data using the LCS self-service database refresh.

(2)- Tier-2 data migration. This environment is used for making transactional data ready for being imported to the production environment at Go-Live.

(3)- Tier-2/3 User acceptance. Here the system is really tested. Lot’s of regression testing and running test scripts. The focus is functionality. If there are concerns on performance, a Tier-5 environment can be purchased for a shorter period to validate that system can handle the full load of a large-scale production environment. For performance testing, it is recommended to also invest in automation of the test script. (Unless you ask the entire organization to participate in a manual test).

The performance of a system is a combination of the raw computing power of the VM’s hosing the AOS, and the sizing of the Azure SQL. With Dynamics 365 we don’t have any way’s of influencing the sizing of this. It is all managed by Microsoft, and they will size the production environment according to number of users and transactions per hour. But the Azure SQL boundaries that Microsoft is most often related to the following sizing steps.

![img](https://kurthatlevik.files.wordpress.com/2019/03/032719_1526_dynamics3654.png?w=950)

I don’t exactly understand how Microsoft is mapping the Tier-2..5 towards these steps, but I have experienced that a Tier-2 level in some cases are a P1, P2, P4 and P6. More information on the DTU capacity can be found [here](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tiers-dtu), and the summary is that we can expect 48 IOPS per DTU. So, a P6 will provide 48000 IOPS. If you want to check your DTP limit, then open SQL manager towards the Azure SQL database, and execute the following script:

SELECT
*
FROM
sys.dm_db_resource_stats ORDER
BY end_time DESC;

And then the DTU limit should be shown here: This is from a Tier-2 environment belonging to the initial subscription, and this seams to have 250 DTU’s(P2)

![img](https://kurthatlevik.files.wordpress.com/2019/03/032719_1526_dynamics3655.png?w=950)

But what puzzles me is if I go into another Tier-2 **add-on** environment I have 500 DTU (P4)

![img](https://kurthatlevik.files.wordpress.com/2019/03/032719_1526_dynamics3656.png?w=950)

And in the third Tier-2 add-on environment I have 1000 DTU (P6)

![img](https://kurthatlevik.files.wordpress.com/2019/03/032719_1526_dynamics3657.png?w=950)

So there seams **not** to be a consistency between the DTU’s provided and the Tier-2 add-on purchased. As far as I know, in this case the production environment is 1000 DTU’s(Or P6) in some of my customers.

The AOS’es on the Tier-2 environment seams to mostly be D12/DS12/DS12_v2 with 4 CPU and 28 Gb RAM and 8x500Gb storage, capable of giving out 12.800 IOPS.

What also puzzles me is the number of Tier-2 AOS’s that is deployed. Some environments have one AOS, and one BI server.

![img](https://kurthatlevik.files.wordpress.com/2019/03/032719_1526_dynamics3658.png?w=950)

While other Tier-2 environments have two AOS’es and one BI server

![img](https://kurthatlevik.files.wordpress.com/2019/03/032719_1526_dynamics3659.png?w=950)

I assume that the differences are related to how the subscription estimator have been filled out, and that this may have an impact on what is deployed as sandbox Tier-2 environments.

![img](https://kurthatlevik.files.wordpress.com/2019/03/032719_1526_dynamics36510.png?w=950)

Dynamics 365 do have some performance indicators under the system administrator menu, that gives some numbers, but I cannot see a clear correlation between the environments and the performance. Maybe some of you smart guys can explain how to interpret these performance test results? What is good, and what is not?

![img](https://kurthatlevik.files.wordpress.com/2019/03/032719_1526_dynamics36511.png?w=950)

If we take the “LargeBufferReads”, how does your environments perform?