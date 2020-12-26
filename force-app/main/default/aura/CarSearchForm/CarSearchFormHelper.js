({
	handleonSearchclick : function(component, event, helper) {
		alert("search click button was pressed")
    },
    getCarType : function(component, event, helper) {
	/*	var action = component.get("c.getCarTypes"); 
        action.setCallback(this, function(data) {
        var state = data.getState();
        if(tate == "SUCCESS"){
            component.set("v.CarTypes", data.getReturnValue());
        } else if(state == "ERROR"){
            alert("unknown error");
        }
        });
        $A.enqueueAction(action);
    } */
    helper.CallServer(component, "c.getCarTypes", 
                    function(response){
                         component.set("v.CarTypes",response)
       });
    }
})