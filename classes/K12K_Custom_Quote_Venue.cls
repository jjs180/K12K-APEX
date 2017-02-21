/*
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Custom Quote Venue Controller derived class.
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
public class K12K_Custom_Quote_Venue extends Custom_Quote_Controller{

    public List<Quote_Line_Wrapper> Venue {get;set;}     
    
    public K12K_Custom_Quote_Venue(){    
        initialize();
    }
    
    private void initialize(){
        //Venue
        this.Venue = getItemsHelper('Venue', '%'); //wildcard to get all subtypes
    }     

    public decimal getVenueTotal(){
        decimal total = 0;
        for(Quote_Line_Wrapper qlw: this.Venue ){
            total += (qlw.item.TotalPrice == NULL) ? 0 : qlw.item.TotalPrice;
        }
        return total;
    } 
    
    public override void saveItems(){
        saveItemsList(this.Venue);
        this.initialize();
    }
}