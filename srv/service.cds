using { india.db.master, india.db.transaction } from '../db/dataModels';

service CatalogService {
    entity businesspartner as projection on master.businesspartner;
    entity address as projection on master.address;
    entity product as projection on master.product;
    entity purchase_order as projection on transaction.purchaseorder;
    entity poitem as projection on transaction.poitems;
    @readonly
    entity worker as projection on master.worker;
}

//Annotations to restrict the service
//1. You can do perform only get req ->     @readonly

//2.
annotate CatalogService.businesspartner with @(
    Capabilities:{
        InsertRestrictions : {Insertable},
    }
);

