+++
title = '2024 牛客暑期多校训练营 3 - J'
date = 2024-09-09T16:55:00+08:00
draft = true
series = ["2024 牛客暑期多校训练营 3"]
series_order = 5
showSummary = false
tags = [""]
categories = ["比赛", "2024 牛客暑期多校训练营"]

+++

{{< katex >}}

## 1. 题目

{{< toggle "English" >}}

In a two-player competitive match, for any positive integer \\(a\\), we define the \\(\text{Best of }2a - 1\\) format as follows: the two players continue to compete until one of them wins \\(a\\) times, thereby winning the overall match. The \\(\text{Best of }2a - 1\\) format includes a maximum of \\(2a-1\\) games and a minimum of \\(a\\) games.

For any two positive integers \\(a\\) and \\(b\\), we define the \\(\text{Best of }2b - 1\\) of \\(\text{Best of }2a - 1\\) format as follows: the two players compete in a major match using the \\(\text{Best of }2b - 1\\) format, which consists of a maximum of \\(2b-1\\) major games and a minimum of \\(b\\) major games. Each major game is a \\(\text{Best of }2a - 1\\) format, consisting of a maximum of \\(2a-1\\) minor games and a minimum of \\(a\\) minor games. For example, Team \\(A\\) and Team \\(B\\) play a \\(\text{Best of }3\\) of \\(\text{Best of }5\\) match. Here are some possible outcomes (we use \\(1\\) to represent a win for Team \\(A\\) and \\(0\\) to represent a win for Team \\(B\\)):

- \\(000111000\\) (Team \\(A\\) loses the first and third major games \\(0:3\\), wins the second major game \\(3:0\\), so the overall score is a \\(1:2\\) loss for Team \\(A\\));
- \\(0110000110\\) (Team \\(A\\) loses the first and second major games \\(2:3\\), so the overall score is a \\(0:2\\) loss for Team \\(A\\)).

Team \\(A\\) and Team \\(B\\) are currently engaged in a \\(DotA2\\) match using the \\(\text{Best of }2b - 1\\) of \\(\text{Best of }2a - 1\\) format. To the spectators, this is an exciting event! However, unknown to the spectators, the entire match outcome is predetermined: there is a "script" of length \\(n\\) represented by a binary string \\(T\\), where the results of the minor games will continuously repeat this pattern of \\(01\\). Having this information, you want to know the match results when the "script" \\(01\\) string is repeated from each position (see the sample explanation for details).

***<u>Input</u>***

The first line of input contains three integers \\(n\\), \\(a\\), \\(b\\) \\((1\leq n,a,b\leq 10^5)\\), whose meanings are already given in the statement.

The second line of input contains a binary "script" string \\(T\\) with length \\(n\\).

***<u>Output</u>***

Output a binary string \\(ans\\) of length \\(n\\), where \\(ans[i]\\) \\((1 \leq i \leq n)\\) represents the final match result when repeating the script string \\(T\\) starting from the \\(i\\)-th position of \\(T\\).

{{< /toggle >}}

<br>

{{< toggle "简体中文（大意）">}}

大比赛采取 \\(\text{BO } 2b+1\\)，对应每场小比赛采取 \\(\text{BO } 2a+1\\)，现在告诉一串小比赛的比分，比分循环进行，求把每一场小比赛作为第一场比赛谁会赢。

{{< /toggle >}}

## 2. 思路



## 3. 代码

{{< toggle "C++" >}}

```cpp

```

{{< /toggle >}}

## 4. 总结

