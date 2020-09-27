public with sharing class RecordDeletionWithSharing implements Database.Batchable<sObject>{
	String query;
    Boolean allOrNone;
    public RecordDeletionWithSharing(String query,Boolean allOrNone)
    {
        this.query=query;
        this.allOrNone=allOrNone;
    }
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc,List<sObject> deletionList)
    {
        Database.delete(deletionList,allOrNone);
    }
    public void finish(Database.BatchableContext bc)
    {
        
    }
}