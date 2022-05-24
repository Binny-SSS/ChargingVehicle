@isTest
public class SendAmountDueDetails_Test {

    public static testMethod void validatesendEmail() {
        List<Contact> con = new List<Contact>();
        Contact c = new Contact();
        c.LastName = 'Test';
        c.Card_Value__c = 100;
        c.Email = 'abc@test.com';
        con.add(c);
        insert con;
        SendAmountDueDetails.sendEmail(con);
    }
    
    public static testMethod void validateTriggerUpdate() {
        Contact c = new Contact();
        c.LastName = 'Test';
        c.Card_Value__c = 100;
        c.Email = 'abc@test.com';
        insert c;
        
        Charge__c ch = new Charge__c();
        ch.Name = 'Test';
        ch.Contact_Id__c = c.Id;
        ch.Start_Time__c = System.now();
        insert ch;
        
        ch.End_Time__c = System.now();
        update ch;
    }
}