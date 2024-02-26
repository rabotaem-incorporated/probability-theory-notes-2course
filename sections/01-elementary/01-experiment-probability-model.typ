#import "../../utils/core.typ": *

== Вероятностная модель эксперимента

#def[
    $Omega = {omega_1, omega_2, ..., omega_n}$ --- _пространство_ (или _множество_) _элементарных исходов_, причем неформально:
    1. $omega_i$ --- несовместны (то есть если элементарные исходы --- грани кубика, то исходы $omega_i$ и $omega_j$ не могут реализоваться одновременно при $i != j$).
    2. $omega_j$ --- равновозможны.
    3. Один элементраный исход всегда реализуется.

    _Случайное событие_ $A$ --- произвольное подмножество  в $Omega$.
]

#example[
    Если $Omega = {1, 2, ..., 6}$ --- множество граней кубика, и $i$ --- элементраный исход "выпала грань с числом $i$", то событие "выпало четное число" есть ${2, 4, 6}$.
]

#def[
    _Вероятность события $P(A)$_:
    $
        P(A) := (\#A) / (\#Omega).
    $
]

#props[
    1. $0 <= P(A) <= 1$, причем $P(empty) = 0$, и $P(Omega) = 1$.
    2. Если $A sect B = empty$ (говорят, что _события несовместны_), то $P(A union B) = P(A) + P(B)$.
    3. $P(A union B) = P(A) + P(B) - P(A sect B)$.
        В частности, всегда есть $P(A union B) <= P(A) + P(B)$.
    4. _Формула включений-исключений_: $ 
        P(A_1 union A_2 union ... union A_m) &=
        sum_(i = 1)^m P(A_i) - \
        &- sum_(i < j) P(A_i sect A_j) + \
        &+ sum_(i < j < k) P(A_i sect A_j sect A_k) - ... \
        ... &+ (-1)^(m - 1) P(A_1 sect A_2 sect ... sect A_m). $
    5. $P(neg(A)) = 1 - P(A)$, где $neg(A)$ --- отрицание события $A$, то есть $Omega without A$.
]

#proof[
    1. Очевидно.
    2. Очевидно.
    3. $ A union B = A union.sq (B without A) = A union.sq (B without (A sect B)) $
    4. По индукции. База есть: при $m = 2$ это свойство 3. Переход $m ~~> m + 1$ доказывается. Вопросы?
    5. $1 = P(Omega) = P(A union neg(A)) = P(A) + P(neg(A))$
]

#def[
    Пусть $A != nothing$. Вероятность того, что случилось событие $B$ при условии того, что случилось событие $A$ называется _Условной вероятностью_ события $B$ при условии события $A$, и
    $
        P(B | A) = (\#(A sect B))/(\#A) = (\#(A sect B)/(\#Omega))/((\#A)/(\#Omega)) = P(A sect B) / P(A).
    $
]

#props[
    1. $P(A | A) = 1$ и если $B supset A$, то $P(B | A) = 1$.
    2. $P(nothing | A) = 0$.
    3. Если $B_1 sect B_2 = nothing$, то $P(B_1 | A) + P(B_2 | A) = P(B_1 union B_2 | A)$. В частности, $P(B | A) + P(neg(B) | A) = 1$.
]

#notice[
    $P(B | A) + P(B | neg(A))$ не обязательно $1$. Например, в примере с кубиком, если $A = {2, 4, 6}$, а $B = {3, 6}$, то $P(B | A) = 1/3$, и $P(B | neg(A)) = 1/3$. Если взять $neg(B)$ вместо $B$, то сумма вероятностей будет больше 1.
]

#th(name: "формула полной вероятности")[
    Пусть $Omega = usb_(k = 1)^m A_k$, где $P(A_k) > 0$. В нашем случае пока $P(A) > 0 <==> A != empty$, но скоро это будет не всегда так. Мы будем пытаться сразу писать правильные формулы.

    Тогда 
    $
        P(B) = sum_(k = 1)^m P(B | A_k) dot P(A_k).
    $

    В частности, $P(B) = P(B | A) P(A) + P(B | neg(A)) P(neg(A))$, если $0 < P(A) < 1$.
]

#proof[
    Знаем, что $B = (B sect A_1) union.sq (B sect A_2) union.sq (B sect A_m)$. Тогда
    $
        P(B) = sum_(k = 1)^m P(B sect A_k) = sum_(k = 1)^m P(B | A_k) dot P(A_k).
    $
]

