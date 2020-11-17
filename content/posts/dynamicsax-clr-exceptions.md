---
title: "如何在 DynamicsAX 中处理CLR对象报错的问题"
subtitle: "Working with CLR Exceptions in Dynamics AX"
date: 2020-11-17T15:44:23+08:00
lastmod: 2020-11-17T15:44:23+08:00
draft: false
author: ""
authorLink: ""
description: ""

tags: [Ax2012]
categories: [Dynamicsax]

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

在 Dynamics AX 中 无论版本是2009还是2012或者D365，总是会遇到下面这两个报错：

- ***Object ‘CLRObject’ could not be created***
- ***ClrObject static method invocation error***

而且系统给出的日志实在是太简短了，让人摸不着头脑。不过一般出现这两个问题都是在AX中处理 .net 相关的 dll 或者在调用 web service、WCF。那么剩下的问题就是我们该怎么样得知在调用 .net 框架的时候究竟出了什么问题呢，一旦知道了具体原因就好办了。

------

好，那我们通过一个 Job 演示一下吧：

```c#
static void RaiseCLRException(Args _args)
{
  ;
  //Necessary if executed on the AOS
  new InteropPermission(InteropKind::ClrInterop).assert(); 

  try
  {
    //This will cause an exception
    System.Int32::Parse("abc");
  }
  catch(Exception::CLRError)
  {
    //Access the last CLR Exception
    info(CLRInterop::getLastException().ToString());
    
    //See AifUtil::getClrErrorMessage for another alternative
    //how to parse the Exception object 

  }
  //Revert CAS back to normal
  CodeAccessPermission::revertAssert();
}
```

 执行上面代码我们可以得到如下信息：

```
System.Reflection.TargetInvocationException: Exception has been thrown by the target of an invocation. —> **System.FormatException: Input string was not in a correct format.**
  at System.Number.StringToNumber(String str, NumberStyles options, NumberBuffer& number, NumberFormatInfo info, Boolean parseDecimal)
  at System.Number.ParseInt32(String s, NumberStyles style, NumberFormatInfo info)
  at System.Int32.Parse(String s)
  — End of inner exception stack trace —
  at System.RuntimeMethodHandle._InvokeMethodFast(Object target, Object[] arguments, SignatureStruct& sig, MethodAttributes methodAttributes, RuntimeTypeHandle typeOwner)
  at System.RuntimeMethodHandle.InvokeMethodFast(Object target, Object[] arguments, Signature sig, MethodAttributes methodAttributes, RuntimeTypeHandle typeOwner)
  at System.Reflection.RuntimeMethodInfo.Invoke(Object obj, BindingFlags invokeAttr, Binder binder, Object[] parameters, CultureInfo culture, Boolean skipVisibilityChecks)
  at System.Reflection.RuntimeMethodInfo.Invoke(Object obj, BindingFlags invokeAttr, Binder binder, Object[] parameters, CultureInfo culture)
  at ClrBridgeImpl.InvokeClrStaticMethod(ClrBridgeImpl* , Char* pszClassName, Char* pszMethodName, Char* assemblyName, Int32 argsLength, ObjectWrapper** arguments, Boolean* argsAreByRef, Boolean* isException)
```



> **=> The part *System.FormatException: Input string was not in a correct format.*** 

从这一段就可以看出到底是哪里出问题了。