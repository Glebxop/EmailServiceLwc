/**
 * Created by Master on 15.11.2019.
 */
public with sharing class TimeParser {

    public static Time parseTime(String timeStr) {
        Time timeMeeting;
        if (timeStr.containsIgnoreCase('p.m.')) {
            timeMeeting = workWithPM(timeStr);
        } else if (timeStr.containsIgnoreCase('a.m.')) {
            timeMeeting = workWithAM(timeStr);
        } else {
            String[] timeArray = timeStr.replaceAll(' ', '').split(':');
            timeMeeting = Time.newInstance(Integer.valueOf(timeArray[0]), Integer.valueOf(timeArray[1]), 0, 0);
        }
        return timeMeeting;
    }

    private static Time workWithPM(String timeStr) {
        return getHour(timeStr).addHours(12);
    }

    private static Time workWithAM(String timeStr) {
        return getHour(timeStr);
    }

    private static Time getHour(String timeStr) {
        Pattern myPattern = Pattern.compile('([0-9]{1,2})');
        Matcher myMatcher = myPattern.matcher(timeStr);
        Integer hour;
        if (myMatcher.find()) {
            String hourStr = timeStr.substring(myMatcher.start(), myMatcher.end()).replaceAll(' ', '');
            hour = Integer.valueOf(hourStr);
        }
        return Time.newInstance(hour, 0, 0, 0);
    }


}
