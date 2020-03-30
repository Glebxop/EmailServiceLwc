/**
 * Created by Master on 18.11.2019.
 */
@IsTest
public with sharing class TestTimeParser {
    @IsTest
    static void doubleDot() {
        Test.startTest();
        Time result = TimeParser.parseTime('12:20');
        Test.stopTest();
        Time expected = Time.newInstance(12, 20, 0, 0);
        System.assertEquals(expected, result);
    }

    @IsTest
    static void parsePM(){
        Test.startTest();
        Time result = TimeParser.parseTime('6 p.m.');
        Test.stopTest();
        Time expected=Time.newInstance(18,0,0,0);
        System.assertEquals(expected,result);
    }

    @IsTest
    static void parseAM(){
        Test.startTest();
        Time result = TimeParser.parseTime('6 a.m.');
        Test.stopTest();
        Time expected=Time.newInstance(6,0,0,0);
        System.assertEquals(expected,result);
    }

}