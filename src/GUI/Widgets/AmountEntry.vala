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
    public class AmountEntry : Gtk.Entry {
    
        construct{
            this.enditable = true;
            this.max_width_chars = 5;
            this.placeholder_text = "12345";
            this.truncate_mulitline = false;
        }
    }
}
