trigger Privacy_Notice_Trigger on Privacy_Notice__c ( after insert, after update) {
    if(trigger.isinsert ){
        Map<id,Privacy_Notice__c> imap = new map<id,Privacy_Notice__c>();
        HelperPrivacyNotice.upPrivacy(trigger.new,trigger.newMap,imap);
    }
    if(trigger.isupdate ){
        HelperPrivacyNotice.upPrivacy(trigger.new,trigger.newMap,Trigger.oldMap);
    }
}