@isTest
public class DeleteRecordsControllerTest {

    @isTest
    public static void positiveTest()
    {
        DeleteRecordsController.DataWrapper dW=new DeleteRecordsController.DataWrapper();
        dW.objectName='Contact';
        dW.batchSize=200;
        dW.partialDelete=true;
        dW.systemLevel=true;
        dW.deleteUnshared=true;
        dW.recordLimit=200;
        DeleteRecordsController.executeDeletion(JSON.serialize(dW));
    }
    @isTest
    public static void negativeTest()
    {
        DeleteRecordsController.DataWrapper dW=new DeleteRecordsController.DataWrapper();
        dW.objectName='';
        DeleteRecordsController.executeDeletion(JSON.serialize(dW));
    }
}