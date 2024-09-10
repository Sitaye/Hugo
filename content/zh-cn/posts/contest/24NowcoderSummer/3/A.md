+++
title = '【2024牛客暑期多校训练营3】A'
date = 2024-09-09T16:54:33+08:00
draft = true
series = ["2024牛客暑期多校训练营3"]
series_order = 1
showSummary = false
tags = [""]
categories = ["比赛", "2024牛客暑期多校训练营", "2024牛客暑期多校训练营3"]

+++

{{< katex >}}

## 1. 题目

{{< toggle "English" >}}

A group of nnn walkers arrives at a riverbank at night. They want to cross the river using a boat, which is initially on their side. The boat can hold at most RRR walkers at a time and requires at least \\(L\\) \\((1 \leq L < R)\\) walkers to operate.

Rowing the boat is a tiring task. Each time the boat is used to transport a group of walkers to the other side of the river, all walkers on the boat must have stamina greater than \\(0\\), and each walker's stamina decreases by \\(1\\) after the trip. Initially, the \\(i\\)-th walker \\((1 \leq i \leq n)\\) has a stamina value of \\(h_i\\)​.

You need to determine if it is possible to transport all the walkers to the other side of the river using the boat.

***<u>Input</u>***

The first line of input contains three integers \\(n, L, R\\) \\((1 \le L < R \le n \le 5 \times 10^5)\\), denoting the number of walkers, the minimum and the maximum number of walkers to use the boat at a time, respectively.

The second line of input contains nnn integers \\(h_1,h_2,\dots,h_n\\) \\((1\leq h_i\leq 5\times 10^5)\\), where \\(h_i\\) \\((1 \leq i \leq n)\\) denotes the stamina value of the \\(i\\)-th walker.

***<u>Output</u>***

If it is possible to transport all the walkers to the other side of the river using the boat, output "`Yes`" in the first line (without quotes). Otherwise, output "`No`" in the first line (without quotes). You can output each letter in any case (lowercase or uppercase). For example, the strings "`yEs`", "`yes`", "`Yes`", and "`YES`" will all be considered as positive replies.

{{< /toggle >}}

<br>

{{< toggle "简体中文（大意）">}}

\\(n\\) 个人过河，有一个能装 \\(R\\) 个人的船，需要 \\(L\\) 个人体力不为空才能出发，且每划一次船划船者的体力减一，确定是否所有人都能走到对岸。

{{< /toggle >}}

## 2. 思路



## 3. 代码

{{< toggle "C++" >}}

```cpp

```

{{< /toggle >}}

## 4. 总结
