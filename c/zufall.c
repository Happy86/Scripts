/*
 *  Zufall.c
 *  Datenverarbeitung
 *
 *  Created by Andreas Boesen on 13.05.07.
 *  Copyright 2007 boesen-art.de. All rights reserved.
 *
 */

#include "stdio.h"							// Standard Ein-/Ausgabe
#include "stdlib.h"							// Bibliothek fuer rand() (32767)

void chance(int);							
int i;

int main () {
	system("clear");						// unix:clear, win:cls/clrscr();
	
	int length;		
	
	printf ("Bitte geben sie die Laenge ihres neuen Passworts ein: ");
	scanf ("%i", &length);
	printf ("\n\n");
	

	
	printf("Ihr %i Zeichen langer WPA-Pre Shared Key ist: \n", length);
	
	chance(length);
	
	printf ("\n\n");
	
	getchar(); getchar();					// Programm anhalten und auf Eingabe warten (win "bcc": getch();)
	return 0;								// Programm beenden
}


void chance (int length) {
		char zeichen[69];					// Array mit allen Zeichen
			zeichen[0] = '0';
			zeichen[1] = '1';
			zeichen[2] = '2';
			zeichen[3] = '3';
			zeichen[4] = '4';
			zeichen[5] = '5';
			zeichen[6] = '6';
			zeichen[7] = '7';
			zeichen[8] = '8';
			zeichen[9] = '9';
			zeichen[10] = 'a';
			zeichen[11] = 'b';
			zeichen[12] = 'c';
			zeichen[13] = 'd';
			zeichen[14] = 'e';
			zeichen[15] = 'f';
			zeichen[16] = 'g';
			zeichen[17] = 'h';
			zeichen[18] = 'i';
			zeichen[19] = 'j';
			zeichen[20] = 'k';
			zeichen[21] = 'l';
			zeichen[22] = 'm';
			zeichen[23] = 'n';
			zeichen[24] = 'o';
			zeichen[25] = 'p';
			zeichen[26] = 'q';
			zeichen[27] = 'r';
			zeichen[28] = 's';
			zeichen[29] = 't';
			zeichen[30] = 'u';
			zeichen[31] = 'v';
			zeichen[32] = 'w';
			zeichen[33] = 'x';
			zeichen[34] = 'y';
			zeichen[35] = 'z';
			zeichen[36] = 'A';
			zeichen[37] = 'B';
			zeichen[38] = 'C';
			zeichen[39] = 'D';
			zeichen[40] = 'E';
			zeichen[41] = 'F';
			zeichen[42] = 'G';
			zeichen[43] = 'H';
			zeichen[44] = 'I';
			zeichen[45] = 'J';
			zeichen[46] = 'K';
			zeichen[47] = 'L';
			zeichen[48] = 'M';
			zeichen[49] = 'N';
			zeichen[50] = 'O';
			zeichen[51] = 'P';
			zeichen[52] = 'Q';
			zeichen[53] = 'R';
			zeichen[54] = 'S';
			zeichen[55] = 'T';
			zeichen[56] = 'U';
			zeichen[57] = 'V';
			zeichen[58] = 'W';
			zeichen[59] = 'X';
			zeichen[60] = 'Y';
			zeichen[61] = 'Z';
			zeichen[62] = '#';
			zeichen[63] = '$';
			zeichen[64] = '!';
			zeichen[65] = '&';
			zeichen[66] = '%';
			zeichen[67] = '+';
			zeichen[68] = '*';
	
		srand( (unsigned)time ( NULL ));		// initialisierung fuer rand()

		for(i = length;i>0;i--) {				// for-Schleife 
			int random = (rand() % 69);			// Zufallszahl (Erstellung) 

			printf("%c", zeichen[random]);		// Wert aus Array zu Zufallszahl (Ausgabe)
		}

		return;
	
}

