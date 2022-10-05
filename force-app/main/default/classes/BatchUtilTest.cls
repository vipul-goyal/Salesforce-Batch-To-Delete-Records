@isTest
public class BatchUtilTest {

    @testSetup
    public static void setupData(){
        List<Contact> contactList=new List<Contact>();
        for(Integer i=0;i<10;i++)
        {
            contactList.add(new Contact(lastname='Contact'+i));
            contactList.add(new Contact(lastname='Save'+i));
        }
        insert contactList; 	
    }
    
    @isTest
    public static void executebatchWithSharingAtUserLevel()
    {
        System.assertEquals(20,[Select id from contact].size());
        Test.startTest();
        BatchUtil bat=assignValues('Contact','where lastname like \'Contact%\'',10,20,true,true,false);
        bat.executeBatch();
        Test.stopTest();
        System.assertEquals(10,[Select id from contact].size());
    }
    
    @isTest
    public static void executebatchWithoutSharingAtUserLevel()
    {
        System.assertEquals(20,[Select id from contact].size());
        Test.startTest();
        BatchUtil bat=assignValues('Contact','where lastname like \'Contact%\'',10,20,true,false,false);
        bat.executeBatch();
        Test.stopTest();
        System.assertEquals(10,[Select id from contact].size());
    }

    public static BatchUtil assignValues(String obj,String condition,Integer batchSize,Integer lim,Boolean runLeveL,Boolean sharing,Boolean deletionMode)
    {
        BatchUtil bat=new BatchUtil();
        bat.setObject(obj);
        bat.setcondition(condition);
        bat.setBatchSize(batchSize);
        bat.setLimit(lim);
        bat.runAtSystemLevel(runLeveL);
        bat.runAtUserLevel(!runLevel);
        bat.setWithoutSharing(!sharing);
        bat.setWithSharing(sharing);
        bat.setAllOrNone(deletionMode);
        return bat;
    }
}