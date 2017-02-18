/*
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Wrapper for Quote Line. Used in the Custom Menu Selection UI
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

    
}