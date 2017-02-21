/*
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Custom Quote Beverages Controller derived class.
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
public class K12K_Custom_Quote_Bev extends Custom_Quote_Controller {

    public List<Quote_Line_Wrapper> Bev_Stations {get;set;}     
    
    public K12K_Custom_Quote_Bev(){    
        initialize();
    }
    
    private void initialize(){
        //Beverages
        this.Bev_Stations = getItemsHelper('Beverage', 'Beverage-Stations');   
    }
     
    public decimal getBev_StationsTotal(){
        decimal total = 0;
        for(Quote_Line_Wrapper qlw: this.Bev_Stations ){
            total += (qlw.item.TotalPrice == NULL) ? 0 : qlw.item.TotalPrice;
        }
        return total;
    }
    
    public override void saveItems(){
        saveItemsList(this.Bev_Stations);
        this.initialize();
    }
    
}