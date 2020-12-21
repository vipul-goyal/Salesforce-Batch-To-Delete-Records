Global class BatchUtil Implements Database.batchable<sobject> {
    global final String query;
    global final String lim;
    global final String obj;
    global final String cond;
    private Integer scopeSize;
    global void setBatchSize(Integer siz){
        scopeSize = siz;
    }
    global void setObject(String o){
        obj = o;
    }
    global void setCondition(String con){
        cond = con;
    }
    global void setObject(String limi){
        lim = limi;
    }
    global BatchMassDeleteRecs(){
        
        query = 'select id,name,(select id,name from ' + obj + ' where ' + cond + ') from Account limit ' + lim;
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    global  void execute(Database.BatchableContext BC,List<SObject> scope){
        delete scope;
    }
    global void finish(Database.BatchableContext BC){
    }
    global BatchUtil() {
        query.clear(),
        lim.clear(),
        obj.clear(),
        cond.clear(),
        scopeSize{0};
    }
}
