/**
 * Created by Master on 18.11.2019.
 */

public with sharing class MeetingTriggerHandler {

    public static void triggerAfterInsert(List<Meeting__c> meetings) {

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        List<Contact> contacts = [
                SELECT Id, Email,(SELECT Id FROM Meetings__r)
                FROM Contact
                WHERE Email != NULL
        ];
        System.debug(contacts);
        List<String> emails = new List<String>();
        for (Contact contact : contacts) {
            emails.add(contact.Email);
        }
        EmailTemplate emailTemplate = [
                SELECT Id
                FROM EmailTemplate
                WHERE Name = 'MeetingTemplate'
                LIMIT 1
        ];
        email.setTargetObjectId(contacts.get(0).Meeting__r.Id);
        email.setTemplateId(emailTemplate.Id);
        email.setToAddresses(emails);
       // email.setBccAddresses(emails);
      // email.setTargetObjectId(meetings.get(0).Id);
       // email.setSaveAsActivity(false);
       // email.setWhatId(contacts.get(0).Id);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{
                email
        });


/*
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        EmailTemplate emailTemplate = [
                SELECT Id
                FROM EmailTemplate
                WHERE Name = 'MeetingTemplate'
                LIMIT 1
        ];
        email.setTemplateId(emailTemplate.Id);
        email.setTreatTargetObjectAsRecipient(false);

        //email.setWhatId(meetings.get(0).Id);//meetings.get(0).Id);
        List<Contact> contacts = [
                SELECT Id, Email
                FROM Contact
                WHERE Email != NULL
        ];
        List<String> emails = new List<String>();
        for (Contact contact : contacts) {
            emails.add(contact.Email);
        }
        email.setToAddresses(emails);
        email.setTargetObjectId([SELECT Id FROM Meeting__c LIMIT 1].Id);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{
                email
        });*/

       /* Messaging.MassEmailMessage massEmailMessage = new Messaging.MassEmailMessage();

        EmailTemplate emailTemplate = [
                SELECT Id
                FROM EmailTemplate
                WHERE Name = 'MeetingTemplate'
                LIMIT 1
        ];
        System.debug(emailTemplate);
        massEmailMessage.setTemplateId(emailTemplate.Id);
        List<Id>meetingIds = new List<Id>();
        for (Meeting__c meeting:meetings){
            meetingIds.add(meeting.Id);
        }


        List<Contact> contacts = [
                SELECT Id, Email
                FROM Contact
                WHERE Email != NULL
        ];
        List<Id> emails = new List<Id>();
        for (Contact contact : contacts) {
            emails.add(contact.Id);
        }
        //massEmailMessage.setWhatIds(meetingIds);
massEmailMessage.setTargetObjectIds(emails);
       // massEmailMessage.
       // massEmailMessage.setTargetObjectIds(meetingIds);
        Messaging.sendEmail(new Messaging.MassEmailMessage[] { massEmailMessage });


*/

        /*List<Contact> contacts = [
                SELECT Id, Email
                FROM Contact
                WHERE Email != NULL
        ];
        List<String> emails = new List<String>();
        for (Contact contact : contacts) {
            emails.add(contact.Email);
        }

        String textOfMessage = '';
        String subject = '';
        for (Meeting__c meeting : meetings) {
            textOfMessage += 'Arrange meeting: ' + meeting.Name_who_arrange_a_meeting__c
                    + 'Date time of meeting: ' + meeting.Date_time_of_meeting__c + ' Place: ' + meeting.Place__c;
            subject += meeting.Subject__c;

        }
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(emails);
        email.setPlainTextBody(textOfMessage);
        email.setSubject(subject);
        try {
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{
                    email
            });
        } catch (exception e) {
            throw e;
        }
*/
    }
}