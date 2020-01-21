/**
 * Created by Master on 15.11.2019.
 */

public with sharing class DateParser {

    private static String[] days;
    static {
        days = new String[]{
                'sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'
        };
    }

    public static Date parseDate(String dateStr) {
        Pattern myPattern = Pattern.compile('[0-9]{1,2}\\.[0-9]{1,2}');
        Matcher myMatcher = myPattern.matcher(dateStr);
        Date dateOfMeeting;
        if (myMatcher.find()) {
            dateOfMeeting = workWithDotDate(dateStr);
        } else if (dateStr.containsIgnoreCase('next')) {
            dateOfMeeting = workWithNext(dateStr);
        }
        return dateOfMeeting;
    }

    private static Date workWithDotDate(String dateStr) {
        String [] dateMeeting = dateStr.split('\\.');
        Boolean isDateWrong = Integer.valueOf(dateMeeting[0]) > 12;
        String hour = (isDateWrong ? dateMeeting[1] : dateMeeting[0]);
        String minutes = (isDateWrong ? dateMeeting[0] : dateMeeting[1]);
        String dateToParse = hour.replaceAll(' ', '') + '/' + minutes + '/' + Date.today().year();
        return Date.parse(dateToParse);
    }
    private static Date workWithNext(String dateStr) {
        Date dateOfMeeting = Date.today().toStartOfWeek();
        if (dateStr.containsIgnoreCase('week')) {
            dateOfMeeting = dateOfMeeting.addDays(7);
        }
        return setDay(dateStr, dateOfMeeting);
    }

    private static Date setDay(String dateStr, Date dateOfMeeting) {
        for (Integer i = 0; i < days.size(); i++) {
            if (dateStr.containsIgnoreCase(days.get(i))) {
                dateOfMeeting = dateOfMeeting.addDays(i);
            }
        }
        return dateOfMeeting;
    }
}