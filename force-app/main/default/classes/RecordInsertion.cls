public class RecordInsertion
{

    @AuraEnabled
    public static void createChargeRecord(Id recordId){
        System.debug('recordId>>'+recordId);
        List<Charge__c> charge = new List<Charge__c>();
            Charge__c c = new Charge__c();
            c.Start_Time__c = System.now();
            c.Contact_Id__c = recordId;
            charge.add(c); 
        if(charge.size() > 0){
            insert charge;
        }
    }    
    
    @AuraEnabled
    public static void updateEndTime(Id recordId){
            Charge__c c = [select id,lastmodifieddate from Charge__c where Contact_Id__c =: recordId order by lastmodifieddate desc limit 1];
            System.debug('charge record to update>>'+c);
                c.End_Time__c = System.now(); 
        if(c != null){
            update c;
        }
    } 
}