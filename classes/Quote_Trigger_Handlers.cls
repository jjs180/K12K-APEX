/*
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Quote Trigger handler classes
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
public class Quote_Trigger_Handlers {

    private static Set<Id> processedQuoteIds = new Set<Id>();    
    
    public static void afterInsert(List<Quote> newQuoteList){
        List<Quote> quotesToProcess = new List<Quote>();
        for(Quote q: newQuoteList){
            if(q.Package__c != NULL && !processedQuoteIds.contains(q.Id) ){
				quotesToProcess.add(q);                
            }
        }
        if(!quotesToProcess.isEmpty()){
            applyPackageToQuotes(quotesToProcess);
        }
    }
    
    public static void afterUpdate(Map<Id,Quote> newQuoteMap, Map<Id,Quote> oldQuoteMap){
        List<Quote> quotesToProcess = new List<Quote>();        
        
        //get quotes to process for package changes
        for(Quote q: newQuoteMap.values()){
            if(q.Package__c != NULL && !processedQuoteIds.contains(q.Id) &&
              q.Package__c != oldQuoteMap.get(q.Id).Package__c ){
				quotesToProcess.add(q);                    
            }
        }
        
        //get quotes to process for guest count changes
        Set<Id> guestChangedQuoteIds = new Set<Id>();
		for(Quote q: newQuoteMap.values()){
            if(q.Guest_Count__c != oldQuoteMap.get(q.Id).Guest_Count__c &&
              !processedQuoteIds.contains(q.Id)){
                guestChangedQuoteIds.add(q.Id);
                processedQuoteIds.add(q.Id);
            }
        }       
        
        if(!quotesToProcess.isEmpty()){
            applyPackageToQuotes(quotesToProcess);
        }

        if(!guestChangedQuoteIds.isEmpty()){
            recalculateQuoteLines(guestChangedQuoteIds);
        }         
    }
    
    //method to do recalculation of quote lines
    private static void recalculateQuoteLines(Set<Id> quoteIdSet){
        for(Id qId: quoteIdSet){
            Custom_Quote_Controller cqController = new Custom_Quote_Controller(qId);
            cqController.saveAllItems();
        }
    }
    
    //method to apply Package Items to Quotes
    public static void applyPackageToQuotes(List<Quote> quoteList){
        //First delete all existing quote line items
        List<QuoteLineItem> qliDeleteList = [SELECT Id FROM QuoteLineItem WHERE quoteId IN: quoteList];
        delete qliDeleteList;
        
		//Get a set of all packages in list of quotes
		Set<Id> packageIds = new Set<Id>();
        for(Quote q: quoteList){
            packageIds.add(q.Package__c);
        }

        //Get all product Ids in the packages in scope
        //and get a map of Package Items to Package Id
        Set<Id> ProductIdSet = new Set<Id>();
        Map< Id, List<Package_Item__c> > packageToItemsMap = new Map< Id, List<Package_Item__c> >();
        for(Package__c pack: [ SELECT Id, (SELECT Product__c, Package__c FROM Package_Items__r) FROM Package__c WHERE Id IN: packageIds]){
            packageToItemsMap.put(pack.Id,pack.Package_Items__r);
            for(Package_Item__c pi: pack.Package_Items__r){
                ProductIdSet.add(pi.Product__c);
            }
        }
        
        //Create a map of pricebook entry Ids with a combo key of 
        //Product2Id and PricebookId
        Map<String, PricebookEntry> priceBookEntryMap = new Map<string,PricebookEntry>();
        for(PricebookEntry pbe: [SELECT Id, Product2Id, Product2.Alternative_Calculation__c, Pricebook2Id, UnitPrice FROM PricebookEntry WHERE Product2Id IN:ProductIdSet]){
            priceBookEntryMap.put(string.valueOf(pbe.product2Id) + string.valueOf(pbe.Pricebook2Id), pbe);
        }
        system.debug('pricebookentry map---' + priceBookEntryMap);
        
        //Loop through quotes and create list of quote Line Items to insert
        List<QuoteLineItem> qliToInsert = new List<QuoteLineItem>();
        for(Quote q: quoteList){
            for(Package_Item__c pi: packageToItemsMap.get(q.package__c)){
                system.debug('combo key---' + string.valueOf(pi.Product__c) + string.valueOf(q.Pricebook2Id));
                if(priceBookEntryMap.get( string.valueOf(pi.Product__c) + string.valueOf(q.Pricebook2Id) ) != NULL){
                	QuoteLineItem qli = new QuoteLineItem(QuoteId = q.Id);                
                	qli.PricebookEntryId = priceBookEntryMap.get( string.valueOf(pi.Product__c) + string.valueOf(q.Pricebook2Id) ).Id;
                	qli.Selected_Quantity__c = 1;
                    qli.Quantity = 1; //TO-DO:  Make quantity dynamic based on package item settings
                	qli.UnitPrice = priceBookEntryMap.get( string.valueOf(pi.Product__c) + string.valueOf(q.Pricebook2Id) ).UnitPrice;
                	qliToInsert.add(qli);                    
                }
            }
        }
        
        if(!qliToInsert.isEmpty()){
            system.debug('Quote Lines list---' + qliToInsert);
            try{ 
                insert qliToInsert;
            }
            catch(Exception e){
                system.debug('EXCEPTION occurred trying to insert quote Lines during automated package insert---' + e.getMessage());              
            }
        }
    }
    
}