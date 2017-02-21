/*
* ─────────────────────────────────────────────────────────────────────────────────────────────────
* Custom Quote Staff Controller derived class.
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
public class K12K_Custom_Quote_Staff extends Custom_Quote_Controller {

    public List<Quote_Line_Wrapper> Staffing {get;set;}  
    
    public K12K_Custom_Quote_Staff(){
		initialize();   
    }
    
    private void initialize(){
        //Staffing
        this.Staffing = getItemsHelper('Staffing', ''); //Staffing currently has no subtypes 
    }    
    
    public decimal getStaffTotal(){
        decimal total = 0;
        for(Quote_Line_Wrapper qlw: this.Staffing ){
            total += (qlw.item.TotalPrice == NULL) ? 0 : qlw.item.TotalPrice;
        }
        return total;
    }    
    
    public override void saveItems(){
        saveItemsList(this.Staffing);
        this.initialize();
    }    
    
}