# Inteligencja Obliczeniowa
## Wykład 1 – 14.10.2017

### Wstęp
Inteligencja Obliczeniowa (CI) zajmuje się teorią rozwiązywania problemów, które nie są efektywnie algoytmiczne. Obejmuje wiele dziedzin np. sieci  neuronowe, algorytmy genetyczne i ewolucyjne, algorytmy mrówkowe i rojowe, systemy rozmyte, metody zgłębiania danych. Systemy korzystajace z CI przetwarzają i interpretują dane o różnorodnym charakterze, np. dane numer numeryczne, symboliczne.

### Algorytmy genetyczne
Oparte na mechanizmach doboru naturalnego i dziedziczenia. Nie przechowują bezpośrednio  parametrów zadania, tylko ich zakodowaną postać, prowadzą poszukiwania wychodząc z pewnej populacji, nie z pojednyczego punktu, korzystają z funkcji przystosowania (celu). Osobniki towrzą populację – zawierają rozwiązanie, pupulacja zawiera osobników, istnieją operatory genetyczne i funkcje przypisania.

### Klasyczny algorytm genetyczny
1. Inicjalizacja – wybór początkowej populacji,
1. Ocena przystosowania osobników w populacji,
1. Iteracja postępowania:
    1. selekcja osobników,
    1. zastosowanie operatorów genetycznych,
    1. ustalenie nowej populacji,
1. Wypisanie najleszego osobnika.

Operator mutacji odgrywa drugoplanową rolę w sotsunku do krzyżowania, które to występuje prawie zawsze, mutacja bardzo rzadko (z prawdopodbieństwem rzędu 0,01).

### Algorytm ewolucyjny
Algorytm ewolucyjny jest pewnym uogólnieniem algoytmu genetycznego – nie musi być nieparzystą binarną opartą nie tylko genetycznie, ale dane do zrealizowania. Elementy określające algorytm genetyczny: sposób reprezentacji osobników, metoda zdefiniowania populacji początkowej, określenie funkcji przystosowania, wybór operatorów, określenie kryterium zakończenia.

### Problem Komiwojażera
Jak określić funkcje przystosowania? Jak reprezenotwać osobniki?
Można uzyć tak zwanej reprezentacji ścieżkowej, czyli osobnik jest permutacją liczb od 1 do n; jak zdefiniować krzyżowanie i mutację? W reprezentacji prządkowej określa się tak zwany wzorzec, osobnik na i-tej pozycji może zawierać liczbę między 1 i n-i+1 np. dla n=7 wzorzec (1 2 3 4 5 6 7), osobnik jest listą (1 1 4 2 1 1 1) reprezentującą trasę 1-2-6-4-3-5-7.

### Szeregowanie Zadań
Dany jest zbiór złożony z n zadań, ponadto dane są: czasy przetwarzania p1,...,pn, d czas zakończenia, kary a1,...,an za wykonanie zadania zbyt wcześnie, kary b1,...,bn za wykonanie zadania zbyt późno, jeśli ci jest czasem zakończenia i-tego zadania, to funkcję, która należy zminimalizować jest funkcja oceny.

### Bibliografia
1. L. Rutkowski – Metody i techniki sztucznej inteligencji, PWN,
1. J. Han – Data Mining. Concepts and Techniques, Morgan Kaufmann,
1. T. Morz – Eksploracja danych. Metody i algorytmy, PWN,
1. A.P. Engelbrecht – Computional Inteligence. An Itroduction, Wiley,
1. UCI Repository, http://archive.ics.uci.edu/ml,
