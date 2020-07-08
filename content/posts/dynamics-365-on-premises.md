---
title: "Dynamics 365 On-premises Environments"
date: 2020-01-15T14:24:30+08:00
description: ""
draft: false
tags: ["Dynamics365"]
categories: ["Dynamicsax"]
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
<!--more-->

## Environments\系统环境

微软提供了四种类型的环境，下面会讲到如何部署他们。

### Demo environment\演示环境

无论是本地部署还是云端部署都可以选择 Demo环境，第一次接触dynamics365之前可以先部署一个demo环境来熟悉Dynamics365的业务功能和开发功能。		
详细信息可以参考： [Sign up for preview subscriptions](https://docs.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/dev-tools/sign-up-preview-subscription).

### Developer environment\开发环境

对于开发者来说，在云端开发和在本地开发的体验式一样的。		
详细信息可以参考： [Deploy and access development environments](https://docs.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/dev-tools/access-instances).

### Sandbox environment\沙盒环境

业务用户和开发团队可以通过沙盒环境来验证一些应用程序功能。比如一些从AX2012移植过来的功能。		
详细信息可以参考： [Set up and deploy on-premises environments home page](https://docs.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/deployment/setup-deploy-on-premises-environments).

沙盒环境的最小硬件要求：

- 3 machines running Environment Orchestrator
- 2 machines running Application Object Servers (AOS)
- 1 machine running Management Reporter (MR)
- 1 machine running SQL Server Reporting Services (SSRS)
- 1 machine running Active Directory
- 1 machine running SQL Server

### Production environment\生产环境
详细信息可以参考： [Set up and deploy on-premises environments home page](https://docs.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/deployment/setup-deploy-on-premises-environments).

生产环境的最小硬件要求：

- 3 machines running Environment Orchestrator
- 3 machines running Application Object Servers (AOS)
- 1 machine running Management Reporter (MR)
- 1 machine running SQL Server Reporting Services (SSRS)
- 2 or more machines running SQL Server
- 2 or more machines running Active Directory