#example[
    - I урна: 3 белых шара, и 5 черных шаров.
    - II урна: 5 белых и 5 черных шаров.
    Из первой урны берем наугад 2 шара, и перекладываем во вторую. Затем перемешиваем шары во второй урне, и вытаскиваем какой-то шар. Какова вероятность того, что он белый?

    Воспользуемся формулой полной вероятности. Пусть $B$ --- событие "вытянутый шар белый", $A_k$ --- событие "мы переложили $k$ белых шаров" (k = 0, 1, 2). Посчитаем вероятности.
    #table(columns: 3, inset: 0.3cm)[
        #align(center)[5 белых, 7 черных]
        $ P(B | A_0) = 5/12 $
    ][
        #align(center)[6 белых, 6 черных]
        $ P(B | A_1) = 1/2 $
    ][
        #align(center)[7 белых, 5 черных]
        $ P(B | A_2) = 7/12 $
    ][
        $ P(A_0) = (C_5^2)/(C_8^2) = 5/14 $
    ][
        $ 
            P(A_1) = 1 - P(A_0) - P(A_2) newline(=)
            1 - 5/14 - 3/38 = 15/28.
        $
    ][
        $ P(A_2) = (C_3^2)/(C_8^2) = 3/28 $
    ]
    Тогда 
    $
        P(B) &= P(B | A_0) P(A_0) + P(B | A_1) P(A_1) + P(B | A_2) P(A_2) =\
        &= 5/12 dot 10/28 + 6/12 dot 15/28 + 7/12 dot 3/28 = 23/48.
    $
]

#th(name: "формула Байеса")[
    Пусть $P(A) > 0$ и $P(B) > 0$. Тогда
    $
        P(B | A) = (P(A | B) P(B)) / P(A).
    $
]

#proof[
    $
        P(B | A) = P(A sect B) / P(A) = P(A sect B) / P(B) dot P(B) / P(A) = P(A | B) P(B) / P(A).
    $
]

#example[
    Пусть у нас ковид. $A$ --- событие "тест положительный". $B$ --- событие "человек болен". Пусть $P(B) = 10^(-3)$ (вероятность того, что человек болен), $P(A | neg(B)) = 10^(-2)$ (вероятность того, что тесь оказался положительным, хотя человек не болен, то есть false positive), и $P(A) = 1/10$ (эмпирическая доля положительных тестов).
]

#exercise[
    Найти $P(B | A)$ (вероятность того, что человек с положительным тестом и правда болен). #text(rgb(255, 50, 50))[Вообще тут должно получаться, что почти все положительные тесты на самом деле ложно-положительные, но в данные закралась бага. Тут можно посчитать, что $P(B union neg(A)) = 10^(-3) - (1/10 - 10^(-2) dot (1- 10^(-3))) < 0$.]
]

#th(name: "теорема Байеса")[
    Пусть $P(A_k) > 0$, $P(B) > 0$ и $Omega = usb_(k = 1)^m A_k$. Тогда
    $
        P(A_k | B) = (P(B | A_k) P(A_k)) / (sum_(j = 1)^m P(B | A_j) P(A_j)).
    $
]

#proof[
    Первый переход --- просто формула Байеса, а второй --- формула полной вероятности:
    $
        P(A_k | B) = (P(B | A_k) P(A_k))/(P(B)) =  (P(B | A_k) P(A_k)) / (sum_(j = 1)^m P(B | A_j) P(A_j)).
    $
]

#notice[
    В частности,
    $
        P(A | B) = (P(B | A) P(A)) / (P(B | A) P(A) + P(B | neg(A)) P(neg(A))),
    $
    если $0 < P(A) < 1$, и $P(B) > 0$.
]

#example[
    Пусть есть 2 монеты: одна симметричная, а вторая кривая, и $P("орел") = 2/3$, а $P("решка") = 1/3$. Пусть мы взяли случайную монету, и выпал орел. Какова вероятность того, что монета кривая?

    Пусть $A_1$ --- кинули первую монетку, $A_2$ --- кинули вторую, $B$ --- выпал орел. Тогда
    $
        P(A_2 | B) = (P(B | A_2) P(A_2)) / (P(B | A_1) P(A_1) + P(B | A_2) P(A_2)) = 4/7.
    $
]

#def[
    Событие $A$ _не зависит_ от события $B$ (где $P(B) > 0$), если
    $
        P(A) = P(A | B) = P(A sect B)/P(B).
    $
    Если домножить на знаменатель, исчезнет проблема с делением на $0$, да и формула станет симметричнее, поэтому так определение составляют редко.
]

#def[
    События $A$ и $B$ _независимы_, если $P(A sect B) = P(A) P(B)$.
]

#def[
    $A_1, A_2, ..., A_m$ _независимы в совокупности_, если для любых различных индексов $i_1$, $i_2$, ..., $i_k$ различные индексы, и
    $
        P(A_(i_1) sect A_(i_2) sect ... sect A(i_k)) = P(A_(i_1)) P(A_(i_2)) ... P(A_(i_j)).
    $
]

#notice[
    Независимость попарная не влечет независимость в совокупности. Например, если есть два кубика, и $A$ --- на первом четное число, $B$ --- на втором четное число, и $C$ --- сумма четная, то эти события попарно независимы, но в совокупности независимости нет:
    $
        P(A) = P(B) = P(C) = 1/2,
    $
    а следующие события --- вообще одно и то же:
    $
        A sect B = A sect C = B sect C = A sect B sect C,\
    $
    Тогда
    $
        P(A sect B) = 1/4 = P(A) P(B), ...
    $
    Все события попарно независмы, но $P(A sect B sect C) != P(A) P(B) P(C) = 1/8$.
]

