trigger TalkdeskActivityTrigger on talkdesk__Talkdesk_Activity__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    new TalkdeskActivityTriggerHandler().run();
}