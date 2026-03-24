namespace india.db;

using { india.db.master,india.db.transaction } from './dataModels';

context CDSviews { 
    define view ![PODetails] 
    as select from transaction.purchaseorder 
    {
        key PO_ID as ![purchaseorder],
        PARTNER_GUID.BP_ID as ![VendorID],
        PARTNER_GUID.COMPANY_NAME as ![CompanyName],
        GROSS_AMOUNT as ![POGrossAmount],
        CURRENCY_CODE as ![POCurrency],
        key ITEMS.PO_ITEM_POS as ![ItemPosition],
        ITEMS.PRODUCT_GUID.PRODUCT_ID as ![ProductId],
        ITEMS.PRODUCT_GUID.DESCRIPTION as ![ProductDesc],
        PARTNER_GUID.ADDRESS_GUID.CITY as ![City],
        PARTNER_GUID.ADDRESS_GUID.COUNTRY as ![Country],
        ITEMS.GROSS_AMOUNT as ![ItemGrossAmount],
        ITEMS.NET_AMOUNT as ![ItemAmount]
    }


define view ![ItemView] as select from
transaction.poitems{
    key PARENT_KEY.PARTNER_GUID.NODE_KEY as ![Vendor],
    PRODUCT_GUID.NODE_KEY as ![ProductId],
    CURRENCY_CODE as ![Correncycode],
    NET_AMOUNT as ![NetAmount],
    TAX_AMOUNT as ![TexAmount],
    PARENT_KEY.OVERALL_STATUS as ![POStatus]
}

    //using aggregation

    define view ProductSum as
        select from master.product as prod {
            key PRODUCT_ID        as ![ProductId],
                texts.DESCRIPTION as ![Description],
                (
                    select from transaction.poitems as a {
                        SUM(a.GROSS_AMOUNT) as sum
                    }
                    where
                        a.PRODUCT_GUID.NODE_KEY = prod.NODE_KEY
                )                 as PO_SUM : Decimal(10, 2)
        }

}

