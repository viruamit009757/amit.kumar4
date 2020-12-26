({
	CallServer : function(component,method,callback,params) {
		var action = component.get(method);
        if(params){
            action.setParams(params);
        }
        action.setCallback(this, function(response) {
        var state = response.getState();
        if(state == "SUCCESS"){
            // pass returned value to callback function
           callback.call(this, response.getReturnValue());
        } else if(state == "ERROR"){
            var errors = response.getError();
            if(errors){
                console.log("Errors",errors);
                if(errors[0] && errors.message){
                    throw new Error("Error" + errors[0].message);
                } else {
                    throw new Error("unknown error");
                }
            }
          
        }
        });
        $A.enqueueAction(action);
	}
})