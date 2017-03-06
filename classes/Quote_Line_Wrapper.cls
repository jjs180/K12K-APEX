/*
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Wrapper for Quote Line. Used in the Custom Menu Selection UI
* Covered by Custom_Quote_ControllerTestClass
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Initial implementation
* @author       Jason Sun <jsun@relationedge.com>
* @created      2017-02-15
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Changes
*
*
* ─────────────────────────────────────────────────────────────────────────────────────────────────
*/
public class Quote_Line_Wrapper {
    
    public quoteLineItem item {get;set;}    
    public string name {get;set;}
    public integer guestCount{
    get{
        if(this.guestCount == NULL){
            return 0;
        }
        return this.guestCount;
    }
    set;}    
    public boolean Selected {get;set;}    
    public string category {get;set;}
    public string subType {get;set;}
    public boolean isCheckbox {get;set;}
    public boolean quantitySelected {
        get {
        	return item.Selected_Quantity__c > 0;
    	}
        set {
            item.Selected_Quantity__c = (value ? 1 : 0);
        }
    }
    
}