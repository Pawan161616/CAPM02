using { Catalogservice } from '../../srv/CatalogService';

//cds.odata.valuelist will create F4 help in business Partner field with only company_name and primary Key of businesspartner
annotate Catalogservice.BPSet with @(
    UI.Identification:[COMPANY_NAME],
    cds.odata.valuelist
);

//Changing business partner set with above annotations will also change company name with selected entry from business partner if we apply below annotation.
//making COMPANY_NAME as common text with annotation applied on association(ie PARTNER_GUID)
annotate Catalogservice.POs with {
    PARTNER_GUID @(
        Common:{
            Text: PARTNER_GUID.COMPANY_NAME
        },
        //below line will decide from where the value help records will be seen
        ValueList.entity: CatalogService.BPset
    )
};
annotate Catalogservice.POItems with {
    PRODUCT_GUID@(
        Common:{
            Text:PRODUCT_GUID.NODE_KEY
        },
        // ValueList.entity: Catalogservice.ProductSet
        ValueList.entity: Catalogservice.Description
    )
};
@cds.odata.valuelist
annotate Catalogservice.ProductSet with @(
    UI.Identification:[{
        $Type:'UI.DataField',
        // Value: NODE_KEY
        Value: Description
    }]
);
annotate Catalogservice.POs with @(
    UI: {
        //anothation for filters
        SelectionFields: [
            PO_ID,
            GROSS_AMOUNT,
            LIFECYCLE_STATUS,
            CURRENCY_CODE
        ],
        //anotations for table columns and navigation enabled in table.
        LineItem  : [
            {
                $Type: 'UI.DataField',
                Value: PO_ID
            },{
                $Type: 'UI.DataField',
                Value: GROSS_AMOUNT
            },{
                $Type: 'UI.DataFieldForAction',
                Label : 'Boost',
                Action: 'Catalogservice.boost',
                //Below property shows boost button for each record in table after Gross_amount
                //if inline is set to false then button is shown once only in toolbar section of table
                Inline : true
            },{
                $Type: 'UI.DataField',
                Value: CURRENCY_CODE.code
            },{
                $Type: 'UI.DataField',
                Value: PARTNER_GUID.COMPANY_NAME
            },{
                $Type: 'UI.DataField',
                Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY
            },{
                $Type: 'UI.DataField',
                Value: TAX_AMOUNT
            },{
                $Type: 'UI.DataField',
                Value: LIFECYCLE_STATUS,
                //responsible for color and icon change as per critical status of value
                Criticality: Critically,
                CriticalityRepresentation: #WithIcon
            }
        ],
        //HeaderInfo is for displaying header description in detail page. 
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Purchase Order',
            TypeNamePlural : 'Purchase Orders',
            Title: {
                Label: 'Order Id',
                Value: PO_ID
            },
            Description:{
                Label: 'Company Name',
                Value: PARTNER_GUID.COMPANY_NAME
            }
        },
        Facets  : [
            {
                $Type: 'UI.ReferenceFacet',
                Label: 'Purchase Order Header Details',
                Target: ![@UI.FieldGroup#HeaderGeneralInformation]
            },{
                $Type: 'UI.ReferenceFacet',
                Label: 'Line Items',
                Target: 'Items/@UI.LineItem'
            }
        ],
        FieldGroup#HeaderGeneralInformation : {
            $Type : 'UI.FieldGroupType',
            Data: [
                {
                    $Type: 'UI.DataField',
                    Value: PO_ID
                },{
                    $Type: 'UI.DataField',
                    // PARTNER_GUID is association , so when we want to label that field we...
                    // ...use column name we gave in csv file
                    Value: PARTNER_GUID_NODE_KEY
                },{
                    $Type: 'UI.DataField',
                    Value: PARTNER_GUID.COMPANY_NAME
                },{
                    $Type: 'UI.DataField',
                    Value: PARTNER_GUID.BP_ID
                },{
                    $Type: 'UI.DataField',
                    Value: GROSS_AMOUNT
                },{
                    $Type: 'UI.DataField',
                    Value: TAX_AMOUNT
                },{
                    $Type: 'UI.DataField',
                    Value: NET_AMOUNT
                },{
                    $Type: 'UI.DataField',
                    Value: CURRENCY_CODE.code
                },{
                    $Type: 'UI.DataField',
                    Value: LIFECYCLE_STATUS
                }
            ]
            
        },
    }
);

annotate Catalogservice.POItems with @(
    UI:{
        LineItem  : [
            {
                $Type:'UI.DataField',
                Value: PO_ITEM_POS
            },{
                $Type:'UI.DataField',
                Value: PRODUCT_GUID_NODE_KEY
            },{
                $Type:'UI.DataField',
                Value: PRODUCT_GUID.PRODUCT_ID
            },{
                $Type:'UI.DataField',
                Value: GROSS_AMOUNT
            },{
                $Type:'UI.DataField',
                Value: TAX_AMOUNT
            },{
                $Type:'UI.DataField',
                Value: NET_AMOUNT
            },{
                $Type:'UI.DataField',
                Value: CURRENCY_CODE.code
            }
        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'PO Item',
            TypeNamePlural : 'PO Item',
            Title:{
                $Type:'UI.DataField',
                Value: NODE_KEY
            },
            Description: {
                $Type:'UI.DataField',
                Value: PO_ITEM_POS
            },
            ImageUrl: 'https://1000logos.net/wp-content/uploads/2022/06/Demon-Slayer-Logo.png'
        },
        Facets  : [
            {
                $Type:'UI.ReferenceFacet',
                Label: 'Line Item Header',
                Target: '@UI.FieldGroup#LineItemHeader'
            },{
                Label:'Product Detail',
                $Type: 'UI.ReferenceFacet',
                Target:'PRODUCT_GUID/@UI.FieldGroup#ProductDetail'
            }
        ],
        FieldGroup#LineItemHeader  : {
            $Type : 'UI.FieldGroupType',
            Data :[
                {
                    $Type:'UI.DataField',
                    Value: PO_ITEM_POS
                },
                {
                    $Type:'UI.DataField',
                    Value: PRODUCT_GUID_NODE_KEY
                },{
                    $Type:'UI.DataField',
                    Value: GROSS_AMOUNT
                },{
                    $Type:'UI.DataField',
                    Value: TAX_AMOUNT
                },{
                    $Type:'UI.DataField',
                    Value: NET_AMOUNT
                },{
                    $Type:'UI.DataField',
                    Value: CURRENCY_CODE.code
                },
            ]
            
        },

    }
);
annotate Catalogservice.ProductSet with @(
  UI:{
    FieldGroup#ProductDetail  : {
        $Type : 'UI.FieldGroupType',
        Data:[
            {
                $Type:'UI.DataField',
                Value: PRODUCT_ID
            },{
                $Type:'UI.DataField',
                Value: Description
            },{
                $Type:'UI.DataField',
                Value: TYPE_CODE
            },{
                $Type:'UI.DataField',
                Value:CATEGORY
            },{
                $Type:'UI.DataField',
                Value:SUPPLIER_GUID.COMPANY_NAME
            }
        ]
        
    },
  }
);

