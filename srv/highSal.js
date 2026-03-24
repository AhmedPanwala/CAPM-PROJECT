const cds = require('@sap/cds');
const { SELECT } = cds.ql;

module.exports = cds.service.impl(async function () {
    this.on("getHighestSalary", async () => {
        try {
            const {worker} = cds.entities('india.db.master'); // Getting the worker entity
            
            // Running the query to get the highest salary
            const highestSalaryWorker = await cds.run(
                SELECT.one.from(worker)
                    .columns('salaryamount as highestSalary') //  column selection
                    .orderBy('salaryamount DESC') // Ordering by salary amount descending
            );
            // Check if the result is valid and return the highest salary
            if (highestSalaryWorker) {
                console.log(highestSalaryWorker);
                
                return highestSalaryWorker.highestSalary;
            } else {
                console.log("else block");
                return null;
            }

        } catch (error) {
            console.log("Error to fetch highest salary", error);
            return null;
        }
    });
});