trigger TaskTriggrer on Task (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    new TaskTriggerHandler().run();
}