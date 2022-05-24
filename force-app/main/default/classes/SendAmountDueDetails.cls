// Test Class : SendAmountDueDetails_Test

public class SendAmountDueDetails {
    public static void sendEmail(List<Contact> con){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        EmailTemplate template = [select id,subject,body,DeveloperName,HtmlValue from EmailTemplate where DeveloperName = 'Charging_Amount_Due_Mail'];
        for(Contact c : con){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setSubject(template.Subject);
            String body = template.HtmlValue;
            body = body.replace('[amtDue]',String.valueOf(c.Card_Value__c));
            mail.setHtmlBody(body);
            String []Address = new String[] { c.Email };
            mail.settoAddresses(Address);
               mails.add(mail);
        }
        Messaging.sendEmail(mails);
    }
}