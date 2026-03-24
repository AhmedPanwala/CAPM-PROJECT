namespace india.db;

using {
    cuid,
    managed
} from '@sap/cds/common';
using {
    india.customAspects.Gender      as gender,
    india.customAspects.email       as email,
    india.customAspects.phonenumber as phno
} from './customAspects';
using {india.customAspects.amount as amount} from './customAspects';


context master {
    entity worker : cuid, managed {
        firstName    : String(20);
        lastname     : String(20);
        gender       : gender @assert.range: [
            'M',
            'F',
            'O'
        ];
        phonenumber  : phno;
        email        : email;
        currency     : String(3);
        salaryamount : Decimal(15, 2)
    }


    entity businesspartner : managed {
        key NODE_KEY      : String(50)
            @title: '{i18n>bp_key}';
            BP_ROLE       : String(2)
            @title: '{i18n>bp_role}';
            EMAIL_ADDRESS : String(105)
            @title: '{i18n>email_address}';
            PHONE_NUMBER  : String(32)
            @title: '{i18n>phone_number}';
            FAX_NUMBER    : String(32)
            @title: '{i18n>fax_number}';
            WEB_ADDRESS   : String(44)
            @title: '{i18n>web_address}';
            ADDRESS_GUID  : Association to one address;
            BP_ID         : String(16)
            @title: '{i18n>bp_id}';
            COMPANY_NAME  : String(250)
            @title: '{i18n>company_name}';
    }

    entity address {
        key NODE_KEY       : String(50);
            CITY           : String(40);
            POSTAL_CODE    : String(8);
            STREET         : String(100);
            BUILDING       : String(100);
            COUNTRY        : String(40);
            ADDRESS_TYPE   : String(44);
            VAL_START_DATE : Date;
            VAL_END_DATE   : Date;
            LATITUDE       : Decimal;
            LONGITUDE      : Decimal;
            buinesspartner : Association to one businesspartner
                                 on buinesspartner.ADDRESS_GUID = $self
    }

    entity product {
        key NODE_KEY       : String(50);
            PRODUCT_ID     : String(28);
            TYPE_CODE      : String(2);
            CATEGORY       : String(32);
            DESCRIPTION    : localized String(255);
            SUPPLIER_GUID  : Association to one businesspartner;
            TAX_TARIF_CODE : Integer;
            MEASURE_UNIT   : String(2);
            WEIGHT_MEASURE : Decimal;
            WEIGHT_UNIT    : String(2);
            CURRENCY_CODE  : String(4);
            PRICE          : Decimal;
            WIDTH          : Decimal;
            DEPTH          : Decimal;
            HEIGHT         : Decimal;
            DIM_UNIT       : String(2);
    }
}

context transaction {
    entity purchaseorder : amount {
        key NODE_KEY         : String(50);
            PO_ID            : String(24);
            PARTNER_GUID     : Association to one master.businesspartner;
            LIFECYCLE_STATUS : String(1);
            OVERALL_STATUS   : String(1);
            ITEMS            : Association to many poitems
                                   on ITEMS.PARENT_KEY = $self;
    }

    entity poitems : amount {
        key NODE_KEY     : String(50);
            PARENT_KEY   : Association to one purchaseorder;
            PO_ITEM_POS  : Integer;
            PRODUCT_GUID : Association to one master.product;
    }
}
