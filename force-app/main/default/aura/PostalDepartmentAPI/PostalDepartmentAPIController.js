({

    invokePostalAPI : function(component, event, helper) {

        component.set('v.postalColumns',[

            {label:'Name',fieldName:'Name',type:'text'},

            {label:'Description',fieldName:'Description',type:'text'},

            {label:'PINCode',fieldName:'PINCode',type:'text'},

            {label:'BranchType',fieldName:'BranchType',type:'text'},

            {label:'DeliveryStatus',fieldName:'DeliveryStatus',type:'text'},

            {label:'Circle',fieldName:'Circle',type:'text'},

            {label:'District',fieldName:'District',type:'text'},

            {label:'Division',fieldName:'Division',type:'text'},

            {label:'Region',fieldName:'Region',type:'text'},

            {label:'State',fieldName:'State',type:'text'},

            {label:'Country',fieldName:'Country',type:'text'}

        ]);

        var action;

        var pincode = component.get('v.searchPin');

        var branchName = component.get('v.searchBranch');

        if(pincode){

        action =  component.get("c.postOfficeByPincode");

            action.setParams({

                "pincode":pincode

            });

           

        }

        else if(branchName){

            action =  component.get("c.postOfficeByBranchName"); 

             action.setParams({

                "branchName":branchName

            });

        }

        action.setCallback(this,function(response){

            var state = response.getState();

            if(state === "SUCCESS"){

            component.set("v.indiapostlist",response.getReturnValue());   

            }

        });

        $A.enqueueAction(action);

       

    }

})