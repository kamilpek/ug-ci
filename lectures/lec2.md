# Inteligencja Obliczeniowa
## Wykład 2 – 21.10.2017

### Co to jest zgłębianie danych?
Data mining (ang.): zgłębianie danych, drążenie danych, odkrywanie wiedzy z danych.
Odkrywanie interesujących (nietrywialnch, neioczywistych, wcześniej nieznanych i potencjalnie przydatnch) informacji lub pawidłowości z wielkich baz danych.

### Przykłady zastosowań
Analiza i wspomaganie decyzji. Analizy rynkowe i zarządzanie - marketing skierowany, zarządzanie relacajmi, analiza ksozyka rynkowego, segmentacja rynku. Analiza i zarządzanie ryzykiem - prognozy, utrzymanie klientów, kontrola jakości, analizy konkurencyjności. Wykrywanie oszust i wyłudzeń.
Inne zastosowania. Eksploracja tekstu (doniesień agenycyjnych, dokumentów, poczty elektronicznej), analiza zasobów informacyjnych Internetu.

### Funkcjonalność eksploracji danych
Klasyfikacja i przewidywanie - znajdowanie modeli (funkcji) opisujących i wyróżniających klasy lub pojęcia w celu przewidywania przyszłości, np. klasyfikuje kraje na podstawie klimatu lub samochody na podstawie zużycia paliwa.
Prezentacja - drzewa decyzji, reguły klasyfikacji, sieci neuronowe.
Przewidywanie - prognozuj nieznane lub brakujące wartości liczbowe.
Grupowanie (klasteryzacja) - znajdź schemat grupowania w klasy - np. pogrupuj domy tak, aby odkryć rozkład podaży.
Grupowanie oparte na zasadzie maksymalizuj podobieństow w ramach klasy i minimalizuj podobieństwo pomiędzy klasami.
Analiza wyjątków - wyjąrek (outlier) obiekt (dana), który odbiega od ogólnego scheamtu lub zachowania się, może być szumem lub przypadkiem szczególnym, lecz wyjątek jest użyteczny do wykrywania działań niezgodnych z prawem lub normami.

### Czy wszystkie przypadki są interesujące?
System eksploracji może odkryć setki prawidłowości, lecz nie wszystkie muszą być interesujące. Proponowane podjeście: eksploracja zorientowana na użytkownika, skoncetrowana na jego celach.
Miary przydatności: prawidłowość jest interesująca jeśli łatwo ją zrozumieć, można ją walidować na nowych lub testowych danych, jest potencjalnie użyteczna, nowa lub potwierdza hipotezę, którą użytkownik stara się zbadać.
Miary obiektywne i subiektywne. Obiektywne: statystyczne, strukturalne np. wsparcie, wiarygodność. Subiektywne: oparte na przekonaniu uzytkownika, np. nowość.

### Wstępne przygotowanie danych
Wybór informacji z bazy danych - jakie dane są interesujące, być może agregacja danych z różnych baz, jakie typy poszczególnych atrybutuów (numeryczne - rzeczywiste, numeryczne - całkowit, dane kategoryzowane, logiczne, tekstowe itp.). Problemy: dane przestarzałe. Rekordy z brakującymi polami, punkty oddalone - wyjątki, dane w formacie nieodpowiednim dla modeli DM.
Przyjmuje się, że wstępna odbróbka danych może przekraczać połowę czasu przeznaczonego na cały proces eksploracji danych.

### Problem brakujących danych
Jakie są sposoby radzenia sobie z brakujacymi danymi.
Pomijanie podczas analizy rekordów z brakującymi danymi - niebezpieczne, bo dane mogą tworzyć istotne wzorce; ponadto, marnuje się być może wartościowe dane w rekordach. Zastępowanie brakujących wartości stałą określoną przez analityka. Zastępowanie wartością średnią. Zastępowanie wartością losową z odpowiedniego przedziału, wszystkie powyższe sposoby zastępowania są ryzykowne i mogą zaburzyć analizę.

### Przekształacenie danych – normaliacja
Atrybuty mają na ogół zakresy, które bardzo różnią się od siebie, np. w powyższych przykładach. Dla pewnych algorytmów atrybuty o dużych zakresach mogą mieć nadmierny wpływ na wyniki. Stosuje się normalizację: normalizacja min-max polega na wykoaniu pewnego przekstałcenia (tu był wzorek). Znormalizowane wartości będą należeć do przedziału od 0 do 1.

### Jakie są związki między atrybutami?
Unikać skorelowanych zmiennych w eksploracji danych - użycie skorelowanych danych może wyolbrzymić jakąś częśc danych i dać niepewne wyniki.
W zbiorze churn zbadać zależności między następującymi atrybutami: dzień minuty i dzień rozmowy, dzień rozmowy i dzień opłata, dzień minuty i dzieł opłata oraz analogiczne zależności dla atrybutów dotyczących rozmów wieczorem, w nocy i międzynarodowych. Wykrycie skorelowanych zmiennych oznacza, że w modelu mamy do czynienia z nadmiarowością i pewnych atrybutów należy się pozbyć.

### Poszukiwanie związków między wartościami atrybutów w zbiorze churn
Warto sprawdzić: czy wartość zmiennej churn zależy od wartości atrybutu Plan międzynarodowy, jaka jest zależność churn od atrybutu liczba rozmów z BOK, prześledzić histogram atrybtuu - wiczór minuty - klienci z dużą liczną wykorzystanych minut wiczorem mają małą tendencję do rezygnacji, kliencji z dużą liczbą wykorzystanych minut w ciagu dnia częściej rezygnują.

### Odległość – metryka
Metryka d jest funkcją o wartościach rzeczywistych spełniajcą natępujące trzy warunki:
1. d(x,y) >= oraz d(x,y) = 0
1. d(x,y) = d(y,x)
1. d(x,z) =< d(x,y) + d(y,z)

na przykład dla atrybutów liczbowych: odległość euklidesowa metryka miasto

### Metryka dla różnych typów atrybutów
Metryka VDM (Value Difference Metric) dla atrybutów nominalnych (inaczej kategorycznych).
