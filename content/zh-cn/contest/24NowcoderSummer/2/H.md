+++
title = '【2024牛客暑期多校训练营2】H'
date = 2024-07-31T19:14:54+08:00
draft = false
series = ["2024牛客暑期多校训练营2"]
series_order = 4
showSummary = false
tags = ["前缀和"]

+++

{{< katex >}}

## 1. 题目

{{< toggle "English" >}}

**Red** stands at the coordinate \\((0,0)\\) of the Cartesian coordinate system. She has a string of instructions: up, down, left, right (where `right` increases the x-coordinate by \\(1\\), and `up` increases the y-coordinate by \\(1\\)).

Now **Red** wants to select a continuous substring of instructions and execute them. **Red** hopes that the final execution of the instructions can pass through the coordinate \\((x,y)\\). She wants to know how many selection options there are.

***<u>Input</u>***

The first line contains three integers \\(n\\), \\(x\\), and \\(y\\) (\\(1 \leq n \leq 2 \times 10^5, -10^5 \leq x, y \leq 10^5)\\), — the length of the instruction string and the coordinates **Red** hopes to pass through.

The second line contains a string of length nnn, consisting of the characters \\(W\\), \\(S\\), \\(A\\), and \\(D\\). — the four directions: up, down, left, and right, respectively.

***<u>Output</u>***

Output one integer representing the number of selection options for the continuous substring.

{{< /toggle >}}

<br>

{{< toggle "简体中文（大意）">}}

给定字符串，表示一串移动指令，假如起点为 \\((0,0)\\)，求能到达 \\((x,y)\\) 的子串的个数。

{{< /toggle >}}

## 2. 思路

由于上下左右移动对应的是坐标的变化，故可以将字符串表示为对应的坐标变化，问题便转化成为：寻找坐标变化为 \\((x,y)\\) 的区间的个数。

由于只需要路径穿过了目标点就可以，故对于所有终点在 \\((x,y)\\) 的字符串以及以该字符串为前缀的后续所有字符串都满足条件。

所以我们可以使用**前缀和**保存区间的信息，然后稍作差分计算符合条件的区间的个数。

## 3. 代码

{{< toggle "C++" >}}

```cpp
void solve()
{
    int n, x, y;
    std::cin >> n >> x >> y;
    std::string s;
    std::cin >> s;
    if (x == 0 && y == 0) {
        std::cout << (n * (n + 1) >> 1);
        return;
    }
    std::vector<std::pair<i64, i64>> l(n + 1, {0, 0});
    for (int i = 0; i < n; i++) {
        auto [x0, y0] = l[i];
        if (s[i] == 'A') {
            x0--;
        }
        else if (s[i] == 'D') {
            x0++;
        }
        else if (s[i] == 'W') {
            y0++;
        }
        else {
            y0--;
        }
        l[i + 1] = {x0, y0};
    }
    i64 num = 0;
    std::map<std::pair<i64, i64>, std::vector<int>> ref;
    for (int i = n; i >= 0; i--) {
        auto [x0, y0] = l[i];
        if (!ref[{x + x0, y + y0}].empty()) {
            int min = *ref[{x + x0, y + y0}].begin();
            num += n - min + 1;
        }
        ref[l[i]].push_back(i);
        std::sort(ref[l[i]].begin(), ref[l[i]].end());
    }
    std::cout << num;
}
```

{{< /toggle >}}

## 4. 总结

从代码中发现，可以使用 `map` 对遍历进行优化。由于正向遍历要对每一个前缀和找到第一个符合条件的值，时间复杂度为 \\(O(n^2)\\) ，而逆序遍历的时候对所有已经遍历过的前缀和进行查询，用 `map` 进行了保存，时间复杂度降到了 \\(O(n\cdot logn)\\)。

总之使用前缀和可以很简单的处理可以差分的问题。
