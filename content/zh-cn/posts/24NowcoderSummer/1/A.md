+++
title = '【2024牛客暑期多校训练营1】A'
date = 2024-07-26T20:24:54+08:00
draft = false
categories = ["2024牛客暑期多校训练营"]
series = ["2024牛客暑期多校训练营1"]
series_order = 1
showSummary = false

+++

{{< katex >}}

## 题目

Given two integers \\(n\\) and \\(m\\), among all the sequences containing \\(n\\) non-negative integers less than \\(2^m\\), you need to count the number of such sequences \\(A\\) that there exists a non-empty subsequence of \\(A\\) in which the bitwise **AND** of the integers is \\(1\\).

Note that a non-empty subsequence of a sequence \\(A\\) is a non-empty sequence that can be obtained by deleting zero or more elements from \\(A\\) and arranging the remaining elements in their original order.

Since the answer may be very large, output it modulo a positive integer \\(q\\).

 The bitwise **AND** of non-negative integers \\(A\\) and \\(B\\), \\(A\\) **AND** \\(B\\) is defined as follows: 

- When \\(A\\) **AND** \\(B\\) is written in base two, the digit in the \\(2^d\\)'s place ( \\(d\geq 0\\) ) is \\(1\\) if those of \\(A\\) and \\(B\\) are both \\(1\\), and \\(0\\) otherwise.  

For example, we have \\(4\\) **AND** \\(6\\) = \\(4\\) (in base two: \\(100\\) **AND** \\(110\\) = \\(100\\)).

Generally, the bitwise **AND** of \\(k\\) non-negative integers \\(p_1,𝑝_2,\dots,p_k\\) is defined as
(\\(\dots\\)((\\(p_1\\) AND \\(p_2\\)) AND \\(p_3\\)) AND \\(\dots\\) AND \\(𝑝𝑘\\))
and we can prove that this value does not depend on the order of \\(p_1,𝑝_2,\dots,p_k\\).

