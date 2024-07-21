using { Catalogservice } from '../../srv/CatalogService';

//First screen with search field and cloumns
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
                Value: CURRENCY_CODE
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
                Label: 'PO General Information',
                Target: ![@UI.FieldGroup#HeaderGeneralInformation]
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
                    Value: CURRENCY_CODE
                },{
                    $Type: 'UI.DataField',
                    Value: LIFECYCLE_STATUS
                }
            ]
            
        },
    }
);
