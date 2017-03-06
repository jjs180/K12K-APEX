/*
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Test class for Custom_Quote_Controller and Quote_Line_Wrapper
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Initial implementation
* @author       Jason Sun <jsun@relationedge.com>
* @created      2017-03-02
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Changes
*
*
* ─────────────────────────────────────────────────────────────────────────────────────────────────
*/
@isTest
public class Custom_Quote_ControllerTestClass {
    
	@isTest
    public static void SaveTest(){
        
        //Data setup
        Id pricebook2 = Test.getStandardPricebookId();
        
        Opportunity theOpp = new Opportunity();
        theOpp.StageName = 'New';
        theOpp.CloseDate = date.today();
        theOpp.Name = 'testOpp';
        insert theOpp;
        
        Quote theQuote = new Quote();
        theQuote.Name = 'Quote Name';
        theQuote.OpportunityId = theOpp.Id; 
        theQuote.Pricebook2Id = pricebook2;
        theQuote.Guest_Count__c = 10;
        insert theQuote;        
        
        Product2 prod1 = new Product2();
        prod1.Food_Category__c = 'CHICKEN';
        prod1.Priced_off_of_guest_count__c = true;
        prod1.Product_Type_Tab__c = 'Food';
        prod1.Sub_Type_Style__c = 'Proteins';        
        prod1.IsActive = true; 
        prod1.Name = 'test Product';      
		
        Product2 prod2 = new Product2();
        prod2.Food_Category__c = 'VEGGIE';
        prod2.Name = 'test prod';
        prod2.Priced_off_of_guest_count__c = true;
        prod2.Product_Type_Tab__c = 'Food';
        prod2.Sub_Type_Style__c = 'Passed Appetizer';        
        prod2.IsActive = true;  
        
        Product2 prod3 = new Product2();
        prod3.Food_Category__c = 'VEGGIE';
        prod3.Name = 'test prod';
        prod3.Priced_off_of_guest_count__c = true;
        prod3.Product_Type_Tab__c = 'Food';
        prod3.Sub_Type_Style__c = 'Starters';        
        prod3.IsActive = true;
        
        Product2 prod4 = new Product2();
        prod4.Food_Category__c = 'VEGGIE';
        prod4.Name = 'test prod';
        prod4.Priced_off_of_guest_count__c = true;
        prod4.Product_Type_Tab__c = 'Food';
        prod4.Sub_Type_Style__c = 'Starches';        
        prod4.IsActive = true;
        
        Product2 prod5 = new Product2();
        prod5.Food_Category__c = 'VEGGIE';
        prod5.Name = 'test prod';
        prod5.Priced_off_of_guest_count__c = true;
        prod5.Product_Type_Tab__c = 'Food';
        prod5.Sub_Type_Style__c = 'Breads';        
        prod5.IsActive = true;
        
        Product2 prod6 = new Product2();
        prod6.Food_Category__c = 'VEGGIE';
        prod6.Name = 'test prod';
        prod6.Priced_off_of_guest_count__c = true;
        prod6.Product_Type_Tab__c = 'Food';
        prod6.Sub_Type_Style__c = 'Food-Stations';        
        prod6.IsActive = true;
        
        Product2 prod7 = new Product2();
        prod7.Food_Category__c = 'VEGGIE';
        prod7.Name = 'test prod';
        prod7.Priced_off_of_guest_count__c = true;
        prod7.Product_Type_Tab__c = 'Food';
        prod7.Sub_Type_Style__c = 'Plated';        
        prod7.IsActive = true;
        
        Product2 prod8 = new Product2();
        prod8.Name = 'test prod';
        prod8.Priced_off_of_guest_count__c = true;
        prod8.Product_Type_Tab__c = 'Rentals';
        prod8.Sub_Type_Style__c = 'Tables';        
        prod8.IsActive = true;
        
        Product2 prod9 = new Product2();
        prod9.Name = 'test prod';
        prod9.Priced_off_of_guest_count__c = true;
        prod9.Product_Type_Tab__c = 'Beverage';
        prod9.Sub_Type_Style__c = 'Beverage-Stations';        
        prod9.IsActive = true;
        
        Product2 prod10 = new Product2();
        prod10.Name = 'test prod';
        prod10.Priced_off_of_guest_count__c = true;
        prod10.Product_Type_Tab__c = 'Staffing';
        prod10.Sub_Type_Style__c = 'Kitchen-People';        
        prod10.IsActive = true;
        
        Product2 prod11 = new Product2();
        prod11.Name = 'test prod';
        prod11.Priced_off_of_guest_count__c = true;
        prod11.Product_Type_Tab__c = 'Venue';
        prod11.Sub_Type_Style__c = 'Venue item';        
        prod11.IsActive = true; 
        
        insert new List<Product2> { prod1, prod2, prod3, prod4, prod5, prod6, prod7, prod8, prod9, prod10, prod11 };
		
        PricebookEntry pbe1 = new PricebookEntry();
        pbe1.UnitPrice = 100;   
        pbe1.Product2Id = prod1.Id;
        pbe1.Pricebook2Id = pricebook2;              
        pbe1.IsActive = true;
		
        PricebookEntry pbe2 = new PricebookEntry();
        pbe2.UnitPrice = 100;   
        pbe2.Product2Id = prod2.Id;
        pbe2.Pricebook2Id = pricebook2;              
        pbe2.IsActive = true;
		
        PricebookEntry pbe3 = new PricebookEntry();
        pbe3.UnitPrice = 100;   
        pbe3.Product2Id = prod3.Id;
        pbe3.Pricebook2Id = pricebook2;              
        pbe3.IsActive = true;
		
        PricebookEntry pbe4 = new PricebookEntry();
        pbe4.UnitPrice = 100;   
        pbe4.Product2Id = prod4.Id;
        pbe4.Pricebook2Id = pricebook2;              
        pbe4.IsActive = true;
		
        PricebookEntry pbe5 = new PricebookEntry();
        pbe5.UnitPrice = 100;   
        pbe5.Product2Id = prod5.Id;
        pbe5.Pricebook2Id = pricebook2;              
        pbe5.IsActive = true;
		
        PricebookEntry pbe6 = new PricebookEntry();
        pbe6.UnitPrice = 100;   
        pbe6.Product2Id = prod6.Id;
        pbe6.Pricebook2Id = pricebook2;              
        pbe6.IsActive = true;
		
        PricebookEntry pbe7 = new PricebookEntry();
        pbe7.UnitPrice = 100;   
        pbe7.Product2Id = prod7.Id;
        pbe7.Pricebook2Id = pricebook2;              
        pbe7.IsActive = true;
		
        PricebookEntry pbe8 = new PricebookEntry();
        pbe8.UnitPrice = 100;   
        pbe8.Product2Id = prod8.Id;
        pbe8.Pricebook2Id = pricebook2;              
        pbe8.IsActive = true;
		
        PricebookEntry pbe9 = new PricebookEntry();
        pbe9.UnitPrice = 100;   
        pbe9.Product2Id = prod9.Id;
        pbe9.Pricebook2Id = pricebook2;              
        pbe9.IsActive = true;
		
        PricebookEntry pbe10 = new PricebookEntry();
        pbe10.UnitPrice = 100;   
        pbe10.Product2Id = prod10.Id;
        pbe10.Pricebook2Id = pricebook2;              
        pbe10.IsActive = true; 
		
        PricebookEntry pbe11 = new PricebookEntry();
        pbe11.UnitPrice = 100;   
        pbe11.Product2Id = prod11.Id;
        pbe11.Pricebook2Id = pricebook2;              
        pbe11.IsActive = true; 
        
        insert new List<PricebookEntry> { pbe1, pbe2, pbe3, pbe4, pbe5, pbe6, pbe7, pbe8, pbe9, pbe10, pbe11 };
        
        QuoteLineItem qLi1 = new QuoteLineItem();
        qLi1.QuoteId = theQuote.Id;
		qLi1.Quantity = 10;
        qLi1.Product2Id = prod1.Id;
        qLi1.PricebookEntryId = pbe1.Id;
        qLi1.UnitPrice = 10;
        qLi1.Hours__c = 10;
        qLi1.Selected_Quantity__c = 10;
        
        QuoteLineItem qLi2 = new QuoteLineItem();
        qLi2.QuoteId = theQuote.Id;
		qLi2.Quantity = 10;
        qLi2.Product2Id = prod2.Id;
        qLi2.PricebookEntryId = pbe2.Id;
        qLi2.UnitPrice = 10;
        qLi2.Hours__c = 10;
        qLi2.Selected_Quantity__c = 10;
        
        QuoteLineItem qLi3 = new QuoteLineItem();
        qLi3.QuoteId = theQuote.Id;
		qLi3.Quantity = 10;
        qLi3.Product2Id = prod3.Id;
        qLi3.PricebookEntryId = pbe3.Id;
        qLi3.UnitPrice = 10;
        qLi3.Hours__c = 10;
        qLi3.Selected_Quantity__c = 10;
        
        QuoteLineItem qLi4 = new QuoteLineItem();
        qLi4.QuoteId = theQuote.Id;
		qLi4.Quantity = 10;
        qLi4.Product2Id = prod4.Id;
        qLi4.PricebookEntryId = pbe4.Id;
        qLi4.UnitPrice = 10;
        qLi4.Hours__c = 10;
        qLi4.Selected_Quantity__c = 10;
        
        QuoteLineItem qLi5 = new QuoteLineItem();
        qLi5.QuoteId = theQuote.Id;
		qLi5.Quantity = 10;
        qLi5.Product2Id = prod5.Id;
        qLi5.PricebookEntryId = pbe5.Id;
        qLi5.UnitPrice = 10;
        qLi5.Hours__c = 10;
        qLi5.Selected_Quantity__c = 10;
        
        QuoteLineItem qLi6 = new QuoteLineItem();
        qLi6.QuoteId = theQuote.Id;
		qLi6.Quantity = 10;
        qLi6.Product2Id = prod6.Id;
        qLi6.PricebookEntryId = pbe6.Id;
        qLi6.UnitPrice = 10;
        qLi6.Hours__c = 10;
        qLi6.Selected_Quantity__c = 10;
        
        QuoteLineItem qLi7 = new QuoteLineItem();
        qLi7.QuoteId = theQuote.Id;
		qLi7.Quantity = 10;
        qLi7.Product2Id = prod7.Id;
        qLi7.PricebookEntryId = pbe7.Id;
        qLi7.UnitPrice = 10;
        qLi7.Hours__c = 10;
        qLi7.Selected_Quantity__c = 10;
        
        QuoteLineItem qLi8 = new QuoteLineItem();
        qLi8.QuoteId = theQuote.Id;
		qLi8.Quantity = 10;
        qLi8.Product2Id = prod8.Id;
        qLi8.PricebookEntryId = pbe8.Id;
        qLi8.UnitPrice = 10;
        qLi8.Hours__c = 10;
        qLi8.Selected_Quantity__c = 10;
        
        QuoteLineItem qLi9 = new QuoteLineItem();
        qLi9.QuoteId = theQuote.Id;
		qLi9.Quantity = 10;
        qLi9.Product2Id = prod9.Id;
        qLi9.PricebookEntryId = pbe9.Id;
        qLi9.UnitPrice = 10;
        qLi9.Hours__c = 10;
        qLi9.Selected_Quantity__c = 10;
        
        QuoteLineItem qLi10 = new QuoteLineItem();
        qLi10.QuoteId = theQuote.Id;
		qLi10.Quantity = 10;
        qLi10.Product2Id = prod10.Id;
        qLi10.PricebookEntryId = pbe10.Id;
        qLi10.UnitPrice = 10;
        qLi10.Hours__c = 10;
        qLi10.Selected_Quantity__c = 10;
        
        QuoteLineItem qLi11 = new QuoteLineItem();
        qLi11.QuoteId = theQuote.Id;
		qLi11.Quantity = 10;
        qLi11.Product2Id = prod11.Id;
        qLi11.PricebookEntryId = pbe11.Id;
        qLi11.UnitPrice = 10;
        qLi11.Hours__c = 10;
        qLi11.Selected_Quantity__c = 10;
        
        insert new List<QuoteLineItem> { qLi1, qLi2, qLi3, qLi4, qLi5, qLi6 ,qLi7, qLi8, qLi9, qLi10, qLi11 };
        
        // Run the code
        Test.startTest();
        Custom_Quote_Controller cQC = new Custom_Quote_Controller(theQuote.Id);
        cQc.saveAllItems();
        
        List<Quote_Line_Wrapper> bevSum = cQc.getSummaryBeverage();
        List<Quote_Line_Wrapper> foodSum = cQc.getSummaryFood();
        List<Quote_Line_Wrapper> retSum = cQc.getSummaryRentals();
        List<Quote_Line_Wrapper> venSum = cQc.getSummaryVenue();
        List<Quote_Line_Wrapper> staffSum = cQc.getSummaryStaff();
        Test.stopTest();
        
        // Verify Results
        System.assertEquals(1000, cQc.getFood_ProteinsTotal());
        System.assertEquals(1000, cQc.getFood_PassedAppsTotal());
        System.assertEquals(1000, cQc.getFood_PlatedTotal());
        System.assertEquals(1000, cQc.getFood_StarchesTotal());
        System.assertEquals(1000, cQc.getFood_StartersTotal());
        System.assertEquals(1000, cQc.getFood_StationsTotal());
        System.assertEquals(1000, cQc.getFood_BreadsTotal());
        System.assertEquals(0, cQc.getFood_WrapsWichesTotal());
        System.assertEquals(7000, cQc.getFood_Total());
        System.assertEquals(1000, cQc.getRentalTotal());
        System.assertEquals(1000, cQc.getBev_StationsTotal());
        System.assertEquals(1000, cQc.getStaffTotal());
        System.assertEquals(1000, cQc.getVenueTotal());
        System.assertEquals(1, bevSum.size());
        System.assertEquals(7, foodSum.size());
        System.assertEquals(1, retSum.size());
        System.assertEquals(1, venSum.size());
        System.assertEquals(1, staffSum.size());
        System.assertEquals(10, bevSum[0].guestCount);
        System.assertEquals(true, bevSum[0].quantitySelected);
        
    }
    
