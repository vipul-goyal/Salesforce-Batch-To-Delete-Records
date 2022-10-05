public class DeleteRecordsController {

    public class DataWrapper
    {
        @AuraEnabled
        public String objectName;
        @AuraEnabled
        public String condition;
        @AuraEnabled
        public Integer batchSize;
        @AuraEnabled
        public Integer recordLimit;
        @AuraEnabled
        public Boolean systemLevel;
        @AuraEnabled
        public Boolean deleteUnshared;
        @AuraEnabled
        public Boolean partialDelete;
    }
    
    @AuraEnabled
    public static String executeDeletion(String userInput)
    {
        try
        {
            DataWrapper dataWrapper=(DataWrapper)JSON.deserialize(userInput,DataWrapper.class);
            BatchUtil bat=new BatchUtil();
            bat.setObject(dataWrapper.objectName);
            bat.setcondition(dataWrapper.condition);
            bat.setBatchSize(dataWrapper.batchSize);
            bat.runAtSystemLevel(dataWrapper.systemLevel);
            bat.setAllOrNone(!dataWrapper.partialDelete);
            bat.setWithSharing(!dataWrapper.deleteUnshared);
            if(dataWrapper.recordLimit>0)
                bat.setLimit(dataWrapper.recordLimit);
            bat.executeBatch();
            return 'SUCCESS';
        }catch(Exception e)
        {
            return e.getMessage();
        }
    }
}