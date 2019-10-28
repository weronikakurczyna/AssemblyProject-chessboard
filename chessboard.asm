	ORG 800H  
	
	LXI H,TEKST_POWITALNY
	RST 3
	LXI H,TEKST_SYMBOL
	RST 3
	RST 2 							;wczytanie znaku z klawiatury do akumulatora
	LXI H,TEKST_NOWA_LINIA
	RST 3
	MVI B,80 						;licznik wypisan (znaki w poziomie)
	MVI C,5  						;licznik znakow pod rzad
	MVI E,25 						;licznik wypisanych linii (znaki w pionie)
	MVI H,32 						;znak spacji
	
	
WYPISZ

	RST 1 							;wypisz zawartosc akumulatora
	DCR B							;zmniejsz zawartosc B (licznik wypisan)
	CZ KONIEC_LINII 				;CALL a jezeli spelniony warunek w (przejdz do KONIEC jesli zawartosc B = 0)
	DCR C 							;zmniejsz zawartosc C (licznik znakow pod rzad)
	CZ ZMIEN_ZNAK 					;CALLzero, przejdz do ZMIEN_ZNAK jesli zawartosc C = 0
	JMP WYPISZ						;przejdz do WYPISZ
	
	
ZMIEN_ZNAK							;funkcja zmieniajaca znak po 5 gwiazdkach na spacje

	MOV D,A 						;przesuwa (kopiuje) zawartosc akumulatora (np. '*') do nowego rejestru D 
	MOV A,H							;przesuwa zawartosc H (czyli znak spacji) do akumulatora
	MOV H,D 						;przesuwa zawartosc D (np. '*') do H 
	MVI C,5							;wpisanie do rejestru C '5'
	RET								;wraca do miejsca, gdzie ZMIEN_ZNAK zostalo wywolane (czyli WYPISZ)
	
	
KONIEC_LINII
						
	MVI B,80						;zresetowanie licznika wypisan znakow w poziomie
	DCR E							;zmniejsz zawartosc E (znaki w pionie)
	JZ KONIEC_PROGRAMU				;jezeli zawartosc E bedzie rowna 0 to przejdz do KONIEC_PROGRAMU
	RET								;powrot do WYPISZ
	
	
KONIEC_PROGRAMU

	HLT
	
TEKST_POWITALNY DB 10,13,'Witaj',10,13,'@'
TEKST_SYMBOL DB 10,13,'Podaj symbol >> ',10,13,'@'
TEKST_NOWA_LINIA DB 10,13,'@'