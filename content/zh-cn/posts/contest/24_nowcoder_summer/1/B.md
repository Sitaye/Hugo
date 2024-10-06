+++
title = '2024 牛客暑期多校训练营 1 - B'
date = 2024-07-26T20:24:57+08:00
draft = false
series = ["2024 牛客暑期多校训练营 1"]
series_order = 2
showSummary = false
tags = ["第二类斯特林数"]
categories = ["比赛", "2024 牛客暑期多校训练营"]

+++

{{< katex >}}

## 1. 题目（Problem A Enhanced）

{{< toggle "English" >}}

Given two integers \\(n\\) and \\(m\\), among all the sequences containing \\(n\\) non-negative integers less than \\(2^m\\), you need to count the number of such sequences \\(A\\) that there exists **<u>two different</u>** non-empty subsequencesc of \\(A\\) in which the bitwise **AND** of the integers is \\(1\\).

Note that a non-empty subsequence of a sequence \\(A\\) is a non-empty sequence that can be obtained by deleting zero or more elements from \\(A\\) and arranging the remaining elements in their original order. **<u>Two subsequences are different if they are composed of different locations in the original sequence.</u>**

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

<br>

{{< toggle "简体中文（大意）" >}}

给两个数 \\(n\\) 和 \\(m\\\)，表示 \\(n\\) 个 \\(m\\) 位（B）长度的数，寻找【仅存在<u>**一个**</u> **AND** 和为 \\(1\\) 的子序列】的序列的个数。

{{< /toggle >}}

## 2. 思路

这是 \\(A\\) 题的加强版，\\(A\\) 题前序内容参考：

> {{< article link="/posts/contest/24nowcodersummer/1/a/" >}}

此题可以简化为：\\(A\\) 题中的答案 -【有且仅有一个子序列 **AND** 和为 1 】的数量。

可以根据 \\(A\\) 题的推导过程发现，每次我们选择 \\(k\\) 个末尾均为 \\(1\\) 的数，剩下的 \\(n - k\\) 数末尾均为 \\(0\\)，那么仅有的这个 **AND** 和为 \\(1\\) 的子序列必须为当前选定的 \\(k\\) 个数的子序列。但是这个子序列要想满足**唯一**的条件，就必须修改【除末尾为 \\(1\\)，其余 \\(m - 1\\) 位任选含 \\(0\\) 的 \\(2^k-1\\) 种选择】的条件。

假如 \\(k=3\\)，最后一位为 \\(1\\)，那么下式中的所有的 \\(\underline{\bold{0}}\\) 均为所有选中的 \\(k\\) 个数中所在位**唯一**的 \\(0\\)（称为**特殊位**）：
$$
\begin{array}{c|ccc|c}
 & 1 & 2 & 3 & 4 \\\
\hline
p_1 & \color{red}{\underline{\bold{0}}} & 1 & 1 & 1 \\\
p_2 & 1 & \color{red}{\underline{\bold{0}}} & 1 & 1 \\\
p_3 & 1 & 1 & \color{red}{\underline{\bold{0}}} & 1 \\\
\end{array}
$$
因此可以发现，当选取 \\(k\\) 个数为子序列的时候，我们要满足这些数都至少包含一个特殊位，当满足 \\(1\leq k\leq m-1\\) 的时候，确保不会有重复的特殊位出现：
$$
\begin{array}{c|ccccc|c}
 & 1 & 2 & 3 & \dots & m-1 & m \\\
\hline
p_1 & \color{red}{\underline{\bold{0}}} & 1 & 1 & \dots & 1 & 1 \\\
p_2 & 1 & \color{red}{\underline{\bold{0}}} & 1 & \dots & 1 & 1 \\\
p_3 & 1 & 1 & \color{red}{\underline{\bold{0}}} & \dots & 1 & 1 \\\
\vdots & \vdots & \vdots & \vdots & \ddots & \vdots & \vdots\\\
p_k & 1 & 1 & 1 & \dots & \color{red}{\underline{\bold{0}}} & 1
\end{array}
$$
当删除这些特殊位的时候，就会使得某一位不含有 \\(0\\)，不满足 **AND** 和为 \\(1\\) 的条件，确保了唯一性。

假如此时选取了 \\(k-1\\) 个数，当在为 \\(k\\) 个数添加特殊位的时候，有以下两种情况：

- 添加到新选择的数的某一位上。
- 添加到已选择的 \\(k-1\\) 中某一个数的某一位上

我们采用动态规划，假设选择 \\(k\\) 个数，有 \\(t\\) (\\(k\leq t\leq m-1\\)) 个特殊位的方案数为 \\(dp(k,t)\\)，那么状态转移方程为：
$$
dp(k,t)=C^1_k\cdot(dp(k-1,t-1) + dp(k,t-1))
$$
即特殊位要么加在 \\(k-1\\) 个数的基础上新加的一个数上，要么加在已经存在的一个数上。直观体现为如下两种情况（红色为已有的特殊位，蓝色为新加的特殊位）：
$$
\begin{align*}
\begin{array}{c|cccccc|c}
 & 1 & 2 & 3 & 4 & 5 & \dots & 6 \\\
\hline
p_1 & \color{red}{\underline{\bold{0}}} & 1 & 1 & 1 & 1 & \dots & 1 \\\
p_2 & 1 & \color{red}{\underline{\bold{0}}} & 1 & 1 & 1 & \dots & 1 \\\
p_3 & 1 & 1 & \color{red}{\underline{\bold{0}}} & \color{red}{\underline{\bold{0}}} & 1 & \dots & 1\\\
p_4 & 1 & 1 & 1 & 1 & \color{blue}{\underline{\bold{0}}} & \dots & 1\\\
\end{array}
\hspace{1cm}
\begin{array}{c|cccccc|c}
 & 1 & 2 & 3 & 4 & 5 & \dots & 5 \\\
