/**
 * Created by Master on 18.11.2019.
 */
@IsTest
public with sharing class TestLwcController {
    @IsTest
    static void behaviour() {
        Test.startTest();
        String answer = EmailServicesLwcController.sendMessage('Text of mail', 'Subject', 'glebxop@gmail.com');
        Test.stopTest();
        System.assertEquals(answer, 'ok');
    }
}