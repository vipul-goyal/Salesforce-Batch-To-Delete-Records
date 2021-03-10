@isTest
public class DeleteRecordsControllerTest {

    @isTest
    public static void test1()
    {
        DeleteRecordsController.DataWrapper dW=new DeleteRecordsController.DataWrapper();
        dW.objectName='Contact';
        dW.batchSize=200;
        dW.partialDelete=true;
        dW.systemLevel=true;
        dW.deleteUnshared=true;
        DeleteRecordsController.executeDeletion(JSON.serialize(dW));
    }
}