/*
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Custom Quote Rentals Controller derived class.
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
public class K12K_Custom_Quote_Rentals extends Custom_Quote_Controller {

    public List<Quote_Line_Wrapper> Rentals {get;set;}     
    
    public K12K_Custom_Quote_Rentals(){    
        initialize();
    }
    
    private void initialize(){
        //Rentals
        this.Rentals = getItemsHelper('Rentals', '%');   
    }
         
    public decimal getRentalTotal(){
        decimal total = 0;
        for(Quote_Line_Wrapper qlw: this.Rentals ){
            total += (qlw.item.TotalPrice == NULL) ? 0 : qlw.item.TotalPrice;
        }
        return total;
    }
    
    public override void saveItems(){
        saveItemsList(this.Rentals);
        this.initialize();
    }
}