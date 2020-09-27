public class BatchUtil {
    public class BatchUtilException extends Exception {}
    
    public Integer batchSize=200;
    public Integer recordLimit;
   	public String objectName;
    public String condition;
    public Boolean systemLevel=true;
    public Boolean userLevel=false;
    public Boolean withSharing=true;
    public Boolean withoutSharing=false;
    public Boolean allOrNone=false;
    
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
    
    

}