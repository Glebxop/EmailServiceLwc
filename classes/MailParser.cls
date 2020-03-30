/**
 * Created by Master on 15.11.2019.
 */

public with sharing class MailParser {

    private static List<String>patternsDate;
    private static List<String>patternsTime;
    private static List<String>patternsPlace;

    public static void parse(String textMessage, String emailFrom, String emailFromName, String subject) {


        List<Regular_expressions__mdt>regularExpressions = [
                SELECT Id, Type__c, PatternExpression__c
                FROM Regular_expressions__mdt
        ];
        for (Regular_expressions__mdt expression : regularExpressions) {
            switch on expression.Type__c {
                when 'Date' {
                    patternsDate.add(expression.PatternExpression__c);
                }
                when 'Time' {
                    patternsTime.add(expression.PatternExpression__c);
                }
                when 'Place' {
                    patternsPlace.add(expression.PatternExpression__c);
                }
            }
        }

        String dateMeeting = getDataFromText(patternsDate, textMessage);
        String timeMeeting = getDataFromText(patternsTime, textMessage);
        String placeMeeting = getDataFromText(patternsPlace, textMessage);
        Date dateOfMeeting = DateParser.parseDate(dateMeeting);
        Time timeOfMeeting = TimeParser.parseTime(timeMeeting);

        Meeting__c meeting = new Meeting__c(
                Date_time_of_meeting__c = Datetime.newInstance(dateOfMeeting, timeOfMeeting),
                Place__c = placeMeeting,
                Email_who_arrange_a_meeting__c = emailFrom,
                Name_who_arrange_a_meeting__c = emailFromName,
                Subject__c = subject
        );
        insert meeting;


    }

    private static String getDataFromText(String[] patternString, String text) {
        String result = '';
        for (String eachPattern : patternString) {
            Pattern myPattern = Pattern.compile(eachPattern);
            Matcher myMatcher = myPattern.matcher(text);

            while (myMatcher.find()) {
                result += text.substring(myMatcher.start(), myMatcher.end()) + ' ';
            }
        }
        return result;
    }


}