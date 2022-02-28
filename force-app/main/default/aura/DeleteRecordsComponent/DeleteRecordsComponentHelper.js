({
	getInitialObject : function() 
    {
        var initialObj={
            batchSize: 200,
            recordLimit: 200,
            objectName : '',
            condition : '',
            systemLevel : false,
            deleteUnshared : false,
            partialDelete : true
        };
        return initialObj;
	},
    submitHandler : function(component)
    {
        
        var userSelections=component.get('v.userSelections');
        if(this.isFieldBlank(userSelections.objectName))
        {
            this.showToast('Error','Please provide an Object Name','error');
            return;   
        }
        if(this.isFieldBlank(userSelections.batchSize))
        {
            this.showToast('Error','Batch Size cannot be blank','error');
            return;
        }
        if(userSelections.batchSize>2000 || userSelections.batchSize<1)
        {
            this.showToast('Error','Batch size should be between 1 and 2000','error');
            return;
        }
        if(userSelections.recordLimit==null || userSelections.recordLimit=='')
            userSelections.recordLimit=0;
        var action=component.get('c.executeDeletion');
        action.setParam('userInput',JSON.stringify(component.get('v.userSelections')));
        action.setCallback(this,function(response){
            if(response.getState()=="SUCCESS")
            {
                var resp=response.getReturnValue();
                if(resp=="SUCCESS")
                {
                    this.showToast('Initiated','The Deletion of records has been initiated','success');
                }
                else
                {
                    this.showToast('Error',resp,'error');
                }
            }
        });
        $A.enqueueAction(action);
    },
    isFieldBlank:function(val)
    {
        if($A.util.isUndefinedOrNull(val))
            return true;
        if($A.util.isEmpty(val))
            return true;
        return false;
        
    },
    showToast : function(title,message,type) 
    {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "message": message,
            "type" : type
        });
        toastEvent.fire();
    }
})
