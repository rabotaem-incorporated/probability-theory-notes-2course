#import "../../utils/core.typ": *

== Цепи Маркова

#def[
  $Y$ --- не более чем счетное множество --- _фазовое пространство_. 
  Последовательность $xi_n: Omega --> Y$ --- цепь Маркова, если
  $
    P lr(size: #1.2em, (xi_n = a_n | underbrace(xi_0 = a_0\, ...\, xi_(n - 1) = a_(n - 1), "если случается\nс положительной вероятностью"))) = P(xi_n = a_n | xi_(n - 1) = a_(n - 1)).
  $
  то есть, грубо говоря, если все случайные величины зависят от предыдущих, и не зависят от остальных.
]

#example[
  Случайные блуждания по $ZZ$.
  $eta_n$ --- независимые, $eta_n = plus.minus 1$ с вероятностями $p$ и $1 - p$.
  $
    xi_n = eta_1 + eta_2 + ... + eta_n ==> xi_n = xi_(n - 1) + eta_n.
  $
]

#example[
  Пусть есть какой-то прибор, который либо работает, либо не работает. Если он работает, то с вероятностью $p$ он может сломаться. Если он не работает, то с вероятностью $q$ его могут починить.
  #TODO[картинка марковской цепи]
]

#notice[
  Вероятность оказаться в момент времени $n$ в том или ином состоянии определяется начальным распределением $pi_0$, и вероятностями перехода $P(xi_n = b | xi_(n - 1) = a) =: p_n (a, b)$.
]

#denote[
  $pi_n (a) := P(xi_n = a)$.
]

#def[
  Цепь Маркова _однородная_, если $p_n (a, b)$ не зависят от времени, то есть $p_n (a, b) = p_(a, b)$ для всех $n$.
]

#th[
  Для однородной цепи Маркова,
  $
    P(xi_0 = a_0, xi_1 = a_1, ..., xi_n = a_n) =
    pi_0 (a_0) dot p_(a_0 a_1) dot p_(a_1 a_2) dot ... dot p_(a_(n - 1) a_n).
  $
  Такое событие называется _траектория_.
]

#proof[
  Очевидно по индукции.
]

#th(name: "существования")[
  Если $pi_0: Y --> [0, 1]$ --- распределение вероятностей на $Y$ (то есть $sum_(y in Y) pi_0 (y) = 1$), и заданы переходы $p: Y times Y --> [0, 1]$ --- вероятности переходов, такие, что $sum_(y in Y) p(a, y) = 1$. Тогда существует $(Omega, Ff, P)$ --- вероятностное пространство, и $xi_n: Omega --> Y$ --- цепь Маркова, с начальным распределением $pi_0$ и вероятностями перехода $p_(a, b)$.
]

#proof[
  Это не трудно, но там возня. Без доказательства.
]

#denote[
  $P$ --- матрица $(p_(a, b))_(a, b in Y)$. Вообще говоря, бесконечная.
]
#th[
  $pi_n = pi_0 dot P^n$. Почему-то в теорвере принято обозначать распределения вероятностей строками.
]

#proof[
  База очевидна. Доказываем индукционный переход $n ~~> n + 1$.

  $
    pi_(n + 1) (b) = P(xi_(n + 1) = b) = sum_(y in Y) P(xi_(k + 1) = b | xi_n = y) P(xi_n = y) = sum_(y in Y) pi_n (y) p_(y b) = (pi_n P) (b).
  $
]

#denote[
  $
    P(xi_n = b | xi_0 = a) = p_(a b) (n).
  $
]

#def[
  $pi: Y --> [0, 1]$ --- _распределение_ на $Y$, если $sum_(y in Y) pi(y) = 1$.

  $pi$ --- _стационарное распределение_, если $pi P = pi$.
]

