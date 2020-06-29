---
title: "Using webservice to connect with Dynamics AX"
date: 2020-01-14T11:03:30+08:00
description: ""
draft: false
tags: [Ax2009,WebService,Wcf]
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

## 第三方接口调用AX内部程序

### SystemConnector

在"Csharp"代码中，我们可以直接调用"Systemconnector"提供的接口从而实现执行AX内部程序的功能。

如：

```c#
axServiceProvider.handleAgileData("cig", _XMLStr); 
```

实际上 "axServiceProvider" 是通过内置函数 "CallStaticClassMethod" 来实现调用AX内部程序。

```c#
string returnStr = (string)op.CallStaticClassMethod("AX Class", "Class Method", _legal, _XMLStr);
```

将第三方外部程序组织的XML数据主动传递给AX，AX内部只需要解析该XML数据即可执行相应的业务逻辑操作。

在 axServiceProvider 中我们可以设定AX2009的环境端口，用户，密码，公司等信息，同样可以构建更多的方法来调用Ax不同的功能。

下文是通过"Csharp"代码调用接口的样例：

## Consume SystemConnector in VS

![1](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/AX2009Webservice/1.png)

```c#
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using SystemConnector.DynamicsAX;

namespace CIG_WCF4AgileAX
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string ret = "";
            //string _XMLStr = GetXmlDocument(@"D:/AgileXml/HDC000076-utf.xml");
            //string _XMLStr = GetXmlDocument(@"E:/AgileXml/test1014/UPD-1014-33-01.xml");
            string _XMLStr = GetXmlDocument(@"E:/AgileXml/test1014/CIG000780.xml");
            //string _XMLStr = "AX-MES-RDIF-Go";
            try
            {
                AXServiceProvider axServiceProvider = new AXServiceProvider();
                //ret = axServiceProvider.handleRFIDData("cig", _XMLStr);
                ret = axServiceProvider.handleAgileData("cig", _XMLStr);              
            }
            catch (Exception ex)
            {
                ret= ex.ToString();
            }
            Response.Write(ret);
        }

        private static string GetXmlDocument(string xmlPath)
        {
            try
            {
                XmlDocument doc = null;
                if (File.Exists(xmlPath))
                {
                    doc = new XmlDocument();
                    doc.Load(xmlPath);               
                }
                return doc.InnerXml;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.Write(ex.Message);
            }
            return null;
        }
    }
}
```
[源代码](https://pan.nashome.cn/s/x9FmdkpEiiWnT4B)

## AX内部程序调用第三方接口

AX2009 调用外部接口只需要打开AOT-Reference-添加一个服务引用即可，添加引用时可以添加dll文件。

如下图：

![2](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/AX2009Webservice/2.png)

![3](https://nashome-image-bucket.oss-accelerate.aliyuncs.com/Images/AX2009Webservice/3.png)

这样就可以了。