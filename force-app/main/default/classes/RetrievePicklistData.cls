public class RetrievePicklistData {
        public List<SelectOption> getpicknames()
        {
                List<SelectOption> options = new List<SelectOption>();
                //If you want to retrieve picklist values from Account obejct 
               Schema.DescribeFieldResult ccity = Schema.sObjectType.Contact.fields.langaue__c.getSObjectField().getDescribe();
                options.add(new SelectOption('--None--', '--None--'));
                for(PicklistEntry ent:ccity.getpicklistvalues())
                {
                options .add(new SelectOption(ent.getValue(), ent.getLabel()));

                }
               return options;
        }
}