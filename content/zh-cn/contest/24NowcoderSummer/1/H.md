+++
title = '【2024牛客暑期多校训练营1】H'
date = 2024-07-27T12:12:36+08:00
draft = false
series = ["2024牛客暑期多校训练营1"]
series_order = 5
showSummary = false
tags = ["签到题"]

+++

{{< katex >}}

## 1. 题目

{{< toggle "English" >}}

The ICPC World Finals are coming. Due to some reasons, the 46th and 47th World Finals will be held simultaneously. For the teams qualified in both competitions, they should choose one to take part in.

 As we know, `lzr010506`'s team is double-qualified and should make a choice. To make a wiser choice, `lzr010506` looked up the qualified lists for two competitions and trained a magic model to predict the results for all participants among the two competitions. Moreover, a result contains the number of solved problems and the time penalty. The more solved problems, the better the result is, and if two teams solved the same number of problems, the result with the lower time penalty is better.

 Now, `lzr010506` wants to know the best possible ranking if the actual results are all the same as predicted and that the competition choices of the double-qualified teams can be arbitrarily arranged by him.

***<u>Input</u>***

The first line contains one integer \\(n\\) (\\(1 \le n \le 10^5\\)), denoting the number of teams qualified in the 46th World Finals.

Next nnn lines each contain one string \\(S\\) (\\(1 \le |S| \le 10\\)) and two integers \\(p,t\\) (\\(1 \le p,t \le 10^9\\)), denoting the name, the predicted number of solved problems, and time penalty of one team in the 46th World Finals respectively.

Next one line contains one integer \\(m\\) (\\(1 \le m \le 10^5\\)), denoting the number of teams qualified in the 47th World Finals.

Next \\(m\\) lines each contain one string \\(S\\) (\\(1 \le |S| \le 10\\)) and two integers \\(p,t\\) (\\(1 \le p,t \le 10^9\\)), denoting the name, the predicted number of solved problems, and time penalty of one team in the 47th World Finals respectively.

It is guaranteed that:

- the team names only contain digits and English letters;
- the team names in one competition are different from each other;
- no two teams have the same predicted number of solved problems and the time penalty simultaneously in one competition;
- the same names among two qualified name lists refer to the same team in real;
- `lzr010506` appears in both two qualified name lists.

***<u>Output</u>***

Output one line containing one integer, denoting the best possible ranking of `lzr010506`'s team.

{{< /toggle >}}

<br>

{{< toggle "简体中文（大意）" >}}

一些队伍同时参加了两场比赛，但只能选择一场比赛积分，求 `lzr010506` 能获得的最高名次。

{{< /toggle >}}

## 2. 思路

签到题，只需要将两次比赛的队伍按照规则排个序，然后假设在两场比赛在`lzr010506`之前的队伍都参加另一场比赛（如果能参加另一场比赛的话），比较`lzr010506`在两场比赛中的名次取最小值。

## 3. 代码

{{< toggle "C++" >}}

```cpp
struct part {
    std::string s;
    int pass, pen;
};
bool cmp(part x, part y)
{
    if (x.pass > y.pass) {
        return true;
    }
    else if (x.pass == y.pass) {
        return x.pen < y.pen;
    }
    else {
        return false;
    }
}
void solve()
{
    int n;
    std::cin >> n;
    std::set<std::string> l46b, l47b;
    std::vector<part> l46(n);
    for (int i = 0; i < n; i++) {
        std::string s;
        int p, t;
        std::cin >> s >> p >> t;
        l46[i] = {s, p, t};
        l46b.insert(s);
    }
    int m;
    std::cin >> m;
    std::vector<part> l47(m);
    for (int i = 0; i < m; i++) {
        std::string s;
        int p, t;
        std::cin >> s >> p >> t;
        l47[i] = {s, p, t};
        l47b.insert(s);
    }
    std::sort(l46.begin(), l46.end(), cmp);
    std::sort(l47.begin(), l47.end(), cmp);
    std::set<std::string> l46f, l47f;
    for (int i = 0; i < n; i++) {
        if (l46[i].s == "lzr010506") {
            break;
        }
        l46f.insert(l46[i].s);
    }
    for (int i = 0; i < m; i++) {
        if (l47[i].s == "lzr010506") {
            break;
        }
        l47f.insert(l47[i].s);
    }
    int num1 = 1, num2 = 1;
    for (auto i : l46f) {
        if (l47b.find(i) == l47b.end()) {
            num1 ++;
        }
    }
    for (auto i : l47f) {
        if (l46b.find(i) == l46b.end()) {
            num2 ++;
        }
    }
    std::cout << std::min(num1, num2);
}
```

{{</ toggle >}}

## 4. 总结

签到题
