 ;CPU     "Z80.TBL"
 ;HOF     "INT8" ; jesli "BIN8" wowczas musimy zmienic plik wynikowy na BIN
TI:        EQU 7    ; TI - pobranie znaku z echem
EXPR:      EQU 0213h ; EXPR - pobranie ciagu liczb szesnastkowych /HEX/ na stos
EXPRW:     EQU 19B4h ; j.w. ale tylko cyfry 0-9
PARAM:     EQU 01F4H ; pobiera 4. znaki do HL + PWyœw
COM:       EQU 01ABh  ; COM - pokazuje znak 7-seg z rejestru C
CLR:       EQU 10h   ; CLR - kasowanie wyswietlacza
CLR1:      EQU 11h   ; CLR1 - kasowanie wyswietlacza bez zmiany PWYS
PRINT:     EQU 01D4h ; PRINT - drukuje komunikat z (HL)
PRINT1:    EQU 01D5H ; PRINT1 - drukuje komunikat z (HL) bez zmiany PWYS
CO:        EQU 01E0h ; CO - wyswietlenie cyfry hex
CO1:       EQU 01E1h ; CO1 - wyswietlenie cyfry hex bez zmiany PWYS
LBYTE:     EQU 18h   ; LBYTE - wyswietlenie Aku w HEX
LBYTE1:    EQU 1Bh   ; LBYTE1 - wyswietlenie Aku w HEX bez zmiany PWYS
LADR:      EQU 20h   ; LADR - wyswietlenie HL w HEX
LADR1:     EQU 21h   ; LADR1 - wyswietlenie HL w HEX bez zmiany PWYS
CSTS:      EQU 0FFC3h; pobiera znak z klawiatury /flaga C/
CI:        EQU 0FFC6h; czekanie na puszczenie klawisza a potem na wcisniecie
CIM:       EQU 184H  ; jak CSTS
NMIU:      EQU 0FFCCh; obsluga przerwania niemaskowalnego u¿ytkownika
ERR:       EQU 0A23h ; tekst "Err" ca80
hilo:      EQU 023bh ; HL=HL+1, DE-HL
TOS:       EQU 0FF8Dh; stos systemowy
TOS1:      EQU 0FF66h; stos uzytkownika
ME1:       EQU 039Fh ; czesc zlec. wpisanie stalej do CA -: C-stala, HL, od DE do
L1:        EQU 80h    ; pocz. 1. linii LCD
L2:        EQU 0C0h   ; pocz. 2. linii
L3:        EQU 94h    ; pocz. 3. linii
L4:        EQU 0D4h   ; pocz. 4. linii
CYF0:      EQU 0FFF7h ;wysw. cyfry na pozycji 0 wyswietlacza CA80
CYF1:      EQU 0FFF8h ;wysw. cyfry na pozycji 1
CYF2:      EQU 0FFF9h
CYF3:      EQU 0FFFAh
CYF4:      EQU 0FFFBh
CYF5:      EQU 0FFFCh
CYF6:      EQU 0FFFDh
CYF7:      EQU 0FFFEh
  ; do obslugi LCD
INSTR:     EQU 0E8h  ; INSTRUKCJA
DANA:      EQU 0E9h  ; DANA
LCD_BUSY:  EQU 0EAh  
LCD_RDR:   EQU 0EBh
  
