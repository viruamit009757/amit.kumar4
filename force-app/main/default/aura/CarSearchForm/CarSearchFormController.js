({
        
    doInit : function(component, event, helper){
        var createcarrecord = $A.get("e.force:createRecord");
        if(createcarrecord){
           component.set("v.ShowNew",true);
        } else {
            component.set("v.ShowNew",false);
        }
        
      // component.set("v.CarTypes", ["Sports Car", "Luxury Car", "Van"]); another method in next line
       // alert("init is fired"); 
      helper.getCarType(component, event, helper);
    },
	onSearchclick : function(component, event, helper) {
        // alert("search button was clicked");
        helper.handleonSearchclick(component, event, helper);
        var SearchFormSubmit = component.getEvent("SearchFormSubmit");
        SearchFormSubmit.setParams({
            "CarTypeId" : component.find("CarTypeList").get("v.value")
        });
        SearchFormSubmit.fire();
	},
   /* togglebutton : function(component, event, helper){
       var currentValue = component.get("v.ShowNew");
        if(currentValue) {
            component.set("v.ShowNew",false);
        } else {
            component.set("v.ShowNew",true);
        }
        
    },*/
    newValueSelected : function(component, event, helper){
       var carTypeId = component.find("CarTypeList").get("v.value");
        alert(carTypeId + " is selected");
    },

    CreateRecord : function(component, event, helper){
        var createCarRecord = $A.get("e.force:createRecord");
        createCarRecord.setParams({
            "entityApiName": "Car_Type__c"
        });
        createCarRecord.fire();
    }
    
})