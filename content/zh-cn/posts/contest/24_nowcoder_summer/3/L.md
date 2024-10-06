+++
title = '2024 牛客暑期多校训练营 3 - L'
date = 2024-09-09T16:55:07+08:00
draft = false
series = ["2024 牛客暑期多校训练营 3"]
series_order = 7
showSummary = false
tags = ["签到题"]
categories = ["比赛", "2024 牛客暑期多校训练营"]

+++

{{< katex >}}

## 1. 题目

{{< toggle "English" >}}

Sudoku is a logic-based, combinatorial number-placement puzzle. In classic Sudoku, the objective is to fill a \\(9 \times 9\\) grid with digits so that each column, each row, and each of the nine \\(3 \times 3\\) subgrids that compose the grid contains all of the digits from \\(1\\) to \\(9\\). The puzzle setter provides a partially completed grid, which for a well-posed puzzle has a single solution.

Minesweeper is a logic puzzle video game. The game features a grid of clickable tiles, with hidden mines scattered throughout the board. The objective is to clear the board without detonating any mines, with help from clues about the number of neighboring mines in each field. 

You are given a solved classic Sudoku. You are asked to replace some numbers with mines so that the remaining numbers equal the number of neighboring mines. You can't replace all the numbers with mines. 

***<u>Input</u>***

The input contains \\(9\\) lines. Each line contains \\(9\\) characters. Each character is a number between \\(1\\) and \\(9\\). 

The input describes the solved classic Sudoku. 

***<u>Output</u>***

Output \\(9\\) lines, denoting the answer. Each line contains \\(9\\) characters. Each character is either a number between \\(1\\) and \\(9\\) or`*`(which represents a mine). 

{{< /toggle >}}

<br>

{{< toggle "简体中文（大意）">}}

将矩阵中一些数换为`*`，使得剩下的数分别等于周围`*`个数。

{{< /toggle >}}

## 2. 思路

由于数独每一行每一列的数字都在 \\(0\\) 到 \\(9\\)，只要在中间找到一个 \\(8\\)，其他数字全部变为`*`就满足条件。

## 3. 代码

{{< toggle "C++" >}}

```cpp
void solve()
{
    int n = 9;
    std::string s[n];
    for (int i = 0; i < n; i++) {
        std::cin >> s[i];
    }
    int x, y;
    for (int i = 1; i < n - 1; i++) {
        for (int j = 1; j < n - 1; j++) {
            if (s[i][j] == '8') {
                x = i, y = j;
            }
        }
    }
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (i == x && j == y) {
                std::cout << '8';
            }
            else {
                std::cout << '*';
            }
        }
        std::cout << "\n";
    }
}
```

{{< /toggle >}}

## 4. 总结

签到题
