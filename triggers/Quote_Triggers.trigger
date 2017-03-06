/*
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Triggers on Quote
* Covered by Quote_Trigger_Test
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Initial implementation
* @author       Jason Sun <jsun@relationedge.com>
* @created      2017-02-16
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Changes
*
*
* ─────────────────────────────────────────────────────────────────────────────────────────────────
*/
trigger Quote_Triggers on Quote (after insert, after update) {

    if(Trigger.isAfter){
        if(Trigger.isInsert){
            Quote_Trigger_Handlers.afterInsert(trigger.new);
        }
        else if(Trigger.isUpdate){
            Quote_Trigger_Handlers.afterUpdate(trigger.newMap, trigger.oldMap);
        }
    }

    
}