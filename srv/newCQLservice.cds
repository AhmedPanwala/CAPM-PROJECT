using { india.db.master.worker } from '../db/dataModels';

service NewCQLService {
    entity readworker as projection on worker;

    @insertonly
    entity insertworker as projection on worker;
}

