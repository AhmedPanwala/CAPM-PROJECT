const cds = require('@sap/cds');
const resolve = require('@sap/cds/lib/compile/resolve');
const { INSERT } = require('@sap/cds/lib/ql/cds-ql');

module.exports = (srv) => {

    srv.on("READ", "readworker", async (req) => { 
        req.query
        return await cds.run(req.query);
    });

    //insrting data into the table
    srv.on("CREATE","insertworker", async(req,res)=>{
        let returnData = await cds.transaction(req).run([
        INSERT.into(Worker).entities([req.data])
        ]).then((resolve,reject)=>{
            if(typeof(resolve) !==undefined){
                return req.data
            }
            else{
                req.error(500, "There was an error")
            }
        }).catch(err =>{
            req.error(500,"below error occurred"+err.toString())
        })
        return returnData;
    })
};