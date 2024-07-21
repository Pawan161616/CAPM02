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
//since lifecycle_status is used separately on POs service then we have to mention it's label sepatately
LIFECYCLE_STATUS@title: '{i18n>LifeCycleStatus}';	
};

   