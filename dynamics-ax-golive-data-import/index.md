# Dynamics AX GoLive Data Import


<!--more-->

期初余额的导入程序大致都比较相似，只是创建的日记账有些区别，源代码在文末。

期初数据模板请跳转至[Dynamics AX GoLive Data Initialize]({{< ref "Dynamics-AX-GoLive-Data-Initialize.md" >}})

## GL：总帐

```
static void ImportTBGL(Args _args)
{
    ……
    try
    {
        axLedgerJournalTable = new AxLedgerJournalTable();
        axLedgerJournalTable.parmJournalName("FIOpening");
        axLedgerJournalTable.parmName("TB GL 20190831");
        axLedgerJournalTable.save();
        numImported = 0;
        lineNo = 1;
        record = csvFile.read();
        while (csvFile.status() == IO_Status::Ok)
        {
            record = csvFile.read();
            lineNo = lineNo +1;
            if (!record) break;
            ttsBegin;
            if (conPeek(record,1)!="")
            {
                axLedgerJournalTrans = new AxLedgerJournalTrans();           			axLedgerJournalTrans.parmJournalNum(axLedgerJournalTable.ledgerJournalTable().JournalNum);             
                axLedgerJournalTrans.parmTransDate(str2Date("2019/8/31",321));
                axLedgerJournalTrans.parmTxt("TBGL20190831");
                axLedgerJournalTrans.parmAccountType(LedgerJournalACType::Ledger);
                axLedgerJournalTrans.parmAccountNum(conPeek(record,1));
                axLedgerJournalTrans.parmCurrencyCode(conPeek(record,2));
                if  (str2num(conPeek(record,3)) > 0)
                {                      axLedgerJournalTrans.parmAmountCurDebit(str2num(conPeek(record,3)));
                } else
                {                       axLedgerJournalTrans.parmAmountCurCredit(abs(str2num(conPeek(record,3))));
                }
                axLedgerJournalTrans.parmExchRate(round(conPeek(record,4),0.0001));
                axLedgerJournalTrans.parmOffsetAccountType(LedgerJournalACType::Ledger);
                axLedgerJournalTrans.parmOffsetAccount("9999");
                axLedgerJournalTrans.save();
                numImported = numImported + 1;
            } else
            {
                info(strfmt("line No -- %1 -- has no accountNum, not imported",lineNo));
            }
            ttsCommit;
        } //while
    ……
}
```

## AP：应付账款

```
static void ImportTBAP(Args _args)
{
    ……
    try
    {
        axLedgerJournalTable = new AxLedgerJournalTable();
        axLedgerJournalTable.parmJournalName("FIOpening");
        axLedgerJournalTable.parmName("TB AP 20190831");
        axLedgerJournalTable.save();
        numImported = 0;
        lineNo = 1;
        record = csvFile.read();
        while (csvFile.status() == IO_Status::Ok)
        {
            record = csvFile.read();
            lineNo = lineNo +1;
            if (!record) break;

            ttsBegin;
            if ((conPeek(record,1)!="")  && (VendTable::find(conPeek(record,1),false)))
            {
                axLedgerJournalTrans = new AxLedgerJournalTrans();
                axLedgerJournalTrans.parmJournalNum(axLedgerJournalTable.ledgerJournalTable().JournalNum);
                axLedgerJournalTrans.parmTransDate(str2Date("2019/8/31",321));
                axLedgerJournalTrans.parmTxt(conPeek(record,5));
                axLedgerJournalTrans.parmAccountType(LedgerJournalACType::Vend);
                axLedgerJournalTrans.parmAccountNum(conPeek(record,1));
                axLedgerJournalTrans.parmInvoice(conPeek(record,2));
                axLedgerJournalTrans.parmDue(str2Date(conPeek(record,3),321));
                axLedgerJournalTrans.parmPostingProfile(conPeek(record,4));
                axLedgerJournalTrans.parmCurrencyCode(conPeek(record,6));
                if  (str2num(conPeek(record,8)) > 0)
                {                      axLedgerJournalTrans.parmAmountCurDebit(str2num(conPeek(record,8)));
                } else
                {                 axLedgerJournalTrans.parmAmountCurCredit(abs(str2num(conPeek(record,8))));
                }
                axLedgerJournalTrans.parmExchRate(conPeek(record,7));
                axLedgerJournalTrans.parmOffsetAccountType(LedgerJournalACType::Ledger);
                axLedgerJournalTrans.parmOffsetAccount("9999");
                axLedgerJournalTrans.save();
                numImported = numImported + 1;
            } else
            {
                info(strfmt("line No -- %1 -- has no accountNum %2, not imported",lineNo,conPeek(record,1)));
            }
            ttsCommit;
        } //while
    ……
}
```

## AR/OR：应收账款，其他应收款

AR和OR使用同一份模板， OR: other 

