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
        BatchUtil bat=new BatchUtil();
        bat.setObject('Contact');
        bat.setcondition('where lastname like \'Contact%\'');
        bat.setBatchSize(10);
        bat.setLimit(20);
        bat.runAtUserLevel(true);
        bat.setWithSharing(true);
        bat.setAllOrNone(false);
        bat.executeBatch();
        Test.stopTest();
        System.assertEquals(10,[Select id from contact].size());
    }
    
    @isTest
    public static void executebatchWithoutSharingAtUserLevel()
    {
        System.assertEquals(20,[Select id from contact].size());
        Test.startTest();
        BatchUtil bat=new BatchUtil();
        bat.setObject('Contact');
        bat.setcondition('where lastname like \'Contact%\'');
        bat.setBatchSize(10);
        bat.setLimit(20);
        bat.runAtSystemLevel(true);
        bat.setWithoutSharing(true);
        bat.setAllOrNone(false);
        bat.executeBatch();
        Test.stopTest();
        System.assertEquals(10,[Select id from contact].size());
    }
}