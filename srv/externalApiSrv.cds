using { india.db as db}from '../db/dataModel';

service ExternalApiService {
    entity ExternalData as projection on db.ExternalData;
}
