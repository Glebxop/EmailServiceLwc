/**
 * Created by Master on 18.11.2019.
 */
@IsTest
public with sharing class TestDateParser {
    @IsTest
    static void dotNotation() {
        Test.startTest();
        Date result = DateParser.parseDate('12.20');
        Test.stopTest();
        Date expextedDate = Date.newInstance(2019, 12, 20);
        System.assertEquals(expextedDate, result);
    }
    @IsTest
    static void nextWeek () {
        Test.startTest();
        Date result = DateParser.parseDate('next week monday');
        Test.stopTest();
        Date expextedDate=Date.today().addDays(7).toStartOfWeek().addDays(1);
        System.assertEquals(expextedDate,result);
    }


}