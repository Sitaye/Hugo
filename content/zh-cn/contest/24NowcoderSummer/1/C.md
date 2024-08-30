+++
title = '【2024牛客暑期多校训练营1】C'
date = 2024-07-26T21:35:59+08:00
draft = false
series = ["2024牛客暑期多校训练营1"]
series_order = 3
showSummary = false
tags = ["前缀和", "模运算"]

+++

{{< katex >}}

## 1. 题目

{{< toggle "English" >}}

Given an array which is initially empty, you need to perform \\(q\\) operations:

- Given two non-negative integers \\(t\\) and \\(v\\), take out the element from the end of the array for \\(t\\) times and then append \\(v\\) to the end of the array. It is guaranteed that \\(t\\) does not exceed the length of the array before this operation.

After each operation, let \\(a_1,a_2,\dots,a_n\\)  be the current array, find the sum of \\(s_1,s_2,\dots,s_n\\) , where \\(s_i =a_i +a_{i+1}+\dots+a_n\\)  is the sum of the suffix starting from position \\(i\\).

Since the answers may be very large, output them modulo \\(1000000007\\).

***<u>Input</u>***

The first line contains an integer \\(q\\) ( \\(1\leq q\leq 5\times 10^5\\) ), denoting the number of operations.

Each of the following \\(q\\) lines contains two non-negative integers \\(t\\) and \\(v\\) ( \\(0\leq v\leq 10^9\\) ), describing an operation, where \\(t\\) does not exceed the length of the array before this operation.

***<u>Output</u>***

Output \\(q\\) lines, each of which contains an integer, denoting the answer.

{{</ toggle >}}

<br>

{{< toggle "简体中文（大意）" >}}

\\(q\\) 次询问，每次从序列末尾删除 \\(t\\) 个数，并添加一个数 \\(v\\)，求每次询问后的后缀和的和。

{{< /toggle >}}

## 2. 思路

观察到元素在后缀和中拥有不同的权重，假如 \\(a_1,a_2,a_3,a_4=[1,2,3,4]\\)，那么有：
$$
\begin{aligned}
s_1&=&a_1+a_2+a_3+a_4\\\
s_2&=&a_2+a_3+a_4\\\
s_3&=&a_3+a_4\\\
s_4&=&a_4\\\
\end{aligned}
$$
则该 \\(before=\sum\limits^n_{i=1}{s_i} = a_1+2a_2+3a_3+4a_4\\)。假如 \\(t=1\\)，那么有：
$$
\begin{aligned}
s_1&=&a_1+a_2+a_3\\\
s_2&=&a_2+a_3\\\
s_3&=&a_3\\\
s_4&=&\\\
\end{aligned}
$$
此时 \\(after=\sum\limits^{n-t}_{i=1}{s_i} = a_1+2a_2+3a_3=before-4a_4\\)。

计算 \\(\sum\limits^n_{i=1}{s_i}\\) 时，每次从末尾删除 \\(t\\) 个元素，都会删掉对应的 **权重** \\(\times\\) **数**。

那么每次操作的时候，只需要在总的 \\(\sum\limits^n_{i=1}{s_i}\\) 上进行增删就可以了。

## 3. 代码

{{< toggle "C++" >}}

```cpp
constexpr int mod = 1000000007;
void solve()
{
    int q;
    std::cin >> q;
    i64 sum = 0;
    std::stack<i64> l;
    while (q--) {
        i64 t, v;
        std::cin >> t >> v;
        while (t--) {
            sum += mod; // 防止减的时候成为负数
            sum -= (l.top() * l.size()) % mod;
            sum %= mod;
            l.pop();
        }
        l.push(v);
        sum += (v * l.size()) % mod;
        sum %= mod;
        std::cout << sum << "\n";
    }
}
```

{{</ toggle >}}

## 4. 总结

这个题主要对**模运算**进行了考察，有几个点需要特别注意一下：

- 模运算中：\\((A\pm\* B)\mod P=((A\mod P)\pm* (B\mod P))\mod P\\)
- 由于第一条特性，在程序的减法的过程中会对每一项元素取模后再取模，所以在计算过程中迭代器很容易在做减法的时候**变为负数**，此时需要在对迭代器取模前<u>先加上一个模数</u>防止溢出。
