/***************************************************************************
*
* Copyright 2018 by Sean Conner.
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
* Comments, questions and criticisms can be sent to: sean@conman.org
*
*************************************************************************/

#include <stdio.h>
#include <ctype.h>

char const g_upper[] = "EGDEURTYOUIOJHAPZVWBIFXSNA";
char const g_lower[] = "egdeurtyouiojhapzvwbifxsna";

int main(void)
{
  int c;
  
  while((c = getchar()) != EOF)
  {
    if (isupper(c))
      c = g_upper[c - 'A'];
    else if (islower(c))
      c = g_lower[c - 'a'];
    putchar(c);
  }
  return 0;
}
