/*
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Custom Quote Controller. Used in the Custom Menu Selection UI
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
public class Custom_Quote_Controller {

    private final Quote theQuote;  
    
    //Lists of the things    
    public List<Quote_Line_Wrapper> Food_PassedApps {get;set;}    
    public List<Quote_Line_Wrapper> Food_DipsSalads {get;set;}    
    public List<Quote_Line_Wrapper> Food_WrapsWiches {get;set;}
    public List<Quote_Line_Wrapper> Food_Starches {get;set;}  
    public List<Quote_Line_Wrapper> Food_Proteins {get;set;} 
    public List<Quote_Line_Wrapper> Food_Breads {get;set;} 
    public List<Quote_Line_Wrapper> Food_Stations {get;set;}
    public List<Quote_Line_Wrapper> Food_Plated {get;set;} 
    public List<Quote_Line_Wrapper> Bev_Stations {get;set;}     
    public List<Quote_Line_Wrapper> Staffing {get;set;}     
    public List<Quote_Line_Wrapper> Rentals {get;set;}  

	private List<Quote_Line_Wrapper> allTheThings;  
    
    public Custom_Quote_Controller(){
        Id quoteId = Apexpages.currentPage().getParameters().get('Id');
        this.theQuote = [SELECT Id,Pricebook2Id, Guest_Count__c, Service_Style__c, RecordType.Name FROM Quote WHERE Id =:quoteId];
        initializeTheThings();
    }   
    
    private void initializeTheThings(){
		//initialize the lists of things
        this.allTheThings = new List<Quote_Line_Wrapper>();		
        //Foods
        this.Food_PassedApps = getItemsHelper('Food', 'Passed Appetizer');
        this.allTheThings.addAll(this.Food_PassedApps);
        this.Food_DipsSalads = getItemsHelper('Food', 'Dips&Salads');
        this.allTheThings.addAll(this.Food_DipsSalads);        
        this.Food_Starches = getItemsHelper('Food', 'Starches');
        this.allTheThings.addAll(this.Food_Starches);        
        this.Food_Proteins = getItemsHelper('Food', 'Proteins');
        this.allTheThings.addAll(this.Food_Proteins);          
        this.Food_Breads = getItemsHelper('Food', 'Breads');
        this.allTheThings.addAll(this.Food_Breads);          
        this.Food_Stations = getItemsHelper('Food', 'Food-Stations');
        this.allTheThings.addAll(this.Food_Stations);          
        this.Food_Plated = getItemsHelper('Food', 'Plated');
        this.allTheThings.addAll(this.Food_Plated);          
        
        //Beverages
        this.Bev_Stations = getItemsHelper('Beverage', 'Beverage-Stations');
        this.allTheThings.addAll(this.Bev_Stations);          
        
        //Rentals
        this.Rentals = getItemsHelper('Rentals', '%'); //wildcard to get all subtypes
        this.allTheThings.addAll(this.Rentals);          
        //Staffing
        this.Staffing = getItemsHelper('Staffing', ''); //Staffing currently has no subtypes        
        this.allTheThings.addAll(this.Staffing);          
    }
    
    public pageReference goBack(){
        return new pageReference('/' + this.theQuote.Id);
    }
        
    public void saveItems(){
        List<QuoteLineItem> qliInserts = new List<QuoteLineItem>();
        List<QuoteLineItem> qliUpdates = new List<QuoteLineItem>();
        List<QuoteLineItem> qliDeletes = new List<QuoteLineItem>();
        
        for(Quote_Line_Wrapper qlw: this.allTheThings){
            if(qlw.item.Id == NULL && qlw.item.Selected_Quantity__c > 0 ){
                qlw.item.quantity = 99; //the workflow rule will set the actual quantity so we can set this to whatever                
                qliInserts.add(qlw.item);
            }
            else if(qlw.item.Selected_Quantity__c == 0 && qlw.item.Id != NULL){
                qliDeletes.add(qlw.item);
            }
            else if(qlw.item.Selected_Quantity__c > 0 && qlw.item.Id != NULL ){
                qliUpdates.add(qlw.item);
            }
        }
        if(!qliInserts.isEmpty()){
            system.debug(qliInserts);
            try{
	            insert qliInserts;                
            }
            catch(Exception e){
                ApexPages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,'An error occured: ' + e.getMessage() ));
            }
        }
        if(!qliDeletes.isEmpty()){
            try{
	            delete qliDeletes;                
            }
            catch(Exception e){
                ApexPages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,'An error occured: ' + e.getMessage() ));
            }            
        }
        if(!qliUpdates.isEmpty()){
            try{
	            update qliUpdates;                
            }
            catch(Exception e){
                ApexPages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,'An error occured: ' + e.getMessage() ));
            }            
        }
        this.initializeTheThings();       
    }
    
    
    //Get Totals Methods
    public decimal getFood_PassedAppsTotal(){
        return this.totalHelper('Food', 'Passed Appetizer');
    }    

    public decimal getFood_DipsSaladsTotal(){
        return this.totalHelper('Food', 'Dips&Salads');
    } 

    public decimal getFood_WrapsWichesTotal(){
        return this.totalHelper('Food', 'Wraps&Wiches');
    }
    
    public decimal getFood_StarchesTotal(){
        return this.totalHelper('Food', 'Starches');
    }      
        
    public decimal getFood_ProteinsTotal(){
        return this.totalHelper('Food', 'Proteins');
    }     
    
    public decimal getFood_BreadsTotal(){
        return this.totalHelper('Food', 'Breads');
    }  
    
    public decimal getFood_StationsTotal(){
        return this.totalHelper('Food', 'Food-Stations');
    }    
    
    public decimal getFood_PlatedTotal(){
        return this.totalHelper('Food', 'Plated');
    }        
    
    public decimal getBev_StationsTotal(){
        return this.totalHelper('Beverage', 'Beverage-Stations');
    }    
    public decimal getRentalTotal(){
        return this.totalHelper('Rentals', '%');
    }
    public decimal getStaffTotal(){
        return this.totalHelper('Staffing', '');        
    }     
    
    private List<Quote_Line_Wrapper> getItemsHelper(string productType, string subType){
        List<Quote_Line_Wrapper> qlwList = new List<Quote_Line_Wrapper>(); 
        Set<Id> existingPBEntryIds = new Set<Id>();       
        //get all existing Quote Lines for this quote
        for(QuoteLineItem qli: [SELECT PriceBookEntryId, UnitPrice, Selected_Quantity__c,Quantity,PriceBookEntry.Name,
                                PriceBookEntry.Product2.Product_Type_Tab__c, PriceBookEntry.Product2.Sub_Type_Style__c,
                                PriceBookEntry.Product2.Priced_Off_of_Guest_Count__c, PriceBookEntry.Product2.Food_Category__c,
                                TotalPrice, Hours__c
                                FROM QuoteLineItem WHERE QuoteId=:this.theQuote.Id
                                AND PriceBookEntry.Product2.Product_Type_Tab__c = :productType 
                                AND PriceBookEntry.Product2.Sub_Type_Style__c like :subType 
                                AND PriceBookEntry.Pricebook2Id = :this.theQuote.Pricebook2Id]){
            Quote_Line_Wrapper qlw = new Quote_Line_Wrapper();
            qlw.guestCount = (theQuote.Guest_Count__c == NULL) ? 0 : integer.valueOf(theQuote.Guest_Count__c);
            qlw.name = qli.PriceBookEntry.Name;
            qlw.item = qli;
            qlw.subtype = qli.PriceBookEntry.Product2.Sub_Type_Style__c;
            qlw.category = qli.PriceBookEntry.Product2.Food_Category__c;
            qlwList.add(qlw);  
            existingPBEntryIds.add(qli.PriceBookEntryId);                                          
        }
            
        //get all price book entries for this quote's pricebook and the specified Product and sub types
        List<PriceBookEntry> pbeList = [SELECT Id,Name, Product2.Product_Type_Tab__c,Product2.Sub_Type_Style__c,
                                        Product2.Food_Category__c,Product2.Priced_Off_of_Guest_Count__c, UnitPrice, Pricebook2Id
                                        FROM PricebookEntry 
                                        WHERE Product2.Product_Type_Tab__c = :productType 
                                		AND Product2.Event_Record_Type__c includes (:this.theQuote.RecordType.Name)
                                		AND Product2.Service_Style__c includes (:this.theQuote.Service_Style__c)
                                        AND Product2.Sub_Type_Style__c like :subType 
                                        AND Pricebook2Id = :this.theQuote.Pricebook2Id
                                        AND Id NOT IN: existingPBEntryIds
                                        ORDER BY Product2.Food_Category__c];

        for(PriceBookEntry pbe: pbeList){
            QuoteLineItem qli = new QuoteLineItem(QuoteId = this.theQuote.Id, PriceBookEntryId = pbe.Id, UnitPrice = pbe.UnitPrice, Selected_Quantity__c = 0);
            Quote_Line_Wrapper qlw = new Quote_Line_Wrapper();
            qlw.guestCount = (theQuote.Guest_Count__c == NULL) ? 0 : integer.valueOf(theQuote.Guest_Count__c);
            qlw.name = pbe.Name;
            qlw.item = qli;
            qlw.subtype = pbe.Product2.Sub_Type_Style__c;
            qlw.category = pbe.Product2.Food_Category__c;
            qlwList.add(qlw);
        }
        return qlwList;        
    }
    
    private decimal totalHelper(string productType, string subType){
        decimal total = 0;
		for(QuoteLineItem qli: [SELECT TotalPrice
                                FROM QuoteLineItem WHERE QuoteId=:this.theQuote.Id
                                AND PriceBookEntry.Product2.Product_Type_Tab__c = :productType 
                               	AND PriceBookEntry.Product2.Sub_Type_Style__c like :subType]){
			total += (qli.TotalPrice == NULL) ? 0 : qli.TotalPrice;                                        
        }
		return total;        
    }
      
    
}