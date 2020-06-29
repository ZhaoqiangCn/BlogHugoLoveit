---
author: "hatlevik"
author_link: "https://en.gravatar.com/hatlevik"
title: "Dynamics 365 货运集装箱标签指南"
date: 2020-03-18T16:39:38+08:00
lastmod: 2020-03-18T16:39:38+08:00
draft: false
description: ""
show_in_homepage: true
description_as_summary: false
license: ""

tags: ["Dynamics365"
]
categories: ["Dynamicsax"
]

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

Major retailers have identified incorrect logistic unit (pallet) labeling as a major emerging supply chain issue. A recent sample audit found that approximately 44% of pallet labels are not meeting agreed upon industry requirements. The issues they face include:

- No label has been applied
- Label is in the wrong location
- Information on the label does not match what is on the pallet
- Multiple labels with different Serial Shipping Container Codes (SSCC) been applied
- Pallet label will not scan
- Stretch-wrap has been applied over the pallet label so it doesn’t scan

The following information contains guidelines and general information on how to create and apply good quality logistic (pallet) labels as per the standard requirements of the Retail Industry.

As the Retail Industry adopts the key principles of Efficient Consumer Response (ECR) there is increased demand for high quality data capture at all points in the supply chain. Although the industry has been numbering and bar coding trade items for a number of years, the biggest emerging problem in the supply chain is logistic unit labeling.

With the migration to more and more automated scanning in warehouses and distribution centres, it is imperative that suppliers and their logistics providers ensure 100% scannability of all bar codes which will bring mutual benefits to all trading partners. Printing and applying a good quality bar code label that complies to industry standards and which is scannable by all trading partners’ costs no more than printing and applying a bar code label that doesn’t scan.

This document and its recommendation should be read in conjunction with other GS1 technical guidelines as well as retailer specific documentation all of which can be accessed and downloaded from their respective websites.

## 物流（托盘）标签的重要性

The use of the logistic label incorporating the Serial Shipping Container Code (SSCC) by all parties in the supply chain, from manufacturers to transporters, distributors and retailers, is seen to be inevitable for the identification and tracking of pallets and other forms of logistic units. The purpose of the GS1 logistics label is to uniquely identify specific information about the pallet clearly and concisely in a standard format, to facilitate the process of moving products through the supply chain quickly and efficiently.

Industry Business Benefits of GS1 Logistics LabelLogistics Units are identified with a number that is unique worldwideGS1 standards are global and apply through the entire supply chain, from raw materials supplier to manufacturer to distributor/wholesaler to end user/retailer.Provides a link with bar coded information on a logistics unit and the information that is communicated between trading partners via electronic business transactions.Use to identify contents of pallets, including stock data, use-by-dates etcContributes to efficient management of stock rotation at a glanceSaves costs by doing it onceAvoids multiple label types (industry standard)Faster receiving, quick turnaroundImproves data integrity – use by date and quantity fieldsStock rotation based on use by datePallet tracking from vendor to retailer can assist product recallsWorks in conjunction with a Dispatch Advice – Advanced Shipping Notice (ASN)SSCC can be used for both inter and intra-company transactions.

![image](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365LabelingGuide/2.png)

Fig 1: Example of Numbering & Bar coding Labelling Hierarchy

## 零售业的物流（托盘）标签要求

The GS1 Logistics Label can typically have many different formats. The SSCC is the only mandatory piece of information that must be contained on the label itself as ideally the information flow, which accompanies the physical flow of goods, is communicated between trading partners by EDI.

In practice, however, fully automated communication channels, which make it possible to rely exclusively on electronic files for retrieving information on the movements of goods, are not always available. In this situation there may be a requirement to add additional information to the logistics label to facilitate the process of the logistic units through the supply chain.

The purpose of the GS1 logistics label is to provide information about the unit to which it is fixed, clearly and concisely. The core information on the label should be represented both in machine (bar code) and human readable form. There may be other information, which is represented in human readable form only.

