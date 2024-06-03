#import "../../utils/core.typ": *

== Предельные теоремы для схем Бернулли

#example[
    Пусть $S_n$ --- количество успехов в схеме Бернулли с $n$ испытаниями.
    
    Что больше
    $
        P(S_1000 = 220) "при" p = 1/5, "или" P(S_2000 = 360) "при" p = 1/6?
    $
    Их можно вычислить, но это очень тяжело. Первое выражение равняется $C_2000^360 dot (1/6)^360 dot (5/6)^(2000 - 360) approx 0.006625$, а вторая $approx 0.00894$. Мы приведем более простой способ решения этой задачи.
]

#th(name: "Пуассона")[
    Рассмотрим последовательность схем Бернулли с $n$ испытаниями и вероятностью успеха $p_n$, такую что $n p_n --> lambda > 0$. Тогда
    $
        P(S_n = k) -->_(n -> oo) (lambda^k)/(k!) e^(-lambda).
    $
]

#proof[
    $
        P(S_n = k) = C_n^k p_n^k (1 - p_n)^(n - k) sim C_n^k lambda^k/n^k (1 - p^n)^(n - k) newline(=)
        (n dot (n - 1) dot ... dot (n - k + 1))/(k!) lambda^k / (n^k) (1 - p_n)^(n - k) sim
        lambda^k / (k!) (1 - p_n)^(n - k) sim lambda^k / (k!) e^(-lambda).
    $
    Последний переход верен потому что $(1 - p_n)^(n - k) sim (1-p_n)^n$, и
    $
        n ln(1 - p_n) = n ln(1 - lambda/n + o(1/n)) sim n (-lambda/n + o(1/n)) = -lambda + o(1).
    $
]

#notice[
    Если $p_n = lambda/n$, то $P(S_n = k) sim lambda^k / (k!) e^(-lambda)$ при $k = o(sqrt(n))$.
]

#proof[
    Надо понять, что
    $
        (n dot (n - 1) dot ... (n - k + 1))/(n^k) --> 1.
    $
    Это верно, потому что
    $
        1 <-- 1 - (k (k - 1))/ (2n) = 1 - 1/n - 2/n - ... - (k - 1)/n <=^* 1 dot (1 - 1/n) dot ... dot (1 - (k - 1)/n) <= 1,
    $
    а неравенство $*$ выполняется, потому что
    $
        (1 + x_1)(1 + x_2) ... (1 + x_n) >= 1 + x_1 + x_2 + ... + x_n,
    $
    где $x_i$ одного знака, и $x_i > -1$. Это похоже на неравенство Бернулли и доказывается точно также, по индукции. Это остается читателю в качестве упражнения.

    Наконец, $(1 - p_n)^(n - k) --> e^(-lambda)$, потому что
    $
         (n - k) ln(1 - p_n) --> (n - k) ln(1 - lambda/n) sim (n - k) (-lambda/n) --> -lambda.
    $
]

#th(name: "локальная теорема Маувра-Лапласа")[
    Пусть $0 < p < 1$ и $q := 1 - p$, при $n -> oo$,
    $
        x = (k - n p) / sqrt(n p q),
    $
    и $k$ меняется так, что $abs(x) <= T$.
    Тогда
    $
        P(S_n = k) sim 1/(sqrt(2 pi n p q)) e^(-x^2/2)
    $
    равномерно по $x$ в интервале $[-T, T]$ в схеме Бернулли с $n$ испытаниями и вероятностью успеха $p$.
]

