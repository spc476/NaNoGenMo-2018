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

local lpeg   = require "lpeg"
local wrap   = require "org.conman.string".wrap
local valley = require "valley"
local chef   = require "chef"

local Cs = lpeg.Cs
local C  = lpeg.C
local P  = lpeg.P
local R  = lpeg.R
local S  = lpeg.S

-- -----------------------------------------------------------------
-- Convert paragrphs separated by a blank line into text where each
-- paragraph is on a single line, and normalize all whitespace.
-- -----------------------------------------------------------------

local char      = P"\n\n" / "\n"
                + S" \t\n"^1 / " "
                + P(1)
local normalize = Cs(char^1)

-- ----------------------------------------------------------------
-- Convert the text.  Non-speech is "translated" to Valley Speak,
-- while speech is "translated" to Swedish Chef (Sorry, Sweeden!).
-- One wrinkle is that quoted speech can span paragraphs, and in
-- that case, the final quote on the previous line is omitted.
-- ----------------------------------------------------------------

local nqq       = P'\n"' + (P(1) - P'"')
local nq        = (P(1) - P'"')^1
local fragment  = C(P'"' * nqq^1 * P'"')
                / function(c)
                    return chef:match(c,1,{})
                  end
                + nq
                / function(c)
                    return valley:match(c)
                  end
local story     = Cs(fragment^1)

-- ----------------------------------------------------------------
-- Convert each line to blank line separated paragraphs
-- ----------------------------------------------------------------

local line      = (R" ~"^0 * P"\n")
                / function(c)
                    return wrap(c)
                  end
local dowrap    = Cs(line^1)

-- ************************************************************************

local f = io.open(arg[1],"r")
local text = f:read("*a")
f:close()

text = normalize:match(text)
text = story:match(text)
text = dowrap:match(text)
print(text)
