+++
title = '【2024牛客暑期多校训练营2】C'
date = 2024-07-31T19:14:33+08:00
draft = false
series = ["2024牛客暑期多校训练营2"]
series_order = 2
showSummary = false
tags = ["动态规划"]
categories = ["比赛", "2024牛客暑期多校训练营", "2024牛客暑期多校训练营2"]

+++

{{< katex >}}

## 1. 题目

{{< toggle "English" >}}

**Red** is on a \\(2\cdot n\\) grid, with some cells being red and others being white.

**Red** can initially choose a red cell, and at each step, can choose a red cell above, below, to the left, or to the right. When **Red** leaves a cell, the cell immediately turns white.

**Red** wants to know the maximum number of steps she can take.

If there are no initial red cells, please output \\(0\\).

***<u>Input</u>***

The first line contains a positive integer \\(n(1\leq n \leq 10^6)\\).

The next two lines contain a \\(2\cdot n\\) character matrix, consisting only of `R` and `W` characters. `R` represents a red cell, and `W` represents a white cell.

***<u>Output</u>***

An integer — the maximum number of steps **Red** can take.

{{< /toggle >}}

<br>

{{< toggle "简体中文（大意）">}}

在 \\(2\times n\\) 的格子中有 `R` 和 `W`，求从任意一个 `R` 出发能连续走到最多的 `R` 的个数。

{{< /toggle >}}

## 2. 思路

这道题是一道比较经典的**动态规划**问题。假定从左往右寻找，当前位置假如为 `R`，则只有可能从**左方**或者**另一条线**的 `R` 所在的搜索路线上加 \\(1\\) 得到。因此我们能比较容易得到动态规划的转移方程：
$$
\begin{cases}
dp(i,j,0)=\max{(dp(i,j-1,0),dp(i,j-1,1))}\\\
dp(i,j,1)=dp(1-i,j,0)+1
\end{cases}
$$
其中 \\(dp(i,j,k)\\) 数组表示坐标为 \\((i,j)\\) 的 `R` 从 \\(k\\) 方向上来的 `R` 的个数，\\(k=0\\) 表示从左方来的个数，\\(k=1\\) 表示从另一条线上来的个数。对于同一个元素的 \\(k\\) 可以通过另一条线加 \\(1\\) 得到。

然后对所有的 \\(dp\\) 数组遍历寻找最大值即可。

## 3. 代码

{{< toggle "C++" >}}

```cpp
void solve()
{
    int n;
    std::cin >> n;
    std::string s[2];
    for (int i = 0; i < 2; i++) {
        std::cin >> s[i];
    }
    std::vector<std::vector<std::vector<int>>> dp(2, std::vector<std::vector<int>>(n, std::vector<int>(2, 0)));
    for (int j = 0; j < n; j++) {
        for (int i = 0; i < 2; i++) {
            if (s[i][j] == 'R') {
                dp[i][j][0] = 1;
            }
        }
    }
    for (int j = 0; j < n; j++) {
        for (int i = 0; i < 2; i++) {
            if (s[i][j] == 'R' && j > 0) {
                dp[i][j][0] += std::max(dp[i][j - 1][0], dp[i][j - 1][1]);
            }
        }
        for (int i = 0; i < 2; i++) {
            if (s[i][j] == 'R') {
                dp[i][j][1] = dp[i ^ 1][j][0] + 1;
            }
        }
    }
    int ans = 0;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < n; j++) {
            for (int k = 0; k < 2; k++) {
                ans = std::max(ans, dp[i][j][k]);
            }
        }
    }
    std::cout << std::max(0 ,ans - 1) << '\n';
}
```

{{< /toggle >}}

## 4. 总结

经典的动态规划，懂点掌握如何设计动态转移方程。一般可以将已有的条件设置为可以推导的部分（比如下标），而要求的值设置为 `dp` 数组的值进行递推。
