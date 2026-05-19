# Raport bezpieczeństwa - Projekt Serwer1

Data: 2026-05-08
Autor: Ihor Skrypnyk, Kamil Witczak, Patryk Schubert
Środowisko: Windows 11 (localhost) + Ubuntu VM (VirtualBox)

---

## 1. Streszczenie

W ramach projektu przeprowadziliśmy audyt bezpieczeństwa lokalnego
środowiska testowego. Przeskanowaliśmy porty, zbadaliśmy konfigurację
systemu Linux i wdrożyliśmy poprawki dla najważniejszych problemów.

Znaleźliśmy cztery podatności. Dwie z nich - otwarty port SMB i
niezaszyfrowany HTTP - zostały naprawione jeszcze w trakcie projektu.
Trzecia, dotycząca konfiguracji systemu Linux, została częściowo
poprawiona. Czwarta pozostaje do adresowania w kolejnym sprincie.

Ogólna ocena: stan bezpieczeństwa poprawił się w sposób mierzalny.
Wynik hardeningu Linux wzrósł z 59 do 62 punktów, a dwa otwarte
porty wysokiego ryzyka zostały zamknięte.

---

## 2. Co i jak testowaliśmy

Testowaliśmy lokalne środowisko składające się z komputera z Windows 10
oraz maszyny wirtualnej Ubuntu uruchomionej w VirtualBox.

Do testów użyłem dwóch narzędzi. Nmap posłużył do skanowania portów
sieciowych - sprawdziliśmy które usługi są dostępne i czy nie stanowią
zagrożenia. Lynis posłużył do oceny ogólnego stanu bezpieczeństwa
systemu Linux - sprawdza setki parametrów konfiguracyjnych i podaje
wynik punktowy.

Testy trwały dwa sprinty, od 24 kwietnia do 8 maja 2026. Głównym
ograniczeniem było to, że skany wykonywaliśmy tylko na localhost,
więc nie możemy ocenić jak system wygląda z perspektywy zewnętrznego
atakującego.

---

## 3. Co znaleźliśmy

### Problem 1 - Otwarty port SMB (VULN-001, ryzyko: wysokie)

Podczas skanu Nmap odkryliśmy że port 445 jest otwarty. To port
protokołu SMB, który służy do udostępniania plików w sieci Windows.
Problem polega na tym, że SMB ma długą historię poważnych podatności -
najsłynniejsza to EternalBlue, która została wykorzystana przez
ransomware WannaCry do zainfekowania setek tysięcy komputerów.

Jeśli ten port jest dostępny z zewnątrz sieci, atakujący może
potencjalnie przejąć kontrolę nad systemem bez znajomości hasła.

Jak to sprawdziliśmy:
Uruchomiliśmy nmap -p 445 127.0.0.1 i otrzymaliśmy wynik
445/tcp open microsoft-ds, co potwierdza że usługa działa.

Co zrobiliśmy:
Dodaliśmy regułę zapory sieciowej Windows blokującą wszystkie
przychodzące połączenia na port 445. Po wdrożeniu poprawki
reguła jest aktywna we wszystkich profilach sieciowych
(domowy, firmowy, publiczny).

Dowód skuteczności: plik wyniki/sprint-02/retest_FIX001.txt


### Problem 2 - Niezaszyfrowany HTTP na porcie 80 (VULN-002, ryzyko: średnie)

Nmap wykrył że na porcie 80 działa serwer IIS 10.0 firmy Microsoft.
Komunikacja przez HTTP jest niezaszyfrowana, co oznacza że każdy
kto jest w tej samej sieci może przechwycić przesyłane dane.
W praktyce dotyczy to haseł, danych logowania i innych wrażliwych
informacji.

Jak to sprawdziliśmy:
nmap -sV -p 80 127.0.0.1 zwrócił
80/tcp open http Microsoft IIS httpd 10.0

Co zrobiliśmy:
Zatrzymaliśmy usługę IIS komendą net stop W3SVC.
Po zatrzymaniu port 80 zmienił status z open na closed,
co potwierdził ponowny skan Nmap.

Dowód skuteczności: plik wyniki/sprint-02/retest_FIX002.txt


### Problem 3 - Słaba konfiguracja systemu Linux (VULN-003, ryzyko: średnie)

Audyt Lynis wykazał wynik 59 na 100 możliwych punktów. To wynik poniżej
średniej, oznaczający że system ma wiele miejsc gdzie konfiguracja
mogła być bezpieczniejsza. Lynis zgłosił 2 ostrzeżenia i aż 39 sugestii
do poprawy - między innymi brak aktualizacji pakietów i zbędne
uruchomione usługi.

Jak to sprawdziliśmy:
sudo lynis audit system i zapis do pliku lynis_before.txt

Co zrobiliśmy:
Zaktualizowaliśmy wszystkie pakiety systemowe (apt upgrade)
i wyłączyliśmy zbędną usługę drukowania (cups). Po tych zmianach
wynik wzrósł do 62 punktów, a liczba sugestii spadła do 37.

To dobry początek ale system wymaga dalszej pracy w kolejnych sprintach.

Dowody: pliki wyniki/sprint-02/lynis_before.txt i lynis_after.txt


### Problem 4 - Otwarty port 135 (RPC) (VULN-004, ryzyko: niskie)

Port 135 (Microsoft RPC) jest otwarty. RPC to mechanizm zdalnego
wywoływania procedur, historycznie związany z kilkoma podatnościami.
Nie wdrożyliśmy jeszcze poprawki - zaplanowane na kolejny sprint.

---

## 4. Porównanie przed i po

Nmap (Windows):
- Port 80:  przed - otwarty (HTTP),  po - zamknięty
- Port 445: przed - otwarty (SMB),   po - zablokowany przez firewall
- Port 135: przed - otwarty (RPC),   po - bez zmian (kolejny sprint)

Lynis (Ubuntu):
- Wynik hardeningu: 59 -> 62 (+3 punkty)
- Ostrzeżenia: 2 -> 2 (bez zmian)
- Sugestie: 39 -> 37 (-2 sugestie)

---

## 5. Co robimy dalej

W kolejnym sprincie planujemy zająć się portem 135 (RPC) oraz
dalej poprawiać wynik Lynis - celujemy w minimum 70 punktów.
Chcemy też uruchamiać automatyczny skan co tydzień przez
Task Scheduler, żeby na bieżąco monitorować stan systemu.

---

## 6. Załączniki

Wszystkie dowody techniczne są dostępne w repozytorium:

- wyniki/sprint-01/nmap_raport.txt - pierwszy skan
- wyniki/sprint-02/retest_FIX001.txt - dowód blokady SMB
- wyniki/sprint-02/retest_FIX002.txt - dowód zamknięcia HTTP
- wyniki/sprint-02/lynis_before.txt - pełny audyt przed poprawkami
- wyniki/sprint-02/lynis_after.txt - pełny audyt po poprawkach
- skrypty/auto_scan.bat - skrypt automatyzacji