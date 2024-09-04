+++
title = '【2024牛客暑期多校训练营1】D'
date = 2024-07-27T12:12:27+08:00
draft = true
series = ["2024牛客暑期多校训练营1"]
series_order = 4
showSummary = false
categories = ["比赛", "2024牛客暑期多校训练营", "2024牛客暑期多校训练营1"]

+++

{{< katex >}}

## 1. 题目（Problem C Enhanced）

{{< toggle "English" >}}

Given an array which is initially empty, you need to perform \\(q\\) operations:

- Given two non-negative integers \\(t\\) and \\(v\\), take out the element from the end of the array for \\(t\\) times and then append \\(v\\) to the end of the array. It is guaranteed that \\(t\\) does not exceed the length of the array before this operation. 

After each operation, let \\(a_1, a_2, \ldots, a_n\\) be the current array, find the bitwise **XOR** of \\(s_1, s_2, \ldots, s_n\\), where \\(s_i = a_i + a_{i+1} + \ldots + a_n\\) is the sum of the suffix starting from position \\(i\\).

Since the answers may be very large, output them modulo \\(2097152\\).

The bitwise **XOR** of non-negative integers \\(A\\) and \\(B\\), \\(A \oplus B\\) is defined as follows:

- When \\(A \oplus B\\) is written in base two, the digit in the \\(2^d\\)'s place (\\(d \ge 0\\)) is \\(1\\) if exactly one of the digits in that place of \\(A\\) and \\(B\\) is \\(1\\), and \\(0\\) otherwise. 

For example, we have \\(3 \oplus 5 = 6\\) (in base two: \\(011 \oplus 101 = 110\\)).

Generally, the bitwise **XOR** of \\(k\\) non-negative integers \\(p_1, p_2, \ldots, p_k\\) is defined as
(\\(\ldots((p_1 \oplus p_2) \oplus p_3) \oplus \ldots \oplus p_k\\))
and we can prove that this value does not depend on the order of \\(p_1, p_2, \ldots, p_k\\)​.

***<u>Input</u>***

The first line contains an integer \\(q\\) ( \\(1\leq q\leq 5\times 10^5\\) ), denoting the number of operations.

Each of the following \\(q\\) lines contains two non-negative integers \\(t\\) and \\(v\\) ( \\(0\leq v\leq 10^9\\) ), describing an operation, where \\(t\\) does not exceed the length of the array before this operation.

***<u>Output</u>***

Output \\(q\\) lines, each of which contains an integer, denoting the answer.

{{< /toggle >}} 

<br>

{{< toggle "简体中文（大意）" >}}

\\(q\\) 次询问，每次从序列末尾删除 \\(t\\) 个数，并添加一个数 \\(v\\)，求每次询问后的**后缀和**的**异或和**。

{{< /toggle >}} 
