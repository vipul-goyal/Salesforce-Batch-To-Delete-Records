public class BatchUtil {
    public class BatchUtilException extends Exception {}
    
    private Integer batchSize=200;
    private Integer recordLimit;
   	private String objectName;
    private String condition;
    private Boolean systemLevel=true;
    private Boolean userLevel=false;
    private Boolean withSharing=true;
    private Boolean withoutSharing=false;
    private Boolean allOrNone=false;
    
    public void setBatchSize(Integer batchSize)
    {
        this.batchSize=batchSize;
    }
    public void setObject(String objectName)
    {
        this.objectName=objectName;
    }
    public void setCondition(String condition)
    {
        this.condition=condition;
    }
    public void runAtSystemLevel(Boolean param)
    {
        systemLevel=param;
        if(!param)
            userLevel=true;
        else
            userLevel=false;
    }
    public void runAtUserLevel(Boolean param)
    {
        userLevel=param;
        if(!param)
            systemLevel=true;
        else
            systemLevel=false;
    }
    public void setWithSharing(Boolean param)
    {
        withSharing=param;
        if(!param)
            withoutSharing=true;
        else
            withoutSharing=false;
    }
    public void setWithoutSharing(Boolean param)
    {
        withoutSharing=param;
        if(!param)
            withSharing=true;
        else
            withSharing=false;
    }
    public void setLimit(Integer recordLimit)
    {
        this.recordLimit=recordLimit;
    }
    public void setAllOrNone(Boolean allOrNone)
    {
        this.allOrNone=allOrNone;
    }
    public void executeBatch()
    {
        String query='Select id from ';
        if(String.isBlank(objectName))
        {
            throw new BatchUtilException('Object API name is missing.Please provide the object name for record deletion.');
        }
        else
        {
            if(Schema.getGlobalDescribe().get(objectName.toLowerCase())==null)
                throw new BatchUtilException('Object not found.Please make sure that you are providing the correct API name.');
            query+=objectName;
        }
        if(String.isNotBlank(condition))
           query+=' '+condition;  
        if(recordLimit!=null)
           query+=' LIMIT '+ recordLimit;
        if(userLevel)
        {
            if(!this.checkPermissions())
            {
                throw new BatchUtilException('User does not have sufficient permissions.');
            }
        }
        if(withSharing)
            Database.executeBatch(new RecordDeletionWithSharing(query,allOrNone),batchSize);
        if(withoutSharing)
            Database.executeBatch(new RecordDeletionWithoutSharing(query,allOrNone),batchSize);            
    }
    
    private Boolean checkPermissions()
    {
        if(Schema.getGlobalDescribe().get(objectName.toLowerCase()).getDescribe().isAccessible())
        {
            if(Schema.getGlobalDescribe().get(objectName.toLowerCase()).getDescribe().isDeletable())
                return true;
            else
                return false;
        }
        else
            return false;
    }
    
    public static void emailService()
    {
        String emailId=UserInfo.getUserEmail();
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        mail.setToAddresses(new List<String>{emailId});
        mail.setSubject('Deletion of records completed');
        String body='<html><body><p><b>Hi '+UserInfo.getName()+'</b>,<br/><br/>The record deletion is Completed.<br/><br/>Thanks,<br/>System Admin(Salesforce)</p></body></html>';
        mail.setHtmlBody(body);
        if(!Test.isRunningTest())
            Messaging.sendEmail(new List<Messaging.Email>{mail});
    }

}