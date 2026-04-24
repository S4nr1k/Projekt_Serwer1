\# Raport Before and After - Sprint 02



\## Nmap - Windows host



| Port    | PRZED        | PO       | Poprawka |

|---------|--------------|----------|----------|

| 80/tcp  | open (HTTP)  | closed   | FIX-002  |

| 445/tcp | open (SMB)   | filtered | FIX-001  |

| 135/tcp | open (RPC)   | open     | -        |

| 137/tcp | filtered     | filtered | -        |



\## Lynis - Ubuntu VM



| Metryka         | PRZED | PO | Zmiana |

|-----------------|-------|----|--------|

| Hardening index | 59    | 62 | +3     |

| Warnings        | 2     | 2  | 0      |

| Suggestions     | 39    | 37 | -2     |



\## Wnioski



1\. Zablokowanie portu 445 (SMB) wyeliminowalo ryzyko atakow

&#x20;  typu EternalBlue z zewnatrz sieci.

2\. Zatrzymanie IIS usunelo niezaszyfrowany HTTP na porcie 80,

&#x20;  eliminujac ryzyko podsluchu transmisji.

3\. Aktualizacja pakietow Ubuntu i wylaczenie uslug podniosa

&#x20;  wynik hardeningu Lynis o 3 punkty.



\## Ocena efektywnosci sprintu



Przed sprintem: 2 otwarte porty wysokiego ryzyka, Lynis 59/100

Po sprincie:    0 otwartych portow wysokiego ryzyka, Lynis 62/100

