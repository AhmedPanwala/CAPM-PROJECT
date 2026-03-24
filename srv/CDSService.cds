using { india.db.CDSviews} from '../db/CDSviews';

service CDSViewsSrv @(path:'CDSViewsSrv') {
    entity PODetails as projection on CDSviews.PODetails;
    entity ItemView as projection on CDSviews.ItemView;
    entity ProductSum as projection on CDSviews.ProductSum;
}
