---
title: "Dynamics AX 中的生产工单的每个状态究竟有什么不同"
subtitle: ""
date: 2020-07-29T16:02:26+08:00
lastmod: 2020-07-29T16:02:26+08:00
draft: true
author: ""
authorLink: ""
description: ""

tags: []
categories: []

hiddenFromHomePage: false
hiddenFromSearch: false

featuredImage: ""
featuredImagePreview: ""

toc:
  enable: true
math:
  enable: false
lightgallery: false
license: ""
---

<!--more-->

# Production order statuses in Dynamics AX

[September 30, 2016](https://timsaxblog.wordpress.com/2016/09/30/production-order-statuses-in-dynamics-ax/) [timschofieldaxblog](https://timsaxblog.wordpress.com/author/timschofieldaxblog/) [AX2009](https://timsaxblog.wordpress.com/category/ax2009/), [AX2012](https://timsaxblog.wordpress.com/category/ax2012/), [AX7](https://timsaxblog.wordpress.com/category/ax7/), [D365O](https://timsaxblog.wordpress.com/category/d365o/), [Dynamics 365 for Operations](https://timsaxblog.wordpress.com/category/dynamics-365-for-operations/)[Production](https://timsaxblog.wordpress.com/tag/production/), [Production order scheduling](https://timsaxblog.wordpress.com/tag/production-order-scheduling/)

I don’t usually use flow charts in my workshops – but I make an exception whenever we’re talking about processing production orders – because the production order has so many statuses and we need to define how a production order will be processed for each company (and sometimes for each separate production unit). That is, we need to define which statuses will be used and what they all mean.

I almost entitled this post “Why you should set production orders to ‘Reported as finished’ but realised that there are more statuses that you should use, and some you shouldn’t.

So here goes.

First, the flow chart. This is ***an example\*** of a production order flow where we are back-flushing component/ingredient consumption and there’s no route operation hours or costs. I’m emphasising **example** because you have to analyse your own situation and develop your own production order process.

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/092716_2247_productiono1.png)

OK – so we’ve got that out of the way, now let’s walk through the various statuses that we’re using (or not).

| **Status**               | **Description**                                              |
| ------------------------ | ------------------------------------------------------------ |
| **Created**              | You’ll normally only see this status when you create a production order manually – although you can setup master planning to create ‘Created’ production orders when you firm a planned order.The Item BOM has been copied to the production BOM. The production BOM can be deleted and re-copiedThe Item route has been copied to the production Route. The production Route can be deleted and re-copiedThe production order can be deleted**Master planning processes the production order (parent) item only. ****There are no demands on components ****There are no capacity reservations** |
| **Estimated**            | Phantoms have been exploded. (The Bill of material items and route operations from the phantom are copied into the production order BOM and Route, and the phantom item is deleted from the production BOM).Planned inventory transactions have been created for the production BOM component items. Component items are scheduled for the delivery date of the production order (i.e. no production order lead time).Sub-contract purchase orders (and Sub-production orders) have been created.The production order price calculation is created.You don’t normally see this status, because normally you’d just Schedule the order. |
| **Scheduled**            | Capacity is reservedComponents are scheduled according to beginning (or end) of their ‘deliver to’ operation |
| **Released**             | Shop floor documents are printed                             |
| **Started**              | Material can be issued, hours recorded, and production reported as finished |
|                          | <Issue materials> <Record hours> <Report as finished>        |
| **Reported as finished** | All outstanding inventory transactions (issues and receipts) are deleted.Outstanding capacity reservations are deleted |
| **Ended**                | Physical inventory accounting postings are reversed.Financial inventory postings are created.No further transactions can be posted.The production order can be deleted. |

So Some rules:

1. **You should never have ‘Created’ production orders.** Master planning processes the ‘supply’ side of a ‘Created’ production order, but there are no derived requirements or capacity reservations. If you create a production order, schedule it immediately – no exceptions.
2. **You don’t need to Estimate production orders.** If you schedule a ‘Created’ production order, Estimation is performed for you automatically. The exception to this rule is the next rule. A scheduled production order is more use than an estimated one – so schedule, don’t estimate.
3. **If you change the production order quantity or BOM lines quantity you must re-estimate the production order.** If you change the production order quantity a form pops up prompting you to re-estimate the order:
   ![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/092716_2247_productiono2.png)
   If you don’t re-estimate and reschedule, the BOM line components are still calling for their original quantities. This means that either you will order too much of your component (or, as happened to us last week) you will run out half-way through your production order, because someone increased the quantity on the production order but didn’t re-estimate.**
   **
4. You don’t need to Release production orders – so this is an optional step, but sometimes it’s used by planners to signal to the shop floor that they can start the order (and the production order is updated to ‘Started’ on the shop floor when work actually starts) – but mostly I’ve seen this step left out of the process.**
   **
5. **You should start a production order.** The production order status must be ‘Started’**
   **before you can issue materials; record hours; or report as finished. But the system will perform Process > Start for you if you jump directly to Report as finished – however my personal preference is not to rely on the system performing this step for you – and you perform it manually.**
   **
6. **You should not reset the status on a ‘Started’ production order** unless you know exactly what you are doing. If you reset the status to before started and there are any postings on the production order – (that’s picking list issues; route/job card hours; and/or report as finish quantities) – the system will try to **reverse all** of those postings. Even if it succeeds and posts all of the relevant journals – that’s probably not exactly what you wanted to happen.**
   **
7. **A Production planner / supervisor should set the production order to ‘Reported as finished’.** This is telling the system (and everyone else) that you don’t expect to do any more work on this production order. You don’t expect to make any more product; you’re not reserving or planning to consume any components, ingredients, or packaging; and you’re not reserving any production capacity – but you can still post transactions to the production order if you need to (for instance in the case that something got mis-reported or forgotten).
8. **Ending a production order is a financial transaction** so it’s normally performed by someone in the finance department – or someone responsible for the budget or financial performance of the production unit. You can’t post any transactions to an Ended production order – and you can’t reverse the Process > End, so before you set the status to Ended you have to have checked the production order postings and variances and you have to be sure that everything is posted correctly.
9. You shouldn’t tick ‘Reported as finished’ when you Update > End a production order:
   ![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/092716_2247_productiono3.png)
   Well, this is only relevant if you’ve ignored rules 7 and 11, but that tick allows you to End production orders that aren’t Reported as finished, and at the same time report as finish the remainder of your production order – so you could be implicitly performing an inventory update – so you’re breaking rule 8 as well.
10. **Before you perform any production order updates set your user default values.** For instance on the Process > End form, there’s a Default values button:
    ![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/092716_2247_productiono4.png)
    Click on it and you see:
    ![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/092716_2247_productiono5.png)
    Every new user should be given a setup script that they have to walk through setting their user defaults for each and every production order process transaction before they are let loose on production orders.
11. And finally, you can enforce some of these rules on the Status tab of your production parameters (which can be set by Site, as well as by company):

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/092716_2247_productiono6.png)

Lastly – and it’s not really a rule – but notice that you can’t cancel a production order. On sales orders and purchase orders you can cancel lines – so the evidence is there that there used to be an order, but you don’t want it any more. Sadly, there’s no equivalent in production – so if you do need to cancel a production order you’re going to have to reset the status to ‘Created’ and delete it and then have some manual process which will update previously printed schedules and production documents.