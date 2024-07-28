+++
title = '【2024牛客暑期多校训练营1】A'
date = 2024-07-26T20:24:54+08:00
draft = false
categories = ["2024牛客暑期多校训练营"]
series = ["2024牛客暑期多校训练营1"]
series_order = 1
showSummary = false
tags = ["规律题"]

+++

{{< katex >}}

## 1. 题目

{{< toggle "English" >}}

Given two integers \\(n\\) and \\(m\\), among all the sequences containing \\(n\\) non-negative integers less than \\(2^m\\), you need to count the number of such sequences \\(A\\) that there exists a non-empty subsequence of \\(A\\) in which the bitwise **AND** of the integers is \\(1\\).

Note that a non-empty subsequence of a sequence \\(A\\) is a non-empty sequence that can be obtained by deleting zero or more elements from \\(A\\) and arranging the remaining elements in their original order.

Since the answer may be very large, output it modulo a positive integer \\(q\\).

 The bitwise **AND** of non-negative integers \\(A\\) and \\(B\\), \\(A\\) **AND** \\(B\\) is defined as follows: 

- When \\(A\\) **AND** \\(B\\) is written in base two, the digit in the \\(2^d\\)'s place ( \\(d\geq 0\\) ) is \\(1\\) if those of \\(A\\) and \\(B\\) are both \\(1\\), and \\(0\\) otherwise.  

For example, we have \\(4\\) **AND** \\(6\\) = \\(4\\) (in base two: \\(100\\) **AND** \\(110\\) = \\(100\\)).

Generally, the bitwise **AND** of \\(k\\) non-negative integers \\(p_1,𝑝_2,\dots,p_k\\) is defined as
(\\(\dots\\)((\\(p_1\\) AND \\(p_2\\)) AND \\(p_3\\)) AND \\(\dots\\) AND \\(p_𝑘\\))
and we can prove that this value does not depend on the order of \\(p_1,𝑝_2,\dots,p_k\\).

***<u>Input</u>***

The only line contains three integers \\(n\\) (\\(1 \le n \le 5\,000\\)), \\(m\\) (\\(1 \le m \le 5\,000\\)) and \\(q\\) (\\(1 \le q \le 10^9\\)).

***<u>Output</u>***

Output a line containing an integer, denoting the answer.

{{</ toggle >}}

## 2. 思路

这是一道找规律的题。通过观察样例`2 3 998244353 -> 17`可以发现如下的计算过程：

- 选择含有一个数的子序列，则选择的这个子序列必须为 `001`。另外一个数的各位任选，有 \\(2^3\\) 种方案。由于子序列按照不同顺序排列算作不同的子序列，那将`001`放在另一个数的位置为另一种情况。此时还需要减去`[001, 001]`的情况，出现了两次。故此时的结果为 \\(2^3+2^3 - 1=15\\)。
- 选择含有两个数的子序列，则选择的两个子序列的末尾那一位必须均为 \\(1\\)。由于刚刚已经计算过了其中一位为`001`的情况，再加上两个末尾为 \\(1\\) 但是不为`001`的情况：`[101, 011]`和`[011, 101]`。故此时的结果为 \\(15+2=17\\)。

将上面的过程进行推广我们可以发现有如下的规律：

- 选择其中的 \\(k\\) 个数，使得这 \\(k\\) 个数的末尾一位均为 \\(1\\)，而其他位上的数，保证至少出出现一个 \\(0\\)。我们可以知道第 \\(i\\) 位的数字范围为`[000...0~111...1]`，当我们去除最后一个全为 \\(1\\) 的数，其他的数均满足出现至少一个 \\(0\\)。此时的范围为 \\(C_n^k \cdot(2^k-1)^{m-1}\\)，即从 \\(n\\) 个数中任选 \\(k\\) 个数并对除了最后一位的其余 \\(m-1\\) 位都获取了 \\(2^k-1\\) 种结果。
- 然后对于剩下的 \\(n-k\\) 个数，任意选择每一位上的结果，为了保证不会重复计算，让剩下的 \\(n-k\\) 个数的最后一位均为 \\(0\\)。此时的范围为 \\((2^{m-1})^{n-k}=2^{(m-1)\cdot(n-k)}\\)，即对每一个数选定最后一位为 \\(0\\)，其余位置任选。

于是最终的结果为 \\(\sum\limits_{k=1}^n(C_n^k \cdot(2^k-1)^{m-1}\cdot2^{(m-1)\cdot(n-k)})\\)

## 3. 代码

{{< toggle "C++" >}}

```cpp

```

{{</ toggle >}}