#exercise[
    Доказать, что $A_1$, ..., $A_m$ независимы в совокупности тогда и только тогда, когда
    $
        P(B_1 sect B_2 sect ... sect B_m) = P(B_1) P(B_2) ... P(B_m),
    $
    где $B_j = A_j "или" neg(A_j)$.
]

#line(length: 100%)

Теперь будем говорить о модели, в которой элементарные исходы не равновероятны.

#def[
    Небольшое обобщение модели.

    Пусть $Omega = {omega_1, omega_2, ..., omega_n}$, и имеются $p_1, p_2, ..., p_n >= 0$, причем $p_1 + p_2 + ... + p_n = 1$.

    $A subset Omega$ --- событие, и
    $
        P(A) := sum_(omega_i in A) p_i.
    $
    Если $A sect B = empty$, то $P(A union B) = P(A) + P(B)$. Остальные свойства тоже есть, потому что мы аккуратно выводили их из этого.
]

#def[
    Пусть $omega = (x_1, x_2, ..., x_n)$, где $x_n in {0, 1}$. $Omega = {omega : omega = (x_1, x_2, ..., x_n)}$. $\#Omega = 2^n$. Пусть $p in (0, 1)$. Положим 
    $ 
        P(omega) := p^(x_1 + x_2 + ... + x_n) (1 - p)^(n - x_1 - x_2 - ... - x_n) = p^(\#{i: x_i = 1}) (1 - p)^(\#{i: x_i = 0}). 
    $
    Такая модель называется _схемой Бернулли_.

    Можно думать об этом так: мы $n$ раз подбрасываем нечестную монетку (считаем орел успехом, или $1$, и решку неудачей, то есть $0$), причем так, что все броски независимы в совокупности.

    В модели независимость получается из того, как мы определили вероятность элементарных исходов. Проверим по упражнению:
    $
        P(B_1 sect B_2 sect ... sect B_n) = P(B_1) P(B_2) ... P(B_n),
    $
    где $P(B_i) = p$ если на $i$-м броске выпал орел, и $P(B_i) = 1 - p$ если на $i$-м броске выпала решка. Тогда вероятность $B_1 sect ... sect B_n$ равна $p^(\#{i: x_i = 1}) (1 - p)^(\#{i: x_i = 0})$, что и есть $P(B_1) P(B_2) ... P(B_n)$.

    В такой модели вероятность события "в серии из $n$ испытаний ровно $k$ успехов" равна $C_n^k p^k (1 - p)^(n - k)$.
]

#def[
    Пусть $omega = (x_1, x_2, ..., x_n)$ где $x_i in {1, 2, ..., m}$. Имеются $p_1 + p_2 + ... + p_m = 1$, где $p_i >= 0$. $Omega = {omega : omega = (x_1, x_2, ..., x_n)}$. $\#Omega = m^n$. Положим
    $
        P(omega) := p_1^(\#{i: x_i = 1}) p_2^(\#{i: x_i = 2}) ... p_m^(\#{i: x_i = m}).
    $
    Такая модель называется _полиномиальной схемой_. Это тоже серия из $n$ независимых испытаний, но исходов теперь $m$ на каждом, а не $2$.

    В такой модели вероятность события "в серии из $n$ испытаний ровно $k_1$ исходов $1$, $k_2$ исходов $2$, ..., $k_m$ исходов $m$" равна $binom(n, k_1, k_2, ..., k_m) p_1^k_1 p_2^k_2 ... p_m^k_m$.
]

#th(name: "Эрдеша-Мозера")[
    Имеется $n$ волейбольных команд, и каждая команда играет с каждой ровно один раз. Пусть $k$ --- наибольшее число, для которого заведомо найдутся команды $A_1, A_2, ..., A_k$ такие, что $A_i$ выиграла у $A_j$ тогда и только тогда, когда $i < j$. Тогда $k <= 1 + floor(2 log_2 n)$.
]

#proof[
    Рассмотрим случайный турнир, то есть проведем схему Бернулли с вероятностью успеха $1/2$ для $C_n^2$ матчей. Тогда
    $
        P(A "выиграла у" B) &= 1/2,\
        P(A_1, A_2, ..., A_k "подходят") &= (1/2)^(C_k^2),\
        P("Какие-то" k "команд подходят") &<= sum_(A_1, ..., A_k) P(A_1,...,A_k "подходят") = C_n^k dot k! dot (1/2)^(C_k^2).
    $
    Предположим, что $k >= 2 + floor(2 log_2 n)$. Тогда
    $
         C_n^k dot k! dot (1/2)^(C_k^2) = n dot (n - 1) dot ... (n - k + 1) dot (1/2)^((k (k - 1))/2) < n^k dot (1/2)^((k(k-1))/2) = (n dot (1/2)^((k - 1)/2))^k.
    $
    Но мы знаем, что $(k-1)/2 > log_2 n$, значит $2^((k - 1)/2) > n$ и в скобках стоит число меньше $1$. Имеем
    $
        P("Какие-то" k "команд подходят") < 1.
    $
    Значит вероятность того, что никакие $k$ команд не подходят, положительна, а значит найдется турнир, в котором $k$ команд не подходят. Что и требовалось доказать.
]
