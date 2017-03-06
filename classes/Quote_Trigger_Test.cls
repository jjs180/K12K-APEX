/*
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Test class for Quote_Triggers and Quote_Trigger_Handlers
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
public class Quote_Trigger_Test {
    
	@isTest
    public static void TestTrigger(){
        
		// Data setup
        Id pricebook2 = Test.getStandardPricebookId();
        
        Product2 prod1 = new Product2();
        prod1.Food_Category__c = 'CHICKEN';
        prod1.Priced_off_of_guest_count__c = true;
        prod1.Product_Type_Tab__c = 'Food';
        prod1.Sub_Type_Style__c = 'Proteins';        
        prod1.IsActive = true; 
        prod1.Name = 'test Product'; 
        insert prod1;
        
        PricebookEntry pbe1 = new PricebookEntry();
        pbe1.UnitPrice = 100;   
        pbe1.Product2Id = prod1.Id;
        pbe1.Pricebook2Id = pricebook2;              
        pbe1.IsActive = true;
        insert pbe1;
        
        Opportunity theOpp = new Opportunity();
        theOpp.StageName = 'New';
        theOpp.CloseDate = date.today();
        theOpp.Name = 'testOpp';
        insert theOpp;
        
        Package__c thePackage1 = new Package__c();
        thePackage1.Name = 'Package Name 1';
        insert thePackage1;
        
        Package__c thePackage2 = new Package__c();
        thePackage2.Name = 'Package Name 2';
        insert thePackage2;
        
        Package_Item__c pItem1 = new Package_Item__c();
        pItem1.Product__c = prod1.Id;
        pItem1.Package__c = thePackage2.Id;
        insert pItem1;
        
        // Run the code
        Test.startTest();
		
        Quote theQuote = new Quote();
        theQuote.Name = 'Quote Name';
        theQuote.OpportunityId = theOpp.Id; 
        theQuote.Pricebook2Id = pricebook2;
        theQuote.Guest_Count__c = 10;
        theQuote.Package__c = thePackage1.Id;
        insert theQuote;
        
        theQuote.Package__c = thePackage2.Id;
        theQuote.Guest_Count__c = 11;
        update theQuote;
		
        Test.stopTest();
        
        // Verify Results
        System.assertEquals(1, [SELECT COUNT() FROM QuoteLineItem]);
    }
}