#example[
  Стационарное распределение сущесвует не всегда. Например, в случайных блужданиях по $ZZ$ с симметричной вероятностью переходов. Предположим, что нашлось стационарное распределение $pi$. Тогда 
  $
    P(xi_1 = b) =
    sum_(y in ZZ) P(xi_1 = b | xi_0 = y) P(xi_0 = y) newline(=)
    P(xi_0 = b - 1) dot 1/2 + P(xi_0 = b + 1) dot 1/2 =
    (pi(b - 1) + pi(b + 1))/2.
  $
  Значит для любого $b$ целого,
  $
    2pi (b) = pi (b - 1) + pi (b + 1) ==> pi(b + 1) - pi(b) = pi(b) - pi(b - 1) ==> pi(y + 1) - pi(y) =: c.
  $
  Если $c > 0$, то 
  $
    pi(n) =  (pi(n) - pi(n - 1)) + pi(n - 1) = c + pi(n - 1) = ... = n c + pi(0).
  $
  Но тогда для любого $c > 0$, начиная с какого-то $n$ вероятность будет больше 1. Аналогично, если $c < 0$ (для больших $n$ она меньше $0$). Значит $c = 0$. Но это тоже дичь какая-то: $pi equiv const$, то есть во всех целых точках вероятность одна и та же.
]

#th(name: "Эргодическая теорема Маркова")[
  Пусть $Y$ --- конечное, $p_(a, b) > 0$ для любых $a, b in Y$ (то есть из чего угодно можно попасть куда угодно с положительной вероятностью). Тогда сущесвует единственное стационарное распределение. Более того, $pi(b) = lim_(n -> oo) p_(a, b) (n)$. Более того, сущесвует $q < 1$ такое, что
  $
    abs(pi(b) - p_(a, b) (n)) <= C q^n
  $
  для любых $a, b in Y$.
]

#proof[
  Пусть $\#Y = m$. Рассмотрим $RR^m$ с нормой --- сумма модулей координат: $norm(x) = abs(x_1) + ... + abs(x_m)$. Рассмотрим отображение $T: RR^m --> RR^m$ вида $x arrow.bar.long (x^T P)^T = P^T x$ --- это линейное отображение. Будем смотреть на него на 
  $
    K := {x in RR^m : x_1, ..., x_m >= 0 "и " x_1 + ... + x_m = 1}
  $
  --- это компакт. Тогда $T: K --> K$. Проверим, что это сжатие.
  $
    norm(T_x - T_y) <= q norm(x - y).
  $
  Надо доказать, что $norm(T z) <= q norm(z)$, где $z = x - y$, и $q < 1$. Пусть $delta := min_(i, j) p_(i, j) > 0$.
  $
    (T z)_j = sum_(i = 1)^m p_(i j) z_i = sum_(i = 1)^m (p_(i j) - delta) z_i + delta sum_(i = 1)^m z_i.
  $
  Сумма $z_i$ это $0$ (какая-та сумма разностей $x - y$, а сумма $x_i$ и $y_i$ обе 1). Оценим норму
  $
    norm(T z) =
    sum_(j = 1)^m abs((T z)_j) =
    sum_(j = 1)^m abs(sum_(i = 1)^m (p_(i j) - delta) z_i) <=
    sum_(j = 1)^m sum_(i = 1)^m (p_(i j) - delta) abs(z_i) newline(=)
    sum_(i = 1)^m underbrace((sum_(j = 1)^m (p_(i j) - delta)), 1 - m delta) abs(z_i) =
    (1 - m delta) sum_(i = 1)^m abs(z_i) = (1 - m delta) norm(z).
  $
  Положим $q := (1 - m delta) < 1$. Примерим теорему Банаха о сжатии. По ней
  1. Существует неподвижная точка.
  2. Любая последовательность итераций сходится к ней с хорошей скоростью.
  Что и требовалось.
]

#notice[
  Мы требуем $p_(a, b) > 0$, но это немного сильно: достаточно просить, что через сколько-то шагов (но ограниченное количество) все вершины достижимы. Просто будет рассматривать теорему Маркова каждые $M$ шагов.
]

#def[
  $a$ и $b$ --- состояния цепи. $p_(a, b) (n)$ --- вероятность попасть из $a$ в $b$ за $n$ шагов.
  - $b$ _достижимо_ из $a$, если сущесвует $n in NN$ такое, что $p_(a, b) (n) > 0$.
  - $a$ --- _существенное_, если для любого $b$ достжимого из $a$, следует достижимость из $a$ в $b$.
]

