/**
 * Created by Master on 17.11.2019.
 */

trigger MeetingTrigger on Meeting__c (after insert) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            MeetingTriggerHandler.triggerAfterInsert(Trigger.new);
        }
    }

}