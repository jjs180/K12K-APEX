/*
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Custom Quote Food Controller derived class.
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Initial implementation
* @author       Jason Sun <jsun@relationedge.com>
* @created      2017-02-20
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Changes
*
*
* ─────────────────────────────────────────────────────────────────────────────────────────────────
*/
public class K12K_Custom_Quote_Food extends Custom_Quote_Controller {

	public List<Quote_Line_Wrapper> Food_PassedApps {get;set;}    
    public List<Quote_Line_Wrapper> Food_DipsSalads {get;set;}    
    public List<Quote_Line_Wrapper> Food_WrapsWiches {get;set;}
    public List<Quote_Line_Wrapper> Food_Starches {get;set;}  
    public List<Quote_Line_Wrapper> Food_Proteins {get;set;} 
    public List<Quote_Line_Wrapper> Food_Breads {get;set;} 
    public List<Quote_Line_Wrapper> Food_Stations {get;set;}
    public List<Quote_Line_Wrapper> Food_Plated {get;set;}    
    
    private List<Quote_Line_Wrapper> allFoods; 
    
    public K12K_Custom_Quote_Food(){    
        initialize();
    }
    
    private void initialize(){
		//Foods
		this.allFoods = new List<Quote_Line_Wrapper>();        
        this.Food_PassedApps = getItemsHelper('Food', 'Passed Appetizer');
        this.allFoods.addAll(this.Food_PassedApps);
        this.Food_DipsSalads = getItemsHelper('Food', 'Dips&Salads');
        this.allFoods.addAll(this.Food_DipsSalads);        
        this.Food_Starches = getItemsHelper('Food', 'Starches');
        this.allFoods.addAll(this.Food_Starches);        
        this.Food_Proteins = getItemsHelper('Food', 'Proteins');
        this.allFoods.addAll(this.Food_Proteins);          
        this.Food_Breads = getItemsHelper('Food', 'Breads');
        this.allFoods.addAll(this.Food_Breads);          
        this.Food_Stations = getItemsHelper('Food', 'Food-Stations');
        this.allFoods.addAll(this.Food_Stations);          
        this.Food_Plated = getItemsHelper('Food', 'Plated');
        this.allFoods.addAll(this.Food_Plated);      
    }
         
	//Get Totals Methods
    public decimal getFood_PassedAppsTotal(){
        decimal total = 0;
        for(Quote_Line_Wrapper qlw: this.Food_PassedApps ){
            total += (qlw.item.TotalPrice == NULL) ? 0 : qlw.item.TotalPrice;
        }
        return total;
    }    
    
    public decimal getFood_DipsSaladsTotal(){
        decimal total = 0;
        for(Quote_Line_Wrapper qlw: this.Food_DipsSalads ){
            total += (qlw.item.TotalPrice == NULL) ? 0 : qlw.item.TotalPrice;
        }
        return total;
    }      

    public decimal getFood_WrapsWichesTotal(){
        decimal total = 0;
        for(Quote_Line_Wrapper qlw: this.Food_WrapsWiches ){
            total += (qlw.item.TotalPrice == NULL) ? 0 : qlw.item.TotalPrice;
        }
        return total;
    }    
    
    public decimal getFood_StarchesTotal(){
        decimal total = 0;
        for(Quote_Line_Wrapper qlw: this.Food_Starches ){
            total += (qlw.item.TotalPrice == NULL) ? 0 : qlw.item.TotalPrice;
        }
        return total;
    }              
     
    public decimal getFood_ProteinsTotal(){
        decimal total = 0;
        for(Quote_Line_Wrapper qlw: this.Food_Proteins ){
            total += (qlw.item.TotalPrice == NULL) ? 0 : qlw.item.TotalPrice;
        }
        return total;
    }
   
    public decimal getFood_BreadsTotal(){
        decimal total = 0;
        for(Quote_Line_Wrapper qlw: this.Food_Breads ){
            total += (qlw.item.TotalPrice == NULL) ? 0 : qlw.item.TotalPrice;
        }
        return total;
    }
  
    public decimal getFood_StationsTotal(){
        decimal total = 0;
        for(Quote_Line_Wrapper qlw: this.Food_Stations ){
            total += (qlw.item.TotalPrice == NULL) ? 0 : qlw.item.TotalPrice;
        }
        return total;
    }    
       
    public decimal getFood_PlatedTotal(){
        decimal total = 0;
        for(Quote_Line_Wrapper qlw: this.Food_Plated ){
            total += (qlw.item.TotalPrice == NULL) ? 0 : qlw.item.TotalPrice;
        }
        return total;
    }
    
    public override void saveItems(){
        saveItemsList(this.allFoods);
        this.initialize();
    }
}