### 有什么问题吗？ –常见陷阱

It is imperative that suppliers and logistics providers ensure 100% scannability of all barcodes. There are many reasons as to why pallet labels may not meet industry requirements. Here are some examples:

- Label position incorrect

- No pallet label applied

- Multiple or mismatching SSCCs on the same pallet

- Duplicated SSCCs

- Damaged label such as creases and folds.

- Will not scan due to incorrect bar code symbology or poor print quality

- Label applied underneath stretch wrap

- Pallet label applied to only one side of the pallet

- Product information applied in the bar code does not match the product on the pallet

- Pallet label bar codes not scanning

- - Ribbon wrinkle with thermal transfer application
  - Print-head element failure leading to a line through a black bar (split bar) within the bar code
  - Poor print quality – faint print due to the label print-head heat being too low or the print speed too high
  - Poor print quality – bleeding print due to the label printer print-head heat being too high with the print speed too low

- Handwritten changes are not reflected in the bar code and are therefore not permitted on pallet labels

- Label applied over carton joins/seams causing tearing

- Label Dimensions

The business requirements for most users of GS1 Logistic Labels are met by using one of following:

- A6 (105 mm x 148 mm) – 4 x 6 inch, which is particularly suitable when only the SSCC, or the SSCC and limited additional data, is encoded
- A5 (148 mm x 210 mm) – 6 x 8 inch

However, the label can be any size that suits the labeller’s requirements, but it must be large enough to carry all the information required together with the GS1-128 bar codes.

Factors influencing label sizes include the amount and a type of data required the content and X-dimensions of the bar code symbols used, and the dimensions of the logistic unit to be labeled.

![image](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365LabelingGuide/3.png)

Example label used for single product parcels and pallets, with GTIN information.

![image](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365LabelingGuide/4.png)

Example label used for parcels and pallets with AI 403 – Routing code without GTIN and product information.

## 物流标签要求



### 标签尺寸

- The minimum label size is A6, 105mm x 148mm, however larger label sizes such as A5 or A4 are permitted

### 标签格式

- The label layout can be either portrait or landscape
- Information contained in the top bar code can be broken down into more multiple bar codes if required, in order to maintain a larger magnification (bar width)

### 标签位置

- Two identical labels, one placed on each fork entry side
- Label should be placed between 50mm – 100mm from the right hand vertical edge
- Label should be placed between 400mm – 800mm from the base of the pallet
- The target placement of the label (top of SSCC bar code) is 600mm from ground level

### 标签数据和应用程序标识符

- · SSCC (Serial Shipping Container Code) – AI (00)

- - It is recommended that additional information not be included in the SSCC (00) bar code unless feasible

- GTIN of the product – AI (02)

- - The data format for AI (02) is that it has to be numeric and 14 digits in length. Note: that if your carton barcode number is 13 digits, you need to include an additional zero at the beginning to increase it to 14 digits

- Quantity of trade units on the pallet – AI (37)

- Date Information YYMMDD – Mandatory if this information is on consumer unit

- - Use By Date – AI (17)
  - Best Before Date – AI (15)
  - Packed on Date – AI (13)

- Batch Number, if on consumer unit – AI (10)