\hline
p_1 & \color{red}{\underline{\bold{0}}} & 1 & 1 & 1 & 1 & \dots & 1 \\\
p_2 & 1 & \color{red}{\underline{\bold{0}}} & 1 & 1 & 1 & \dots & 1 \\\
p_3 & 1 & 1 & \color{red}{\underline{\bold{0}}} & 1 & 1 & \dots & 1\\\
p_4 & 1 & 1 & 1 & \color{red}{\underline{\bold{0}}} & \color{blue}{\underline{\bold{0}}} & \dots & 1\\\
\end{array}
\end{align*}
$$
由于 \\(t\\) 的范围为 \\(k\leq t\leq m-1\\)，相当于将 \\(t\\) 个特殊位分给 \\(k\\) 个数，每个数至少含有一个特殊位，类似于**第二类斯特林数**，故也可以结合斯特林数的推导过程理解状态转移方程。

需要注意的是：

- 当 \\(k=1\\) 的时候，当且仅当子序列为 \\(1\\) 的时候，这个数满足条件，需要单独计算：\\(C_n^1\cdot2^{(n-1)\cdot(m-1)}\\)
- 当 \\(k>1\\) 的时候，我们选择其中 \\(t\\) 位，其他 \\(m-1-t\\) 位依然可以任选，但是注意每位不能只含有一个 \\(0\\) （防止成为特殊位，有 k 种只有一位有 \\(0\\) 情况），再减去全为 \\(1\\) 的情况：\\((2^k-k-1)^{{m-1-t}}\\)

于是最终结果为：
$$
\begin{align*}
ans &= \sum\limits_{k=1}^n(C_n^k \cdot(2^k-1)^{m-1}\cdot2^{(m-1)\cdot(n-k)})-\sum\limits_{k=2}^n(C_n^k\cdot2^{(m-1)\cdot(n-k)}\cdot\sum\limits_{t=k}^{m-1}(C_{m-1}^t\cdot dp(k,t)\cdot(2^k-k-1)^{m-1-t}))+C_n^1\cdot2^{(n-1)\cdot(m-1)}\\\
&=\sum\limits_{k=2}^n(C_n^k\cdot2^{(m-1)\cdot(n-k)}\cdot((2^k-1)^{m-1}-\sum\limits_{t=k}^{m-1}(C_{m-1}^t\cdot dp(k,t)\cdot(2^k-k-1)^{m-1-t})))
\end{align*}
$$

## 3. 代码

{{< toggle "C++" >}}

```cpp
i64 binpow(i64 a, i64 b, i64 mod) // 快速幂
{
    a %= mod;
    i64 ans = 1;
    while (b > 0) {
        if (b & 1) {
            ans *= a;
            ans %= mod;
        }
        a *= a;
        a %= mod;
        b >>= 1;
    }
    return ans;
}
void solve()
{
    int n, m;
    i64 q;
    std::cin >> n >> m >> q;
    
    std::vector<i64> pw2(n + 1), c(n + 1), ct(m); // 初始化 2^k、Cn 组合数和 Cm 组合数
    pw2[0] = c[0] = ct[0] = 1;
    for (int i = 1; i <= n; i++) {
        pw2[i] = (pw2[i - 1] << 1) % q;
    }
    for (int i = 1; i <= n; i++) {
        for (int j = i; j > 0; j--) {
            c[j] = (c[j] + c[j - 1]) % q;
        }
    }
    for (int i = 1; i <= m - 1; i++) {
        for (int j = i; j > 0; j--) {
            ct[j] = (ct[j] + ct[j - 1]) % q;
        }
    }
    
    std::vector<std::vector<i64>> dp(n + 1, std::vector<i64>(m)); // 定义 dp 数组
    dp[0][0] = 1;
    for (int k = 1; k <= n; k++) { // 更新 dp 数组
        for (int t = 1; t <= m - 1; t++) {
            dp[k][t] = ((dp[k][t - 1] + dp[k - 1][t - 1]) % q * k) % q;
        }
    }
    
    i64 ans = 0;
    for (int k = 2; k <= n; k++) { // 按照公式求解
        i64 tmp1 = binpow(pw2[k] - 1, m - 1, q);
        i64 tmp2 = 0, tp = (pw2[k] + q - k - 1) % q, tmpt = 1;
        for (int t = m - 1; t >= k; t--) {
            tmp2 += ((ct[t] * dp[k][t]) % q * tmpt) % q;
            tmp2 %= q;
            tmpt *= tp;
            tmpt %= q;
        }
        i64 tmp3 = binpow(pw2[n - k], m - 1, q);
        ans += (((tmp1 + q - tmp2) % q * tmp3) % q * c[k]) % q;
        ans %= q;
    }
    std::cout << ans;
}
```

{{</ toggle>}}

## 4. 总结

本题是 \\(A\\) 题的加强版，在 \\(A\\) 的基础上引入了**第二类斯特林数**的思想对【有且仅有一个子序列 **AND** 和为 1 】进行了解释和推导，是对于规律总结和组合数学的很好的练习。

第二类斯特林数请参考：

> {{< article link="/posts/math/combinatorialmath/stirlingnumber/">}}
