using { india.db.master } from '../db/dataModels';

service increment {
    entity worker as projection on master.worker;
    action hike(ID:UUID)
}