/**
 * Created by Master on 15.11.2019.
 */

global class EmailServicesMeeting implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        MailParser.parse(email.plainTextBody, email.fromAddress, email.fromName, email.subject);
        return result;
    }
}