```
static void ImportTBAR(Args _args)
{
    ……
    try
    {
        axLedgerJournalTable = new AxLedgerJournalTable();
        axLedgerJournalTable.parmJournalName("FIOpening");
        axLedgerJournalTable.parmName("TB AR 20190831");
        axLedgerJournalTable.save();
        numImported = 0;
        lineNo = 1;
        record = csvFile.read();
        while (csvFile.status() == IO_Status::Ok)
        {
            record = csvFile.read();
            lineNo = lineNo +1;
            if (!record) break;
            ttsBegin;
            if ((conPeek(record,1)!="")  && (CustTable::find(conPeek(record,1),false)))
            {
                axLedgerJournalTrans = new AxLedgerJournalTrans();                axLedgerJournalTrans.parmJournalNum(axLedgerJournalTable.ledgerJournalTable().JournalNum);               
                axLedgerJournalTrans.parmTransDate(str2Date("2019/8/31",321));
                axLedgerJournalTrans.parmTxt(conPeek(record,5));
                axLedgerJournalTrans.parmAccountType(LedgerJournalACType::Cust);
                axLedgerJournalTrans.parmAccountNum(conPeek(record,1));
                axLedgerJournalTrans.parmInvoice(conPeek(record,2));
                axLedgerJournalTrans.parmDue(str2Date(conPeek(record,3),321));
                axLedgerJournalTrans.parmPostingProfile(conPeek(record,4));
                axLedgerJournalTrans.parmCurrencyCode(conPeek(record,6));
                if  (str2num(conPeek(record,8)) > 0)
                {                       axLedgerJournalTrans.parmAmountCurDebit(str2num(conPeek(record,8)));
                } else
                {                       axLedgerJournalTrans.parmAmountCurCredit(abs(str2num(conPeek(record,8))));
                }
                axLedgerJournalTrans.parmExchRate(conPeek(record,7));
                axLedgerJournalTrans.parmOffsetAccountType(LedgerJournalACType::Ledger);
                axLedgerJournalTrans.parmOffsetAccount("9999");
                axLedgerJournalTrans.save();
                numImported = numImported + 1;
            } else
            {
                info(strfmt("line No -- %1 -- has no accountNum %2 , not imported",lineNo,conPeek(record,1)));
            }
            ttsCommit;
        } //while
    }
    ……
}
```

## INVENTORY：存货

导入存货的时候需要注意把序列号一并导入（如果有）

```
static void ImportTBInvent(Args _args)
{
    ……
    try
    {
            numImported = 0;
            lineNo = 1;
            axInventJournalTable    = new AxInventJournalTable();        axInventJournalTable.parmJournalNameId("Mov_Inventory_Adjust");//Mov_Inventory_Adjust
            axInventJournalTable.parmDescription("TB Invent 20190831");
            axInventJournalTable.save();
            _journalId  = axInventJournalTable.inventJournalTable().JournalId;

            record = csvFile.read();
            ttsbegin;
            while (csvFile.status() == IO_Status::Ok)
            {
                record = csvFile.read();
                lineNo = lineNo +1;
                if (!record) break;
                if (!InventTable::find(conPeek(record,1),false))
                {
                    info(strfmt("line No -- %1 -- has non existed itemNum, not imported",lineNo));
                    continue;
                } else
                {
                    axInventJournalTrans = new AxInventJournalTrans();
                    axInventJournalTrans.parmJournalId(_journalId);
                    axInventJournalTrans.parmTransDate(str2Date("2019/8/31",321));
                    axInventJournalTrans.parmItemId(conPeek(record,1));
                    inventDim.clear();
                    inventDim.InventSiteId      = conPeek(record,2);
                    inventDim.InventLocationId  = conPeek(record,3);
                    inventDim.wMSLocationId     = conPeek(record,4);
                    if (InventTable::find(conPeek(record,1)).DimGroupId == "rev")
                    {
                        if (strLRtrim(conPeek(record,5)) != "")
                        {
                            inventDim.InventColorId     = conPeek(record,5);
                            inventColor = InventColor::find(conPeek(record,5),conPeek(record,1));
                            if (!inventColor)
                            {
                                  info(strfmt("line No -- %1 --, version is not exists, %2 not imported",lineNo,conPeek(record,1)));
                                  continue;
                            }
                        } else
                        {
                            info(strfmt("line No -- %1 -- has no version, not imported",lineNo));
                            continue;
                        }
                    }
                    _inventDimId                = InventDim::findOrCreate(inventDim).inventDimId;
                    axInventJournalTrans.parmInventDimId(_inventDimId);
                    axInventJournalTrans.parmQty(str2num(conPeek(record,6)));             
                    axInventJournalTrans.parmCostAmount(str2num(conPeek(record,9)));              axInventJournalTrans.parmCostPrice(round(axInventJournalTrans.parmCostAmount()/axInventJournalTrans.parmQty(),0.0001));
                    axInventJournalTrans.parmLedgerAccountIdOffset("9999");
                    axInventJournalTrans.save();
                    numImported = numImported + 1;
                }

            } //while
            ……
            //序列号
            while (csvFile2.status() == IO_Status::Ok)
            {
                record = csvFile2.read();
                lineNo = lineNo +1;
                if (!record) break;
               // ttsBegin;
                if ((InventTable::find(conPeek(record,1),false)) && (InventTable::find(conPeek(record,1)).CIG_SerialControl == NoYes::Yes))
                {
                    _itemId                     = conPeek(record,1);
                    inventDim.clear();
                    inventDim.InventSiteId      = conPeek(record,3);
                    inventDim.InventLocationId  = conPeek(record,4);
                    inventDim.wMSLocationId     = conPeek(record,5);
                    inventDim.InventColorId     = conPeek(record,6);
                    _inventDimId                = InventDim::findOrCreate(inventDim).inventDimId;
                    cig_inventTransSerial.clear();
                    cig_inventTransSerial.ItemId    = _itemId;
                    select firstonly inventJournalTrans where
                            inventJournalTrans.JournalId  == _journalId
                        &&  inventJournalTrans.ItemId     == _itemId
                        &&  inventJournalTrans.InventDimId  == _inventDimId;
                    cig_inventTransSerial.InventTransId     = inventJournalTrans.InventTransId;
                    //cig_inventTransSerial.Qty               =
                    cig_inventTransSerial.InventStatus      = CIG_InventStatus::Registered;
                    cig_inventTransSerial.inventSerialId    = conPeek(record,2);
                    cig_inventTransSerial.TransType         = InventTransType::InventTransaction;
                    cig_inventTransSerial.TransRefId        = _journalId;
                    cig_inventTransSerial.DocumentId        = _journalId;
                    cig_inventTransSerial.inventDimId       = InventDim::inventDimIdBlank();
                    cig_inventTransSerial.initValue();
                    cig_inventTransSerial.insert();
                    cig_serialTable.clear();
                    cig_serialTable.InventSerialId          = conPeek(record,2);
                    cig_serialTable.DateCode                = conPeek(record,7);
                    cig_serialTable.InventSerialIdCustomer  = conPeek(record,8);
                    cig_serialTable.initValue();
                    cig_serialTable.insert();
                    numImported = numImported + 1;
                }
               // ttsCommit;
            } //while
             ttsCommit;
            info(strfmt("%1 records imported",numImported));

    }
……
}
```

