@echo off
set TIMESTAMP=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%_%TIME:~0,2%-%TIME:~3,2%
set TIMESTAMP=%TIMESTAMP: =0%
set OUTFILE=C:\Users\skrip\Projekt_Serwer1\wyniki\auto\nmap_%TIMESTAMP%.txt

mkdir C:\Users\skrip\Projekt_Serwer1\wyniki\auto 2>nul

echo Rozpoczecie skanu: %DATE% %TIME% >> %OUTFILE%
echo ================================ >> %OUTFILE%

nmap -sV -p 80,135,137,445 127.0.0.1 -oN %OUTFILE%

echo ================================ >> %OUTFILE%
echo Zakonczenie skanu: %DATE% %TIME% >> %OUTFILE%

echo Skan zapisany do: %OUTFILE%