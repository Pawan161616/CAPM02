using { anubhav.db.master, anubhav.db.transaction } from '../db/datamodel';

service Catalogservice@(path:'/CatalogService') {
    //below annotation will control crud operations in employeeset
   @Capabilities : {Insertable,Updatable,Deletable: false}
    entity EmployeeSet as projection on master.employees;
    entity AddressSet as projection on master.address;
    entity PurchaseOrderSet as projection on transaction.purchaseorder;
    entity ProductSet as projection on master.product;
    //BPSet will be readonly due to below annotation
    entity BPSet as projection on master.businesspartner;
//Below code is for association, but it's not needed ,we can directly use association with $expand on above entities.
    entity POs @(
        title: '{i18n>poHeader}'
    ) as projection on transaction.purchaseorder{
        *,
        //another way of showing gross_amount in POs cds view,
        //earlier GROSS_AMOUNT would be seen from transaction.purchaseorder but now it will be overwritted by below line.
        round(GROSS_AMOUNT, 2) as GROSS_AMOUNT: Decimal(15, 2),
        // below case statement replaces single character value of LIFECYCLE_STATUS to text
        case LIFECYCLE_STATUS
            when 'N' then 'New'
            when 'D' then 'Delivered'
            when 'B' then 'Blocked'
        end as LIFECYCLE_STATUS: String(20),
        //earlier LIFECYCLE_STATUS would be seen from transaction.purchaseorder but now it will be overwritted by below line.
        // below case statement add criticallity to LIFECYCLE_STATUS values
        //if you wish to see below switch case changes to UI, then add annotation to annotation.cds
        case LIFECYCLE_STATUS
            when 'N' then 2
            when 'B' then 1
            when 'D' then 3
        end as Critically: Integer,
        Items: redirected to POItems
    }actions{
        //actions are entity specific ie. only for POs and have to pass a perticular Purchase order 
        //all the actions and functions are triggered only when primary key is passed as parameter to them
        //function is only for reading the data and in actions we can do create,update,delete operations b
        function largestOrder() returns array of POs;
        action boost();
    };
     entity POItems @(
        title: '{i18n>POItems}'
     ) as projection on transaction.poitems{
        *,
        PARENT_KEY: redirected to POs,
        PRODUCT_GUID: redirected to ProductSet
     }

}
