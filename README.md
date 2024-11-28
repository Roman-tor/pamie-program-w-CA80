Po napisaniu jakiegoś programu do CA80, jeśli chcemy go gdzieś zapamietać/zapisać, możemy użyć funkcji standardowej w CA80 czyli zapis na magnetofon , zlec. #4 w MONITORZE CA80. Alternatywą do tego zapisu na taśmie magnetofonewej jest zapis np. do pamięci IIC typu AT24C512. Jest to pamięc EEPROM, którą można zapisywać i odczytywać bezpośrednio za pomocą CA80, używając programu np. z mojego repozytorium "AT24C512_I2C_eeprom". Mieści się tam sporo programów w przstrzeni  64KB. Problem tylko, jeśli mamy więćej programów i chcielibyśmy mieć do nich łatwyy dostęp. Dletego opracowałem prohgram  zapisu i odczytu programów z CA80 na AT24C512.

Można również wykorzystać to:
https://microgeek.eu/viewtopic.php?f=82&t=2435#p14642
ale tu potrzebna jest płytka PCB z pinami i wkładana do CA80 tam gdzie pamięc od 4000h-7FFFh

Mój program jest dość długi /#AF7/ ale łatwy w obsłudze; warunkiem dobrej przejrzystości programu jest wykorzystanie wyświetlacza LCD 20x4, który też jest w moim repozytirum /schemat podłączenia opracował #ZEGAR, podłączony pod port systemowy U7 -8255. Wyświetlacz pomoże nam wyświetlać nr i nazwę szukanych programów /nazwę programu musimy wpisać podczas pisania programu, poprzedzając ją znakami DDE2h/.
Moje programy, a mam ich teraz ok. 20, mają /przeważnie na końcu programu/ tę nazwę, np "KALENDARZ". Pamięć AT24C512 jest podłączona: zasilanie do odpowiednich pinów złącza ZU50: Vcc do pinu 48, GND do pinu 50, linia DATA do portu PB.0 - pin 9 a linia CLK do portu PC.4 - pin 22 układu U21 - 8255 złącza użytkownika. Pamięc jest ustawiona na "adres" A0 czyli piny A, A1 i A2 tejże pamięci są połączone do GND. Oczywiście, można to zmienić, nadać inny adres ale wówczas w pliku ASM musimy wpisać odpowiedni adres pod <adr_z_64> i <adr_o_64> np. na A4 i A5

cdn...
