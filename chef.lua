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
-- NOTE: the resulting pattern MUST be called with an empty table so the
-- production rules can keep state during processing.  This means you will
-- call this pattern like:
--
--      chef   = require "chef"
--      output = chef:match(input,1,{})
--
-- ************************************************************************
-- luacheck: ignore 611

             require "org.conman.math".randomseed()
local lpeg = require "lpeg"
local Carg = lpeg.Carg
local Cmt  = lpeg.Cmt
local Cs   = lpeg.Cs
local C    = lpeg.C
local B    = lpeg.B
local P    = lpeg.P
local R    = lpeg.R

-- ************************************************************************

local function noseen(_,position,capture)
  capture.seen = false
  return position
end

-- ************************************************************************

local function seenit(_,position,capture)
  if capture.seen then
    return position,"i"
  else
    capture.seen = true
    return position,"ee"
  end
end

-- ************************************************************************

local function bjorkbjorkbjork(_,position,capture,data)
  data.seen = false
  if capture == '!' then
    return position,capture .. " Bjork bjork bjork" .. capture
  end
  
  if math.random(4) == 1 then
    if capture == ',' then
      return position,capture .. " bjork bjork bjork" .. capture
    else
      return position,capture .. " Bjork bjork bjork" .. capture
    end
  else
    return position,capture
  end
end

-- ************************************************************************

local WC   = R("AZ","az","''")
local NW   = (P(1) - WC)
local chef = Cmt(C"," * Carg(1),bjorkbjorkbjork)
           + Cmt(C"." * Carg(1),bjorkbjorkbjork)
           + Cmt(C"!" * Carg(1),bjorkbjorkbjork)
           + Cmt(NW   * Carg(1),noseen)
           + P"an"                    / "un"
           + P"An"                    / "Un"
           + P"au"                    / "oo"
           + P"Au"                    / "Oo"
           + P"a"  *  #WC             / "e"
           + P"A"  *  #WC             / "E"
           + P"en" *  #NW             / "ee"
           + B(WC) *  P"ew"           / "oo"
           + B(WC) *  P"e" * #NW      / "e-a"
           + B(NW) *  P"e"            / "i"
           + B(NW) *  P"E"            / "I"
           + B(WC) *  P"f"            / "ff"
           + B(WC) *  P"ir"           / "ur"
           + Cmt(B(WC) * P"i" * Carg(1),seenit)
           + B(WC) *  P"ow"           / "oo"
           + B(NW) *  P"o"            / "oo"
           + B(NW) *  P"O"            / "OO"
           + B(WC) *  P"o"            / "u"
           + P"the"                   / "zee"
           + P"The"                   / "Zee"
           + P"th" *  #NW             / "t"
           + B(WC) *  P"tion"         / "shun"
           + B(WC) *  P"u"            / "oo"
           + B(WC) *  P"U"            / "OO"
           + P"v"                     / "f"
           + P"V"                     / "F"
           + P"w"                     / "v"
           + P"W"                     / "V"
           + P(1)
           
return Carg(1) / function(c) c.seen = false end
     * Cs(chef^1)
