# Dynamics 365 Supply Structures in Grocery Retail Industry


>
> Author link: https://en.gravatar.com/hatlevik
>


Today I will write a bit about the supply chain structure we see in the retail grocery industry, and challengers Dynamics 365 may face, and how to address them. The grocery industry has for many years seen that industry collaboration brings benefits and synergies throughout the value chain. We see industry collaboration that offers a range of services to its owners, customers and partners. In the country where I’m from, the main collaboration initiative is [TradeSolution](https://tradesolution.no/), and is owned by the main grocery chains in Norway. TradeSolution operates and maintains central registers, databases, and various IT, reporting and analysis services in Norway, but we see much of the same pattern in other countries and other industries also.

One essential element is to have a unification of how to identify products and how the products are packed, ordered and shipped. In Norway we have the term EPD (Electronic Product-Database), that makes it easy for the entire Norwegian grocery marked to purchase and sell products. Much of the information shown in the blogpost here is originating from TradeSolutions public pages [here](https://tradesolution.no/wp-content/uploads/Quick-Guide-to-EPD-API-2018.pdf).

# What is EPD? 

In Dynamics 365, one of the most essential SCM elements are [products and released products](https://docs.microsoft.com/en-us/dynamics365/supply-chain/pim/product-information), and the associated master data tables related to this. In the grocery industry it is actually the packaging that is the center of it all. **The products etc is actually properties of a packing structure.** It would be an oversimplification to say that EPD is products. EPD is describing not only the products, but also the packaging of the products. The EPD standard is describing the products in up to 4 levels: basis, inner box, outer box and pallet(with [SCCS](https://www.gs1.org/standards/id-keys/sscc)). Each level identified with a [GTIN](https://www.gs1.org/standards/id-keys/gtin). See also my [old blogpost]({{< ref "dynamics-365-shipping-container-labeling-guide.md" >}})about SSCC.

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SupplyStructures/1.png)

So far so good. We can model this in Dynamics 365 by having a product defined as a “Basis”, and use the inner box, outer box and pallet as unit conversions. In D365 we also have the possibility to create barcodes for each unit of measurement (UOM). It would also be quick to assume that the EPD number is an external item description.

Unfortunately, the grocery industry is a bit more complex. Let’s take a quick look on the EPD numbers of Coca Cola. It is actually 7 packing structure/EPD numbers, and these are shown to the right(7digits). All of the represents different packaging of the same basis unit, and can have different properties and attributes.

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SupplyStructures/2.png)

What we also see is that some boxes are marked with a **“F”**, that means this is a consumer unit. So talk in D365 language, is can be sold to consumers. Some are also marked with a **“B”** that means that this is the unit that the EPD number is purchased in. So if we take a detailed look at EPD **4507224**, we see that it is defined what units you can sell, and what units you can purchase. On a single EPD number there is only one level you can choose to purchase of. Here are 2 examples that describes the complexity. First example is an EPD, where the grocer can sell in basis unit and in inner box unit (EPD 4507224)

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SupplyStructures/3.png)

The next example is where the grocer can also sell basis unit and in another inner box unit type (EPD 2142941)

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SupplyStructures/4.png)

**As you can see here, the conversion between inner boxes to pallet results in different quantities.
**

To further add complexity we can add the definition mix to the element. The ordering is happening on the inner box level, but it actually contains separate products that is sold through the stores.

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SupplyStructures/5.png)

On last element is also the concept of unmarked variants. Like this package of yogurts.

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SupplyStructures/6.png)

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SupplyStructures/7.png)

# Summary EPD 

- A product is identified by a EPD number (EPDnr)
- A unit is identified by a GTIN (Global Trade Item Number)
- A unit is called «pakning» in EPD
- A product can have up to 4 levels of units (hierarchy)
- A product can be a mix of multiple «basis» or «mellom/innerbox» units
- A “basis” unit can be shared by many products
- The first level of the units is called «basis» in EPD (often referred to as a customer unit or base unit)
- The top level of the units is called «topp» in EPD (often referred to as a load carrier unit)
- The levels between «basis» and «topp» (if any) are called « mellom/innerbox/outerbox » units
- A basis unit can consist of units without identification called unmarked variants («umerkede varianter»)
- Within an EPD structure, only one of the packings is used for ordering.
- Multiple packings can be used for sale.

Some key issues we have faced with Dynamics 365 on how the industry is modelling products is the following:

