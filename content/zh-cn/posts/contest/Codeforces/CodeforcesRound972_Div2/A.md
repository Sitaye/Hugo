+++
title = 'Codeforces Round 972 (Div. 2) - A'
date = 2024-09-15T08:35:37+08:00
draft = false
series = ["Codeforces Round 972 (Div. 2)"]
series_order = 1
showSummary = false
tags = [""]
categories = ["比赛", "Codeforces", "Div2"]

+++

{{< katex >}}

## 1. 题目

{{< toggle "English" >}}

*Narek has to spend 2 hours with some 2-year-old kids at the kindergarten. He wants to teach them competitive programming, and their first lesson is about palindromes.*

Narek found out that the kids only know the vowels of the English alphabet (the letters \\(\mathtt{a}\\), \\(\mathtt{e}\\), \\(\mathtt{i}\\), \\(\mathtt{o}\\), and \\(\mathtt{u}\\)), so Narek needs to make a string that consists of vowels only. After making the string, he'll ask the kids to count the number of subsequences that are palindromes. Narek wants to keep it simple, so he's looking for a string such that the amount of palindrome subsequences is minimal.

Help Narek find a string of length \\(n\\), consisting of **lowercase** English **vowels only** (letters \\(\mathtt{a}\\), \\(\mathtt{e}\\), \\(\mathtt{i}\\), \\(\mathtt{o}\\), and \\(\mathtt{u}\\)), which **minimizes** the amount of **palindrome\\(^{\dagger}\\) subsequences\\(^{\ddagger}\\)** in it.

\\(^{\dagger}\\) A string is called a palindrome if it reads the same from left to right and from right to left.

\\(^{\ddagger}\\) String \\(t\\) is a subsequence of string \\(s\\) if \\(t\\) can be obtained from \\(s\\) by removing several (possibly, zero or all) characters from \\(s\\) and concatenating the remaining ones, without changing their order. For example, \\(\mathtt{odocs}\\) is a subsequence of \\(\texttt{c}{\color{red}{\texttt{od}}}\texttt{ef}{\color{red}{\texttt{o}}}\texttt{r}{\color{red}{\texttt{c}}}\texttt{e}{\color{red}{\texttt{s}}}\\).

***<u>Input</u>***

The first line of the input contains a single integer \\(t\\) (\\(1 \le t \le 100\\)) — the number of test cases.

Subsequently, the description of each test case follows. The only line of each test case contains a single integer \\(n\\) (\\(1 \le n \le 100\\)) — the size of the string.

***<u>Output</u>***

For each test case, output any string of length nn that satisfies the above conditions.

{{< /toggle >}}

<br>

{{< toggle "简体中文（大意）">}}

利用 \\(\mathtt{a}\\), \\(\mathtt{e}\\), \\(\mathtt{i}\\), \\(\mathtt{o}\\), \\(\mathtt{u}\\) 构造长度为 \\(n\\) 的字符串，使得回文子串个数最少。

{{< /toggle >}}

## 2. 思路

观察可以发现：

- 当 \\(n \leq 5\\) 时，所有的字符串的回文子串个数均最少。
- 当 \\(n > 5\\) 时，必定会出现重复的元音字母，而重复的元音字母均会与其中间的字母构成一个三字母的回文串，例如 \\({\color{red}\mathtt{a}}\mathtt{b}{\color{blue}\mathtt{c}}\mathtt{d}{\color{red}\mathtt{a}}\\)，其中 \\({\color{red}\mathtt{a}}{\color{blue}\mathtt{c}}{\color{red}\mathtt{a}}\\) 构成一个回文串。

因此只要将相同字母放在一起，减少第二种情况中相同字母之间字母的个数，就能减少回文子串的个数。

## 3. 代码

{{< toggle "C++">}}

```cpp
void solve()
{
    int n;
    std::cin >> n;
    char c[] = {'a', 'e', 'i', 'o', 'u'};
    std::map<char, int> l;
    for (int i = 0; i < n; i++) {
        l[c[i % 5]] ++;
    }
    for (auto &[x, y] : l) {
        while (y--) {
            std::cout << x;
        }
    }
    std::cout << '\n';
}
```

{{< /toggle >}}