num_pr_EE: EQU 1000h    ; tu zapis pocz. programow w EEPROM - np. adr 1000-1001-pr.nr 0, 1002-1003-pr. nr 1 itd 
pr_EE:     EQU 1100h    ; tu pocz. programow w EEprom AT24C512 /64kbajtow
nr_L:      EQU 0FE00h   ; tu aktualnie wyswiet. nr linii
pr_ile:    EQU 0FE01h   ; ilosc znalezionych programow
;wyb_port:  EQU 0FE03h   ; przechowalnia wybranego portu /E3 lub inny np. E7+
pocz_pr_t: EQU pr_ile+1 ; miejsce w TABL_PR_CA w CA, do obliczen
pr_ca:     EQU 0FE04h   ; numery programow /*4/ lub nr, nazwa, pocz. w EEPR /*6/, FC00-0F wykorz. przy przesuw. tekstu <WYSW_TEKST_CA80>
pocz_wEE:  EQU pr_CA+1  ; pocz. adres wpisu nowego programu /przy zapisie/ lub pocz. szuk programu przy odczycie
pr_od:     EQU pocz_wEE+2 ; zapisz program z RAM CA "od"
pr_do:     EQU pr_od+2  ; zapisz program z RAM CA "do"
pr_dlug:   EQU pr_do+2  ; ilosc bajtow, dlugosc programu
nr_pr:     EQU pr_do+4  ; nr programu /FE0D
pocz_w_CA: EQU pr_do+5  ; pocz. uruchamianego pr. w CA
TABL_PR_CA:EQU pr_do+7  ; tu zapisuj odczytane numery programow /FE10-FEFF 
adr_z_64:  EQU 0A0h    ; "adres" EEPROM 64kB /nr 7/- ustaw na ZAPIS , bit 0->0
adr_o_64:  EQU adr_z_64+1; "adres" EEPROM - ustaw na ODCZYT , bit 0-> 1
CTRL:      EQU 0E3h    ; slowo kontrolne portu 8255 /lub inne np. E7
        ; SDA - PA.0    SCL - PC.4
;WE_WE:     EQU 99h ; SDA WEJ/H, SCL-WEJ/H
;WY_WE:     EQU 89h ; SDA WYJ/L  SCL-WEJ/H -podczas <spr_ACK>
;WE_WY:     EQU 90h ; SDA WEJ/J  SCL-WYJ L
;WY_WY:     EQU 80h ; SDA i SCL na L
;P_SDA:     EQU CTRL-3 ; 0E0h ; port danych - tu PA.0 
        ; SDA - PB.0    SCL - PC.4
WE_WE:     EQU 8Bh ; SDA WEJ/H, SCL-WEJ/H
WY_WE:     EQU 89h ; SDA WYJ/L  SCL-WEJ/H -podczas <spr_ACK>
WE_WY:     EQU 82h ; SDA WEJ/J  SCL-WYJ L
WY_WY:     EQU 80h ; SDA i SCL na L
P_SDA:     EQU CTRL-2 ;  0E1h ; port danych - tu PB.0 - 0E1h
P_CLK:     EQU CTRL-1 ; 0E2h - port CLK - taktowanie zegara PC.4
        ; SDA - PC.0,   SCL - PC.4 - u mnie jako P3
;WE_WE:     EQU 89h ; SDA WEJ/H, SCL-WEJ/H                    89 lub 8Bh
;WY_WE:     EQU 88h ; SDA WYJ/L  SCL-WEJ/H -podczas <spr_ACK> 88 lub 8Ah 
;WE_WY:     EQU 81h ; SDA WEJ/J  SCL-WYJ L                    81 lub 83H
;WY_WY:     EQU 80h ; SDA i SCL na L                            80h       
;P_SDA:      EQU CTRL -1 ; 0E2h ; port danych - tu  PC.0 0E2h
  
  ; okreslenie markerów
M_KPR:     EQU 0FEh       ; M_KPR - marker konca programow: FD E4 , potem FE FE FF FF...
M_PR:      EQU 0FDE4h     ; FD E4 - marker pocz/konca programu 
M_NAZ:     EQU 0DDE2H       ; marker nazwy - DD E2
  ;==============
  ; format pliku z nr i nazwami w EEprom /przyklad/:
  ; od 1000h format jak nizej:
  ; 01 03 11 - 01 nr porgramu, 1103 pocz. tego prgramu w EEPROM I2c
  ; 02 C3 19 - 02 nr porgramu  19C3 pocz.tego prgramu w EEPROM I2C
  ; ... FE FE FE FE - az do 10FF
  ; od 1100h taki format jak nizej:
  ; FD E4 pocz. programu/ow, taki sam jak w FLASH 2 i EEPROm SST29xxx
  ; 01 - nr programu
  ; 00 C0 ; dwa bajty - pocz. programu w RAM CA80 - C000h
  ; 31 66 FF.. .. ..  - nasz program
  ; FD E4 marker konca i pocz. nastepnego prog.
  ; 02 .....program nr 2
  ; 00 D0  ; pocz. programu w CA80 - D000h
  ; 21 11 22 .. .. ..  program
  ; FD E4 nastepny prog.
  ; 03 ..... itd
  ; w programie umieszczamy nazwe, poprzedzajac ja DD E2 !!!
  ; FD E4 FE FE FF FF.. - koniec obszaru z numerami /FD E$ FE FE/, nazwami programow
  ;====
  ; ver. ..b5a - podczas szuk. dl. programu, wysw. nazwe w L1, zapis programow <wpis_pr> w RAM CA
  ; ver. ..b5b - zapis w EEPROM pocz. programow, od adr 1000-10FF, programy od 1100
  ;            ; od 1000h - np. 01 05 11 ... 23 00 C0 FE FE FE FE ...
  ;            01 program nr 1, od 1105h FE FE.. koniec programow            
  ; ver. ..b5d - pobieranie numeru progr. - tylko cyfry CD 0B419h EXPRW 
     ORG 08000h ; EEPROM pod P2 -> PB.0 ; SDA - PB.0    SCL - PC.4
pr_start:
  ; ld a, CTRL ; gdzie podlaczona pamiec EEPROM
  ; ld (wyb_port), a
 progr_E:
   ld SP,0FF66H       ;
   ld HL,CIEE         ;Wlaczenie obslugi "G" w NMI
   ld (CI+1),HL
   ;======
 ;  ld HL, obs_przer1
 ;  ld (CSTS+1), HL
 ;  ld a, 0C3h
 ;  ld (NMIU), A
   ;==========
 CAEE:
   ld SP, 0FF66H
   call ini_wysw ;inicjacja LCD, wpis stalych /FD-od FC99/ do CA
   rst CLR
   defb 80h

CAEEP:
   ld HL,ca_ee ; na CA "EEPr_i2c"
   call PRINT
   defb 80H
     ; na LCD
   call wysw_kom_1
   call TI ; pobierz nr zlec.
   defb 17h
   ld E,A             ; nr zlecenia
   cp LCTX            ; czy "legalne"
   jp nc,EREE ; nielegalne
   rst CLR
   defb 70H
   ld HL,CAEE
   push HL
   ld C,2             ;dla EXPR
   ld HL,CTBLX        ;tablica rozejsc
   ld D,0             ;w E numer zlecenia
   add HL,DE
   add HL,DE
   ld E,(HL)
   inc HL
   ld D,(HL)
   ex DE,HL
   jp (HL)            ;Pseudo CALL

EREE:
   rst CLR
   defb 80H
   ld HL,ERR ; "ERR" na CA
   call PRINT
   defb 35H
   jr CAEE

CTBLX:
         DEFW Z0      ; kasowanie pamieci EEPROM - przygotowanie do zapisu programow
         DEFW Z1      ; szukaj pierwszy wolny nr programu
         DEFW aktual  ; aktualizacja wpisanych programow - wpis do CA i przepisanie do NUM_PR w EEPROM - od 1000
         DEFW spec    ; C9 - powrot - rezerwa
         DEFW Z4      ; Zapisz RAM [od][.][do][.][NR] do EEPROM
         DEFW Z5      ; szukanie dlugosci programu 
         DEFW Z6      ; szukanie nazw programow i przepisanie programu do RAM - podaj nr programu 0-FF
         DEFW spec    ; C9 - powrot - rezerwa  Z7      ; przeglad EEPROM
LCTX:    EQU ($-CTBLX)/2 ; ilosc programow/zleceñ

CIEE: ; obsluga, gdy wcisniemy klawisz G - powrot na pocz. programu
   call CIM   ;jak CD F3 FF
   push AF
   cp 10H     ;Kod klaw. "G"
   jp z,CAEE
   pop AF
   ret
   ;====
;OBS_PRZER1: ; bezwarunkowe przjeœcie, w NMIU FFCC
; call CSTS  ; CD CC FF
;  push AF
;  cp 17h
;  jp z, CAEE
;  pop AF
;  ret
   ;====
Z0: ; kasowanie /wpis FD E4 FE FE/ na pocz. pamieci EEPROM AT24C256/512
   call czysc_lcd
   ld HL, kas_EE ; "Erase?"  na CA
   call print
   defb 80h
   ld HL, kas_EE2 ; "KASOWAC EEPROM?C-OK" na LCD
   call wys_tekst   ;"KASUJ PROGRAM A ="
 Z0a:
   rst 8 ; CF czekaj na wcisniecie klawisza 
   cp 0Ch ; jesli C, to kasuj caly EEPROM I2C
   jp z, Z01
   cp 0Ah ; kasuj program
   jr nz, Z0a
  ; jr CAEE       ; mozna zmodyfikowac i wpisac FF do calej pamieci

kas_prog: ; wcisnieto klaw. A - pobierz nr programu i skasuj
   ld HL, kas_pr1 ; "Eras.Pr."
   call print
   defb 62h
   rst 10h ; D7
   defb 20h
   call find_prog_szuk
     ; znaleziono program
   dec HL
   dec HL
   dec HL
   push HL
   pop IY ; na potrzeby sprawdzenia konca strony
   push BC
   call reset
   call  wpisz_adr ; wpisz adres pocz. zapisu do EEPROM
   ld e, 0FFh   ;  marker FF po FD E4 oznacza "pusty obszar" - FF
   call zap_b_KS
   pop BC ; dlugosc zapisu bajtow FF
   ld e, b  ;  BC - ilosc wolnych bajtów, wpis: najpierw starsze bajty, potem mlodsze
   call zap_b_KS
   ld e, c        ; prostsze do wyswietlenia na LCD
   call zap_b_KS  
 kas2:
   ld e, 0FFh; ta stala bedzie wpisana jako "pusty obszar"
   call zap_bajt
   call sprawdz ;BC = BC-1, czy BC = 0
   jr z, kas_z64
   inc iy
   ; sprawdzenie czy koniec strony zapisu w EEPROM
   ld a, IYL ;dfb 0fdh, 7dh ;   ld ml. bity IY do A
   and 3Fh ; sprawdz mlodsze bity i 4. bit /koniec str. 1F /24C64/
       ; 3Fh - co 64/40h bajtow /24C256/, 7Fh /dla 24C512/, FF - dla 24C16
   cp 0h
   jr nz, kas2
      ; koniec strony: 0,20/4kB/, 40/8kB-DS3231/, itd, przystosowane do EEPROM DS3231 8- kB, 32 kB, 64kB
   call kon_str1
   jr kas2

kas_z64:
   ; dopisac wpis do RAM CA80, tam gdzie byl nr programu FF FF FF
  ld A, (NR_PR)
  ld HL, TABL_PR_CA-3 ; bo programy od 1 a nie od 0 !
  call obl_adr
  push HL
  pop iY
  exx  ; sprawdzimy, czy kasowany program jest ostatni, jesli tak
  push IY       ; zamiast FF FF  FF wpiszemy FE FE FE
  pop HL
  inc HL
  inc HL
  inc HL
  ld A, (HL)
  cp M_KPR ; czy FE  **
  jr nz, abc
  ld A, M_KPR
  push IY
  pop HL
  exx
  jr kas1a
 abc:
  exx
 abc1:
   ; w HL adres /w CA/ kasow. programu
  ld A, 0FFh
 kas1a:
  ld B, 3
   kas1:
  ld (HL), A
  inc HL
  djnz kas1
   ; teraz wpisz FF FF FF do EEPROM w miejsce skasowanego programu *w num_pr_EE /od 1000
   call STOP ; lub RESET
  ld HL, (pocz_pr_t) ; adres w CA , od FE10, tablica nr prog
  ld A, L
  sbc A, 11h ; w CA od FE 10, a w EEPROM od 10 00
  ld L, A 
  ld H, 10h
  push HL
  pop IY ; do kontroli konca strony
  call wpisz_adr ; do EEPROM
  ld BC, 03FFh ; trzy bajty, wartosc 0FF
 kas3:
  ld E, C
  call zap_b_KS ; zapisz bajt i sprawdz czy koniec strony
  nop
  djnz kas3
  call STOP ; teraz nastepuje zapis do EEPROM - uaktualnienie RAM w CA
  call czyt_nr ; przepisanie z EEPROM do CA numerow programow i ich adr. w EEPROM
  ld HL, kon ; "END" na CA
  call print
  defb 30h
  rst  10h ; D7 czysc wysw. CA
  defb 53h
  rst  8 ; CF czekaj na klawisz    
  ret ; jp CAEE

 Z01:
   ld C, M_KPR ; 0FEh ; stala do zapisu
   ld Hl, TABL_PR_CA
   ld DE, TABL_PR_CA+0EFh
   call ME1 ; wpisanie stalej do CA80
   ld HL, num_pr_EE ; w EEPROM, 1000h - dokad
   call wpisz_adr ; START I2C i zapis bajtu/ow
   ld HL, TABL_PR_CA ; w CA80, FE10 ; skad
   ld BC, 0EFh ; dlugosc, ile bajtow zapisac
   call zap_z64
   ; teraz "inicjacja" pamieci FD E4 FE FE
  LD HL, pr_EE
  jp end_wp4 ; zapis tylko FD E4 FE FE na pocz. programow w pamieci EEPROM

Z1: ; sprawdz, ktory numer programu jest wolny call nr_free ; ktory numer jest wolny, wyswietl go na LCD i CA, ile programow na LCD
  call czysc_LCD
  call NR_FREE1
  ld HL, nr_fr+2 ; pocz. tekstu
  call print
  defb 44h
  ld A, E
  rst 18h ; D7 wysw. A
  defb 22h
  rst 8; czekaj na wcisniecie klawisza
  ret ; jp CAEE

END_PR: ; szukaj "najstarszego adresu" w EEPROM w <TABL_PR_CA>
  ld BC, 3 ; tablica  trzybajtowa, moze sie zdarzyc, ze np. wpiszemy program
  ld HL, (TABL_PR_CA+1)       ; "recznie" w miejsce skasowanego, gdzies w srodku
  ld IX, TABL_PR_CA+4  ;       pamieci EEPROM
 sz2:
  ld E, (IX+0)
  ld D, (IX+1)
  ; sprawdz, czy "pusty" obszar /FF FF/ czy koniec <TABL_PT_CA>
  ld A, 0FFh ; pusty obszar
  cp E
  jr nz, sz21
  cp D
  jr z, sz3  
 sz21:
  ld A, 0FEh ; koniec <TABL_PR_CA>
  cp E
  jr nz, sz2a
  cp D
  ret z ; znaleziono "najwiekszy" adres /HL/
  sz2a: 
  push HL
  pop IY  
  sbc HL, DE
  jr c, aa ; DE > HL
 sz3:
  add IX, BC
  push IY
  pop HL
  jr sz2
aa: ; wpisz wiekszy adres do HL i IY
  push DE
  pop HL
  push HL
  pop IY
  add IX, BC
  jr sz2

;end_pr1: ; szukamy ostatniego programu w EEPROM
;  ld hl, TABL_PR_CA ; tablica programow w CA /po trzy bajty- nr prog. i dwa baty -adres w EEPROM
;  ld C, M_KPR ; 2x FE  koniec tablicy programow
;  ld B, 0FFh ; skasowany program
;  a1:
;  ld A, (HL)
;  inc HL
;  cp C  
;  jr nz, a1
;  inc HL
;  cp C
;  jr nz, a1
;  ret ; w HL adres pocz. ostatniego programu w EEPROM

szuk_mFD:  ; szukaj  FD E4 - pocz/koniec programu w EEprom, nastepny bajt to nr programu
   ld ix, pocz_w_CA ; tu beda zapisywane odczytane numery programow / 1,2 ...itd/
 szuk_mFD1:
   call marker_PR
       ; znaleziono FD E4, po nim nr programu, musimy go zapisac w RAM
   call CZYT_BAJT ; odczytuje nr programu i zapisuje w RAM
   cp M_KPR   ;  0FE   FE po FD E4 oznacza koniec programow,
   ret z      ;  koniec programow
   jr szuk_mFD1 ;

      ;[4][ADR1[.][ADR2][.][NR][=] NR = nr programu 1- 99 , tylko cyfry 0-9
Z4: ; zapis programu [od] [.]  [do] [.]  [nr_programu] [=]/ nr 1-99
   ld HL, pr_ob ; "PR/ogram/ kl. A , oB/szar/ kl. E"  na CA
   call print
   defb 80h
   call czysc_LCD
   ld HL, zap_pr_ob ;"ZAPISZ PROGR klaw. A ZAPIS OBSZARU kl. E"
   call wys_tekst ; wyœwietla w 1. i 3. linii
 Z41a:
   call CSTS ; CD C3 FF
   jr nc, Z41a  ; nie wcisnieto klawisza
   cp 0Ah ; czy A ? -> zapisz program
   jr z, Z4_PR
   cp 0Eh ; przepisz obszar z CA do EEPORM [od CA] [.] [do_CA] [.] od_EEP] [=]
   jr nz, Z41a ; ustaw rejestry do zapisu do EEPROM - HL adr. CA, IY - adr. EEPROM, BC - dlugoœæ
  Z4_OB:
   call set_obsz ; pobierz adresy
   call ZAP_z64 ; zapis obszaru do EEPROM
      ; koniec zapisu
   ld HL, kon ; "END" na CA80
   call print
   defb 35h
   ld A, IYL
   rst LBYTE
   defb 20h
   ld A, IYH
   rst LBYTE
   defb 22h
   rst 8 ; CF
   ret ; jp CAEE ; pocz. programu

 Z4_PR: ; zapis programu
   rst CLR
   defb 30h
   call szukam  ;wyswietl na LCD "szukam konca " itd  a na CA "FIND" i mruga kwadr.
   ld HL, pr_EE
   call set_adr_odcz ;
 Z41:
   call czyt_bajt ; IY++
   cp 0FFh ; jesli pierwszy bajt = FF - brak wpisanych programow, pamiec czysta ma FF FF FF ?
   call z, wpis_mark ; wpisz na pocz. EEPROM AT24C512 bajty: FD E4 FE FE
   call end_pr ; szukaj poczatek ostatniego programu w <TABL_PR_CA> w CA -> EEPROM
   ;dec hl      ; za ostatnim programem mozna wpisac nowy /w EEPROM/
   ;dec hl
   ;dec hl
   ;ld D, (HL)
   ;dec HL
   ;ld E, (HL)
   ;ex DE, HL
   ;push HL ; adres w EEPRON do 
   ;pop IY 
   call set_adr_odcz ; bo wyzej byl odczyt teraz wracamy do pocz. /PR_EE/
   call szuk_mFD ; szukamy adr. konca programow w EEPROM (IY) i zapis nr programu do RAM [pocz_w_CA]

 Z42:          ;pobierz adresy i nr programu - przepisz RAM do EEPROM
   rst clr ; CA80
   defb 53h
   call czysc_LCD
   ld HL, zap_do_EE ; "podaj od . do . nr ="
   call wys_tekst1 ; na LCD
   ld HL, ca_od
   call pob_adr
   ld (PR_OD), HL ; zapamietanie
   ld HL, ca_do
   call pob_adr
   ld (PR_DO), HL  ; zapamietanie
   ld HL, nr
   call print
   defb 44h
   call nr_free1
   ld A, E ; pierwszy wolny
   rst 18h ; wysw. nr programu na CA
   defb 22h
   ld C, 1 ; numer programu
   call EXPRW ; tylko 0 - 9 ; zmienia HL!
   defb 20h
   pop BC  ;C - nazwa = nr programu 1 do 99, dwucyfrowy
    ; zapamietanie
   ld DE, (PR_OD) ; ADR1 - od
   ld HL, (PR_DO) ; ADR2 - do
   sbc HL, de
   inc HL
   inc HL
   ld (pr_dlug), HL
   dec iy
   dec iy ; pocz. /w EEPROM/  wpisu nastepnego programu
   ld (pocz_wEE), iy ; przechowanie
   ld a, c ; nr programu
   call spr_nr ; jesli wolny, wpisz go do EEPROM /od 0 - FD/
     ; jesli zajety, znajdz pierwszy wolny nr /FF oznacza wolny obszar/
   push af ; dla LCD
   push af ; dla CA80
   call ini_lcd
   pop af
   rst LBYTE ; DF wysw. rej. A
   defb 20h ; PWYSW
   ld HL, nr_nf ; "noFree" - nr zajety
   call print   ;na CA
   defb 62h
   ld a, L1 ; 1. linia
   out (INSTR), a
   pop af ; numer juz uzywany
   call wysw_A
   ld HL, nr_nf1 ; "numer zajety" na LCD
   call wys_tekst
   call op_100ms
   defb 20 ; op. ok. 2 sek
 z42a:
   call nr_free
   ld a, L3
   out (INSTR), a
   ld HL, pr_END+7 ; "podaj numer progr" na LCD
   call wys_tekst
   call op_100ms ; opoznienie
   defb 10
  Z43:
   rst clr ; czysc na CA CYF0 i CYF1
   defb 20h
   ld HL, nr_prog
   call print
   defb 62h
         ; znaleziono pierwszy wolny numer, mozna go wpisac albo inny nr
   ld c, 1   ; 1 parametr
   call EXPR
   defb 20H
   pop BC  ;C - nowy nr programu
   ld a, c
   call spr_nr ; jesli numer "wolny", to przepisanie  programu do EEPROM
     ;  wpisany nr zajety
   call nr_free
   call op_100ms
   defb 15
   jr z43 
   
 czyt_bajty_pr:
   CALL CZYT_BAJT; odczytuje bajt i zapisuje wg (IX)
   LD (IX), A
   INC IX
   CALL SPRAWDZ ; czy BC = 0, koniec odczytu
   JR NZ, czyt_bajty_pr
       ; koniec odczytu
 ;RES2:
  ; call RESET ; pam. EEprom
  ; ret

RESET: ; reset pamieci 24C16/512
  ; ld c, CTRL
   CALL start_I2C
   LD A, WE_WY
   OUT (CTRL), A
   ;out (CTRL), A
   LD B, 9H ; 9. cykli zegara
 RES21:
   CALL CLK
   DEC B
   JR NZ, RES21
   CALL start_I2C
   NOP
   NOP
   CALL STOP
   RET

kon_str: ; koniec strony podczas zapisu EEPROM
   inc iy ;
   ld a, iyL
   and 3Fh
   cp 0
   ret nz
 kon_str1:
   push bc
   push HL
   CALL STOP ; teraz nastepuje zapis  do EEPROM-koniec strony
   PUSH IY ; aktualny adres zapisu w EEPROM
   POP HL
  ; LD E, adr_z_64 ; "adres" pamieci EEPROM do zapisu
   call wpisz_adr
   POP HL
   POP BC
   RET

wpis_mark: ; jesli pierwszy program /pamiec byla "pusta" FF, to  musimy wpisac marker
   ld HL, pr_EE
   ld IY, pr_EE
   call end_wp3
   ret

spr_nr: ;rej. A i  C - nr programu - czy podany numer programu juz wykorzystany
   cp M_KPR ; 0FEh  ; nr zabroniony, po FD E4 FE oznacza koniec programów w EEPROM
   ret z
   cp 0FFh  ; nr zabroniony , po Fd E4 FF oznacza "pusty obszar" - wypelniony FF
   ret z
   ld b, 80 ; max il. programów 
   ld HL, TABL_PR_CA ; pocz. obszaru szukania numer programu w RAM
  spr1: ; szukaj, czy nr /rej.A/ wolny, jesli tak to przepisz program do EEPROM
   cp (HL)
   ret z ; numer wykorzystany, podaj inny
   inc HL
   inc HL
   inc HL
   dec B
   djnz spr1
   jp PRZEP_PROG
    
nr_free: ; ktory numer programu jest wolny oraz ile programow znaleziono
  call nf ; numer wolny
 nr2:  ; znaleziono nr nieuzywany - pierwszy wolny
   ld A, E
   push af ; dla CA
   push af ; dla LCD
   ld a, L2
   out (INSTR), a
   ld HL, nr_1WOL; tekst na LCD "pierwszy wolny nr " <rej.A>
   call wys_tekst1 ; bez INC (IX) = przeskok na nastepna linie
   pop af
   call wysw_A ; na LCD
   pop af
   rst LBYTE ; wysw. rej. A PWYS 20  wolny numer
   defb 20h
   ld HL, nr_fr ; nrFree
   call print
   defb 62h
   ld a, L3
   out (INSTR), a
   ld HL, ile_pro ; "ZNALEZIONO "
   call wys_tekst1; bez INC (IX) = przeskok na nastepna linie
   call szuk_end_pr ; ile znaleziono programow /rej. E/
   ret               ; rej. D ile "wolnych obszarów" z FF FF ...

  NF: ; ktory numer programu wolny
  ld E, 1 ; od 1, moze byc od 0
 n1:
  ld hl, TABL_PR_CA  ; max 222 bajty
  ld B, 80 ; bo mamy 3x inc hl, wiec B < 222/3
 n2:
  ld A, E
 n21:
  cp (HL)
  jr z, n3
 n22:
 ; pop AF
 ;n22a:
  inc hl
  inc hl
  inc hl
  djnz n21
  ld a, e
  ret ; 1. wolny nr progr. znaleziony

 n3:
  or A
  ld A, E
  inc A
  daa
  ld E, A
  jr n1

przep_prog: ;  zapisz program  CA -> EEPROM
      ; WEJ:
      ; <PR_OD>  <PR_DO> , nr programu w <NR_PR>, ilosc bajtów <PR_DLUG>
  ld (nr_pr), a ; przechowanie numeru programu
        ;od  <POCZ_WEE> - zapisane juz numery programow,  IY wskazuje adres w EEPROM
      ; przepisuje program z CA80 do EEPROM - nr, nazwa, pocz. uruchomienia
  inc IY
  push iy ; IY= <PR_EE>             ; w RAM potem program
  pop HL ; adres pocz. wpisu do EEprom /procedura <set_adr_odcz>
        ;  teraz wpisz nr programu
  call reset
  call  wpisz_adr ; wpisz adres pocz. zapisu do EEPROM
  ld a, (nr_pr) ; pocz. danych:nr, adr. start w CA80
  ld e, a
  ld bc, 1 ; zapisz tylko jeden bajt - tu nr programu
  call ZAP_z641; ma STOP   ; wpis nr, i adres startowy programu w RAM CA80 - IY aktual. adr. w EEPROM
      ; wpis pocz. adresu - start programu w CA80
  ld bc, 2 ; dwa bajty
  inc iy
  push iy
  pop HL ; ciag dalszy zapisu
  call  wpisz_adr ; wpisz adres zapisu do EEPROM
        ; w BC dlugosc - tu 2. bajty
  ld HL, pr_od
  call ZAP_z64 ; wpis do EEPROM
          ; teraz przepisanie programu
  ld de, (pr_od)
  ld HL, (pr_do)
  sbc HL, de
  push HL
  pop bc ; dlugosc do przepisania
  inc bc
  push iy
  pop HL
  inc HL
  call  wpisz_adr ; wpisz adres pocz. zapisu do EEPROM
  ld HL, (pr_od) ; pocz. w RAM pocz. progr /do wpisu do EEPROM/
  inc iy
     ; w BC dlugosc nazwy
  call ZAP_z64 ; wpis programu do EEPROM
  call end_wpisu ; zakonczenie -> wpis  FD E4 FE FE do EEPROM
  call wp_adr_EE
  jp CAEE
    ;=============
ZAP_z64:
   ld e, (HL) ; dana do zapisu
 ZAP_z641:
   call zap_bajt
   call sprawdz ;BC = BC-1, czy BC = 0
   jr nz, zap2
   call STOP ; teraz nastepuje zapis do EEPROM
   ret
 zap2:
   inc HL ; nastepny bajt do zapisu
   inc iy
     ; sprawdzenie czy koniec strony zapisu w EEPROM
   ld a, IYL ;dfb 0fdh, 7dh ;   ld ml. bity IY do A
   and 3Fh ; sprawdz mlodsze bity i 4. bit /koniec str. 1F /24C64/
         ; 3Fh - co 64/40h bajtow /24C256/, 7Fh /dla 24C512/, FF - dla 24C16
   cp 0h
   jr nz, ZAP_z64
    ; koniec strony: 0,20/4kB/, 40/8kB-DS3231/, itd, przystosowane do EEPROM DS3231 8- kB, 32 kB, 64kB
      ; koniec strony, wpisz nowy adres do EEprom
   push bc
   push HL
   CALL STOP ; teraz nastepuje zapis  do EEPROM-koniec strony lub koniec zapisu
   PUSH IY ; aktualny adres zapisu w EEPROM
   POP HL
   call wpisz_adr
   POP HL
   POP BC
   jr zap_z64
     ; na zakonczenie wpisu programu, wpisz FD E4 FE FE i adres pocz.
end_wpisu:          ; wpisu nastepnego programu
   push iy
   pop HL ; ciag dalszy zapisu
   inc HL
   ld a, L  ;
   adc A, 20h ; dodanie 32 x FF wolnych bajtow na ew. zmiany na dluzszy program
   jr nc, end_wp3 ; brak przeniesienia
   inc h
 end_wp3:
   LD L, A ; adres zwiekszony
   end_wp4:
   CALL STOP
   call  wpisz_adr ; wpisz adres pocz. zapisu do EEPROM 
   ld BC, M_PR
   ld E, B
   call zap_b_KS
   ld E, C
   call zap_b_KS
   ld e, M_KPR   ;  0FE
   call zap_b_KS
   ld e, M_KPR   ;  0FE
   call zap_b_KS
   call stop ;  zapis i stop dla EEPROM
   ret ; jp CAEE

zap_b_KS: ; zapisz bajt i sprawdz, czy koniec strony - przy zapisie jednego bajtu!!
   call zap_bajt
   call kon_str
   ret

      ;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Z6: ; odczyt numeru i nazwy programu /z EEPROM/ i zapis do RAM /od PR_CA
   call ini_wysw ; ini LCD i set danych EEPRO wpis stalych /FD-od FC99/ do CA
     ; wysw. znaleziony numer i jego nazwe, przepisz nr do RAM i wyswietl-po 4 nazwy
   ;call czyt_nr ; przepisz z EEPROM do CA nr prog. i adres z EEPROM
   ld HL, pr_EE; pocz. programow w EEprom
   ld IY, pr_EE ; pocz. programow w EEprom - tu bedzie przechowywany adres do obliczen
 wysw_nr2:
   call set_adr_odcz ; ustaw EEprom na odczyt - adres od pocz. programu
  ;szu_nr:
   call szu_DD ; marker /FD E4/ pocz. nr programu  IY++ /adres w EEprom/-bez zapisu do RAM!
   call czyt_bajt ; numer programu
   call wysw_pr_CA ; wysw. nr programu na CA /i LCD/ i sprawdz czy koniec obszaru szukania FD E4 FE FE
   call wysw_nazwe ; na LCD
 ;szu_nr1:
   push iy ; adres w EEPROM
   pop HL ; do <set_adr_odcz> do nowego szukania nazwy w EEprom
   call spr_linie
   jr nz, wysw_nr2 ; szukaj nastepnej nazwy /max 4/
   rst 8 ; CF czekaj na klawisz - jesli wcisn znak 0-F, to wybiera program i uruchomia
   push af  ; nr programu
   call czysc_LCD
   pop af
   cp 0Fh
   jr nc,  wysw_nr2  ; inny niz 0-F, wyswietlaj dalej nazwy programow
                    ; jesli 0 do F -pobierz nr programu i przepisz do RAM
   jp kon_FF1 ;szuk. wpisanego programu

 ;****************
szu_DD: ; szukaj  FD E4 -pocz/koniec programu w EEprom i wyswietl adres na CA
         ; WEJ - B = FD, C = E4
   call marker_PR
   push bc ; ochrona B = FD C = E4
   ld a, IYH ; dla efektu, wysw. starszych/mlodszych bajtow adr. EEPROM
   rst LBYTE  ; zmienia rej. C !!
   defb 26h
   ld a, IYL
   rst LBYTE
   defb 24h
   pop bc
   ret

wysw_pr_CA: ; wysw. nr programu na CA80 /i LCD/ i sprawdza, czy koniec obszaru, jesli po
   push bc         ; FD E4 jest FE ; jesli FD E4 FF -pusty obszar <FF>
   push de
   rst LBYTE
   defb 20h
   call wysw_A  ; podczas szukania IY+2 wskazuje pocz. programu w EEprom I2C
   pop de
   pop bc
   ld a, e ; odtworzenie wartosci - nr programu
   cp 0FFh ; marker FF po FD E4 oznacza pusty obszar
   jr nz, wysw_fe
   halt
   ld a, " "
   out (DANA), A
   call czyt_bajt
   call wysw_A ; mlodszy bajt dlug. "pustego obszaru"
   call czyt_bajt
   call wysw_A
   ld HL, bajt_FF ; " bajtow FF"
   call wys_tekst
   ret
 wysw_fe:
   cp M_KPR ; FE po FD E4 oznacza koniec programow zapisanych w EEPROM I2C
   jp z, kon_FF
   ret

wysw_nazwe:  ; na LCD; najpierw znajdz marker DD E2
   cp 0FFh  ; po FD E4 bylo FF, obszar pusty, nazwy brak
   jr z, wys2
   ld BC, M_PR
   ld L, B ; FD
   ld BC, M_NAZ ; DD E2 i nazwa
 wysw1:
   call CZYT_BAJT; odczytuje bajt, potwierdza ACK, IY++
   cp B ; B = DD?
   push AF
   cp L ; FD - koniec programu
   jr nz, wysw2
   call czyt_bajt
   cp C ; = E4 ? po FD jest E4 - koniec programu i nazwy nie znaleziono
   jr nz, wysw2
   ld HL, br_nazwy ; "BEZ NAZWY"  === A19EW brak DD E2
   call wys_tekst
 wysw11:
   call wys22 ; ustaw linie
   call czyt_bajt ; czy FE ?
   cp M_KPR ; FE po FD E4 oznacza koniec programow zapisanych w EEPROM I2C
   jp z, kon_FF
     ; ostatni odczytany bajt po FD E4 to nr programu
   rst LBYTE  ; DF wysw. nr na CA
   defb 20h
   call wysw_A  ; na LCD
   pop af
   jr wysw_nazwe
 wysw2:
   pop AF
   jr nz, wysw1; szukaj dalej
  szu_AA_1:
   call CZYT_BAJT
   cp c ; = E2?
   jr nz, wysw1
   ; nazwa znaleziona, wyswietl
 wn1:
   ld b, 18 ; max ilosc znakow w nazwie: nr programu 2 + nazwa / pierwszy znak w nazwie spacja!- albo szuka do FF
 wn2:       ; IY wskazuje pocz. nazwy  /HL nie zmienia wartosci!!/
   call czyt_bajt ; odczyt bajtu z EEPROM
   cp 0FFh ; koniec nazwy
   jr z, wys2
   call busy
   out (DANA), A
   djnz wn2
  wys2:
   call RESET ; zatrzymanie pamieci EEPROM
  wys22:
   ld HL, nr_L
   inc (HL)
   call set_linie ;ustaw kursor na odpowiedniej/nastepnej linii
   ret

szukam: ; wyswietl na LCD "szukam konca " itd  a na CA "FIND" i mrugaj. kwadr.
   ld a, L1+3
   out (INSTR), A
   ld HL, find ; "SZUKAM..." na LCD
   call wys_tekst1 ; z INC (IX) na nastepna linie
   call busy
   ld a, L2
   out (INSTR), A
   ld HL, find2
   call wys_tekst1
   ld HL, find1 ; na CA
   call print
   defb 44h
   ret

kon_FF: ; sprawdz w EEprom czy po FD E4 jest  FE; jesli tak,to koniec
                 ;  obszaru z programami
   call reset ; stop dla EEprom
   ld HL, kon_pr ; "KONIEC PROGRAMOW"
   call set_linie
   call wys_tekst ; na LCD
   call op_100ms
   defb 15 ; opoznienie ok. 1,5 sek
   call set_linie
   ld HL, pod_nr
   call wys_tekst
   rst 8 ; CF czekaj na klawisz
    cp 0Fh 
    jp nc, Z6 ; mniejszy niz klaw. F
    ; wcisn. 0-9 
  kon_FF1:
   rst 10h ; D7 czysc wysw. CA
   defb 20h ; dwa pierwsze znaki
   ld HL, nr_prog ; "nrProg" na CA80
   call print
   defb 62h
   call find_prog_szuk ; szukaj nr programu w RAM CA <TABL_PR_CA> i odczyt adresu w EEPROM
     ; znaleziono zadany numer, po nim pocz. startu progr. w CA /np. 23 00 C0
     ; w IY pocz. poszukiwanego programu                   nr 23 start w CA od C000
     ; przechodzimy do obslugi EEPROM
     ; w BC dlugosc programu do odczytu z EEprom I2C
 kon_FF2:
   push BC ; ochrona dlug. programu w I2C
   call reset
   pop BC
   call set_adr_odcz ; adres pocz. programu w EEPROM , /za numerem programu/  
   call czyt_bajty_pr ; odczyt z EEPROM i zapis do RAM wg (IX)
   ld HL, (pocz_w_ca) ; start programu w CA
    ; wysw. na CA pocz. i koniec programu
   push HL ; pocz.
   rst 20h
   defb 44h
   ld HL, CYF4
   set 7, (HL) ; dobicie kropki
   push ix ; koniec
   pop HL
   rst 20h
   defb 40h
   call op_100ms
   defb 1Ah ; op. ok. 1 sek, aby zobaczyc pocz. uruchomienia programu w CA
   pop HL
   jp (HL)  ; skok do programu
   ;-------

wysw_kom_1:
   ld ix, nr_L ; po  <wys_tekst> zwieksz (IX)
   ld HL, CA_EE2 ; "ZAP-ODCZ PROG z EEPR"
   call wys_tekst; i przeskocz na nastepna linie LCD
   ret

marker_PR: ; szukamy markera umieszczonego w BC /FD E4/, bez wpisu do RAM !
   ld BC, M_PR   ;  FD E4, pocz/koniec programu, po nim nr programu
   jr marker1
marker_NAZ:
   ld BC, M_NAZ ; marker "FD E2"i nazwa pliku/programu 
  marker1: ; WEJ - B C =  szukany marker BC=FD E4 -szuk. progr. lub DD E2-szuk nazwy
   call CZYT_BAJT; odczytuje bajt, potwierdza ACK, IY++
   call wysw_kw
   cp b ; B = FD ? - szuk. programu lub DD - szuk. nazwy
   jr nz, marker1; szukaj dalej
  ; znaleziony 1. marker /FD/, szukaj drugiego - E4 - szuk. programu lub E2 - szuk. nazwy
   call CZYT_BAJT
   cp c ; = E4?
   push AF ; zapamietanie
   jr nz, mar1 ; inny niz E4
   cp M_KPR ; 0FEh ; koniec programów : FD E4 FE FE
   jp z, kon_pam; ##koniec obszaru z programami
 mar1:
   pop AF 
   jr nz, marker1 ; szukaj dalej
   ret

;szu_FF: ; po programie jest obszar FF /32x/ do nastepnego programu,
        ; na ewent. drobne zmiany w programie, max 29 bajtów MUSI zostac
        ; co najmniej 3. bajty FF !!
;   ld b, 0FFh
; szu_FF1:
;   call CZYT_BAJT; odczytuje bajt, potwierdza ACK, IY++
;   call wysw_kw
;   cp b ; B = FF ?
;   jr nz, szu_FF1 ; szukaj dalej
  ; znaleziony 1. FF , szukaj drugiego
;   call CZYT_BAJT
;   cp b ; = FF?
;   jr nz, szu_FF1 ; szukaj dalej
    ; drugi tez FF
;   call czyt_bajt
;   cp b
;   jr nz, szu_FF1
;   nop ;dec IY  ; jesli nazwa na koncu programu,, koniec nazwy to FF !!
;   nop
;   ret z

szuk_end_pr: ; na potrzeby wpisu nowego programu, szukamy ilosc programów
   ld de, 0FF00h
   ld HL, TABL_PR_CA  ; szukamy konca wpisanych numerow /1,2,.. itd/
  szuk1:
   inc d ; tu il. wolnych obszarów z bajtami FF FF ...
  szuk2:          ; w RAM <PR_CA> od FE10
   ld a, (HL)
   inc HL
   inc HL
   inc HL
   cp M_KPR  ; koniec odczytanych nr programow w RAM np. 01, 02,03, FE FE FE itd
   ret z   ; POWRÓT z podprogramu
   or A ; CY = 0, wazne przy DAA !
   ld a, e
   inc a
   daa   ; ilosc programow dziesietnie
   ld e, a ; zapamietanie
   jr szuk2

ini_wysw: ; inicjacja LCD, ustaw na 1. linie, wpis stalych /FD-od FC99/ do CA
   ld a, 0 ; 1 - to 1. linia LCD
   ld (nr_L), a
   ld ix, TABL_PR_CA ; do zapisu /w RAM-<PR_CA> / i wysw. nr i nazwy programu na LCD
   call ini_lcd
   call czysc_LCD
   call czyt_nr ; przepisanie z EEPROM do CA numerow programow i ich adr. w EEPROM
   ret

spr_linie: ; jesli byla 4. linia, przejdz na 1.
   ld a, (nr_L) ;
   cp 4 ; czy byla wyswietl. 4. linia?
   ret nz
   ld a, 0 ; ustaw wyswietlanie na 1. linie LCD 0-1-2-3
   ld (nr_L), a
   ret

set_linie: ; wpis do rej. A pocz. linii do wyswietlana
   push HL
   ld a, (nr_L)
   and 3
   ld HL, num_linii
   add a, L
   ld L, a
   ld a, (HL)
   out (INSTR), a
   pop HL
   ret

wysw_kw: ; wysw. kwadrat na CA80, CYF3
   push AF
   EXX
   ld HL, 0FFECh ; setne sek
   ld a, (HL)
   cp 35h; co 1/3 sek
   jr c, wys_kw
  ; cp 70h
   rst clr ; D7
   defb 13h
   jr wys_kw1
  wys_kw:
   ld c, 5ch ; kod kwadratu
   call com
   defb 13h
  wys_kw1:
   EXX
   pop AF
   ret

kon_pr_EE:
      ; znajdz koniec programow w EEPROM FD E4 FE FE
   ld HL, pr_EE ; pocz. programow w EEPROM
   push HL
   pop iy ; tu bedzie adres EEPROM
   call set_adr_odcz
 prz_pr21:
   ld BC, M_PR   ;  FD E4
   call szu_DD ; czytaj bajty w EEprom, gdzie pocz/koniec programow
 prz_pr31:      ; jesli po FD E4 jest FE FE koniec wpisanych programow
   call czyt_bajt
   cp B ; FF ?
   jr nz, prz_pr21
   call czyt_bajt
   cp C
   jr nz, prz_pr21
   ret

nr_free1: ; ktory numer programu jest wolny oraz ile programow znaleziono
   call nf ; ktory nr programu wolny
   ld A, E
  nf4:   ; 1. wolny nr znaleziony
   push af ; dla LCD
   ld a, L3
   out (INSTR), a
   ld HL, nr_1WOL; tekst na LCD "pierwszy wolny nr " <rej.A>
   call wys_tekst1 ; bez INC (IX) = przeskok na nastepna linie
   pop af
   call wysw_A ; na LCD
   ret

kon_pam: ; podczas szukania nie znaleziono numeru programu
   rst 10h
   defb 22h
   push HL ; w L nr programu
   call set_linie
   ld HL, br_nr ; "nie znaleziono"
   call wys_tekst
   pop HL
   ld A, L
   call wysw_A
   ld A, L
   rst LBYTE ; DF wysw. A
   defb 20h
   ld HL, brak ; "BRAK" na CA80
   call print
   defb 44h
   rst 8 ; CF
   jp kon_FF ; pobierz nowy nr programu

;find_prog:
;   call param
;   defb 20h ; nr programu w L
;   ld A, L
;   ld (NR_PR), A
;   push HL
;znaj_pr: ; odszukaj nr programu  w EEPROM
;   ld HL, pr_EE; pocz. programow w EEprom
;   ld IY, pr_EE ; pocz. programow w EEprom - tu bedzie przechowywany adres do obliczen
; wysw_nr21:
;   call set_adr_odcz ; ustaw EEprom na odczyt - adres od pocz. programu
; szu_nr2:
;  pop HL ; w L nr programu
; szu_nr3:
;  call marker_PR ; marker /FD E4/pocz. nr programu i nazwy IY++ /adres w EEprom/-bez zapisuu do RAM!
;  call czyt_bajt ; nr programu
;   push af ; nr programu
;   cp M_KPR; 0FEh ; jesli po FD E4 jest FE - koniec programow
;   call z, kon_pam ; szukanie doszlo do konca pamieci
;   rst LBYTE ; DF wysw. A
;   defb 20h
;   rst 10h ; D7 czysc wysw. CA
;   defb 22h
;   pop af
;   cp L
;   jr nz, szu_nr3
;   call czyt_bajt
;   ld L, A
;   call czyt_bajt
;   ld H, A
;   ld (pocz_W_CA), HL
;   ret

set_obsz:
   rst CLR
   defb 40h
   ld HL, CA_od ; RAM od....
   call pob_adr  ; pobierz adres  CA "od" do HL
   ld (PR_od), HL
   push HL
   ld HL, CA_do
   call pob_adr  ; pobierz adres  CA "do" do HL
   push HL
   ld HL, EEod
   call pob_adr   ; pobierz adres  EEPROM "od" do HL
   push HL
   pop IY ; do kontroli koñca strony podczas zapisu  w EEPROM
   pop HL ; OD
   pop BC ; DO
   SBC HL, BC ; DLUGOSC
   inc HL
   inc HL  ; tyle bajtow do przepisania
   push HL
   pop BC ; dlugosc
   push IY
   pop HL ; pocz. zapisu w EEPROM
  ; LD E, adr_z_64; "adres" pamieci EEPROM do zapisu
   call  wpisz_adr ; wpisz adres pocz. zapisu do EEPROM
   ld HL, (pr_od) ; pocz. w RAM pocz. obszaru do wpisu do EEPROM
   ret

pob_adr: ; pobieranie adresu
   call print ; wyœw "CA_OD", "CA_DO"  "EEod"
   defb 44h
   call PARAM ; pobranie do HL
   defb 40h
 spec: ; potrzebne do programow jeszcze "nieobszadzonych' - powrot do menu
   ret

Z5: ; szukanie dlugosci programu, gdy ew. zamiana programu
   call czysc_lcd
   ld hl, szu_dl
   call wys_tekst
   halt
   ld a, L2
   out (INSTR), A
   ld hl, pod_nr ; lub pr_END+7 ; "podaj nr programu" na LCD
   call wys_tekst
   ld hl, nr_prog
   call print
   defb 62h
   call param ; pobranie do HL
   defb 20h
   ld A, L ; w L nr programu
   call wysw_A
   call find_prog_szuk+4
     ; HL-pocz. programu w EEPROM, BC-czysta dlug. /bez obszaru z FFFF, IX pocz. pr. w CA
     ; teraz znajdz pocz. nastepnego programu - marker FD E4
   push BC   
   push HL ; pocz. prog. w EEPROM
   ld HL, (PR_DLUG)
   push HL
   rst 20h ; wysw. HL
   defb 40h
   ld hl, dlug1
   call print ; na CA
   defb 44h
   ld a, L3
   out (INSTR), A
   ld hl, dlug ; "dlugosc progr " na LCD
   call wys_tekst
   pop hl ; dlug
   ld a, H
   call wysw_A
   ld a, L
   call wysw_A
   halt ; call reset
   ; wysw. adresu programu <od. <do>
   ld a, " "
   out (dana), A
   pop HL ; pocz. w EEPROM 
   call wys_adr_LCD ; wysw. rej HL
   halt
   ld a, "-" ; spacja
   out (DANA), A
   pop BC
   adc HL, BC

   ;ld H, D
   ;ld L, E 
   dec HL
   dec HL
   dec HL
   call wys_adr_LCD
   ;  (IX) wskazuje bajty pocz. programu w CA80
   ld HL, pocz_CA ; "pocz. PR w CA "
   halt
   ld A, L4
   out (INSTR), A
   halt
   call wys_tekst
   ld HL, (pocz_w_CA)
   halt
   call wys_adr_LCD   ; DE wskazuje pocz. programu
   call nazwe ; wysw. nazwe programu w L1
   rst 8 ; CF czekaj na klawisz
   jp pr_start

blad_ACK: ; jesli po 255 probach nie ma ACK
   ld HL, no_ACK
   call print
   defb 44h
   rst 8h ; CF czekaj na wcisniecie klawisza
   ret ;   jp CAEE ; pocz. programu

  ; podprogramy do obslugi LCD-direct
  ;instr_start:  30h,38h,1h,6h,0Eh ; podstawowe instr. ustawiajace LCD
ini_lcd:
   ld a, 30h ;
   out (INSTR),a
   halt
   halt
   halt
   ld a, 30h
   out (INSTR),a
   call op_100us
   call op_100us
   ld a, 30h
   out (INSTR),a
   call op_100us
   ld a, 38h ; sterowanie 8-bit
   out (INSTR),a
   call busy
   ld a, 1 ; czysc LCD
   out (INSTR),a
   halt
   halt
   call op_100us
   ld a, 0Eh ; kursor na dole i wlacz LCD
   out (INSTR),a
   call op_100us
   ld a, 6
   out (INSTR),a
   ;call wpis_PLD ; polskie znaki - duze litery
   ;ld a, L1
   ;out (INSTR), A
   ret    ; powrot z podprogramu ini_lcd

busy: ; czy LCD juz wolne i gotowe do obs³ugi
   push af
  busy1:
   in a,(LCD_BUSY)
   and 80h ; sprawdŸ BIT D7
   jr nz, busy1
   pop af
   ret

CZYSC_LCD:        ; czysci lcd i ustawia kursor na pozycji poczatkowej LCD
   LD   A,1
   OUT  (INSTR),A
   HALT                 ; opoznienie
   HALT
  U_K_HOME:             ; ustaw kursor na poczatek LCD
   LD   A,L1           ; 1. linia/
   OUT  (INSTR),A
   HALT                     ; opoznienie
   HALT
   RET

wys_tekst: ; wysw. tekst wg (HL), koniec tekstu FF, nastepnie przeskok na nastep. linie
   ld a,(HL) ; pobierz litere
   cp 0FFh
   jr z, wys21
   call busy
   out (DANA),a
   inc HL
   jr  wys_tekst
  wys21:
   inc (IX+0) ; nastepna linia LCD
   ret; wyjœcie z podprogramu

WYS_tekst1: ; wysw. tekst wg (HL), koniec tekstu FF
   ld a,(HL) ; pobierz litere
   cp 0FFh
   ret z  ; wyjœcie z podprogramu
   call busy
   out (DANA),a
   inc HL
   jr  wys_tekst1

 wysw_A: ; wyswietla rej. A na LCD
  push AF
  and 0F0h
  rrca 
  rrca
  rrca
  rrca
  cp 0Ah
  sbc A, 69h
  daa
  halt
  out (DANA), A
 AA1:  
  pop AF 
  and 0Fh
  cp 0Ah
  sbc A, 69h
  daa
  halt
  out (DANA), A
  ret

;wysw_A1:; wyswietlenie rej. A na LCD bez zera poczatkowego
;   push HL
;   call rozdziel
;   ld a, L ;
;   cp 30h
;   jr z, wys1 
;   call busy
;   out (DANA), A
;  wys1:
;   ld a, H
;   cp 30h ; czy zero /kod "0" na LCD
;   jr z, wys12
;   call busy
;   out (DANA), A
; wys12:
;   pop HL
;   ret

    ; PODPROGRAMY do obslugi magistrali I2C
start_I2C: ; procedura START dla pamiêci typu 24Cxxx, I2C
   ;ld c, CTRL ; rej. C - wybór portu - E3 (z³¹cze u¿ytk) lub E7 (dodatkowe)
   ld a, WE_WE ; konfiguracja portów  PA, PB i PC WEJ
   out (CTRL), a
   nop
   ld a, WY_WE ; PA i PB WYJ, PC0-3 - WYJ, PC4-7 WEJ
   out (CTRL), a
   nop
   ld a, WY_WY ;   PA, PB, PC0-3, PC4-7 jako WYJ -stan L
   out (CTRL),a
   halt
   halt
   halt
   ret

stop: ; procedura STOP dla pamiêci typu 24Cxxx, I2C
   ;ld c, CTRL ; rej. C - wybór portu - E3 (z³¹cze u¿ytk) lub E7 (dodatkowe)
   ld a, WY_WE
   out (CTRL), a
   nop
   ld a, WE_WE
   out (CTRL), a
   nop
   ld a, WE_WY ; PC0-3 - WEJ, PB I PC4-7 WYJ
   out (CTRL),a
   ld b, 7 ; to jest parametr opoznienia 7 x 2 ms
   call op_100ms
   defb 1
   ret
WPISZ_ADR: ; przed wywolaniem w rej. E adres pamieci np. A XXX R/W
            ; WEJ: E - "adres" pamieci EEprom /np. A0, A2, A4 itd
            ; HL - adres komorki w EEprom do zapisu
   PUSH BC
   CALL start_I2C
   LD E, ADR_Z_64
   CALL ZAP_BAJT
  WPISZ_ADR2:
   LD E, H ; starszy bajt adresu w EEPROM
   CALL ZAP_BAJT
   LD E, L ; mlodszy bajt adresu
   CALL ZAP_BAJT
   POP BC
   RET

CLK:  ; port C /
   ;dec c          ; E2-port PC zlacze uzytkownika
   LD A, 10H
   OUT (P_CLK), A ; SET SCL
   XOR A   ; RES SCL
   OUT (P_CLK), A
   ;INC C ; C = E3 lub E7
   RET
  ;======
CZYT_BAJT: ; odczyt bajtu z EEPROM + potwierdz. ACK ; IY ++ /do obl. dlug. programow
   push bc   ; WYJ - rej, E i A odczytany bajt
   ;ld a, (wyb_port) ; rej. C - wybór portu - E3 (zlacze uzytk) lub E7 (dodatkowe)
   ;ld c, a
  CZYT1:
   LD A, WE_WY ; PC0 WEJ, PC4-7 WYJ SDA "1" SCL "0"
   OUT (CTRL), A
   ;dec c
   ld d, 8; D - il. bitów = 8, E - jako bufor do odbieranych bitów = 0
  CZYT:
   CALL SCLH ; ustaw SCL na H
   NOP       ; opóznienie
   IN A, (P_SDA) ; odczyt portu z SDA
   rrca ; przesuñ na CY
   rl e  ; przesuñ CY na bit 0 rej. E
   CALL SCLL ; ustaw SCL na L
   DEC D
   JR NZ, CZYT  ; czy ostatni bit?
       ; Master /CA80/ wystawia ACK /"0"/ na SDA
   ;INC C
  m_ack1:
   LD A, WY_WY ; PA, PB, PC - WYJ, stan L
   OUT (CTRL), A ; ustaw SDA na L /czytaj nastêpne bajty
   CALL CLK
   NOP ; opóznienie
   POP BC
   INC IY ; na potrzeby adresu w EEprom
   LD A, E
   RET

SCLH:  ; SCL  na H
   LD A, 10H
   OUT (P_CLK), A
   RET

SCLL:  ; SCL na L
   XOR A  ; ustaw SCL /port PC4/ na L
   OUT (P_CLK), A
   RET

set_adr_odcz: ; ustaw pamiec 24C512 do odczytu
   PUSH BC
   call wpisz_adr
   call start_I2C
   LD E, adr_o_64; adres pamieci EEPROM do odczytu
   call zap_bajt
   POP BC
   ret

  ZAP_BAJT: ; wpis bajtu do EEPROM, w E dana do zapisu
           ;PC4/SCL, PC0/SDA, jeœli  jako WEJŒCIE - to stan wysoki H, jeœli WYJ- stan niski L
            ; WEJ: E - dana do zapisu    80h- PA, PB, PC jako WYJ - stan L
   push bc
   LD D, 08H  ;iloœæ bitów
  ZAP:
   LD A, E  ; odtworzenie danej do wpisu
   RLCA     ; przesuñ na lewo /na znacznik C/
   LD E, A  ; zapamiêtanie
   JR C, ZAPJEDYNKE  ; wyslij "1"
  ;wyslanie "0"
   LD A, WY_WY   ; PC0-3 i PC4-7 jako WYJ/ RES SDA i RES SCL stan niski
   OUT (CTRL), A  ; ustawia dane "0" na SDA
  ZEGAR:
   CALL CLK
   DEC D  ; czy 8. bit?
   JR NZ, ZAP
 ACK:  ; info dla SLAVE, ze koniec bajtu
   LD A, WE_WE  ; PC0-3 PC4-7 WEJ, pocz¹tek 9. cyklu SCL "1"
   OUT (CTRL), A
   NOP
  ; push bc
  ; dec c
  ld b, 0FFh ; iloœæ prób sprawdz. ACK
 ACK_0:
   dec b
   jp z, blad_ack
   IN A, (P_SDA) ; odczyt portu PC
   BIT 0H, A ; testuj bit 0 (SDA=0 potwierdzenie, SDA=1 brak
   JR NZ, ACK_0 ; czekaj a¿ ACK
  ; pop bc
   LD A, WE_WY
   OUT (CTRL), A  ;PC0-3 WEJ, PC4-7 WYJ, koniec 9. cyklu SCL /SDA "1" SCL "0"
   pop bc
   RET

 ZAPJEDYNKE:
   LD A, WE_WY  ;  PC0-3 WEJ/SDA/, PC4-7 WYJ/SCL/
   OUT (CTRL), A ; ustawia dane "1" na SDA
   JR ZEGAR

 SPRAWDZ: ; zmniejsza BC o 1 - przy zapisie/odczycie pam. EEprom
   DEC BC
   XOR A
   CP C
   RET NZ
   CP B
   RET

op_100uS:
   ld a, 50h
  op2:
   dec a
   jr nz, op2
   ret

op_100ms:; opózn. x 0,1s+ podaj param. /cd xx yy zz/
  EX (sp), hl    ; zz - wielkosc opóznienia
  ld a, (hl)
  inc hl
  ex (sp), hl
  push bc
  push HL
  ld b, a  
 op1:
  ld HL, 3C18h
 op12:
  dec HL
  ld a, L
  or H
  jr nz, op12 
  djnz op1    
  pop hl
  pop bc
  ret

NUM_LINII:  ; tablica adresów pocz¹tków linii LCD
   defb  L1, L2, L3, L4  ; musi byc na jednej stronie
    ;************komunikaty CA80
nr_prog:  defb 54h, 50h, 73h,50h,5ch, 0bdh, 255 ; "nr ProG" na CA
;wysw_ile: defb 73h, 50h, 5ch, 0BDh, 48h, 0, 255 ; "Prog=" na CA
brak:     defb 7Ch, 50h, 77h, 0F8h, 0FFh ;"brak" na CA80
nr_fr:    defb 54h, 50h, 71h, 50h, 79h, 0F9h, 255 ; "nrFree" na CA
nr_nf:    defb 54h, 5Ch, 71h, 50h, 79h, 0F9h, 255 ; "noFree" na CA
nr:       defb 54h, 50h, 73h, 0D0h, 255 ; "nrPr."  
CA_EE:    defb 79h, 79h, 73h, 50h,8, 4h, 5Bh, 58h,255 ; na CA "EEPr_i2c"
kas_EE:   defb 79H,50H,77H,6DH,79H,0D3H,0,39h,255;"ErASE? C"
kas_Pr1:  defb 79H,50H,77H,0EDH,73h, 50h, 255 ; Eras.PR."
find1:    defb 71h, 10h, 54h, 5Eh, 255 ; "Find"
dlug1:    defb 5Eh, 38h, 1Ch, 0BDh, 255 ;"dLuG."  na CA80
kon:      defb 79h, 54h, 5Eh, 255; tekst "End" dla ca80
pr_ob:    defb 73h, 0D0h, 77h, 0, 5Ch, 0FCh, 8, 79h, 255 ; "PR A ob_E"
CA_od:    defb 39h, 77h, 5Ch, 0DEh, 255 ; napis "CAod."
CA_do:    defb 39h, 77h, 5eh, 0DCh, 255 ; "CAdo."
EEod:     defb 79h, 79h, 5ch, 5eh, 255 ; "EEod" - 0FFh koniec tekstu
no_ack:   defb 54h,77h, 39h, 78h, 0FFh ; "no ACK" dla ca80
     ; komunikaty LCD
find:      defm "  SZUKAM KONCA " ,255
find2:     defm " PROGRAMOW W EEPROM" ,255
nr_1WOL:   defm "PIERWSZY WOLNY NR " ,255
nr_nf1:    defm " NUMER ZAJETY" ,255
ile_pro:   defm "ZNALEZIONO " ,255
pr_END:    defm "KONIEC-podaj nr prog",255 ; na LCD
zap_pr_ob: defm "ZAPISZ PROGR klaw. A ZAPIS OBSZARU kl. E", 255
zap_do_EE: defm "PODAJ od . do . nr =",255
CA_EE2:    defm " ZAP-ODCZ z EEP I2C "; na L1 ,255
kl_4:      defm "2 AKTUALIZUJ 4 ZAPIS"; na L3 
kl_0:      defm "0 KASUJ   1 WOLNY NR"; na L2    
kl_1:      defm "5 DLUGOSC 6 szukPROG",255; a L4 

pod_nr:    defm "PODAJ NR PROGRAMU " ,255
kon_pr:    defm "KONIEC PROGRAMOW" ,255 ;..M" defb 5 "W"
dlug:      defm "dlug ", 255
kas_EE2:   defm "KASOWAC EEPROM? C = KASUJ PROGRAM A =",255
;kas_pr:    defm "KASUJ PROGRAM A =", 255
br_nazwy:  defm "    BEZ NAZWY", 255
;nr_FE:     defm "nr FE i FF rezerwa", 255
br_nr:     defm "NIE ZNALEZIONO ", 255 ; nie znaleziono numeru
bajt_FF:   defm " BAJTOW FF", 255
;obsz_FF:   defm "obszary z FF  ", 255
przegL:    defm "PRZEGLAD EEPROM-I2C", 255
szu_dl:    defm "SZUK DLUG PROGRAMU", 255
pocz_CA:   defm "pocz. PR w CA ", 255 
   ;# po ostatnim (mozna wpisac wczesniej) bajcie programu wpisujemy DDE2 jako marker pocz. nazwy
   defb 0DDh, 0E2h ; po tym markerze DDE2 nazwa/tytul programu
   defm " SZU I2C P3 B500",255 ; nazwa programu, max 17 znakow ze spacja  !!!

nazwe:  ; wysw. nazwe programu na  LCD- linia 1 
        ; w DE  pocz. programu, szukaj od tego miejsca DD E2
   
   ld HL, (POCZ_WEE)
   call set_adr_odcz
   ld BC, M_NAZ ; ,marker nazwy DD E2
 naz1:
   call czyt_bajt
   cp B ; czy DD ?
   jr nz, naz1
   call czyt_bajt
   cp C ; czy E2
   jr nz, naz1
    ; w IY pocz. nazwy
   ld A, L1
   out (instr), A ; ustaw kursor na pocz. L1
   call wn1 ; wysw. nazwe
   ret

wys_adr_LCD:
   push BC
   ld a, H
   call wysw_A
   ld a, L
   call wysw_A
   pop BC
   ret

find_prog_szuk: ; szukanie numeru programu w CA w obsz. <TABL_PR_CA> , i odczyt z EEPROM
  call param ; pob. nr programu do HL
  defb 20h
  ld A, L
  ld (NR_PR), A ; zapamietanie do dalszych obliczen
  ld C, L ; do kontroli, czy numer prawidlow
  cp 0 ; programy od 1 !
  jr z, F_P
  ld hl,TABL_PR_CA-2 ; adres w CA  /bo 1. program ma nr 1 a nie 0 !
  call obl_adr
  ld (pocz_pr_t), HL ; zapamietanie adresu do wpisu FF FF FF w num_pr_EE w EEPROM - od 1000h
  ld E, (HL)
  inc HL
  ld D, (HL)
  ex HL, DE
  push HL
  ld DE, 0FEFEh ; brak numeru programu
  sbc HL, DE
  ld L, C
  F_P:
  jp nc, kon_pam ; brak programu
  pop HL
  ld (pocz_WEE), HL
   ;odcz_adr:
  ld IY, 0 ; pocz. progr. w EEPROM - do obl. dlugosci programu
  call set_adr_odcz ;                        00 C0
  call czyt_bajt ; mlodszy bajt adresu (start w CA)
    ; w E i A, odczytany bajt
  ld L, A
  call czyt_bajt ; starszy bajt j.w.
  ld H, A
  ld (POCZ_W_CA), HL  ; pocz. uruchom. programu w CA
  push HL
  pop IX  ; w IX - adres w RAM - poczatek zapisu do CA
;  ld IY, 0 ; pocz. w EEPROM , do obl. dlugosci programu
  call marker_PR ; FD E4 call szu_FF ; szukamy konca programu w EEPROM FF FF
       ; koniec programu, do obl. dlug. programu /do przepisania do RAM/
    ; IY wskazuje koniec szukanego programu w EEPROM /bylo 3 x FF/
  push IY
  pop HL ; dlugosc
  dec hl    ; FF FF FF
  dec hl 
  dec hl ; dlug. programu 
  ld (PR_DLUG), HL
  ld C, L
  ld B, H ; BC jako licznik
  ld HL, (pocz_WEE)
  inc HL
  inc HL
  ret ; odczyt bajtow z EEPROM I2C i uruchomienie programu   
  
wp_adr_EE: ; wpis do <TAB_PR> trzech bajtow w EEPROM:NR_PR i adres pocz. pr. w EEPROM, od 1000h w EEPROM I2C
  ld A, (nr_pr)
  ld HL, num_pr_EE-3
  call obl_adr
 ; LD E, adr_z_64; "adres" pamieci EEPROM do zapisu
  call  wpisz_adr ; wpisz adres pocz. zapisu do EEPROM
  ld HL, (pocz_WEE)
  inc HL
  inc HL
  ld (POCZ_WEE), HL
  ld A, (NR_PR)
  ld (PR_CA), A
  ld HL, PR_CA ; zapis do EEPROM (HL)
  ld BC, 3 ; zapis trzech bajtow w EEPROM <tabl+pr>:NR_PR i adres pocz. pr. w EEPROM
  call zap_Z64 ; zapisuje wg (HL) a jak koniec strony w EEPROM ? blad
     ; wpis do TABL_PR_CA - auktualnienie programow po wpisie do EEPROM
 wpis_tabl:
  ld HL, TABL_PR_CA-3  ; /bo 1. program ma nr 1 a nie 0 !
  ld A, (NR_PR); FE0D
  push AF
  call obl_adr
  pop AF
  ld (HL), A
  inc HL
  ld DE, (pocz_WEE); w FE05
  ld (HL), E
  inc HL
  ld (HL), D 
  ret ; jp CAEE

czyt_nr: ; odczyt numerow programu i ich adresow w EEPROM
  call czysc_LCD
  ld HL, num_pr_EE ; tu w EEPROM: 01 nr programu , AA BB -adres uruchomienia w CA
  call set_adr_odcz  ;        02 nr programu ..itd
  ld IX, TABL_PR_CA
  ld BC, 0FFh
  call czyt_bajty_pr
  ret

obl_adr:
  call dec2bin
  ld E, A
  ld D, 0
  add HL, DE
  add HL, DE
  add HL, DE ; w HL adres do wpisu
  ret

dec2bin: ; zamiana numeru programu DEC na postac HEX
  push BC
  ld  c,a
  and 0f0h
  srl a
  ld  b,a
  srl a
  srl a
  add a,b
  ld  b,a
  ld  a,c
  and 0fh
  add a,b
  pop BC
  ret
    
; aktualizacja programow w <TABL_PR_CA> w CA
aktual:
  call INI_WYSW   
  ld HL, PR_EE ; pocz. programow w EEPROM
  push HL
  pop IY ; do kontroli strony zapisu w EEPROM
  call set_adr_odcz
  ld HL, TABL_PR_CA ; zapis odczytanych bajtow w RAM CA80
 ak:
  call szu_DD ; marker programu FD E4, po nim nr programu
  call czyt_bajt
  ld (HL), A ; nr programu wpisz do RAM w CA, do <TABL_PR_CA>
  rst LBYTE
  defb 20h
  cp 0FEh ; koniec programow
  jr z, ab
  ld A,IYL
  inc HL
  ld (HL), A
  ld A, IYH
  inc HL
  ld (HL), A
  inc HL
  jr ak
 ab:   
  ld HL, NUM_PR_EE
  push HL
  pop IY
  call wpisz_adr
  ld BC, 0EFh ; dlugosc zapisu, bo od FE10 do FEFF
  ld HL, TABL_PR_CA ; skad
  call zap_Z64
  rst 8 ; CF
  jp CAEE



  
  

;*****************************
; a(BIN) => a(BCD) 
; [0..63h] => [00..99]
;*****************************
;bin2bcd:
; push bc
; ld b,10
; ld c,-1
;div10: inc c
; sub b
; jr nc,div10
; add a,b
; ld b,a
; ld a,c
; add a,a
; add a,a
; add a,a
; add a,a
; or b
; pop bc
; ret
;***
; a(BIN) => a(BCD) 
; [0..63h] => [00..99]
;****
;bin2bcd1:
; push bc
; ld c, a
; ld b, 8
; xor a
;loop:
; sla c
; adc a, a
; daa
; djnz loop
; pop bc
; ret  
   
 ;  odczyt poz. kursora    IN A, (LCD_BUSY)  DB EA  - L1 0-13, L2 40-53, L3 14-27, L4 54-67
 ;  odczyt znaku z LCD     IN A, (LCD_RDR) ; DB EB

 dpr:  EQU  ($-pr_start)-1 ; dlugosc programu - () dla Aside
; dpr: EQU {$-progr_E}-1    ;                {} dla kompilatora C32