#proof[
    $
        P(S_n = k) = C_n^k p^k q^(n - k) = n!/(k! (n - k)!) p^k q^(n - k).
    $
    и
    $
        k = n p + x sqrt(n p q) >= n p - T sqrt(n p q) --> +oo,\
        n - k = n q - x sqrt(n p q) >= n q - T sqrt(n p q) --> +oo.
    $
    Так как есть стремление к бесконечности, можно писать формулу Стирлинга:
    $
        P(S_n = k) =
            n!/(k! (n - k)!) p^k q^(n - k)
        sim
            (n^n cancel(e^(-n)) sqrt(cancel(2 pi) n))
            /
            (
                k^k cancel(e^(-k)) sqrt(2pi k)
                (n - k)^(n - k) cancel(e^(-n + k)) sqrt(cancel(2pi) (n - k))
            )
            dot p^k q^(n - k) 
        newline(sim)
            (n^n p^k q^(n - k) sqrt(cancel(n)))
            /
            (
                k^k (n - k)^(n - k) sqrt(2pi n p) dot
                sqrt(cancel(n) q)
            ) 
        =
            1/sqrt(2 pi n p q) dot (n^n p^k q^(n - k))
            /
            (k^k (n - k)^(n - k)).
    $
    Надо показать, что последняя дробь стремиться к $e^(-x^2/2)$. Логарифмируем (и сразу домножаем на $-1$ чтобы получить стремление к $x^2/2$):
    $
        k ln k/n + (n - k) ln(1 - k/n) - k ln p - (n - k) ln q newline(=)
        k ln (k / (n p)) + (n - k) ln ((n - k) / (n q)).
    $
    Смотрим на дроби:
    $
        #box(width: 5pt) k / (n p) = (n p + x sqrt(n p q)) / (n p) = 1 + x sqrt(q/(n p)) ==> ln(k/(n p)) = ln(1 + x sqrt(q/(n p))) = x sqrt(q/(n p)) - x^2 q/(2n p) + O(1/(n sqrt(n))).\
        #box(width: 40pt) (n - k)/(n q) = (n q - x sqrt(n p q)) / (n q) = 1 - x sqrt(p/(n q)) ==> ln((n - k)/(n q)) = ln(1 - x sqrt(p/(n q))) = -x sqrt(p/(n q)) - x^2 p/(2n q) + O(1/(n sqrt(n))).
    $

    Подставляем в сумму:
    $
        k ln (k / (n p)) + (n - k) ln ((n - k) / (n q)) = \
        #box(width : 20pt) (n p + x sqrt(n p q))(x sqrt(q/(n p)) - x^2 q/(2n p) + O(1/(n sqrt(n)))) + (n q - x sqrt(n p q))(-x sqrt(p/(n q)) - x^2 p/(2n q) + O(1/(n sqrt(n)))) =
        \
        #box(width : 52pt) x sqrt(n p q) + x^2 q - (x^2 q)/2 - x sqrt(n p q) + x^2 p - (x^2 p)/2 + O(1/sqrt(n)) = x^2 (p + q - p/2 - q/2) + O(1/sqrt(n)) = x^2/2 + O(1/sqrt(n))
    $
]

#notice[
    Аналогичное утверждение верно, если $abs(k - n p) <= phi(n)$, где $phi(n) = o((n p q)^(2/3))$ (в теореме $abs(k - n p) <= C sqrt(n p q)$).
]

#th(name: "Прохорова")[
    Если $n p = lambda$, то
    $
        sum_(k = 0)^oo abs(P(S_n = k) - (lambda^k e^(-lambda))/k!) <=
        (2 lambda)/n min{2, lambda}.
    $
]
#proof[
    Без доказательства.
]

#example[
    Пусть мы играем в рулетку в европейском варианте (ошибка). В ней есть числа от $0$ до $36$. Монетка ставится на одно из чисел (кроме $0$). Обычно, если выпадает число, на которую поставлена монета, возвращается $36$ монет, а если нет, то монета уходит в казино. НО! У нас казино совсем честное (sus), и если мы выигрываем, мы получаем все $37$ монет.

    Допустим, мы сыграли $111$ раз. С какой вероятностью мы уйдем с тем, с чем пришли? Это
    $
        P(S_111 = 3) = C_111^3 (1/37)^3 (36/37)^(111 - 3) approx 0.227127...
    $
    Если посчитать по теореме Пуассона, то $lambda = 3$ и
    $
        P(S_111 = 3) = (3^3 e^(-3))/3! = 4.5/e^3 = 0.224041...
    $
    Получилось близко.

    Посчитаем вероятность того, что мы уйдем с прибылью. Это
    $
        P("выигрыш") = 1 - P(S_111 = 0) - P(S_111 = 1) - P(S_111 = 2) - P(S_111 = 3) newline(approx)
        1 - (3^0 e^(-3))/0! - (3^1 e^(-3))/1! - (3^2 e^(-3))/2! - (3^3 e^(-3))/3! =
        1 - 13/e^3 approx
        0.352754...
    $
    Если посчитать точно, получится $0.352768...$. Короче, хоть у нас оценка и не точная, но она дает хорошее приближение, особенно пока $lambda$ существенно меньше $n$.
]

