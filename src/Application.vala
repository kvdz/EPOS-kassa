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
    public class Application : Granite.Application {
                
        construct {
            program_name = "Kassa";
            exec_name = "Kassa";

            app_years = "2017";
            app_icon = "office-calendar";

            main_url = "";
            bug_url = "";
            help_url = "";
            translate_url = "";

            about_authors = {
                "Kay van der Zander <kay20@hotmail.com>"
            };

            about_license_type = Gtk.License.GPL_3_0;
            
            Intl.setlocale (LocaleCategory.ALL, "");
        }

        protected override void activate () {
		    MainWindow mw = new MainWindow ( this );
		    mw.show_all ();
        }
        
        protected override void shutdown () {
            // store all on exit
            base.shutdown ();
        }

    }
}


public static int main (string[] args) {

        var app = new Kassa.Application ();

        return app.run (args);

}
