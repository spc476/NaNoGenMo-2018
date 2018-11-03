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
#include <stdlib.h>
#include <ctype.h>

static double const g_freq[] =
{
  0.08167,
  0.01492,
  0.02782,
  0.04253,
  0.12702,
  0.02228,
  0.02015,
  0.06094,
  0.06966,
  0.00153,
  0.00772,
  0.04025,
  0.02406,
  0.06749,
  0.07507,
  0.01929,
  0.00095,
  0.05987,
  0.06327,
  0.09056,
  0.02758,
  0.00978,
  0.02360,
  0.00150,
  0.01974,
  0.00074,
};

static int letter(void)
{
  double r = (double)rand() / (double)RAND_MAX;
  
  for (int i = 0 ; i < 26 ; i++)
  {
    r -= g_freq[i];
    if (r < 0.0) return i;
  }

  return ' ';
}

int main(int argc,char *argv[])
{
  int c;
  
  if (argc == 1)
    srand(1);
  else
    srand(strtoul(argv[1],NULL,0));
  
  while((c = getchar()) != EOF)
  {
    if (isupper(c))
      c = letter() + 'A';
    else if (islower(c))
      c = letter() + 'a';
    putchar(c);
  }
  
  return 0;
}
