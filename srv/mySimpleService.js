const cds = require("@sap/cds");
//this method didn't work for me as instructed by anubhav as employees is not used here but
//ReadEmployeeSrv is used which is not available in cds.entities("anubhav.db.master")
const {employees} = cds.entities("anubhav.db.master");

const mysrvDemo = function(srv){
    
    const{ReadEmployeeSrv} = this.entities;
    srv.on("somesrv",(req,res)=>{
       return "hey + req.data.msg"
    });

    srv.on("READ",ReadEmployeeSrv,async (req,res)=>{
        var results = [];
        // result.push({
        //     "ID": "02BD2137-0890-1EEA-A6C2-BB55C19787FB",
        //     "nameFirst": "Pawan",
        //     "nameMiddle": "kumar",
        //     "nameLast": "Khantwal",
        // });
        //CDS Query language
        // results = await cds.tx(req).run(SELECT.from(employees).limit(3));
        //CDS Query language to read single record with where
        // results = await cds.tx(req).run(SELECT.from(employees).where({"nameFirst":"Susan"}));
        results = await cds.tx().run(SELECT.from(employees).where({"nameFirst":"Susan"}));
        return results;
    });

    
    srv.on("CREATE","InsertEmployeeSrv", async(req,res)=>{
        // cds.transaction() is depricated
        // let returnData = cds.transaction().run([
        //     INSERT.into(employees).entries([req.data])
        // ]).then((resolve,reject)=>{
        //     if(typeof(resolve) !== undefined){
        //         return req.data;
        //     }else{
        //         req.error(500,"There is an issue with Insert");
        //     }
        // }).catch(err =>{
        //     req.error(500,"there was an error " + err);
        // })

        // using cds.tx() now
         let returnData = await cds.tx(async (srv) => {
            try {
                await srv.run(INSERT.into(employees).entries([req.data]));
                return req.data;
            } catch (err) {
                req.error(500, err.message)
            }
        });
        return returnData;
    });

    srv.on("UPDATE","updateEmployeeSrv", async(req,res)=>{
        let updateData = await cds.transaction().run([
            UPDATE(employees).set({
                nameFirst: req.data.nameFirst
            }).where({ID :  req.data.ID}),
            UPDATE(employees).set({
                nameLast: req.data.nameLast
            }).where({ID: req.data.ID})
        ]).then((resolve,reject)=>{
            if(typeof(resolve !== undefined)){
                return req.data;
            }else{
                req.error(500,"There was an issue in update");
            }
        }).catch((err)=>{
            req.error(500,"there is an issue in update:" + err.toString());
        })

        return updateData;
    });

    srv.on("DELETE","deleteEmployeeSrv", async(req,res)=>{
        // let returnData = await cds.transaction().run([
            
        //     DELETE.from(employees).where(req.data)
        // ]).then((resolve,reject)=>{
        //     if(typeof(resolve) !== undefined){
        //         return req.data;
        //     }else{
        //         req.error(500,"error in deletion");
        //     }
        // }).catch((err)=>{
        //     req.error(500,"there is error:" + err.toString());
        // });

          let returnData = await cds.tx(async (srv) => {
            try {
                await srv.run(DELETE.from(employees).where({ ID: req.data.ID }))
                return req.data;
            } catch (err) {
                req.error(500, err.message);
            }
        });
        return returnData;
    })
}

module.exports = mysrvDemo;
