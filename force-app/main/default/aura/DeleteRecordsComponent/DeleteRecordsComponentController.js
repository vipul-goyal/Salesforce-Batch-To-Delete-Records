({
	doInit : function(component, event, helper) {
		var initialObject=helper.getInitialObject();
        component.set('v.userSelections',initialObject);
	},
    submit : function(component, event, helper) {
        console.log('here');
        helper.submitHandler(component);
        
    }
})