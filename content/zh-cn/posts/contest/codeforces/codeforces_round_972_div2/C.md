+++
title = 'Codeforces Round 972 (Div. 2) - C'
date = 2024-09-15T08:35:39+08:00
draft = false
series = ["Codeforces Round 972 (Div. 2)"]
series_order = 3
showSummary = false
tags = ["动态规划"]
categories = ["比赛", "Codeforces", "Div2"]

+++

{{< katex >}}

## 1. 题目

{{< toggle "English" >}}

Narek is too lazy to create the third problem of this contest. His friend Artur suggests that he should use ChatGPT. ChatGPT creates \\(n\\) problems, each consisting of \\(m\\) letters, so Narek has \\(n\\) strings. To make the problem harder, he combines the problems by selecting some of the \\(n\\) strings **possibly none** and concatenating them **without altering their order**. His chance of solving the problem is defined as \\(score_n - score_c\\), where \\(score_n\\) is Narek's score and \\(score_c\\) is ChatGPT's score.

Narek calculates \\(score_n\\) by examining the selected string (he moves from left to right). He initially searches for the letter \\(\texttt{"n"}\\), followed by \\(\texttt{"a"}\\), \\(\texttt{"r"}\\), \\(\texttt{"e"}\\), and \\(\texttt{"k"}\\). Upon finding all occurrences of these letters, he increments \\(score_n\\) by \\(5\\) and resumes searching for \\(\texttt{"n"}\\) again (he doesn't go back, and he just continues from where he left off).

After Narek finishes, ChatGPT scans through the array and increments \\(score_c\\) by \\(1\\) for each letter \\(\texttt{"n"}\\), \\(\texttt{"a"}\\), \\(\texttt{"r"}\\), \\(\texttt{"e"}\\), or \\(\texttt{"k"}\\) that Narek fails to utilize (note that if Narek fails to complete the last occurrence by finding all of the \\(5\\) letters, then all of the letters he used are counted in ChatGPT's score \\(score_c\\), and Narek doesn't get any points if he doesn't finish finding all the 5 letters).

Narek aims to maximize the value of \\(score_n - score_c\\) by selecting the most optimal subset of the initial strings.

***<u>Input</u>***

In the first line of the input, you're given a single integer \\(t\\) (\\(1 \le t \le 10^5\\)), the number of test cases. Then the description of each test case follows.

In the first line of each test case, you're given two integers \\(n, m\\) (\\(1 \le n, m \le 10^3\\)), the number of strings and the length of each string.

In the next \\(n\\) lines, you're given \\(n\\) strings, each having a length of \\(m\\). The strings only contain lowercase letters of the English alphabet.

The sum of values of \\(n \cdot m\\) over all test cases does not exceed \\(10^6\\).

***<u>Output</u>***

For each test case, output a single integer: the maximal possible value of \\(score_n - score_c\\).

{{< /toggle >}}

<br>

{{< toggle "简体中文（大意）">}}

有 \\(n\\) 个长度为 \\(m\\) 的字符串，选择其中一些字符串并按顺序相连组成新的字符串。新字符串中每出现 \\(\texttt{narek}\\) 的完整子序列就会加 \\(5\\) 分（不完整不加分），其他出现在 \\(\texttt{narek}\\) 中但没有出现在子序列中的字母会减 \\(1\\) 分。求任意选择字符串拼接所能得到的最大的分数。

{{< /toggle >}}

## 2. 思路

对于任意两字符串拼接，它产生的得分取决与上一个字符串结尾需要什么字母，例如：

- \\(\texttt{\color{red}nare}\texttt{zz}\\)
- \\(\texttt{\color{blue}n}\texttt{\color{red}k}\texttt{\color{blue}arek}\\)

由于第一个字符串结尾的时候需要 \\(\texttt{k}\\)，所以拼接的时候第二个字符串产生的贡献由第一个 \\(\texttt{k}\\) 提供，其他几个在 \\(\texttt{narek}\\) 中的字母要提供负贡献。由此可以看出满足**动态规划**的<u>最优子结构</u>和<u>无后效性</u>，基本可以判断为动态规划的问题。

由于当前字符串的结果取决于上一个字符串结尾需要什么字母，所以我们将每个字符串结尾所需要的字母建立动态规划数组，动态地更新每一轮假如从之前的某一个字符串结尾所需要字母开始所能产生的最优贡献。

当处理完最后一个字符串的时候，我们得到所有 \\(5\\) 个字母结尾的动态规划数组，然而由于不完整的字符串不能提供贡献，所以最后一个字符串所需要的字符不为 \\(\texttt{n}\\) 则应该减去已经产生的贡献。

## 3. 代码

{{< toggle "C++">}}

```cpp
void solve()
{
    int n, m;
    std::cin >> n >> m;
    std::string s[n];
    for (int i = 0; i < n; i++) {
        std::cin >> s[i];
    }
    std::array<int, 5> dp;
    dp.fill(-inf);
    dp[0] = 0;
    const std::string t = "narek";
    for (int i = 0; i < n; i++) {
        auto ndp = dp;
        for (int x = 0; x < 5; x++) {
            int y = x;
            int res = dp[x];
            for (auto c : s[i]) {
                if (c == t[y]) {
                    y++;
                    if (y == 5) {
                        y = 0;
                        res += 5;
                    }
                }
                else if (t.find(c) != -1) {
                    res--;
                }
            }
            ndp[y] = std::max(ndp[y], res);
        }
        dp = ndp;
    }
    int ans = 0;
    for (int i = 0; i < 5; i++) {
        ans = std::max(ans, dp[i] - i);
    }
    std::cout << ans << "\n";
}
```

{{< /toggle >}}

## 4. 总结

这是一道动态规划的问题，问题的关键是怎么建立动态规划的数组来转移状态。

我们分析得到每一个字符串所能产生的贡献只有上一个字符串结尾的字母决定，所以应当根据上一个字符串结尾的字母建立动态规划数组，然后每次单独计算这个字符串的所能产生的贡献对动态规划数组进行更新，时间复杂度为 \\(O(n\cdot m\cdot 5)\\)。
