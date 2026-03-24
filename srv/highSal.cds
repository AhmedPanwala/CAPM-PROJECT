using { india.db.master } from '../db/dataModels';
service highSal @(impl:'srv/highSal.js') {
    entity highSalary as projection on master.worker;
    function getHighestSalary() returns Decimal(15,2);
}