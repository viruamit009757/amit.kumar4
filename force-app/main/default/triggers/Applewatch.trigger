trigger Applewatch on Opportunity (before insert, after insert) {
    for(Opportunity opp : Trigger.new){
        for(integer i=1; i<5; i++){
        Task T = new Task();
        T.Subject = opp.Name + 'apple watch promo'+i;
        T.Description = 'released in upcoming month';
        T.Priority = 'High';
        T.WhatId = opp.id;
        insert T;            
        }
        
    }
}