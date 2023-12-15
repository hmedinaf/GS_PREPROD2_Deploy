trigger ContentDocumentTrigger on ContentDocument (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    new ContentDocumentTriggerHandler().run();
}