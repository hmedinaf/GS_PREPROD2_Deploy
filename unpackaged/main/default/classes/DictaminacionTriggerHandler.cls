public with sharing class DictaminacionTriggerHandler extends TriggerHandler {
    private Map<Id, Contract> newMap;
    private Map<Id, Contract> oldMap;
    private List<Contract> newList;
    private List<Contract> oldList;

    public DictaminacionTriggerHandler() {
        this.newMap = (Map<Id, Contract>) trigger.newMap;
        this.oldMap = (Map<Id, Contract>) trigger.oldMap;
        this.newList = (List<Contract>) trigger.new;
        this.oldList = (List<Contract>) trigger.old;
    }

    public override void beforeInsert() {
    }

    public override void beforeUpdate(){

    }

}