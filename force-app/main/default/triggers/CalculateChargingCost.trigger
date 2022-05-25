trigger CalculateChargingCost on Charge__c (after update) {
    Set<Id> contactId = new Set<Id>();
    List<Contact> contactList = new List<Contact>();
    Map<Id,Charge__c> chargeContactMap = new Map<Id,Charge__c>();
    List<Contact> updateContactList = new List<Contact>();
    
    for(Charge__c c : Trigger.New){
        Charge__c oldTime = Trigger.oldMap.get(c.Id);
        if(oldTime.End_Time__c == null && c.End_Time__c != null){
            contactId.add(c.Contact_Id__c);
            chargeContactMap.put(c.Contact_Id__c, c);
        }
    }
    
    if(contactId.size() > 0){
        contactList = [select id,Card_Value__c,Last_Used__c,Total_Usage_Hours__c from Contact where Id =: contactId];
    }
    
    for(Charge__c c : Trigger.New){
        Contact con = [select id,Card_Value__c,Last_Used__c,Total_Usage_Hours__c,Email from Contact where Id =: c.Contact_Id__c];
        con.Card_Value__c = con.Card_Value__c - c.Cost__c;
        con.Last_Used__c = System.now();
        updateContactList.add(con);
    }
    if(updateContactList.size() > 0){
        update updateContactList;
        SendAmountDueDetails.sendEmail(updateContactList);
    }
}