1. **Cost**: As seen, a product can be sold in many different UOM’s, and we also see that the industry can have different purchase prices depending on which EPD number you choose to order. Meaning that a 4 pcs pack have a different cost than a 24 pcs pack. As the product can be purchased in multiple UOM with different prices, it is difficult to model the cost pricing correctly, because the inventory transactions will be on the lowest item. The inventory transaction costing is based on the lowest level, meaning basis. This costing problem is the reason why I suggest FIFO in retail grocery implementations.
2. **On-hand**: Keeping track of how many basis units, or other consumer units is difficult, because you do not always know with the consumer is breaking up a coca cola inner box. Where should the cost come from, when having multiple purchasing units as shown in figure. This makes it difficult in Dynamics 365 to 100% correctly model the revenue per pcs sold.
3. **Unit conversion**: As shown in the example, the same unit (like pallet) can contain different number of basis products. This means that it is insufficient to unify the UoM per product. **UoM conversion is EPD dependent**. Clear relationships between the UoM must also be modelled. A product may have multiple definitions of an inner box, outer box and pallet.
4. **External item descriptions**: Dynamics 365 external item description cannot be used, because it only supports one external item description per vendor. UoM is not taken into consideration.
5. **Attributes**: In the grocery industry, there may be different attributes per EPD number, and also different attributes per UoM.

# How to model this in Dynamics 365? 

To solve the distribution requirements, we see in the grocery industry, it is required to do some front-end remodeling of how products are represented. The grocery industry are focused on packaging and Dynamics 365 is product oriented. The key here is that **EPD is Object Oriented**, a product can be represented in several packaging structures.

The entities we have at our disposal in Dynamics 365 is the following:

1. Products and released products
2. Unit of measurement and conversion
3. Barcodes
4. External item descriptions
5. BOM’s

But Dynamics 365 is what is it, and any change on the architecture of how products and transactions are handled is not on the near roadmap. We must try to model this structure in a way, such that the EPD standard and Dynamics 365 standard is modelled to work jointly together.

First, lets try to model how the EPD(Only subset) from a grocery supply perspective(Not D365!). An EPD can consist of multiple packaging structures, and a package main contain packages. At the bottom of the packing structure there is a reference to a basic package, that describes the product.

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SupplyStructures/8.png)

 

 

When importing EPD based products I see the following as a solution:

1. EPD will be a separate entity/Table, and modelled as the grocery industry have it.(New tables in D365, the feeds the std D365 tables)

2. D365 products will be defined as the “Basic Package”

3. The EPD package structure populate the barcode table and the product specific unit of measurement table. Because there is several packaging, the traditional naming of the unit of measurement cannot be used. The unit of measurement conversion is actually dependent on the EPD number. In essence, this means having unit’s of measurement named :

   **PCS** – Basic unit for the lowest basis product
   **IB-4507224** – Unit for the inner box
   **OB-4507224** – Unit for the outer box
   **LC-4507224** – Unit for the load carrier

   With this we can create the unit of measurement conversion between the different types.

Let’s say we have the following simple product:

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SupplyStructures/9.png)

This would be modelled in D365 with a released product:

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SupplyStructures/10.png)

I would here have to define 4 unit of measurements:

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SupplyStructures/11.png)

I would then have to define the following unit conversions to describe the unit conversions between the different EPD packing structures.

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SupplyStructures/12.png)

The more EPD packing structures present, the more unit conversions needs to be defined. (In the coca cola example there will be 6 more conversions)

We also need to store GTIN per packing unit per EPD:

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SupplyStructures/13.png)

We also have the Physical dimensions menu item, that now let’s us describe the physical dimension on the product per EPD unit.

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SupplyStructures/14.png)

 

In Dynamics 365 we can only select one suggested purchasing unit. So if you have multiple EPD associated with a product you will have to choose one, and this is the unit that is suggested.

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SupplyStructures/15.png)

The purchase order would then look like this, and where the **unit** is describing the EPD number.

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SupplyStructures/16.png)

To keep track of all unit conversions, GTIN/Barcodes etc will be an impossible manual job. Since EPD is an industry standard, all of these data is imported through WEB-services.

TradeSolution have their webservices that offer the possibility to send EPD structures to D365. This way, all packing structures of products can be automatically imported, distributed into std D365 and adjusted when needed.

![img](https://nashome-image-bucket.oss-cn-shanghai.aliyuncs.com/Images/D365SupplyStructures/17.png)

The suggestion is not 100%, but it would make sure that grocery retailers can procure and sell the products, while also have the concept of packing structures in place.

Let’s conquer the grocery industry also
