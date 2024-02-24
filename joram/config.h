/*
Copyright 2018 Mattia Dal Ben <matthewdibi@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#pragma once
#define USE_SERIAL
#define SPLIT_USB_DETECT
#define EE_HANDS

// THEN on left
// qmk flash -kb redox/rev1 -km joram -bl avrdude-split-left
// THEN on right
// qmk flash -kb redox/rev1 -km joram -bl avrdude-split-right

// if there are issues with startup try
#define SPLIT_WATCHDOG_ENABLE