#example[
    Играем в ту же рулетку, но теперь теперь мы ставим на четное, или на нечетное, причем $0$ не считается ни четным, ни нечетным (вероятность успеха тогда $18/37$). Мы также считаем, что в этот раз казино не такое честное, и лишь удваивает ставку, когда мы выигрываем.
    
    Мы играем $n = 222$ раз. С какой вероятностью мы уйдем с чем пришли?
    $
        P(S_222 = 111) = C_222^111 (18/37)^111 (19/37)^111 = 0.0433228...
    $
    Если посчитать по теореме Муавра Лапласа,
    $
        P(S_222 = 111) = 1/sqrt(2 pi dot 222 dot 18/37 dot 19/37) e^(-((111-111 dot 18/37)/sqrt(111 dot 18/37 dot 19/37))^2/2) = 0.0493950...
    $
]

#th(name: "Интегральная теорема Муавра-Лапласса")[
    Рассматриваем схему Бернулли с вероятностю успеха $0 < p < 1$. Тогда
    $
        P(a < (S_n - n p)/(sqrt(n p q)) <= b) -->_(n -> oo) 1/sqrt(2 pi) integral_a^b e^(-t^2/2) dif t
    $
    равномерно по $a, b in RR$.
]

#proof[
    Эту теорему можно доказать через локальную теорему Муавра-Лапласа: аккуратно посчитать сумму вероятностей в интервале $[a, b]$, и показать, что она стремится к интегралу. Это довольно сложно и неприятно, но доказать можно. Мы не будем этого делать.

    Чуть позже у нас появится центральная предельная теорема, которая дает более общий результат.
]

#th(name: "Оценка на скорость сходимости (Частный случай теоремы Берри-Эссеена)")[
    $
        sup_(x in RR) abs(P((S_n - n p)/sqrt(n p q) <= x) - 1/sqrt(2 pi) integral_(-oo)^x e^(-t^2/2) dif t) <=
        (p^2 + q^2)/(sqrt(n p q)) dot 1/2.
    $
    За константу справа была долгая борьба (изначально в теореме она была порядка $1$), и она до сих пор улучшается. Оценка $0.469$ --- лучшая на данный момент по данным Храброва.
]

#proof[#amogus]

#notice[
    1. Оценки лучше чем $C / sqrt(n)$ не бывает.
]

#example[
    Пусть $p = q = 1/2$, и мы считаем $P(S_(2n) <= n)$. Тогда 
    $
        P(S_(2n) < n) + P(S_(2n) = n) + P(S_(2n) > n) = 1,
    $
    и первая и последняя вероятности равны. Тогда
    $
        P(S_(2n) <= n) = (1 + P(S_(2n) = n))/2 = 1/2 + 1/2 dot C^n_(2n) (1/2)^n (1/2)^n = 1/2 + 1/(2 sqrt(n pi)) + o(1/sqrt(n)).
    $
    А теорема Маувра-Лапласса дает
    $
        1/sqrt(2pi) integral_(-oo)^0 e^(-t^2/2) dif t = 1/2.
    $
    Отклонение тогда равно
    $
        P(S_(2n) <= n) - 1/sqrt(2pi) integral_(-oo)^0 e^(-t^2/2) dif t = 1/(2 sqrt(n pi)) + o(1/sqrt(n)).
    $
]

#notice[
    2. Можно понять, что если немного шевелить $a$ и $b$, то можно улушать формулу, подгоняя интеграл под дискретную величину. Знаем,
        $
            P(S_n <= y) = P((S_n - n p)/(sqrt(n p q)) <= (y - n p)/(sqrt(n p q))) approx 1/sqrt(2pi) integral_(-oo)^((y - n p)/(sqrt(n p q))) e^(-t^2/2) dif t.
        $
        Получается лучше брать полуцелые $y$.
]

