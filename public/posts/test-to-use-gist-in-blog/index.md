# Test to Use Gist in Blog


<!--more-->
##TEST
{{< gist ZhaoqiangCn 5e82d32107c5a5006f39caeca77a90dd >}}

```
//Change the arguments (variable) names and assign names as per your requirements
//Change in the function as well
public DimensionDefault createDefaultDimension(str department, str purpose, str costCenter)
{
    DimensionAttributeValueSetStorage   valueSetStorage = new DimensionAttributeValueSetStorage();
    DimensionDefault                    result;
    int                     i;
    DimensionAttribute      dimensionAttribute;
    DimensionAttributeValue dimensionAttributeValue;
    
    //Change the dimension names. Use the dimension name which are open and active in the system
    //I have given Region, Purpose and Costcentre just for an example
    
    container               conAttr = ["Region", "Purpose", "Costcentre"];
    
    //Change the values which you want to set in dimensions. Use values which are open and active in the system
    //I have given the arguments of function as values for dimensions.
    
    //Dimension name    ->      dimension value
    
    //Region            ->      department
    //Purpose           ->      purpose
    //Costcentre        ->      costCenter
    
    container               conValue = [department, purpose, costCenter];
    
    str                     dimValue;
    
    for (i = 1; i <= conLen(conAttr); i++)
    {
        dimensionAttribute = dimensionAttribute::findByName(conPeek(conAttr,i));
        if (dimensionAttribute.RecId == 0)
        {
            continue;
        }
        dimValue = conPeek(conValue,i);
        if (dimValue != "")
        {
            dimensionAttributeValue = dimensionAttributeValue::findByDimensionAttributeAndValue(dimensionAttribute,dimValue,false,true);
            valueSetStorage.addItem(dimensionAttributeValue);
        }
    }
    
    result = valueSetStorage.save();
    //It reutrns the value of type DimensionDefault
    return result;
}
```
