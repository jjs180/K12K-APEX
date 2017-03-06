/*
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Custom Quote Controller virtual class. Used in the Custom Menu Selection UI
* and extended by individual components' controllers
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
public virtual class Custom_Quote_Controller {

    private final Quote theQuote;  
    private final Id theQuoteId;
    private final boolean isVFContext;   

	public List<Quote_Line_Wrapper> allTheThings;  
    
    public Custom_Quote_Controller(ApexPages.StandardController sc){
        this.theQuoteId = sc.getId();
        this.theQuote = [SELECT Id,Pricebook2Id, Guest_Count__c, Service_Style__c, RecordType.Name FROM Quote WHERE Id =:this.theQuoteId];
        this.isVFContext = true;
        InitializeLists();
    }   
    
    //overloaded constructor for using this class from another APEX to 
    //define the quote Id to use and also initialize the full list of items
    public Custom_Quote_Controller(Id definedQuoteId){
        this.theQuoteId = definedQuoteId;
        this.theQuote = [SELECT Id,Pricebook2Id, Guest_Count__c, Service_Style__c, RecordType.Name FROM Quote WHERE Id =:definedQuoteId];
        this.isVFContext = false;
        InitializeLists();
    }   
    
    private void InitializeLists() {
        extractAllQLIs();
        FoodsInitialize();
        BevInitialize();
        StaffInitialize();
        RentalInitialize();
        VenueInitialize();
    }
    
    private List<QuoteLineItem> allQLIs;
    private List<PriceBookEntry> pbeList;
    private void extractAllQLIs() {
        allQLIs = [SELECT PriceBookEntryId, UnitPrice, Selected_Quantity__c,Quantity,PriceBookEntry.Name,
                               PriceBookEntry.Product2.Product_Type_Tab__c, PriceBookEntry.Product2.Sub_Type_Style__c,
                               PriceBookEntry.Product2.Priced_Off_of_Guest_Count__c, PriceBookEntry.Product2.Food_Category__c,
                               TotalPrice, Hours__c
                               FROM QuoteLineItem WHERE QuoteId=:this.theQuote.Id
                               AND PriceBookEntry.Pricebook2Id = :this.theQuote.Pricebook2Id];
        pbeList = [SELECT Id,Name, Product2.Product_Type_Tab__c,Product2.Sub_Type_Style__c,
                               Product2.Food_Category__c,Product2.Priced_Off_of_Guest_Count__c, UnitPrice, Pricebook2Id
                               FROM PricebookEntry
                               WHERE Product2.Event_Record_Type__c includes (:this.theQuote.RecordType.Name)
                               AND Product2.Service_Style__c includes (:this.theQuote.Service_Style__c)
                               AND Pricebook2Id = :this.theQuote.Pricebook2Id
                               ORDER BY Product2.Food_Category__c];
    }
    
    public pageReference goBack(){
        return new pageReference('/' + this.theQuote.Id);
    }
    
    public void saveItemsList(List<Quote_Line_Wrapper> itemsList){
        List<QuoteLineItem> qliInserts = new List<QuoteLineItem>();
        List<QuoteLineItem> qliUpdates = new List<QuoteLineItem>();
        List<QuoteLineItem> qliDeletes = new List<QuoteLineItem>();
        system.debug(itemsList);
        for(Quote_Line_Wrapper qlw: itemsList){
            if(qlw.item.Id == NULL && qlw.item.Selected_Quantity__c > 0 ){
                qlw.item.quantity = 9999; //the workflow rule will set the actual quantity so we can set this to whatever                
                qliInserts.add(qlw.item);
            }
            else if( (qlw.item.Selected_Quantity__c == 0 || qlw.item.Selected_Quantity__c == NULL) && qlw.item.Id != NULL){
                qliDeletes.add(qlw.item);
            }
            else if(qlw.item.Selected_Quantity__c > 0 && qlw.item.Id != NULL ){				
                qliUpdates.add(qlw.item);
            }
        }
              
        if(!qliInserts.isEmpty()){
            system.debug('qliInserts---' + qliInserts);
            try{
	            insert qliInserts; 
                system.debug('qliInserts---' + qliInserts);
            }
            catch(Exception e){
                system.debug('Insert error occured---' + e.getMessage());
                /*if(isVFContext){
					ApexPages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,'An error occured: ' + e.getMessage() ));                                    
                }*/
            }
        }
        if(!qliUpdates.isEmpty()){
            system.debug('qliUpdates---' + qliUpdates);            
            try{
	            update qliUpdates;                
            }
            catch(Exception e){
                system.debug('Update error occured---' + e.getMessage());
                /*if(isVFContext){
					ApexPages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,'An error occured: ' + e.getMessage() ));                                    
                }*/
            }            
        }
        if(!qliDeletes.isEmpty()){
            system.debug('qliDeletes---' + qliDeletes);            
            try{
	            delete qliDeletes;                
            }
            catch(Exception e){
                system.debug('Delete error occured---' + e.getMessage());
                /*if(isVFContext){
					ApexPages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR,'An error occured: ' + e.getMessage() ));                                    
                }*/
            }            
        }          
    }                                 
   
    public List<Quote_Line_Wrapper> getItemsHelper(string productType, string subType, boolean selectedOnly){
        List<Quote_Line_Wrapper> qlwList = new List<Quote_Line_Wrapper>(); 
        Set<Id> existingPBEntryIds = new Set<Id>();       
        //get all existing Quote Lines for this quote
        for(QuoteLineItem qli: allQlis) {
            if (qli.PriceBookEntry.Product2.Product_Type_Tab__c == productType && (qli.PriceBookEntry.Product2.Sub_Type_Style__c == subType || subType == '%')) {
                Quote_Line_Wrapper qlw = new Quote_Line_Wrapper();
                qlw.guestCount = (theQuote.Guest_Count__c == NULL) ? 0 : integer.valueOf(theQuote.Guest_Count__c);
                qlw.name = qli.PriceBookEntry.Name;
                qlw.item = qli;
                qlw.subtype = qli.PriceBookEntry.Product2.Sub_Type_Style__c;
                qlw.category = qli.PriceBookEntry.Product2.Food_Category__c;
                qlw.isCheckbox = qli.PriceBookEntry.Product2.Priced_off_of_guest_count__c;
                qlwList.add(qlw);  
                existingPBEntryIds.add(qli.PriceBookEntryId);
            }
        }
        
        if (!selectedOnly) {
        	//get all price book entries for this quote's pricebook and the specified Product and sub types
        	for (PriceBookEntry pbe: pbeList) {
            	if (pbe.Product2.Product_Type_Tab__c == productType && (pbe.Product2.Sub_Type_Style__c == subType || subType == '%') && !existingPBEntryIds.contains(pbe.Id)) {
                    QuoteLineItem qli = new QuoteLineItem(QuoteId = this.theQuote.Id, PriceBookEntryId = pbe.Id, UnitPrice = pbe.UnitPrice, Selected_Quantity__c = 0);
                    Quote_Line_Wrapper qlw = new Quote_Line_Wrapper();
                    qlw.guestCount = (theQuote.Guest_Count__c == NULL) ? 0 : integer.valueOf(theQuote.Guest_Count__c);
                    qlw.name = pbe.Name;
                    qlw.item = qli;
                    qlw.subtype = pbe.Product2.Sub_Type_Style__c;
                    qlw.category = pbe.Product2.Food_Category__c;
                    qlw.isCheckbox = pbe.Product2.Priced_off_of_guest_count__c;
                    qlwList.add(qlw);
            	}
        	}
        }
        return qlwList;        
    }
    
    public decimal totalHelper(List<Quote_Line_Wrapper> qlwList){
        decimal total = 0;
        for(Quote_Line_Wrapper qlw: qlwList ){
            total += (qlw.item.TotalPrice == NULL) ? 0 : qlw.item.TotalPrice;
        }
        return total;      
    }
    
    public void saveAllItems() {
        List<Quote_Line_Wrapper> itemsList = new List<Quote_Line_Wrapper>();
        itemsList.addAll(FoodsGetAll());
        itemsList.addAll(BevGetAll());
        itemsList.addAll(StaffGetAll());
        itemsList.addAll(RentalGetAll());
        itemsList.addAll(VenueGetAll());
        saveItemsList(itemsList);
        
        InitializeLists();
    }
    
    // Food stuff below
    private void FoodsInitialize(){
		//Foods      
        this.Food_PassedApps = getItemsHelper('Food', 'Passed Appetizer', false);
        this.Food_Starters = getItemsHelper('Food', 'Starters', false);
        this.Food_WrapsWiches = new List<Quote_Line_Wrapper>();
        this.Food_Starches = getItemsHelper('Food', 'Starches', false);
        this.Food_Proteins = getItemsHelper('Food', 'Proteins', false);
        this.Food_Breads = getItemsHelper('Food', 'Breads', false);
        this.Food_Stations = getItemsHelper('Food', 'Food-Stations', false);
        this.Food_Plated = getItemsHelper('Food', 'Plated', false);
    }
         
	public List<Quote_Line_Wrapper> Food_PassedApps {get;set;}    
    public List<Quote_Line_Wrapper> Food_Starters {get;set;}    
    public List<Quote_Line_Wrapper> Food_WrapsWiches {get;set;}
    public List<Quote_Line_Wrapper> Food_Starches {get;set;}  
    public List<Quote_Line_Wrapper> Food_Proteins {get;set;} 
    public List<Quote_Line_Wrapper> Food_Breads {get;set;} 
    public List<Quote_Line_Wrapper> Food_Stations {get;set;}
    public List<Quote_Line_Wrapper> Food_Plated {get;set;}
    
    public decimal getFood_PassedAppsTotal(){
		return totalHelper(this.Food_PassedApps);
    }
    public decimal getFood_StartersTotal(){
		return totalHelper(this.Food_Starters);
    }
    public decimal getFood_WrapsWichesTotal(){
		return totalHelper(this.Food_WrapsWiches);
    }
    public decimal getFood_StarchesTotal(){
		return totalHelper(this.Food_Starches);
    }
    public decimal getFood_ProteinsTotal(){
		return totalHelper(this.Food_Proteins);
    }
    public decimal getFood_BreadsTotal(){
		return totalHelper(this.Food_Breads);
    }
    public decimal getFood_StationsTotal(){
		return totalHelper(this.Food_Stations);
    }
    public decimal getFood_PlatedTotal(){
		return totalHelper(this.Food_Plated);
    }
    
    public List<Quote_Line_Wrapper> FoodsGetAll() {
        List<Quote_Line_Wrapper> toReturn = new List<Quote_Line_Wrapper>();
        toReturn.addAll(Food_PassedApps);
		toReturn.addAll(Food_Starters);
		toReturn.addAll(Food_WrapsWiches);
		toReturn.addAll(Food_Starches);
		toReturn.addAll(Food_Proteins);
		toReturn.addAll(Food_Breads);
		toReturn.addAll(Food_Stations);
		toReturn.addAll(Food_Plated);
        return toReturn;
    }
    
    // Beverage stuff below
    private void BevInitialize() {
        this.Bev_Stations = getItemsHelper('Beverage', 'Beverage-Stations', false);
    }
    
    public List<Quote_Line_Wrapper> Bev_Stations {get;set;}  
    
    public decimal getBev_StationsTotal(){
		return totalHelper(this.Bev_Stations);
    }
    
    public List<Quote_Line_Wrapper> BevGetAll() {
        return Bev_Stations;
    }
    
    // Staffing stuff below
    private void StaffInitialize() {
        this.Staffing = getItemsHelper('Staffing', '%', false);
    }
    
    public List<Quote_Line_Wrapper> Staffing {get;set;} 
    
    public decimal getStaffTotal(){
        return totalHelper(this.Staffing);
    }
    
    public List<Quote_Line_Wrapper> StaffGetAll() {
        return Staffing;
    }
    
    // Rentals stuff below
    private void RentalInitialize() {
        this.Rentals = getItemsHelper('Rentals', '%', false);
    }
    
    public List<Quote_Line_Wrapper> Rentals {get;set;} 
    
    public decimal getRentalTotal(){
        return totalHelper(this.Rentals);
    }
    
    public List<Quote_Line_Wrapper> RentalGetAll() {
        return Rentals;
    }
    
    // Venue stuff below
    private void VenueInitialize() {
        this.Venue = getItemsHelper('Venue', '%', false);
    }
    
    public List<Quote_Line_Wrapper> Venue {get;set;} 
    
    public decimal getVenueTotal(){
        return totalHelper(this.Venue);
    }
    
    public List<Quote_Line_Wrapper> VenueGetAll() {
        return Venue;
    }
    
    // Summary
    public decimal getFood_Total(){
        return totalHelper(FoodsGetAll());
    }
    public List<Quote_Line_Wrapper> getSummaryFood() {
        List<Quote_Line_Wrapper> toReturn = new List<Quote_Line_Wrapper>();
        for (Quote_Line_Wrapper qlw : FoodsGetAll()) {
            if (qlw.item.TotalPrice != null && qlw.item.TotalPrice > 0) {
                toReturn.add(qlw);
            }
        }
        return toReturn;
    }
    public List<Quote_Line_Wrapper> getSummaryBeverage() {
        List<Quote_Line_Wrapper> toReturn = new List<Quote_Line_Wrapper>();
        for (Quote_Line_Wrapper qlw : BevGetAll()) {
            if (qlw.item.TotalPrice != null && qlw.item.TotalPrice > 0) {
                toReturn.add(qlw);
            }
        }
        return toReturn;
    }
    public List<Quote_Line_Wrapper> getSummaryStaff() {
        List<Quote_Line_Wrapper> toReturn = new List<Quote_Line_Wrapper>();
        for (Quote_Line_Wrapper qlw : StaffGetAll()) {
            if (qlw.item.TotalPrice != null && qlw.item.TotalPrice > 0) {
                toReturn.add(qlw);
            }
        }
        return toReturn;
    }
    public List<Quote_Line_Wrapper> getSummaryRentals() {
        List<Quote_Line_Wrapper> toReturn = new List<Quote_Line_Wrapper>();
        for (Quote_Line_Wrapper qlw : RentalGetAll()) {
            if (qlw.item.TotalPrice != null && qlw.item.TotalPrice > 0) {
                toReturn.add(qlw);
            }
        }
        return toReturn;
    }
    public List<Quote_Line_Wrapper> getSummaryVenue() {
        List<Quote_Line_Wrapper> toReturn = new List<Quote_Line_Wrapper>();
        for (Quote_Line_Wrapper qlw : VenueGetAll()) {
            if (qlw.item.TotalPrice != null && qlw.item.TotalPrice > 0) {
                toReturn.add(qlw);
            }
        }
        return toReturn;
    }
}