#example(name: "Задача о театре")[
    В театре $1600$ мест, два входа, и 2 гардероба. Войдя, человек идет в ближайший гардероб, а если он полон, то в другой. Мы хотим выделить в каждом гардеробе столько мест, чтобы переполнения происходили, скажем, раз в месяц. Каждый человек выбирает вход равновероятно. Сколько мест надо выделить в каждом гардеробе?

    Пусть в гардеробе $C$ мест. Рассмотрим схему Бернулли, где $n = 1600$, $p = 1/2$, и $S_n$ --- количество людей, которые пойдут в первый гардероб. Тогда если $S_n <= C$, то первый гардероб не переполняется. Второй гардероб переполняется, если $S_n > n - C$. Нас интересует вероятность
    $
        P(1600 - C <= S_n <= C) > 29/30.
    $
    Долбим интегральную теорему $n p = 800$, $sqrt(n p q) = 20$:
    $
        P((800 - C)/20 <= (S_n - 800) / 20 <= (C - 800)/20) approx
        1/sqrt(2pi) integral_(-(C - 800)/20)^((C-800)/20) e^(-t^2/2) dif t.
    $
    Обычно такие интегралы считаются численно, или в таблице значений $Phi_0 = 1/sqrt(2pi) integral_0^x e^(-t^2/2) dif t$. Тогда
    $
        1/sqrt(2pi) integral_(-(C - 800)/20)^((C-800)/20) e^(-t^2/2) dif t = 2 Phi_0 lr(size: #2em, (underbrace((C - 800)/20, 2.13))) approx 29/30
    $
    при $C = 843$. Таким образом, в каждом гардеробе должно быть $843$ места.
]

#example(name: "Случайные блуждания по прямой")[
    Пусть есть прямая, на ней стоит фишка в изначальной позиции $a_0 = 0$. Каждый шаг времени фишка с вероятностью $p$ идет вправо, и с вероятностью $q = 1 - p$ влево. Таким образом 
    $
        a_(n + 1) = cases(
            a_n + 1\, "с вероятностью" p,
            a_n - 1\, "с вероятностью" q
        )
    $
    Понятно, что $a_n equiv n (mod 2)$. Можно получить из этого схему Бернулли, если представить, что мы еще делаем каждый шаг времени шаг вправо. Тогда при успехе, мы делаем два шага, а при неудаче 0. Тогда $a_n = 2S_n - n$.
    
    $
        P(a_n = k) = P(2S_n = n + k) = cases(
            0 "если" n + k "нечетно",
            C_n^((n + k)/2) p^((n + k)/2) q^((n - k)/2) "если" n + k "четно"
        )
    $
]

#example(name: "Случайные графы, подводка к числу Рамсея")[
    Рассматриваем случайные графы на $n$ вершинах: между каждой парой вершин проводим ребро с вероятностью $p$. Это схема Бернулли с $C_n^2$ испытаниями.
]

#th(name: "Эрдеша")[
    Если $C_n^k dot 2^(1 - C_k^2) < 1$, то
    $
        R(k, k) > n,
    $
    где $R(k, k)$ --- число Рамсея, то есть такое наименьшее число $n$, что для любого графа на $k$ вершинах найдется подграф на $n$ вершинах, в котором либо все ребра присутсвуют, либо все ребра отсутствуют.
    
    В частности, $R(k, k) > 2^(k / 2)$ при $k >= 3$.
]

#proof[
    Пусть $p = 1/2$, строим случайный граф на $n$ вершинах. Тогда
    $
        P("вершины" a_1, a_2, ..., a_k "есть клика или антиклика") = (1/2)^(C_k^2) + (1/2)^(C_k^2) = 2^(1 - C_k^2). 
    $
    А вероятность для каких-то подходящих вершин из $n$ не превосходит
    $
        P("какие-то вершины подходят") <= sum_(a_1, a_2, ..., a_k) P(a_1,..., a_k "подходят") = C_n^k dot 2^(1 - C_k^2).
    $
    Если
    $
        P("никакие-вершины не подходят") > 0,
    $
    то этого достаточно для того, чтобы число Рамсея было больше $n$. А эта вероятность больше нуля, если вероятность обратного события меньше $1$:
    $
        P("какие-то вершины подходят") <= C_n^k dot 2^(1 - C_k^2) < 1.
    $
    Доказали.

    Теперь покажем, что при $n <= 2^(k/2)$ из условия это выполняется. Тогда
    $
        C_n^k = n!/(k! (n - k)!) <= n^k/k!
    $
    и
    $
        C_n^k dot 2^(1 - C_k^2) <= n^k/k! dot 2^(1 - C_k^2) <= 2/k! dot (2^(k/2))^k dot 2^(-(k(k - 1))/2) = 2/k! dot (2^(k/2 - (k - 1)/2))^k < 2^(1+k/2)/k! <= 1.
    $
    Для $k = 3$ это верно, и для больших $k$ тоже по индукции.
]
