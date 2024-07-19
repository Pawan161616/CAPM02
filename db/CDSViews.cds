namespace anubhav.db;

using { anubhav.db.master, anubhav.db.transaction } from './datamodel';

context CDSViews {
    define view![POWorklist] as 
      select from transaction.purchaseorder {
    key PO_ID as ![PurchaseOrderId],
        PARTNER_GUID.BP_ID as ![PartnerId],
        PARTNER_GUID.COMPANY_NAME as ![CompanyName],
        GROSS_AMOUNT as ![POGrossAmount],
        CURRENCY_CODE as ![POCurrencyCode],
        LIFECYCLE_STATUS as ![POStatus],
    key Items.PO_ITEM_POS as ![ItemPosition],
        Items.PRODUCT_GUID.PRODUCT_ID as ![ProductId],
        Items.PRODUCT_GUID.Description as ![ProductName],
        PARTNER_GUID.ADDRESS_GUID.COUNTRY as ![Country],
        Items.NET_AMOUNT as ![NetAmount],
        Items.TAX_AMOUNT as ![TaxAmount],
        Items.GROSS_AMOUNT as ![GrossAmount],

      };


      define view ProductValueHelp as
      select from master.product {
        @EndUserText.label: [
          {
            language: 'EN',
            text: 'Product ID'
          },{
            language:'DE',
            text: 'Produkt ID'
          }
        ]
        PRODUCT_ID as ![ProductId],
        @EndUserText.label:[
          {
            language:'EN',
            text:'Discription'
          },{
            language:'DE',
            text:'Beschreibung'
          }
        ]
        Description as ![Description]
      };

      define  view ![ItemView] as 
      select from transaction.poitems{
        PARENT_KEY.PARTNER_GUID.NODE_KEY as ![Partner],
        PRODUCT_GUID.NODE_KEY as ![ProductId],
        CURRENCY_CODE as ![CurrencyCode],
        GROSS_AMOUNT as ![GrossAmount],
        NET_AMOUNT as ![NetAmount],
        TAX_AMOUNT as ![TaxAmount],
        PARENT_KEY.OVERALL_STATUS as ![POStatus]
      };

      define view ProductViewSub as
      select from master.product as prod{
    key PRODUCT_ID as ![ProductId],
        Description as ![Description],
        (
          select from transaction.poitems as a{
             SUM(GROSS_AMOUNT) as SUM
          }where a.PRODUCT_GUID.NODE_KEY = prod.NODE_KEY
          
        )as PO_SUM :Decimal
      };

      //Exposed association view - create a view which will 
      // have selection of primary records and then dependent records can be exposed as association

      define view ProductView as select from master.product
      mixin{
          PO_ORDERS: Association[*] to ItemView on
                           PO_ORDERS.ProductId = $projection.ProductId //$projection here will reference to ProductId mentioned in 'into' section.
      }into{
        //below are fields from master.product table
          NODE_KEY as ![ProductId],
          Description,
          CATEGORY as ![Category],
          PRICE as ![Price],
          TYPE_CODE as ![TypeCode],
          SUPPLIER_GUID.BP_ID as ![BPId],
          SUPPLIER_GUID.COMPANY_NAME as ![CompanyName],
          SUPPLIER_GUID.ADDRESS_GUID.CITY as ![City],
          SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as ![Country],
          //Exposed Association, which means when someone read the view 
          //the data for orders wont be read by default
          //until unless someone consume the association
          PO_ORDERS
      };
      define view CProductValueView as 
           select from ProductView{
            ProductId,
            Country,
            PO_ORDERS.CurrencyCode as ![CurrencyCode],
            sum(PO_ORDERS.GrossAmount) as ![POGrossAmount]: Decimal
           }
           group by ProductId,Country,PO_ORDERS.CurrencyCode
}
