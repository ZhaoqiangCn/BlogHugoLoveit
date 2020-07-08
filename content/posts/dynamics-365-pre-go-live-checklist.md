---
author: "ZhaoQiang"
author_link: ""
title: "Dynamics 365 Pre Go Live Checklist"
date: 2020-03-18T17:03:19+08:00
lastmod: 2020-03-18T17:03:19+08:00
draft: false
description: ""
show_in_homepage: true
description_as_summary: false
license: ""

tags: ["Dynamics365"]
categories: ["Dynamicsax"]

featured_image: ""
featured_image_preview: ""

toc:
  enable: true
  auto: false
code:
  copy: true
math:
  enable: true
mapbox:
  accessToken: ""
share:
  enable: true
comment:
  enable: true
---

#### Pre Go-live Health Check list:

1. **Solution acceptance by users: UAT**
   1. Is UAT completed successfully? How many users participated in UAT?
   2. Did UAT test cases cover entire scope of requirements planned for go-live?
   3. How many bugs/issues from UAT are still open?
   4. Any of the open bugs/issues a showstopper for go-live?
   5. Was UAT done using migrated data?
2. **Business signoff:**
   1. Business has signed off after UAT that the solution meets business needs?
   2. Solution adheres to any company/industry specific compliance (where necessary)
   3. Training is complete
   4. All features going live are documented, approved and signed off by customer
3. **Performance:**
   1. How was the performance in UAT? Is it acceptable for go-live?
   2. If Performance testing was done, then are there any open actions from it?
4. **User & Security setup:**
   1. How many security roles are being used. All security roles are setup and tested?
   2. Users that will need access at go-live have been setup with correct security role?
5. **Data Migration:**
   1. Data migration status – Masters & Open Transactions/Balances
   2. Business has identified owners for data validation?
   3. Review cut-over plan: Business & Partner teams are comfortable with the plan?
   4. Does the Data migration performance fits within cut-over window?
6. **Configuration Management:**
   1. Are the configurations updated in Golden Configuration environment based on changes in UAT?
   2. Data stewards/owners identified and process in place for post go-live changes in Master/Configuration data?
   3. All Legal Entities configured for Go-Live?
   4. Are configurations documented?
7. **Integrations:**
   1. Review list of integrations and readiness plan for each
   2. Latency requirements and performance criteria are met
   3. Integration support is in place with named contacts/owners
8. **Code Management**
   1. Production fixes/maintenance process defined?
   2. Code promotion (between environments) process is in place, documented and the entire team knows and understands the process
   3. Code promotion schedule for production is in place?
   4. Emergency process for code promotion to production is defined?
9. **Monitoring and Microsoft Support**
   1. LCS diagnostics setup and knowledge transfer to customer
   2. Issue resolution and Escalation process defined – LCS support is verified?