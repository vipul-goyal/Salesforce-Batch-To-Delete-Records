# Salesforce-Batch-To-Delete-Records

This library facilitates you to delete multiple records of any object through batches.

The features provided in this library are:
1)You can add conditions for record deletion

2)You are allowed to set the number of records that have to be deleted.

3)You can set the batch size as per your convenience depending on the other processes that are triggered during record deletion.

4)You can delete the records in both user and system mode. In user mode the object accessibility and CRUD permissions of the running user are checked. In system mode CRUD permissions are bypassed.

5)You also have the right to set the mode of record deletion i.e.with sharing or without sharing.

# Classes and Functions
1)BatchUtil:This class is the heart of the library.This class contains the following methods:

	>setBatchSize(Integer) :This method can be used to set the batch size [Default batch size is 200].
	
	>setObject(String) : This method can be used to set the object for record deletion.
	
	>setCondition(String) : This method is used to add conditions if any.
	
	>runAtSystemLevel(Boolean) : This method can be used to run deletion at system level [By default it is true].
	
	>runAtUserLevel(Boolean) : This method can be used to run deletion at user level [By default it is false].
	
	>setWithSharing(Boolean) : This method can be used to set deletion mode as with sharing.Only the records which are shared with user will be deleted [By default it is true].
	
	>setWithoutSharing(Boolean) : This method can be used to set deletion mode as without sharing.All the records which are present in the org will be deleted [By default it is false].
	
	>setLimit(Integer) : This is to limit the records that are being deleted.
	
	>setAllOrNone(Boolean) : This method can be used to set whether you want a partial deletion of records in every batch or not(in case of an error) [By default it is false].
	
	>executeBatch() : This function is used to execute the batch for record deletion.
	
	>checkPermissions() : This is an internal method used to check the permissions in case the batch is to be executed in user mode.
	
2)RecordDeletionWithoutSharing: This is the batch class to delete records in without sharing mode.

3)RecordDeletionWithSharing: This is the batch class to delete records in with sharing mode.

# Example
	BatchUtil bat=new BatchUtil();
	bat.setObject('Contact');
	bat.setcondition('where lastname like \'%con%\'');
	bat.setBatchSize(10);
	bat.runAtUserLevel(true);
	bat.executeBatch();

#Please raise any concerns or issue that you may face during the use of the functionalities.

#Developer : Vipul Goyal (Email: vipul.gyl12@gmail.com)
