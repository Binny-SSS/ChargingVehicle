({
	 getButtonValue:function(component,event,helper){
        var checkCmp = component.find("chkbox").get("v.value");
        component.set("v.chkboxvalue",checkCmp);
        console.log(checkCmp);
        if(checkCmp == true){
            var action=component.get('c.createChargeRecord');
            var recordId = component.get('v.recordId');
            action.setParams({ recordId :recordId });
            action.setCallback(this, function(response) {
            var state = response.getState();
            
            if (state === "SUCCESS") {
            }
        });
          
        $A.enqueueAction(action)
        }
        else if(checkCmp == false){
            var action=component.get('c.updateEndTime');
            var recordId = component.get('v.recordId');
            action.setParams({ recordId :recordId });
            action.setCallback(this, function(response) {
            var state = response.getState();
            
            if (state === "SUCCESS") {
            }
        });
         
        $A.enqueueAction(action)
        }
    },
})