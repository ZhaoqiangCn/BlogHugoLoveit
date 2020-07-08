---
title: "Dynamics AX GoLive Data Initialize"
date: 2020-01-02T10:19:24+08:00
description: "DynamicsAX项目上线期初数据的初始化"
draft: false
tags: [Ax2009,Data,Golive]
categories: [Dynamicsax]
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
## 静态数据

静态数据主要包括系统参数，仓库站点，物料编号等等等数据对应上面1-88行，期初由用户一一按照格式整理后由我们导入AX中。

## 动态数据

动态数据主要包括未结销售订单，未结采购订单，期初余额的数据对应上面201-213行，期初由用户一一按照格式整理后由我们导入AX中。

### 01-Open SO

这里是[未结销售订单导入模板](https://pan.nashome.cn/s/mwos8gMqdNMw2d5) ,这部分销售订单数据需要通过开发功能导入系统，请参考此文：[销售订单导入功能]()。 

### 02-Open PO

这里是[未结采购订单导入模板](https://pan.nashome.cn/s/RRo8Z5yTPMJk4Mf) ,这部分采购订单数据需要通过开发功能导入系统，请参考此文：[采购订单导入功能]()。 

### 03-Opening Balance
- 这里是[期初余额导入模板-总账](https://pan.nashome.cn/s/GQf9PyKQPG86MQW) 
- 这里是[期初余额导入模板-应收](https://pan.nashome.cn/s/JAcFm7apo3QjZCR) 
- 这里是[期初余额导入模板-应付](https://pan.nashome.cn/s/iFLJLjrwEkCoWck) 
- 这里是[期初余额导入模板-固定资产](https://pan.nashome.cn/s/Gy4koJCkgFaPm3N) 
- 这里是[期初余额导入模板-其他应收](https://pan.nashome.cn/s/eR4bXmzgYyAAgNC) 
- 这里是[期初余额导入模板-库存01](https://pan.nashome.cn/s/JjHFZcRPZfecjkf) 
- 这里是[期初余额导入模板-库存02](https://pan.nashome.cn/s/e7jY8rBJQJexHRy) 

这部分数据需要通过开发功能导入系统，请参考此文：[Dynamics AX GoLive Data Import]({{< ref "Dynamics-AX-GoLive-Data-Import.md" >}})。 

## 所有期初数据

这里是我整理的一份[期初数据模板](https://pan.nashome.cn/s/oK4d8BBDcg3W8op) ，下表罗列了模板中的部分页签的内容。


|      | Go live check list                                  |                   |             |
| ---- | --------------------------------------------------- | ----------------- | ----------- |
|      | Date used in this Sheet based on China  Time zone   |                   |             |
|      | Task                                                | Type              | Module      |
| 1    | Validate Inventory Module  Parameter                | Parameter         | Inventory   |
| 2    | Validate Production Module  Parameter               | Parameter         | Production  |
| 3    | Validate Master Plan Module  Parameter              | Parameter         | Master Plan |
| 4    | Validate Master Plan Setup                          | Setup             | Master Plan |
| 5    | Validate Sales Module Parameter                     | Parameter         | Sales       |
| 6    | Validate Purchase Module Parameter                  | Parameter         | Purchase    |
| 7    | Validate Accounts Receivable  Module Parameter      | Parameter         | AR          |
| 8    | Validate Accounts Payable Module  Parameter         | Parameter         | AP          |
| 9    | Validate General Ledger Module  Parameter           | Parameter         | GL          |
| 10   | Validate Fixed Assets Module  Parameter             | Parameter         | FA          |
| 11   | Validate Organization Module Setup                  | Parameter         | System      |
| 12   | Validate System Administration  Setup               | Parameter         | System      |
| 13   | Validate Number sequence for  Inventory Module      | Parameter         | System      |
| 14   | Validate Number sequence for  Production Module     | Parameter         | System      |
| 15   | Validate Number sequence for  General Journal       | Parameter         | System      |
| 16   | Validate Number sequence for  Accounts Receivable   | Parameter         | System      |
| 17   | Validate Number sequence for  Accounts Payable      | Parameter         | System      |
| 18   | Validate Number sequence for Fixed  Assets          | Parameter         | System      |
| 19   | Validate Number sequence for Sales  Order Module    | Parameter         | System      |
| 20   | Validate Number sequence for  Purchase Order Module | Parameter         | System      |
| 21   | Validate User Permission Setup                      | Parameter         | System      |
| 22   | Units                                               | Setup             | Inventory   |
| 23   | Unit Convert                                        | Setup             | Inventory   |
| 24   | Site                                                | Setup             | Inventory   |
| 25   | Warehouse                                           | Setup             | Inventory   |
| 26   | Locations                                           | Setup             | Inventory   |
| 27   | Item Group                                          | Setup             | Finance     |
| 28   | Inventory Model Group                               | Setup             | Inventory   |
| 29   | Dimension Group                                     | Setup             | Inventory   |
| 30   | Cost group                                          | Setup             | Costing     |
| 31   | Calculation group                                   | Setup             | Costing     |
| 32   | Counting Group                                      | Setup             | Inventory   |
| 33   | Intercompany Setup                                  | Setup             | Inventory   |
| 34   | Validate Item Master                                | Master Data       | Engerring   |
| 35   | Validate BOM                                        | Master Data       | Engerring   |
| 36   | Validate Routes                                     | Master Data       | Engerring   |
| 37   | Validate Operations                                 | Master Data       | Engerring   |
| 38   | Inventory Journal Name                              | Setup             | Inventory   |
| 39   | Working Time Template                               | Setup             | Production  |
| 40   | Working Calendar                                    | Setup             | Production  |
| 41   | Production Pool                                     | Setup             | Production  |
| 42   | Coverage Group                                      | Setup             | Master Plan |
| 43   | Cost Catergory                                      | Setup             | Costing     |
| 44   | Resource Group                                      | Setup             | Production  |
| 45   | Resources                                           | Setup             | Production  |
| 46   | Chart of Accounts                                   | Master Data       | GL          |
| 47   | Finance Dimensions                                  | Master Data       | GL          |
| 48   | Currency and Rates                                  | Setup             | GL          |
| 49   | Financial Report Setup                              | Setup             | GL          |
| 50   | Sales Tax Group                                     | Setup             | GL          |
| 51   | Item sales tax group                                | Setup             | GL          |
| 52   | Sales tax codes                                     | Setup             | GL          |
| 53   | Fixed assets cards                                  | Master Data       | FA          |
| 54   | Fixed assets group                                  | Setup             | FA          |
| 55   | Fixed assets value model                            | Setup             | FA          |
| 56   | Fixed assets posting profile                        | Setup             | FA          |
| 57   | Fixed assets depreciation profile                   | Setup             | FA          |
| 58   | Finance Calendar                                    | Setup             | GL          |
| 59   | Generla Ledger Journal Names                        | Setup             | GL          |
| 60   | General Ledger - System accounts                    | Setup             | GL          |
| 61   | Bank Group                                          | Setup             | Bank        |
| 62   | Bank Accounts                                       | Setup             | Bank        |
| 63   | Employees                                           | Setup             | System      |
| 64   | Customer Group                                      | Setup             | AR          |
| 65   | Customer Master                                     | Master Data       | Sales       |
| 66   | Accounts Receivable Posting  profile                | Setup             | AR          |
| 67   | Accounts Receivable Misc Charge                     | Setup             | AR          |
| 68   | Payment Term                                        | Setup             | AR          |
| 69   | Method of payment                                   | Setup             | AR          |
| 70   | Vendor Group                                        | Setup             | AP          |
| 71   | Vendor Master                                       | Master Data       | Purchase    |
| 72   | Accounts Payable Posting profile                    | Setup             | AP          |
| 73   | Accounts Payeble Misc Charge                        | Setup             | AP          |
| 74   | Inventory Posting(Item & Item  Group)               | Setup             | Inventory   |
| 75   | Accounts setup for Inventory  Journal               | Setup             | Inventory   |
| 76   | Accounts setup for cost categories                  | Setup             | Inventory   |
| 77   | Sales Forecast                                      | Setup             | Master Plan |
| 78   | Sales trade agreement                               | Setup             | Sales       |
| 79   | Purchase trade agreement                            | Setup             | Purchase    |
| 80   | Mode of delivery                                    | Setup             | Sales       |
| 81   | Delivery term                                       | Setup             | Sales       |
| 82   | address book                                        | Setup             |             |
| 83   | Contact                                             | Setup             | Sales       |
| 84   | Shipping instruction                                | Setup             | Sales       |
| 85   | Billing instruction                                 | Setup             | Sales       |
| 86   | CustExternalItem                                    | Setup             | Sales       |
| 87   | Item (defaul warehouse)                             | Setup             | Inventory   |
| 88   | Order pool                                          | Setup             | Sales       |
|      |                                                     |                   |             |
| 201  | Prepare for Open Sales Orders                       | Open orders       | Sales       |
| 202  | Enter Open Sales Orders                             | Open orders       | Sales       |
| 203  | Prepare for Open Purchases Orders                   | Open orders       | Purchase    |
| 204  | Enter Open Purchase Orders                          | Open orders       | Purchase    |
| 205  | Prepare for Opening Inventory                       | Opening inventory | Inventory   |
| 206  | Enter opening Inventory                             | Opening inventory | Inventory   |
| 207  | Prepare for AR Open invoice list                    | Finance Open      | AR          |
| 208  | Enter AR Open invoice list                          | Finance Open      | AR          |
| 209  | Prepare for AP Open invoice list                    | Finance Open      | AP          |
| 210  | Enter AP Open invoice list                          | Finance Open      | AP          |
| 211  | Prepare for Fixed Asset Opening                     | Finance Open      | FA          |
| 212  | Enter Fixed Asset Opening                           | Finance Open      | FA          |
| 213  | Trail Balance                                       | Finance Open      | GL          |
