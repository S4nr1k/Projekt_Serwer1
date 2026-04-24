\# Sprint 02 - Dokumentacja poprawek



\## FIX-001 - Blokada portu 445 (SMB)



\*\*Identyfikator:\*\* FIX-001

\*\*Data:\*\* 2026-04-24

\*\*Ryzyko przed poprawka:\*\* High



\*\*Opis zmiany:\*\*

Dodano regule zapory sieciowej Windows blokujaca przychodzace

polaczenia TCP na porcie 445 (SMB) we wszystkich profilach

sieciowych (Domain, Private, Public).



\*\*Komenda:\*\*

netsh advfirewall firewall add rule name="BLOCK SMB 445 - Sprint02"

dir=in action=block protocol=TCP localport=445



\*\*Test naprawy:\*\*

Weryfikacja przez: netsh advfirewall firewall show rule

Wynik: Enabled=Yes, Action=Block, wszystkie profile aktywne

Plik dowodowy: retest\_FIX001.txt



\*\*Status:\*\* Skuteczna





\## FIX-002 - Wylaczenie uslug IIS (HTTP port 80)



\*\*Identyfikator:\*\* FIX-002

\*\*Data:\*\* 2026-04-24

\*\*Ryzyko przed poprawka:\*\* Medium



\*\*Opis zmiany:\*\*

Zatrzymano usluge World Wide Web Publishing Service (IIS/W3SVC)

eliminujac niezaszyfrowany dostep HTTP na porcie 80.



\*\*Komenda:\*\*

net stop W3SVC



\*\*Test naprawy:\*\*

Nmap przed: 80/tcp open http Microsoft IIS httpd 10.0

Nmap po:    80/tcp closed http

Plik dowodowy: retest\_FIX002.txt



\*\*Status:\*\* Skuteczna





\## Podsumowanie sprintu



| ID      | Podatnosc       | Ryzyko przed | Ryzyko po | Status    |

|---------|-----------------|--------------|-----------|-----------|

| FIX-001 | Port 445 SMB    | High         | Low       | Skuteczna |

| FIX-002 | Port 80 HTTP    | Medium       | Brak      | Skuteczna |

