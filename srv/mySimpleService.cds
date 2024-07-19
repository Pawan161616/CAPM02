using {anubhav.db.master, anubhav.db.transaction} from '../db/datamodel';

service mysrvDemo @(path:'/mysrvdemo') {
    function somesrv(msg: String) returns String;


    @readonly
    entity ReadEmployeeSrv as projection on master.employees;
    @insertonly
    entity InsertEmployeeSrv as projection on master.employees;
    @updateonly
    entity updateEmployeeSrv as projection on master.employees;
    @deleteonly
    entity deleteEmployeeSrv as projection on master.employees;
}