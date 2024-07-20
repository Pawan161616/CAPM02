namespace anubhav.common;

using { sap, Currency, temporal, managed } from '@sap/cds/common';


type Gender: String(1) enum{
    male='M';
    female='F';
    nonBinary='N';
    noDisclosure='D';
    selfDescribe='S';
};
//here we are creating AmountT which is having currency code and then when using it as identifier for any 
//amount field we can set it's currency code.
type AmountT : Decimal(15, 2)@(
    Semantics.amount.CurrencyCode : 'CURRENCY_CODE',
    sap.unit: 'CURRENCY_CODE'
);
//instead of 'abstract entity' you can use 'aspect' keyword 
// abstract entity Amount {
//      CURRENCY_CODE	:String(4);
//       GROSS_AMOUNT   :AmountT;     	
//       NET_AMOUNT     :AmountT;     
//       TAX_AMOUNT     :AmountT;
// };
// aspect Amount {
//      CURRENCY_CODE	:String(4);
//       GROSS_AMOUNT   :AmountT;     	
//       NET_AMOUNT     :AmountT;     
//       TAX_AMOUNT     :AmountT;
// };

type PhoneNumber : String(30)@assert.format : '^(\+0?1\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$';
type Email : String(255)@assert.format : '/^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/';