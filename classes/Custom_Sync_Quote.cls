public class Custom_Sync_Quote {

    private final Quote theQuote;
    private final Id quoteId;
    
    public Custom_Sync_Quote(ApexPages.StandardController stdcontroller){
        this.quoteId = stdcontroller.getId();
        this.theQuote = [SELECT OpportunityId FROM Quote WHERE Id = :this.quoteId];
    }
    
    public pageReference SyncQuote(){
        Opportunity o = [SELECT SyncedQuoteId FROM Opportunity WHERE Id = :this.theQuote.OpportunityId LIMIT 1];
        if(o.SyncedQuoteId == this.quoteId)
            o.SyncedQuoteId = NULL;
        else
            o.SyncedQuoteId = this.theQuote.Id;
        try{
            update o;
            PageReference pg = new PageReference('/'+this.theQuote.Id);
            return pg;                    
        }
        catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, e.getMessage()) );
        }    
        return null;

    }
    
}