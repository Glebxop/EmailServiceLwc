/**
 * Created by Master on 15.11.2019.
 */

global with sharing class EmailServicesLwcController {

    @AuraEnabled(Cacheable=true)
    global static String sendMessage(String mailText, String mailSubject, String emailAdress) {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        List<String> adre = new List<String>();
        adre.add(emailAdress);
        email.setToAddresses(adre);
        email.setSubject(mailSubject);
        email.setPlainTextBody(mailText);

        try {
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{
                    email
            });
        } catch (Exception e) {
            throw e;
        }
        return 'ok';
    }
}
