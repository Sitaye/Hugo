+++
title = '【2024牛客暑期多校训练营3】B'
date = 2024-09-09T16:54:39+08:00
draft = false
series = ["2024牛客暑期多校训练营3"]
series_order = 2
showSummary = false
tags = ["裴蜀定理"]
categories = ["比赛", "2024牛客暑期多校训练营", "2024牛客暑期多校训练营3"]

+++

{{< katex >}}

## 1. 题目

{{< toggle "English" >}}

After five years, the most high-profile event in motor racing, Formula \\(1\\), returns to China. The Chinese Grand Prix was recently held at the Shanghai International Circuit. Formula \\(1\\) cars can reach speeds of up to \\(350\\) km/h. To ensure the safety of the drivers, the cars must pass rigorous crash tests.

 We consider the following simplified version of a crash test. Initially, a car is positioned with its front facing a wall, at a distance of \\(D\\) meters from the wall. This crash test provides nnn types of boosters, where the \\(i\\)-th type of booster has a thrust performance of \\(h_i\\)​, and there are ample quantities of each type of booster. Suppose the current distance between the car's front and the wall is \\(d\\), and we use a booster with a thrust performance of \\(h\\). When \\(d \ge h\\), the car will move forward \\(h\\) meters and then stop. Otherwise, the car will move forward \\(d\\) meters, crash into the wall, and rebound \\(h-d\\) meters, after which it stops, still facing the wall.

 Now, you want to know, through any number of operations (including no operation), what the minimum distance between the car's front and the wall can be?

***<u>Input</u>***

The first line of input contains two positive integers \\(n\\) and \\(D\\) (\\(1 \le n \le 100, 1 \le D \le 10^{18}\\)), denoting the number of boosters and the distance between the Formula \\(1\\) car and the wall, respectively.

The second line of inputcontains \\(n\\) positive integers \\(h_1, h_2, \ldots, h_n\\) (\\(1 \le h_i \le 10^{18}\\)), denoting the thrust performance of each booster.

***<u>Output</u>***

Output an integer in a line, denoting the minimum possible distance between the car's front and the wall.

{{< /toggle >}}

<br>

{{< toggle "简体中文（大意）">}}

一辆车距离墙壁 \\(D\\) ，有 \\(n\\) 种助推器，每种助推器让车前进 \\(h_i\\)，若剩余距离不足 \\(h_i\\)，则反弹 \\(h_i - D\\) 。求与墙壁之间的最小距离。

{{< /toggle >}}

## 2. 思路

我们发现其实最终到墙壁的距离可以表示为 \\(|a_1h_1+a_2h_2+\cdots+a_nh_n - D|\\)，对于 \\(a_1h_1+a_2h_2+\cdots+a_nh_n\\) 可以联想到著名的**裴蜀定理**。

> {{< article link="/posts/math/numbertheory/bezout/" >}}

由裴蜀定理我们就很容易知道所有推进器最终可以看作推进 \\(\gcd(h_1,h_2,\dots,h_n)\\) 的距离，最终的答案只能在 \\(D \mod \gcd(h_1,h_2,\dots,h_n)\\) 和 \\(\gcd(h_1,h_2,\dots,h_n) - D \mod \gcd(h_1,h_2,\dots,h_n)\\) 中选择。

## 3. 代码

{{< toggle "C++" >}}

```cpp
void solve()
{
    int n;
    i64 D;
    std::cin >> n >> D;
    i64 ans = 0;
    for (int i = 0; i < n; i++) {
        i64 h;
        std::cin >> h;
        ans = std::__gcd(ans, h);
    }
    i64 res = D % ans;
    std::cout << std::min(res, ans - res);
}
```

{{< /toggle >}}

## 4. 总结

这个题主要考查了裴蜀定理的应用。不过在代码中有一个小的知识点：

- \\(\gcd(x,0)=x\\)，因为 \\(0\\) 可以被任何数整除。
- 负数没有最大公因数，但是代码中有 `gcd(x, -y) = gcd(x, y)`
