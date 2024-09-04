+++
title = '【2024牛客暑期多校训练营2】I'
date = 2024-07-31T19:14:56+08:00
draft = false
series = ["2024牛客暑期多校训练营2"]
series_order = 5
showSummary = false
tags = ["动态规划"]
categories = ["比赛", "2024牛客暑期多校训练营", "2024牛客暑期多校训练营2"]

+++

{{< katex >}}

## 1. 题目

{{< toggle "English" >}}

There are \\(2\cdot n\\) cards arranged in a row, with each card numbered from \\(1\\) to \\(n\\) having exactly \\(2\\) copies.

Each time, **Red** can choose a subarray of consecutive cards (at least \\(2\\) cards) to remove from the deck. The chosen subarray must satisfy that the first and last cards have the same number. The score for this operation is: the number of cards multiplied by the number on the first card.

Now **Red** wants to know what is the maximum value of the final score?

***<u>Input</u>***

The first line contains a positive integer \\(n(1\leq n \leq 3\times 10^3)\\) — the number of card types.

The second line contains \\(2\cdot n\\) positive integers \\(a_i(1\leq a_i \leq n)\\) — the number on each card from left to right.

***<u>Output</u>***

A single positive integer — representing the maximum final score.

{{< /toggle  >}}

</br>

{{< toggle "简体中文（大意）" >}}

一个序列包含 \\(1\\) ~ \\(n\\)，每个数出现两次。每次选择删掉首尾两个数相同的区间，得到的值为 <u>区间元素个数</u> \\(\times\\) <u>首/尾的数</u>，并将所得到的值求和。求和的最大值。

{{< /toggle  >}}

## 2. 思路

这很显然是一个**区间 DP** 问题。很容易想到，区间和区间之间可能会出现包含关系，所以一个大的区间可以由所包含的小的区间转移得到。

虽然区间之间可能会有包含关系，但是最后也有可能出现单个没有配对的数。因此我们在原题的基础上添加一个条件：在首尾添加两个 \\(0\\)。问题就变成了将所有数都删掉所能得到的最大值是多少，因为最后假如还剩下了无法配对的数，虽然不会产生贡献，但是可以归纳到 \\(0\\) 的区间里面。这样所有的数都能通过计算除去。

假如一个大的区间包含了很多完整的小的区间，那么状态转移就可以变为：每个小的区间的最大值 + 单独出现的值产生的贡献。

因此对于这个区间的状态转移方程为：
$$
dp(i)=\max\begin{cases}\  dp(i-1) + x\\\ dp(l(a(i)) - l(x) - 1) + ans(a(i)) \texttt{ if l(x) < l(a(i)) and r(a(i)) = i + l(x)}\end{cases}
$$
其中当前区间的首尾元素为 \\(x\\)，考虑区间的前 \\(i\\) 个元素，对于当前这个数 \\(a(i)\\)，\\(l(i)\\) 为第一次出现的下标，\\(r(i)\\) 为最后一次出现的下标，有两种操作策略：

- 选择 \\(a(i)\\) 和 \\(x\\) 的区间一起删掉，则贡献为 \\(dp(i-1)+x\\)
- 如果 \\(a(i)\\) 所代表的完整区间在 \\(x\\) 区间内，则优先考虑这个代表区间，此时的答案为除了 \\(a(i)\\) 区间的最大值 \\(dp(l(i)-1)\\) 加上 \\(a(i)\\) 区间的最大值 \\(ans(a(i))\\)。最后让 \\(ans(x)\\) 等于 \\(dp(r(x))\\) 即可。

求一下最大值就可以了。很显然最终的答案为 \\(ans(0)\\)。

## 3. 代码

{{< toggle "C++">}}

```cpp
void solve()
{
    int n, m;
    std::cin >> n;
    m = (n << 1);
    std::vector<int> a(m + 2);
    std::vector<std::vector<int>> p(n + 1);
    a[0] = 0, a[m + 1] = 0;
    p[0] = {0, m + 1};
    for (int i = 1; i <= m; i++) {
        std::cin >> a[i];
        p[a[i]].push_back(i);
    }
    std::vector<std::pair<int, int>> g(n + 1);
    for (int i = 1; i <= n; i++) {
        int l = p[i][0], r = p[i][1];
        g[i] = {r - l + 1, i};
    }
    g[0] = {m + 2, 0};
    std::sort(g.begin(), g.end());
    std::vector<int> ans(n + 1);
    for (int i = 0; i <= n; i++) {
        auto &[len, now] = g[i];
        int l = p[now][0], r = p[now][1];
        std::vector<int> dp(len);
        dp[0] = now;

        for (int j = 1; j < len; j++) {
            dp[j] = dp[j - 1] + now;
            int lx = p[a[j + l]][0], rx = p[a[j + l]][1];
            if (lx > l && rx == j + l) {
                dp[j] = std::max(dp[j], dp[lx - l - 1] + ans[a[j + l]]);
            }
        }
        ans[now] = dp[len - 1];
    }
    std::cout << ans[0];
}
```

{{< /toggle >}}

## 4. 总结

这个是一个从区间 DP 变化而来的题目，就是将子区间的和转移为父亲区间的和来达到动态规划的目的。