#exercise[
  Цепь конечная. Доказать, что сущесвует хотя бы одно достижимое состояние.
]

#def[
  $a$ и $b$ _сообщающиеся_, если $a$ достижимо из $b$ и $b$ достижимо из $a$.
]

#def[
  $a$ --- _нулевое_, если $p_(a, a) (n) -->_(n -> oo) = 0$.
]

#denote[
  $f_a (n) := P(xi_n = a, xi_(n - 1) != a, xi_(n - 2) != a, ..., xi_1 != a | xi_0 = a)$. Это вероятность того, что первый возврат случился на $n$-м шаге. $f_a (0) = 0$.
]

#def[
  $a$ --- _возвратное_, если $sum_(n = 1)^oo f_a (n) = 1$. Обозначим $F_a := sum_(n = 1)^oo f_a$ --- вероятность возврата.
]

#th(name: "критерий возвратности")[
  $a$ возвтрано тогда только тогда, когда 
  $
    sum_(n = 1)^oo p_(a, a) (n) = +oo,
  $
  и если $a$ невозвратно, то $F_a = P_a/(1 + P_a)$, где $P_a := sum_(n = 1)^oo p_(a, a) (n)$.
]

#proof[
  Положим
  - $P(t) := sum_(n = 0)^oo p_(a, a) (n) t^n$.

  - $F(t) := sum_(n = 0)^oo f_a (n) t^n$.

  Тогда при $n >= 1$
  $
    p_(a, a) (n) = sum_(k = 0)^n f_a (k) p_(a, a) (n - k).
  $
  Это свертка последовательностей:
  $
    P(t) - 1 = sum_(n = 1)^oo p_(a, a) (n) t^n = sum_(n = 1)^oo sum_(k = 0)^n f_a (k) p_(a, a) (n - k) t^n = F(t) P(t).
  $
  Значит
  $
    F(t) = (P(t) - 1)/(P(t)).
  $
  - Пусть $P_a = sum_(n = 1)^oo p_(a, a) (n) < +oo$. Тогда $P(t) -->_(t -> 1-) P_a + 1$ по теореме Абеля. $F(t) = (P(t) - 1)/(P(t)) -->_(t -> 1-) P_a/(P_a + 1)$, а еще $F(t) --> F_a$. Значит они равны.
  
  - Пусть $P_a = +oo$. Тогда $F_a <-- F(t) = 1-1/(P(t)) --> 1$, так как $P(t) -->_(t->1-) +oo$.
]

#follow[
  Невозвратное состояние всегда нулевое.
]

#th(name: "солидарности")[
  Пусть $a$ и $b$ сообщающиеся. Тогда
  1. Либо $a$ и $b$ ненулевые, либо $a$ и $b$ нулевые.
  2. Либо $a$ и $b$ возвратные, либо $a$ и $b$ невозвратные.
]

#proof[
  1. Пусть $a$ нулевое. Тогда $p_(a, a) (n) --> 0$. $a$ и $b$ сообщающиеся, поэтому существуют $i$ и $j$ такие, что $p_(a, b) (i) > 0$, и $p_(b, a) (j) > 0$. Вероятность попать в из $b$ в $b$ не меньше, чем вероятность попать в $b$ по маршруту $b ~~> a ~~> a ~~> b$. По есть $p_(b, b) (i + n + j) >= p_(a, b) (i) dot p_(b, b) (n) dot p_(b, a) (j)$. Это равно нулю только если $p_(b, b) (n) --> 0$.

  2. Пусть $b$ возвратное. Тогда $sum_(n = 1)^oo p_(b, b) (n) = +oo$ по критерию возвратности. Проверим расходимость такого же ряда для $a$: $sum_(n = 1)^oo p_(a, a) (n) >= sum_(n = 1)^oo p_(a, a) (n + i + j) >= p_(a, b) (i) dot p_(b, a) (j) sum_(n = 1)^oo p_(b, b) (n)$. Значит этот ряд тоже расходящийся, и $a$ --- возвратное.
]

