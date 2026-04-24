\# Sprint 01 — Skan Nmap



\*\*Data:\*\* 2026-04-24

\*\*Narzędzie:\*\* Nmap 7.99

\*\*Cel:\*\* Identyfikacja otwartych portów i usług na hoście testowym (localhost)

\*\*Wykonał:\*\* \[Twoje imię / nazwa zespołu]



\## Wyniki skanu



| Port    | Stan     | Usługa       | Wersja                  |

|---------|----------|--------------|-------------------------|

| 80/tcp  | open     | HTTP         | Microsoft IIS httpd 10.0|

| 135/tcp | open     | MSRPC        | Microsoft Windows RPC   |

| 137/tcp | filtered | NetBIOS-NS   | —                       |

| 445/tcp | open     | Microsoft-DS | —                       |



\## Wnioski



1\. Port 80 (HTTP) jest otwarty i działa serwer IIS 10.0 — komunikacja

&#x20;  odbywa się bez szyfrowania, ruch może być podsłuchany w sieci lokalnej.

2\. Port 445 (SMB) jest otwarty — protokół SMB bywa celem ataków

&#x20;  (np. EternalBlue/WannaCry), należy sprawdzić czy jest niezbędny.

3\. Port 135 (RPC) jest otwarty — może być wykorzystany do zdalnego

&#x20;  wykonania kodu, powinien być zablokowany na firewallu jeśli nie jest używany.



\## Rekomendacje



\- Skonfigurować HTTPS na porcie 443 zamiast HTTP na 80

\- Zablokować port 445 na firewallu jeśli udostępnianie plików nie jest wymagane

\- Zablokować port 135 na firewallu dla połączeń spoza sieci lokalnej

\- Regularnie aktualizować IIS i system Windows

