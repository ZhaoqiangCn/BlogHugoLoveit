# 如何在二次开发的模块中应用编号规则(How to develop number sequence for custom module in Dynamics 365)


<!--more-->

In Finance and Operations system provide you unique number feature for new record that has been created known as Number Sequence.

In most of the cases it is provided by system wherever it is necessary,and it also possible to use existing number sequence using environment only. When you create new module there you might need to setup new number sequence exclusive for that module.

In such cases we might need to consider custom number sequence development,so in this blog we will see how to achieve that.

following are the steps which need to be performed and screenshots are also there for better understanding.

**Steps:-**

1. Create an extension of NumberSeqModule Base Enum and add a new element and name it with our Module name and label as well.

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/202111290923692.png)

1. Now create New EDT string with the name of PayId and set its properties as follows

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/202111290923933.png)

1. Now create parameter table and set its properties as follows and add key field to it

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/202111290923728.png)

Set its property visible as no

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/202111290924890.png)

create new index and name it as keyIdx and add key field to it

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/202111290925607.png)

1. Now create another table where number sequence is generated on its respective field of table in our case known as PayTable and field where number sequence will be applied is PayId

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/202111290926455.png)

1. Create new parameters form and apply table of contents pattern and add required elements(for reference you can use ProjParameters form) as follows

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/202111290927020.png)

Now to add second tab for number sequence setup.Since number sequence is complex for beginner you can simply copy NumberSeq tab of ProjParameters form and paste in Tab form control as follows

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/202111290927764.png)

6.Now create form where number sequence will be implemented where PayTable will be datasource and drag its fields to form as displayed.

7.Now add the class with name of NumberSeqModulePay and extend it with NumbeSeqApplicationModule and code for that as follows :-

```X++
class NumberSeqModulePay extends NumberSeqApplicationModule {

*///*

*/// standard method for implementing new number sequence module*

*///*

*/// NumberSeqModule value*

public NumberSeqModule numberSeqModule()

{

return NumberSeqModule::Pay;//module name from NumberSeqModule enum extension

}

*///*

*/// standard method for implementing new number sequence module*

*/// sets up number sequences for module identifiers*

*///*

protected void loadModule()

{

NumberSeqDatatype datatype = NumberSeqDatatype::construct();

datatype.parmDatatypeId(extendedTypeNum(Payid));//EDT created in previous step

datatype.parmReferenceHelp(“Pay Id”);

datatype.parmWizardIsContinuous(false);

datatype.parmWizardIsManual(NoYes::No);

datatype.parmWizardIsChangeDownAllowed(NoYes::No);

datatype.parmWizardIsChangeUpAllowed(NoYes::No);

datatype.parmSortField(1);

datatype.parmWizardHighest(999999);

datatype.addParameterType(NumberSeqParameterType::DataArea, true, false);     this.create(datatype);

*// TODO: Add code for data types associated with the module*   }

*///*

*/// event handler for implementing new number sequence module*

*/// adds the module to the global map*

*///*

*/// global map for number sequence modules*

[SubscribesTo(classStr(NumberSeqGlobal), delegateStr(NumberSeqGlobal, buildModulesMapDelegate))]

public static void NumberSeqGlobal_buildModulesMapDelegate(Map numberSeqModuleNamesMap)

{

NumberSeqGlobal::addModuleToMap(classnum(NumberSeqModulePay), numberSeqModuleNamesMap);

}

public static NumberSequenceReference numRefPayId()   {     NumberSeqScope scope = NumberSeqScopeFactory::createDataAreaScope(curext());     return NumberSeqReference::findReference(extendedtypenum(PayId), scope);   }

}
```

 this class is used to provide number sequence setup parameters

1. Now we need to load our number sequence to system for which **create** **loadmodule** **class**

**code:-** 

