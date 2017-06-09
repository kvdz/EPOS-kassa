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
    public class MainWindow : Gtk.Window {
    
        private Gtk.HeaderBar headerbar;
        private Gtk.Button Settingsbtn;
        private Gtk.Grid grid;
    
        public MainWindow (Application application) {
            this.set_application (application);
            this.set_default_size (800, 600);

            build_header_bar ();
            build_main_window ();
	    }
	    
	    private void build_header_bar () {
	        headerbar = new Gtk.HeaderBar ();
            headerbar.show_close_button = true;
            headerbar.set_title ("Kassa");
            
            Settingsbtn = new Gtk.Button.from_icon_name ("preferences-system", Gtk.IconSize.LARGE_TOOLBAR);
            
            headerbar.pack_end (Settingsbtn);
            this.set_titlebar (headerbar);
	    
	    }
	    
	    private void build_main_window () {
	        grid = new Gtk.Grid ();
	        
	        Button payButton = new Button ("Pay", _("button to show pay dialog"));
            payButton.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
            grid.attach (payButton, 0, 1, 1, 1);
            
            ProductView Pordview = new ProductView ();
			grid.attach (Pordview,0,0,1,1);
			
			this.add (grid);
	    
	    }
    }
}
