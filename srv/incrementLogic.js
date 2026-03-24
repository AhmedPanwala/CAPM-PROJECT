
module.exports = cds.service.impl(async function () {
    const { worker } = this.entities;

    this.on('hike', async (req, res) => {
        const { ID } = req.data;    
        if (!ID) {
            return req.reject(400, 'ID is required');
        }
        console.log(`Received the request to increment the salary with worker id: ${ID}`);

        // Start new transaction
        const tx = cds.transaction(req);
        console.log(tx+"tx data");

        try {
            // Retrieve the current salary amount of the worker        
            const workers = await tx.read(worker).where({ ID: ID });
            console.log(workers + " Workers data");

            // Ensure that workers is not empty
            if (!workers || workers.length === 0) {
                await tx.rollback();
                return req.reject(404, `Worker with Id: ${ID} not found`);
            }

            // Corrected this line to access workers[0].salaryamount
            const currentSalary = workers[0].salaryamount; 
            console.log(currentSalary);

            console.log(`Current salary of the worker with ID ${ID} is ${currentSalary}`);

            // Update operation to increment the salary
            const result = await tx.update(worker)
                .set({ salaryamount: currentSalary + 20000 })
                .where({ ID: ID });
            console.log(result);

            if (result === 0) {
                await tx.rollback();
                return req.reject(500, "Failed to update the worker's salary");
            }

            // Fetch the updated worker data before committing the transaction
            const updatedWorker = await tx.read(worker).where({ ID: ID });

            // Commit the transaction after the read
            await tx.commit();
            console.log(`Updated worker with ID ${ID} retrieved successfully`);

            // Return the updated worker data
            return req.reply({ message: "Incremented", worker: updatedWorker[0] });

        } catch (error) {
            console.error("Error during hike action", error);
            try {
                await tx.rollback();
            } catch (rollbackError) {
                console.log("Rollback failed", rollbackError);
            }
            return req.reject(500, `Error: ${error.message}`);
        }
    });
});