## FA：固定资产

Fixed Assets 包括了固定资产卡片、购置、折旧，使用同一个模板用如下程序导入三次即可。

```
static void ImportTBFADetailss(Args _args)
{
    ……
    try
    {
        numImported = 0;
        lineNo = 1;
        record = csvFile.read();
        while (csvFile.status() == IO_Status::Ok)
        {
            record = csvFile.read();
            lineNo = lineNo +1;
            if (!record) break;
            ttsbegin; //Save asset record.
            if (!AssetTable::find(conPeek(record,1),false))
            {
                assetTable.selectForUpdate(true);
                assetTable.clear();
                assetTable.AssetId = conPeek(record,1);
                assetTable.AssetGroup = conPeek(record,4);
                assetTable.NameAlias  = conPeek(record,3);
                assetTable.Model        = conPeek(record,7);
                assetTable.Location     = conPeek(record,8);
                assetTable.SerialNum    = conPeek(record,22);
                assetTable.Responsible  = conPeek(record,20);
                //assetTable.AssetType = AssetType::Intangible; // Type of Asset Tangible, InTangible, Financial, GoodWill etc
                assetTable.Name = conPeek(record,2);                 // Asset Name
                assetTable.Quantity = 1;                                   // Quantity of Asset
                assetTable.PropertyType = AssetPropertyType::FixedAsset; // Asset property type FixedAsset, ContinuingProperty etc
                assetTable.insert(true); // Create Fixed Asset
                serviceLife = conPeek(record,13);
                LifeTimeRest = conPeek(record,15);
                DrunDate    = conPeek(record,12);
                ADate   = conPeek(record,10);
                Costcenter = conPeek(record,18);
                while select assetGroupBookSetup
                        where assetGroupBookSetup.AssetGroup == assetTable.AssetGroup
                {
                    if (assetTable.AssetGroup == assetGroupBookSetup.AssetGroup)
                    {
                        assetBook.clear();
                        assetBook.initValue();
                        assetBook.BookId     = assetGroupBookSetup.BookId;
                        assetBook.AssetId    = assetTable.AssetId;
                        assetBook.AssetGroup = assetGroupBookSetup.AssetGroup;
                        assetBook.initFromAssetGroupBookSetup();
                        assetBook.SortingId  = assetTable.SortingId;
                        assetBook.SortingId2 = assetTable.SortingId2;
                        assetBook.SortingId3 = assetTable.SortingId3;
                        assetbook.ServiceLife = str2num(serviceLife);
                        assetbook.LifeTimeRest = str2num(LifeTimeRest);
                        assetbook.DepreciationStartDate = str2date(DrunDate,321);
                        assetbook.AcquisitionDate       = str2date(ADate,321);
                        assetbook.Dimension[2]          = Costcenter;
                        assetBook.insert();
                    }
                }
                numImported = numImported + 1;

            }
            else
            {
                info("Exists");
            }
            ttscommit;
        } //while
    }
    ……
}
```
这里是[导入功能的源代码](https://pan.nashome.cn/s/6sPoQy46gcgkF9H)
