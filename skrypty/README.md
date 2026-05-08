\# Automatyzacja - skrypt auto\_scan.bat



Automatycznie wykonuje skan Nmap portów 80, 135, 137, 445

na hostcie lokalnym i zapisuje wynik do pliku z datą w nazwie.



\## Porównanie czasu



| Metoda        | Czas wykonania |

|---------------|----------------|

| Ręcznie       | \~2-3 minuty    |

| Skrypt        | 9.12 sekundy   |



Ręcznie: wpisanie komendy, podanie ścieżki pliku, sprawdzenie wyniku.

Skrypt: jedno uruchomienie, wynik zapisany automatycznie.



\## Użycie



Uruchom w CMD:

&#x20;   skrypty\\auto\_scan.bat



Wyniki zapisywane są do:

&#x20;   wyniki\\auto\\nmap\_YYYY-MM-DD\_HH-MM.txt



\## Automatyczne uruchamianie (cron na Linux / Task Scheduler na Windows)



Aby uruchamiać skrypt co dzień o 08:00, w Task Scheduler:

1\. Otwórz Task Scheduler

2\. Create Basic Task

3\. Trigger: Daily, 08:00

4\. Action: Start a program

5\. Program: C:\\Users\\skrip\\Projekt\_Serwer1\\skrypty\\auto\_scan.bat