    @isTest 
    public static void GoBackTest() {
        
        // Data setup
        Opportunity theOpp = new Opportunity();
        theOpp.StageName = 'New';
        theOpp.CloseDate = date.today();
        theOpp.Name = 'testOpp';
        insert theOpp;
        
        Quote theQuote = new Quote();
        theQuote.Name = 'Quote Name';
        theQuote.OpportunityId = theOpp.Id;
        insert theQuote;
        
        // Run the code
        Test.startTest();
        Custom_Quote_Controller cQC = new Custom_Quote_Controller(theQuote.Id);
        PageReference backPage = cQc.goBack();
        Test.stopTest();
        
        // Verify Results
        System.assertEquals('/' + theQuote.Id, backPage.getUrl());
      
    }
    
    @isTest 
    public static void SyncQuoteTest() {
        
        // Data setup
        Opportunity theOpp = new Opportunity();
        theOpp.StageName = 'New';
        theOpp.CloseDate = date.today();
        theOpp.Name = 'testOpp';
        insert theOpp;
        
        Quote theQuote = new Quote();
        theQuote.Name = 'Quote Name';
        theQuote.OpportunityId = theOpp.Id;
        insert theQuote;
        
        // Run the code
        Test.startTest();
        ApexPages.StandardController stdcontroller = new ApexPages.StandardController(theQuote);
        Custom_Sync_Quote cSq = new Custom_Sync_Quote(stdcontroller);
        try{
        	PageReference syncQuote = cSq.syncQuote();
        }
        catch(Exception e){
            system.debug('SyncQuote test class exception:  ' + e.getMessage());
        }
        // Verify Results
        Opportunity o = [SELECT SyncedQuoteId FROM Opportunity WHERE Id =:theOpp.Id];
        System.assertEquals(theQuote.Id,o.SyncedQuoteId);

		// Unsync Quote
        try{
        	PageReference unsyncQuote = cSq.syncQuote();
        }
        catch(Exception e){
            system.debug('SyncQuote test class exception:  ' + e.getMessage());
        } 
        
        // Verify Results
        o = [SELECT SyncedQuoteId FROM Opportunity WHERE Id =:theOpp.Id];
        System.assertEquals(null,o.SyncedQuoteId);        
        
        Test.stopTest();
        

      	
    }    
    
    @isTest
    public static void WrapperTest() {
        
    }
}