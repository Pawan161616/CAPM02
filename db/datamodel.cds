namespace anubhav.db;
using { cuid, managed, temporal, Currency } from '@sap/cds/common';
using {anubhav.common} from './common';

type GUID: String(32);

context master {
     entity businesspartner {
       key NODE_KEY  :GUID;
        BP_ROLE	  : String(2);
        EMAIL_ADDRESS : String(64);	
        PHONE_NUMBER   : String(14);               	
        FAX_NUMBER     : String(14);               	
        WEB_ADDRESS    : String(64);
        ADDRESS_GUID :  Association  to address;                     	
        BP_ID     	: String(16);
        COMPANY_NAME:    String(80);                                                                
 
     }
     entity address {
        key NODE_KEY: GUID;
         CITY         :String(120);                           	
         POSTAL_CODE  :String(14);	
         STREET       :String(64);                                               	
         BUILDING  	  :String(64);
         COUNTRY	   :String(2);
         ADDRESS_TYPE  : String(2);
         VAL_START_DATE	: Date;
         VAL_END_DATE	: Date;
         LATITUDE       : Decimal;  	
         LONGITUDE       :Decimal; 
         businesspartner: Association to one businesspartner on businesspartner.ADDRESS_GUID = $self;

     }
    //  entity prodtext {
    //   key NODE_KEY  : GUID;                      	
    //   PARENT_KEY    : GUID;                    	
    //   LANGUAGE	: String(2);
    //   TEXT     : String(256); 
    //  }
     entity product {
      key NODE_KEY  : GUID;                      	
      PRODUCT_ID	: String(28);
      TYPE_CODE	: String(2);
      CATEGORY    : String(32);
      // DESC_GUID   : Association to prodtext; 
      Description: localized String(255);                             	
      SUPPLIER_GUID: Association to master.businesspartner;          	
      TAX_TARIF_CODE	: Integer;
      MEASURE_UNIT	: String(2);
      WEIGHT_MEASURE : Decimal;
      WEIGHT_UNIT	: String(2);
      CURRENCY_CODE : String(4);	
      PRICE    : Decimal;           	
      WIDTH    : Decimal;        	
      DEPTH    : Decimal;        	
      HEIGHT   : Decimal;        	
      DIM_UNIT	: String(2);

     }
     entity employees: cuid {
         nameFirst	: String(40);
         nameMiddle	: String(40);
         nameLast	 : String(40);
         nameInitials	: String(40);
         sex	: common.Gender;
         language	: String(1);
         phoneNumber	: common.PhoneNumber;
         email	       : common.Email;
         loginName	 : String(12);
         Currency	: Currency;
         salaryAmount	: common.AmountT;
         accountNumber	: String(16);
         bankId	: String(20);
         bankName : String(64);

     }
     
   annotate businesspartner with{
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
}

context transaction {
    entity purchaseorder: common.Amount  {
      key NODE_KEY : GUID;                  	
      PO_ID : String(24);    	
      PARTNER_GUID: association to master.businesspartner;      	
      LIFECYCLE_STATUS: String(1);	
      OVERALL_STATUS: String(1);
      Items: Association to many poitems on Items.PARENT_KEY = $self;
      NOTE: String(256);
    }
    entity poitems: common.Amount {
      key NODE_KEY : GUID;                      	
      PARENT_KEY : Association to purchaseorder;              	
      PO_ITEM_POS	: Integer;
      PRODUCT_GUID : Association to master.product;
    }
}

