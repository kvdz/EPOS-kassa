/* Copyright 2017 Kay van der Zander
*
* This file is part of Kassa.
*
* Kassa is free software: you can redistribute it
* and/or modify it under the terms of the GNU General Public License as
* published by the Free Software Foundation, either version 3 of the
* License, or (at your option) any later version.
*
* Kassa is distributed in the hope that it will be
* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
* Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with Kassa. If not, see http://www.gnu.org/licenses/.
*/

namespace Kassa {
    public class ProductView : Gtk.Grid {
    
        public Gtk.TreeIter iter;
        public Gtk.TreeView productView;
        private Gtk.ListStore list_data;
        private const int ArtikelNumberRowNumber =	0;
        private const int DesciptionRowNumber 	 =	1;
        private const int AmountRowNumber 		 =	2;
        private const int PriceRowNumber 		 =	3;
    
        construct {
            list_data = new Gtk.ListStore (4, typeof (string), typeof (string), typeof (int), typeof (string) );
			list_data.append (out iter);
			string val = "%.2f".printf(0.0000f);
			warning ("%s", val);
			list_data.set (iter, "0", "use barcode scanner or edit artikel number", 0, val);
			list_data.append (out iter);
			
			// The View:
			productView = new Gtk.TreeView.with_model (list_data);
			productView.width_request = 800;
			productView.hexpand = true;
			productView.vexpand = true;
			productView.headers_visible = false;
			productView.set_grid_lines (Gtk.TreeViewGridLines.BOTH);
			this.attach (productView,0,0,1,1);

			Gtk.CellRendererText artikelcell = new Gtk.CellRendererText ();
			artikelcell.set_property ("editable", true);
			artikelcell.width = 100;
			
			artikelcell.edited.connect ((path, newval) => {
				edit_treeview( path, newval, ArtikelNumberRowNumber); // 0 of the artikel number row
			});
			
			Gtk.CellRendererText amountcell = new Gtk.CellRendererText ();
			amountcell.set_property ("editable", true);
			amountcell.width = 50;
			
			amountcell.edited.connect ((path, newval) => {
				edit_treeview (path, newval, AmountRowNumber); // 2 of the amount row
			});
			
			Gtk.CellRendererText desciptioncell = new Gtk.CellRendererText ();
			//desciptioncell.wrap_mode = Pango.WrapMode.WORD;
			//desciptioncell.wrap_width = 575;
			desciptioncell.width = 600;
			
			Gtk.CellRendererText eurocell = new Gtk.CellRendererText ();
			eurocell.width = 50;
			
			productView.insert_column_with_attributes (-1, _("article number"), artikelcell, "text", ArtikelNumberRowNumber);
			productView.insert_column_with_attributes (-1, _("description"), desciptioncell, "text", DesciptionRowNumber);
			productView.insert_column_with_attributes (-1, _("amount"), amountcell, "text", AmountRowNumber);
			productView.insert_column_with_attributes (-1, _("€"), eurocell, "text", PriceRowNumber);
        }
    
    
    	private void edit_treeview (string path, string newval, int rowNumber) {
    		if (path == null && newval == null) {
    			return;
    		}
    		
    		Gtk.TreeIter iter_val;
			if (list_data.get_iter (out iter_val, new Gtk.TreePath.from_string (path))) {
				warning ("path:%s  val:%s", path, newval);
				if (newval == "0" || newval == "") {
					list_data.remove (iter_val);
				} else {
					if(rowNumber == AmountRowNumber) {
						list_data.set_value (iter_val, rowNumber, int.parse(newval));
					} else {
						list_data.set_value (iter_val, rowNumber, newval);
						list_data.append (out iter);
					}
				}
			}
    	}
    	
    	
    	public void set_description (Gtk.TreeIter iter_val, string description) {
    		list_data.set_value (iter_val, DesciptionRowNumber, description);
    	}
    	
    	public void set_price (Gtk.TreeIter iter_val, float price) {
    		list_data.set_value (iter_val, PriceRowNumber, price);
    	}
    	
    	public void set_amount (Gtk.TreeIter iter_val, int amount) {
    		list_data.set_value (iter_val, AmountRowNumber, amount);
    	}
    
    }
}
