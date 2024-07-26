using {anubhav.db.master, anubhav.db.transaction} from '../db/datamodel';
using {Catalogservice} from '../srv/CatalogService';
using from './purchaseorders/annotations';

annotate master.businesspartner with{
     NODE_KEY @title : '{i18n>bp_key}';
     BP_ROLE @title : '{i18n>bp_role}';
     EMAIL_ADDRESS @title : '{i18n>emailAddress}';
     PHONE_NUMBER @title : '{i18n>PHONE_NUMBER}';
     FAX_NUMBER @title : '{i18n>Fax_Nr}';
     WEB_ADDRESS @title : '{i18n>WebAddr}';
     ADDRESS_GUID @title : '{i18n>AddrGuid}';
     BP_ID @title : '{i18n>BpId}';
     COMPANY_NAME @title : '{i18n>CompanyName}';
   };

annotate master.product with {
     PRODUCT_ID@title : '{i18n>PRODUCT_ID}';	
    TYPE_CODE@title : '{i18n>TYPE_CODE}'	;
    CATEGORY @title : '{i18n>CATEGORY}' ; 
    Description@title : '{i18n>Description}' ;          	
    TAX_TARIF_CODE@title : '{i18n>TAX_TARIF_CODE}';
    MEASURE_UNIT	@title : '{i18n>MEASURE_UNIT}';
    WEIGHT_MEASURE @title : '{i18n>WEIGHT_MEASURE}';
    WEIGHT_UNIT	@title : '{i18n>WEIGHT_UNIT}';
    CURRENCY_CODE @title : '{i18n>CURRENCY_CODE}';
    PRICE       @title : '{i18n>PRICE}';	
    WIDTH     	@title : '{i18n>WIDTH}';
    DEPTH       @title : '{i18n>DEPTH}'	;
    HEIGHT     	@title : '{i18n>HEIGHT}';
    DIM_UNIT	@title : '{i18n>DIM_UNIT}';
};

annotate transaction.purchaseorder with{
    PARTNER_GUID@title : '{i18n>bp_key}';
     CURRENCY_CODE@title : '{i18n>CurrCode}';
      GROSS_AMOUNT@title : '{i18n>GrossAmt}';     	
      NET_AMOUNT  @title : '{i18n>NetAmt}';     
      TAX_AMOUNT  @title : '{i18n>TaxAmt}';             	
      PO_ID @title:   	      '{i18n>PoId}';
      LIFECYCLE_STATUS@title: '{i18n>LifeCycleStatus}';	
      OVERALL_STATUS@title:'{i18n>OverAllStatus}';
      NOTE@title: '{i18n>Note}';
} ;

annotate Catalogservice.POs with {
//since lifecycle_status is used separately in POs service then we have to mention it's label sepatately
LIFECYCLE_STATUS@title: '{i18n>LifeCycleStatus}';	
};

annotate transaction.poitems with {                     	
      PARENT_KEY@title : '{i18n>PARENT_KEY}';           	
      PO_ITEM_POS@title : '{i18n>PO_ITEM_POS}';	
      PRODUCT_GUID@title : '{i18n>PRODUCT_GUID}';
      CURRENCY_CODE@title : '{i18n>CurrCode}';
      GROSS_AMOUNT@title : '{i18n>GrossAmt}';     	
      NET_AMOUNT  @title : '{i18n>NetAmt}';     
      TAX_AMOUNT  @title : '{i18n>TaxAmt}'; 
};
annotate Catalogservice.POItems with {           	
      PARENT_KEY@title : '{i18n>PARENT_KEY}';  
      PRODUCT_GUID@title : '{i18n>PRODUCT_GUID}';
  
};   