1. ```
   class loadmodulePay 
   { 
   	public static void main(Args _args)   
   	{      
           NumberSeq PayNumSeq;     PayId payid;
   
           ttsbegin;     
           PayNumSeq = NumberSeq::newGetNum(NumberSeqModulePay::numRefPayId());     
           payid = PayNumSeq.num();
   
           ttscommit;
   
           Info(strFmt(“Payslip Id is :%1 “,payid));   
       } 
   }
   ```

   Add **number** **sequence** **handler** to form for that add following **code** **to** **PayParameter** form by selecting view code option on the form this

[Form] 

```X++
public class PayParameters extends FormRun {     #ISOCountryRegionCodes

boolean runExecuteDirect;   TmpIdRef tmpIdRef;

NumberSeqScope scope;   NumberSeqApplicationModule numberSeqApplicationModule;   container numberSequenceModules;

public void init()   {     this.numberSeqPreInit();     PayParameters::find();

super();     this.numberSeqPostInit();   }

void numberSeqPostInit()   {     numberSequenceReference_ds.object(fieldNum(NumberSequenceReference, AllowSameAs)).visible(numberSeqApplicationModule.sameAsActive());     referenceSameAsLabel.visible(numberSeqApplicationModule.sameAsActive());   }

void numberSeqPreInit()   {     runExecuteDirect = false;

numberSequenceModules = [NumberSeqModule::Pay];     numberSeqApplicationModule = new NumberSeqModulePay();     scope = NumberSeqScopeFactory::createDataAreaScope();     NumberSeqApplicationModule::createReferences(NumberSeqModule::Pay, scope);     tmpIdRef.setTmpData(NumberSequenceReference::configurationKeyTableMulti(numberSequenceModules));   }

public NumberSeqModule numberSeqModule()   {     return NumberSeqModule::Pay;// module literal crated in

NumberSeqModule enum extension previously   }

public Common resolveReference(FormReferenceControl _formReferenceControl)   {     NumberSequenceCode code = _formReferenceControl.filterValue(         AbsoluteFieldBinding::construct(fieldStr(NumberSequenceTable, NumberSequence),         tableStr(NumberSequenceTable))).value();

*// Do not call super as we’re providing our own disambiguation logic.*     *// resolvedRecord = super(_formReferenceControl);*

return NumberSequenceTable::findByNaturalKey(code, scope.getId(true));   }

public Common lookupReference(FormReferenceControl _formReferenceControl)   {     NumberSequenceTable selectedRecord;     SysReferenceTableLookup sysTableLookup = SysReferenceTableLookup::newParameters(tableNum(NumberSequenceTable), _formReferenceControl, true);     Query lookupQuery;

*// Do not call super as we’re providing our own custom lookup logic.*     *// selectedRecord = super(_formReferenceControl);*

*// Display the Title and Department fields in the lookup form.*     sysTableLookup.addLookupfield(fieldNum(NumberSequenceTable, NumberSequence));

*// Create a custom Query that filters on NumberSequenceScope.*     lookupQuery = new Query();     lookupQuery.addDataSource(tableNum(NumberSequenceTable)).addRange(fieldNum(NumberSequenceTable, NumberSequenceScope)).value(queryValue(scope.getId(true)));     sysTableLookup.parmQuery(lookupQuery);

*// Return the record selected by the user.*     selectedRecord = sysTableLookup.performFormLookup();

return selectedRecord;   }

[DataSource]   class NumberSequenceReference   {     *///*

*///*

*///*

void removeFilter()

{

runExecuteDirect = false;

numbersequenceReference_ds.executeQuery();

}

public display TaxBookSectionId taxBookSectionId(NumberSequenceReference _numberSequenceReference)     {       NumberSequenceTable numberSequenceTableLocal;

if (numberSequenceReference.NumberSequenceId)       {         select firstonly NumberSequence from numberSequenceTableLocal where numberSequenceTableLocal.RecId == _numberSequenceReference.NumberSequenceId;       }

return TaxBookSection::findVoucherSeries(numberSequenceTableLocal.RecId).TaxBookSectionId;     }

void executeQuery()     {       if (runExecuteDirect)       {         super();       }       else       {         runExecuteDirect = true;         this.queryRun(NumberSeqReference::buildQueryRunMulti(numberSequenceReference,                                  tmpIdRef,                                  numberSequenceTable,                                  numberSequenceModules,                                  scope));         numbersequenceReference_ds.research();       }     }

public boolean validateWrite()     {       boolean ret = super();

\#ISOCountryRegionCodes

NumberSequenceDatatype numberSequenceDataType;       NumberSequenceTable numberSequenceTableLocal;

if (ret && SysCountryRegionCode::isLegalEntityInCountryRegion([#isoHU]))       {         numberSequenceDataType = NumberSequenceDatatype::find(numberSequenceReference.NumberSequenceDatatype, false);         if (numberSequenceDataType.DatatypeId == extendedTypeNum(TaxReimbursementDoc_HU))         {           numberSequenceTableLocal = numberSequenceReference.numberSequenceTable();

if (numberSequenceTableLocal.Manual)           {             ret = checkFailed(strFmt(“@AccountsReceivable:NumSequenceNotAllManualEdit“, “@GEE31852”));           }         }       }

return ret;     }

public void init()     {       super();

NumberSequenceReference_ds.cacheAddMethod(identifierStr(taxBookSectionId));       NumberSequenceReference_ds.cacheAddMethod(tableMethodStr(NumberSequenceReference, referenceHelp));       NumberSequenceReference_ds.cacheAddMethod(tableMethodStr(NumberSequenceReference, referenceLabel));     }

}

}
```



