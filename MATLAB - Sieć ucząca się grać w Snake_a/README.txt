Funkcje wewnętrzne:
draw: Rysowanie planszy
genApple: generowanie pozycji nowego jabłka
whatISee: Funkcja sprawdzająca czy "głowa" węża jest w bezpośrednim sąsiedztwie ściany/swojego ciałą
whereIsApple: oblicza kąt pomiędzy kierunkiem poruszania sie robaka i pozycją jabłka znormalizowane do [-1, 1]
Interfejsy:
robakttest: główny interfejs uczenia robaka/gra, budowa danych uczących
ShowDaResults,show2ndResults: Pokazuje wyniki uczenia sieci. Pierwsza pokazuje gdy było dużo neuronów w warstwie ukrytej, druga mniej. Gdzie pierwsza będzie najczesciej trzymała sie ścian to druga erratycznie będzie poszukiwałą jabłka.