- Total Net Weight (excluding wooden pallet weight – A1 (310n) where n = number of decimal places eg. 3102 = x.xxkg, 3101 = xx.xkg, 3100 = xxxkg



## 系列货运包装箱代码（SSCC）

The Serial Shipping Container Code (SSCC) is a reference number or license plate used to uniquely identify logistic units (pallets). In Dynamics AX the Pallet ID is most used for this.

The SSCC acts as a “reference key” which can be stored in a computer system to which information can be added and shared amongst trading partners as the logistic unit moves throughout the supply chain. This unique “license plate” provides the opportunity to track and trace logistic units in the supply chain.

Scanning the SSCC marked on each logistic unit allows the physical movement of units to be individually tracked and traced by providing an information flow. It also opens up the opportunity to implement a wide range of applications such as cross docking, shipment routing, automated receiving etc.

The SSCC is used to uniquely identify goods on the way from sender to final recipient, and can be used by all participants in the transport and distribution chain.

![image](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365LabelingGuide/5.png)

Figure 3: The Use of the SSCC throughout the supply chain.

### 分配SSCC

The SSCC is a unique, non-significant, eighteen-digit number which is assigned by the company constructing the logistic unit. It remains the same for the life of the logistic unit. The SSCC is encoded in a GS1-128 Bar Code and is represented by the Application Identifier (AI) 00.

When assigning an SSCC, an individual SSCC must not be reallocated within one year of the shipment date from the SSCC assignor to a trading partner.

How you allocate an SSCC depends on the length of your assigned GS1 Company Prefix. Your company cab ne allocated a seven- to nine-digit GS1 Company Prefix.

![image](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365LabelingGuide/6.png)

| Application Identifier (00) | Used in the GS1-128 Bar Code to identify that the data following is an eighteen-digit Serial Shipping Container Code (SSCC) |
| --------------------------- | ------------------------------------------------------------ |
| Extension Digit             | A digit (0-9) used to increase the capacity of the Serial Reference within the SSCC. The company that constructs the SSCC assigns the Extension digit to the logistic unit. |
| GS1 Company Prefix:         | The GS1 Company Prefix is allocated by GS1 Member Organisations. GS1 allocates nine- or seven-digit GS1 Company Prefixes. It makes the SSCC unique worldwide but does not identify the country of origin of the unit. |
| Serial Reference:           | A Serial Reference usually comprises seven digits (nine digits if the GS1 Company Prefix is seven digits) and uniquely identifies each transport package or logistic unit. The method used to allocate a Serial Reference is at the discretion of the company coding the package. In Dynamics AX this can be the number sequence of a WMS pallet |
| Check Digit:                | Calculated using a mathematical formula.                     |

## 包裹上的物流标签位置

For parcels, symbol placement will vary slightly in practice; however the target placement for the bottom of the bar code symbol is 32 mm (1.25 inches) from the natural base of the item. The symbol including, its quiet zones, should be at least 19 mm (0.75 inches) from any vertical edge to avoid damage.

For smaller packages, which may be sorted automatically on a conveyor, the label should be placed on the largest surface.

![image](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365LabelingGuide/7.png)



## 托盘上的物流标签位置

Industry Requirements is a GS1 Logistics Label to be placed on each fork entry side.

![image](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365LabelingGuide/8.png)

If the pallet height does not permit the pallet labels to be at least 400mm from the ground, then the pallet labels should be placed as high as possible on the right hand side on each of the fork entry sides of the pallet.

If the pallet needs to be stretch wrapped for stability, the pallet labels must be applied to the **outside** of the stretch wrap as shown above in order to achieve optimum scan rates.

Where there is only one layer high of the trade unit on a pallet and the trade unit height is less than the height of the pallet labels. Please ensure that the bar codes of the labels are on the vertical face of the trade unit with the human readable portion of the labels folded over onto the horizontal surface of the trade unit as shown below.

### 典型的零售商收货流程

- On arrival, a receiving checker will key the purchase order number or appointment number (for a multiple PO truck) into the PDA/Radio Frequency (RF) receiving unit.
- The receiver will then proceed to the first pallet on the truck and scan all of the bar codes on the pallet label.
- The RF scanner will send the information back to the WMS that will verify the quantities on that pallet against the order quantity on the PO. The WMS also verifies the pallet information is correct and checks that the date code on the item is suitable against the minimum and maximum dates set in the WMS.
- If the pallet is accepted then the receiver moves along to the next pallet and repeats the process. If the pallet is not accepted the checker will conduct an investigation to identify the issue and will re label with a generic label if required.
- Once all pallets are received, the checker will confirm the total quantity against the invoiced quantity and then close the load ready for the pallets to be put away by forklifts using RF scanners. The WMS determines the final location in the warehouse during the receival process.

### 典型的B2B ASN收货流程

- On delivery into any receiving location, a receive checker will count the logistics units, (eg: number of pallets) and compare them to the driver’s consignment note and stamp the document accordingly. This is the initial proof of delivery.
- The merchandise is then electronically scan receipted once it arrives at receiving locations. The Advanced Shipping Notice (ASN) must have been transmitted to the receiving company before the goods arrive in order for it to be validated (and rectified if necessary).
- Receiving staff will validate that all SSCCs*,* as noted in the ASN*,* are physically received by scanning each Logistics label at the receiving dock.
- When all SSCCs are accounted for, this will trigger the internal processing to update the stock and PO records and provides information to payment systems.
- Logistic unit contents will be checked to ensure contents exactly match ASN details.

## 制造商/供应商注意事项

### 托盘标签质量标准

Controlling label quality variation requires an integrated quality process incorporating people, processes, procedures and equipment.

Typically there are two options for the application of the pallet label:

- At the point of manufacture, or
- At the point of dispatch

The decision on when to apply the pallet label is dependent on individual organizations practices, including manufacturing, warehousing, order assembly or third party service providers.

The SSCC label standards should be incorporated into internal standards and available (electronically) to all factories and warehouses. The same standards are communicated to third party providers both at contract time and by the use of training packages, if necessary. Visual aids are encouraged in factories, warehouses etc to impart SSCC label standards, especially positioning of the labels.

With many automated and manual labeling systems check scanning controls can be purchased as part of the system, providing a level of automated bar code quality checking and control. These systems incorporate a check scanner at the front of the label printer so that as each label is printed the bar code is scanned to check quality. If a fail to read occurs the printer can print void on the erroneous label and re-print. After multiple failures i.e. 2 or 3, the unit will stop and raise an alarm.

#### 注意事项

- Automate the data sources to simplify printing and reduce the need for data entry.

- Label design tested and sent to GS1 testing service for its verification report

- Document processes

- Train staff to visually

- - check the pallet label and position applied
  - scan label barcodes to ensure readability

**Incorporate checks for**Correct Bar code symbology (GS1-128)Label placementLabel verificationLabel Defects

#### 视觉清单

Does the data encoded in the pallet label bar codes match the product on the pallet eg

- GTIN
- Batch number (if applicable)
- Quantity
- Date code information, eg. best before or use by date

The pallet labels applied to the pallet must contain the same SSCC. Pallet labels should not be placed over two separate cartons. Pallet labels should be placed on the outside of the stretch-wrap. Determine if any white lines running vertically through the black lines of the bar code that may hinder the bar code from scanning are evident.

#### 审核

It is recommended to perform a compliance audit of the labels coming from each factory, warehouse and third party provider every quarter. Results should be reported back as percentage compliance and the issues found highlighted, together with photos, if necessary.

#### 培训

It is imperative that anyone that is required to print or apply pallet labels understand

the industry requirements. Training and documentation is widely available.

#### KPI的使用

Establish performance metrics as part of the pallet quality checking procedures. This could be plotted graphically by warehouse upon feedback from trading partners.

The data should be circulated to all factories and warehouses including third party logistics providers, each week with any relevant comments. Provide all of the raw data obtained to help find solutions to particular issues. Include the overall trend of performance for the last twelve months

Communicate progress to factory and warehouse managers at regular operations meetings to ensure the focus is maintained on the importance of achieving this and other key supply chain standards.

#### 第三方（3PL）物流服务供应商

- What role/service are they providing
- Are they applying labels
- Have you incorporated them into your logistic unit labeling requirements
- What label application and quality control process do they have in place
- Are they scanning any part of the label prior to dispatching goods
- What is their label printer cleaning and maintenance process