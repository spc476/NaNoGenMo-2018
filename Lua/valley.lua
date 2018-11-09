#!/usr/bin/env lua
-- ************************************************************************
--
--  Copyright 2018 by Sean Conner.  All Rights Reserved.
--
--  This program is free software: you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation, either version 3 of the License, or
--  (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-- Comments, questinos and criticisms can be sent to: sean@conman.org
--
-- ************************************************************************
-- luacheck: ignore 611

             require "org.conman.math".randomseed()
local lpeg = require "lpeg"
local Cs   = lpeg.Cs
local P    = lpeg.P

local phrase1 do
  local replies =
  {
    "like, ya know, ",
    "",
    "like wow! ",
    "ya know, like, ",
    "",
    "",
  }
  
  phrase1 = (
	        P" can be "
	      + P" can't be "
	      + P" should have been "
              + P" shouldn't have been "
              + P" should be "
              + P" shouldn't be "
              + P" was "
              + P" wasn't "
              + P" will be "
              + P" won't be "
              + P" is "
	    )
	  / function(p)
	      return p .. replies[math.random(#replies)]
	    end
end

local phrase2 do
  local replies =
  {
    " if, like, you're a Pisces ",
    " if, like, the moon is full ",
    " if, like, the vibes are right ",
    " when, like, you get the feeling ",
    " maybe ",
    " maybe ",
  }
  
  phrase2 = P" maybe "
          / function()
              return replies[math.random(#replies)]
            end
end

local comma do
  local replies =
  {
    ", like, ",
    ", fer shure, ",
    ", like, wow, ",
    ", oh, baby, ",
    ", man, ",
    ", mostly, ",
  }
  
  comma = P", "
        / function()
            return replies[math.random(#replies)]
          end
end

return Cs((
	     P" bad"		/ " mean"
           + P" big"		/ " bitchin'est"
           + P" body"		/ " bod"
           + P" bore"		/ " drag"
           + P" car "		/ " rod "
           + P" dirty"		/ " grodie"
           + P" filthy"		/ " grodie to thuh max"
           + P" food"		/ " munchies"
           + P" girl"		/ " chick"
           + P" Good"		/ " Bitchin'"
           + P" good"		/ " bitchin'"
           + P" Great"		/ " Awesum"
           + P" great"		/ " awesum"
           + P" gross"		/ " grodie"
           + P" guy"		/ " dude"
           + P" Her "		/ " That chick "
           + P" her "		/ " that chick "
           + P" her."		/ " that chick."
           + P" Him "		/ " That dude "
           + P" him "		/ " that dude "
           + P" him."		/ " that dude."
           + phrase1
           + P" house"		/ " pad"
           + P" interesting"	/ " cool"
           + P" large"		/ " awesum"
           + P" leave"		/ " blow"
           + P" man"		/ " nerd"
           + phrase2
           + P" meeting"	/ " party"
           + P" movie"		/ " flick"
           + P" music"		/ " tunes "
           + P" neat"		/ " keen"
           + P" nice"		/ " class"
           + P" no way"		/ " just no way"
           + P" people"		/ " guys"
           + P" really"		/ " totally"
           + P" strange"	/ " freaky"
           + P" the "		/ " thuh "
           + P" very "		/ " super"
           + P" weird"		/ " far out"
           + P" yes"		/ " fur shure"
           + P"But"		/ " Man. "
           + P"He "		/ "That dude "
           + P"I like"		/ "I can dig"
           + P"No,"		/ "Like, no way."
           + P"Sir"		/ "Man"
           + P"This"		/ "Like, ya know, this"
           + P"There"		/ "Like, there"
           + P"We "		/ "Us guys "
           + P"Yes,"		/ "Like,"
           + comma
           + P"ing"		/ "in'"
           + P(1)
         )^1)
