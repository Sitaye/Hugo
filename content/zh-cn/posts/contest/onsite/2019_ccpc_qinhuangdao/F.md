+++
title = '2019 CCPC 秦皇岛站 - F'
date = 2024-09-20T14:19:36+08:00
draft = false
series = ["2019 CCPC 秦皇岛站"]
series_order = 6
showSummary = false
tags = ["环路检测"]
categories = ["比赛", "区域赛"]

+++

{{< katex >}}

## 1. 题目

{{< toggle "English">}}

The kingdom of \\(Z\\) is fighting against desertification these years since there are plenty of deserts in its wide and huge territory. The deserts are too arid to have rainfall or human habitation, and the only creatures that can live inside the deserts are the cactuses. In this problem, a cactus in desert can be represented by a cactus in graph theory.

In graph theory, a cactus is a connected undirected graph with no self-loops and no multi-edges, and each edge can only be in at most one simple cycle. While a tree in graph theory is a connected undirected acyclic graph. So here comes the idea: just remove some edges in these cactuses so that the remaining connected components all become trees. After that, the deserts will become forests, which can halt desertification fundamentally.

Now given an undirected graph with \\(n\\) vertices and \\(m\\) edges satisfying that all connected components are cactuses, you should determine the number of schemes to remove edges in the graph so that the remaining connected components are all trees. Print the answer modulo \\(998244353\\).

Two schemes are considered to be different if and only if the sets of removed edges in two schemes are different.

***<u>Input</u>***

The first line contains two non-negative integers \\(n, m~(1\le n \le 300\,000, 0\le m \le 500\,000)\\), denoting the number of vertices and the number of edges in the given graph.

Next \\(m\\) lines each contains two positive integers \\(u,v~(1\le u,v \le n, u\neq v)\\), denoting that vertices \\(u\\) and \\(v\\) are connected by an undirected edge.

It is guaranteed that each connected component in input graph is a cactus.

***<u>Output</u>***

Output a single line containing a non-negative integer, denoting the answer modulo \\(998244353\\).

{{< /toggle >}}

<br>

{{< toggle "简体中文（大意）">}}

给定一个简单无向连通图，其中每条边最多只存在一个环路中，求删除其中一些边能形成的树的方案数。

{{< /toggle >}}

## 2. 思路

树是一种没有环路的连通图，所以只需要找到所给图的所有的环路，然后把环路拆开就行了。由于题上说每个边最多只存在一个环路中，所以每个环都是独立的。

假如一个环的边数为 \\(k\\)，则拆开的方案数为 \\(2^{k} - 1\\)。注意有的边可能没有成环，所以这些边需要单独计算。假如有 \\(b\\) 条边没有成环，有 \\(m\\) 个环，第 \\(i\\) 个环的边数为 \\(k_i\\)，则总的方案数为 \\(2^b\cdot\prod\limits_{i=1}^{m}{(2^{k_i} - 1)}\\)。

## 3. 代码

{{< toggle "C++">}}

```cpp
constexpr int mod = 998244353;
void solve()
{
    int n, m;
    std::cin >> n >> m; // 输入节点数和边数
    
    std::vector<int> g[n + 1]; // 邻接表
    for (int i = 0; i < m; i++) { // 保存点连接信息
        int u, v;
        std::cin >> u >> v;
        g[u].push_back(v);
        g[v].push_back(u);
    }
    
    std::vector<int> pw2(n + 1); // 离线存下 2^k
    pw2[0] = 1;
    for (int i = 1; i <= n; i++) {
        pw2[i] = (pw2[i - 1] * 2LL) % mod;
    }
    
    std::vector<int> f(n + 1), dep(n + 1); // 存当前点的父亲节点和深度
    std::vector<std::vector<int>> res(n + 1); // 存环路信息
    int cnt = 0; // 环路编号
    auto cycle = [&](int u, int v) { // 保存环路的信息
        if (dep[u] < dep[v]) { // 访问到不是当前环路的点退出
            return;
        }
        cnt++; 
        res[cnt].push_back(v); // 保存环路信息
        while (u != v) {
            res[cnt].push_back(u);
            u = f[u];
        }
    };
    std::function<void(int, int)> dfs = [&](int u, int pre) { // dfs 求环路
        f[u] = pre, dep[u] = dep[pre] + 1; // 记录父亲节点和深度
        for (auto &v : g[u]) { //更新周围点
            if (v == pre) { // 避免访问父亲节点
                continue;
            }
            if (dep[v]) { // 找到环并记录
                cycle(u, v);
            } else {
                dfs(v, u); // 继续遍历
            }
        }
    };
    
    for (int i = 1; i <= n; i++) { // 更新每个点的所在环路
        if (!dep[i]) {
            dfs(i, 0);
        }
    }
    
    int ans = 1, sum = 0;
    for (int i = 1; i <= cnt; i++) {
        ans = (1LL * ans * (pw2[res[i].size()] - 1) % mod); // 存环路的方案数
        sum += res[i].size(); // 存环路的边数，方便求不成环的边数
    }
    
    std::cout << (1LL * ans * pw2[m - sum]) % mod << "\n";
}
```

{{< /toggle >}}

## 4. 总结

本题主要使用**环路检测**来求连通图中的环路的信息，可以参考：

> {{< article link="/posts/algorithm/graph_theory/cycle_detection/">}}

同时代码中对 \\(2^k\\) 进行了离线处理，避免引入多余的时间复杂度。