1. Create 2 **Display** **Menu** **Items** for **Payfrom** and **PayParameters** and assign forms in object field of them

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/202111290927687.png)

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/202111290927372.png)

1. Now **create** new **menu** and name it with Your module name and add display Menu items to it

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/202111290927976.png)

1. Now create **extension** **of** **main** **menu** item and add new menu reference and assign menu name with our custom menu

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/202111290927021.png)

1. Now finally add **number** **Sequence** **handler** **class** and other classes **to** **Payform** to use created number sequence we have to mention field where it should be used as follows

**code:-**

```
[Form]

public class PayForm extends FormRun

{

NumberSeqFormHandler numberSeqFormHandler;

NumberSeqFormHandler numberSeqFormHandler()

{

if (!numberSeqFormHandler)

{

numberSeqFormHandler = NumberSeqFormHandler::newForm(NumberSeqModulePay::numRefPayId().NumberSequenceId,

element,

PayTable_ds,

fieldNum(PayTable, payid));

}

return numberSeqFormHandler;

}

void close()

{

if (numberSeqFormHandler)

{

numberSeqFormHandler.formMethodClose();

}

super();

}

[DataSource]

class PayTable

{

*///*

*///*

*///*

*///*

public void linkActive()

{

element.numberSeqFormHandler().formMethodDataSourceLinkActive();

super();

}

*///*

*///*

public boolean validateWrite()

{

boolean ret;

ret = super();

ret = element.numberSeqFormHandler().formMethodDataSourceValidateWrite(ret) && ret;

return ret;

}

*///*

*///*

public void write()

{

ttsbegin;

super();

element.numberSeqFormHandler().formMethodDataSourceWrite();

ttscommit;

}

public void delete()

{

ttsbegin;

element.numberSeqFormHandler().formMethodDataSourceDelete();

super();

ttscommit;

}

*///*

*///*

*///*

*///*

public void create(boolean _append = false)

{

element.numberSeqFormHandler().formMethodDataSourceCreatePre();

super(_append);

element.numberSeqFormHandler().formMethodDataSourceCreate(true);

}

}

}
```

14.Now go to **system administration>>number sequence** and Select **generate** **button** and follow the steps which are mentioned below to generate number sequence using wizard

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/202111290927414.png)

Click on next button

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/202111290927210.png)

Again click on next button

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/202111290928529.png)

Now click finish button and number sequence is generated

\15.  Now visit to payparameter form and click on number sequence tab and select the desired number sequence for payid field

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/202111290928040.png)

On creating new record you can now see the number sequence is generated for payslip id (PayId)

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/202111290928920.png)

![](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/PicGo/202111290928763.png)

I hope at that after referring this blog you will able to crate your own modules number sequence. 

