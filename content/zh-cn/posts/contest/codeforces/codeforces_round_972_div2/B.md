+++
title = 'Codeforces Round 972 (Div. 2) - B'
date = 2024-09-15T08:35:38+08:00
draft = false
series = ["Codeforces Round 972 (Div. 2)"]
series_order = 2
showSummary = false
tags = ["思维题"]
categories = ["比赛", "Codeforces", "Div2"]

+++

{{< katex >}}

## 1. 题目

{{< toggle "English" >}}

Narek and Tsovak were busy preparing this round, so they have not managed to do their homework and decided to steal David's homework. Their strict teacher noticed that David has no homework and now wants to punish him. She hires other teachers to help her catch David. And now \\(m\\) teachers together are chasing him. Luckily, the classroom is big, so David has many places to hide.

The classroom can be represented as a one-dimensional line with cells from \\(1\\) to \\(n\\), inclusive.

At the start, all \\(m\\) teachers and David are in **distinct** cells. Then they make moves. During each move

-   David goes to an adjacent cell or stays at the current one.
-   Then, each of the \\(m\\) teachers simultaneously goes to an adjacent cell or stays at the current one.

This continues until David is caught. David is caught if any of the teachers (possibly more than one) is located in the same cell as David. **Everyone sees others' moves, so they all act optimally.**

Your task is to find how many moves it will take for the teachers to catch David if they all act optimally.

Acting optimally means the student makes his moves in a way that maximizes the number of moves the teachers need to catch him; and the teachers coordinate with each other to make their moves in a way that minimizes the number of moves they need to catch the student.

Also, as Narek and Tsovak think this task is easy, they decided to give you \\(q\\) queries on David's position.

***<u>Input</u>***

In the first line of the input, you are given a single integer \\(t\\) (\\(1 \le t \le 10^5\\)) — the number of test cases. The description of each test case follows.

In the first line of each test case, you are given three integers \\(n\\), \\(m\\), and \\(q\\) (\\(3 \le n \le 10^9\\), \\(1 \le m, q \le 10^5\\)) — the number of cells on the line, the number of teachers, and the number of queries.

In the second line of each test case, you are given \\(m\\) distinct integers \\(b_1, b_2, \ldots, b_m\\) (\\(1 \le b_i \le n\\)) — the cell numbers of the teachers.

In the third line of each test case, you are given \\(q\\) integers \\(a_1, a_2, \ldots, a_q\\) (\\(1 \le a_i \le n\\)) — David's cell number for every query.

It is guaranteed that for any \\(i\\), \\(j\\) such that \\(1 \le i \le m\\) and \\(1 \le j \le q\\), \\(b_i \neq a_j\\).

It is guaranteed that the sum of values of \\(m\\) over all test cases does not exceed \\(2 \cdot 10^5\\).

It is guaranteed that the sum of values of \\(q\\) over all test cases does not exceed \\(2 \cdot 10^5\\).

***<u>Output</u>***

For each test case, output \\(q\\) lines, the \\(i\\)\-th of them containing the answer of the \\(i\\)\-th query.

{{< /toggle >}}

<br>

{{< toggle "简体中文（大意）">}}

已知 \\(m\\) 个老师在数轴上的位置坐标，假如每次能移动一格，求每次询问给出学生的位置坐标，该位置的学生最晚什么时候被抓住。

{{< /toggle >}}

## 2. 思路

学生的位置只能在三个位置：所有老师最左边、所有老师最右边、某两个老师中间。

由于学生和老师的速度相同，所以在所有老师的一侧的时候，只能逃离到最边缘才会被抓住。而在两个老师中间的区域时，学生最优的情况就是先走到两个老师的中间，然后保持不动直到被抓住。


## 3. 代码

{{< toggle "C++">}}

```cpp
void solve()
{
    int n, m, q;
    std::cin >> n >> m >> q;
    std::vector<int> b(m);
    for (int i = 0; i < m; i++) {
        std::cin >> b[i];
    }
    std::sort(b.begin(), b.end());
    for (int i = 0; i < q; i++) {
        int a;
        std::cin >> a;
        if (a < b[0]) {
            std::cout << b[0] - 1 << "\n";
        }
        else if (a > b[m - 1]) {
            std::cout << n - b[m - 1] << "\n";
        }
        else {
            int lb = b[std::upper_bound(b.begin(), b.end(), a) - b.begin() - 1];
            int ub = b[std::upper_bound(b.begin(), b.end(), a) - b.begin()];
            std::cout << (ub - lb) / 2 << "\n";

        }
    }
}
```

{{< /toggle >}}
