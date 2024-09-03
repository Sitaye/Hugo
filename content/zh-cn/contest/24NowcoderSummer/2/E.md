+++
title = '【2024牛客暑期多校训练营2】E'
date = 2024-07-31T19:14:38+08:00
draft = false
series = ["2024牛客暑期多校训练营2"]
series_order = 3
showSummary = false
tags = ["签到题"]

+++

{{< katex >}}

## 1. 题目

{{< toggle "English" >}}

Ben_H has a positive integer \\(x\\). He wants you to find another positive integer \\(y\\), which is strictly less than \\(x\\), so that the equation \\(gcd(x, y) = x \oplus y\\) holds. Can you help him?

 where \\(\oplus\\) is bitwise **XOR** operation.

***<u>Input</u>***

The first line contains a single integer \\(t (1 \leq t \leq 10^4)\\) — the number of test cases.

The only line of each test case contains a single integer \\(x (1\leq x \leq 10^{18})\\).

***<u>Output</u>***

For each testcase, output a single positive integer \\(y\\), if you find a feasible answer, or \\(-1\\) otherwise.

{{< /toggle >}}

<br>

{{< toggle "简体中文（大意）">}}

给定 \\(x\\)，构造 \\(y\\) 使满足 \\(gcd(x,y) = x\oplus y\\)。

{{< /toggle >}}

## 2. 思路

签到题，由于问题只需要**构造**出一个数满足条件即可，故不需要遍历整个区间。

由最大公约数的性质可知，\\(gcd(x,y)\\) 的结果通常与 \\(x\\) 成倍数关系，而等式右侧又为二进制的表示形式，故考虑是否存在 \\(2\\) 的倍数。

又二进制的表示方法知道，设 \\(x\\) 的二进制形式为 \\(10110100\\)，则可以表示为：
$$
2^7 + 2^5 + 2^4 + 2^2 = (2^5 + 2^3 + 2^2 + 1)\times 2^2
$$
故 \\(x\\) 可以表示为最后一个为 \\(1\\) 位所表示的二进制数的倍数，可以通过补码性质得到。

要保证与右侧的异或值相同，只要保证 \\(y\\) 的前半部分与 \\(x\\) 相同，从 \\(x\\) 的最后一个 \\(1\\) 位往后均为 \\(0\\) 即可：
$$
\begin{array}{cc}
x&10110100\\\
y&10110\color{red}{\underline{0}00}\\\
\hline
\oplus\rightarrow&00000\color{blue}{100}
\end{array}
$$


此外要特别注意的是，如果 \\(x\\) 为 \\(2^k\\)，那么按照这种方法找到的数为 \\(0\\)，不满足条件。

## 3. 代码

{{< toggle "C++">}}

```cpp
void solve()
{
    i64 x;
    std::cin >> x;
    i64 lowbit = (x & -x);
    if (lowbit == x) {
        std::cout << "-1\n";
    }
    else {
        std::cout << x - lowbit << "\n";
    }
}
```

{{< /toggle >}}

## 4. 总结

签到题，但是本题注意数据范围 \\((1\leq x \leq 10^{18})\\) 很大，不要通过遍历去搜索满足条件的数，尽量从二进制的结构上去构造。

掌握获取最后一个为 \\(1\\) 位的方法，也经常运用于树状数组中：`lowbit = (x & -x)`。
