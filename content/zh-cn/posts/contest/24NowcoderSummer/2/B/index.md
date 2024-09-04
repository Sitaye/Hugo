+++
title = '【2024牛客暑期多校训练营2】B'
date = 2024-07-31T19:14:31+08:00
draft = false
series = ["2024牛客暑期多校训练营2"]
series_order = 1
showSummary = false
tags = ["最小生成树", "三元环计数"]
categories = ["比赛", "2024牛客暑期多校训练营", "2024牛客暑期多校训练营2"]

+++

{{< katex >}}

## 1. 题目

{{< toggle "English" >}}

Sajin has recently delved into the study of minimum spanning trees and now he has mastered the algorithm of MST.

He is eager to assess your grasp of minimum spanning tree concepts through a series of queries.
You are confronted with an weighted undirected graph that encompasses nnn vertices and mmm edges without any self-loops.

Sajin presents \\(q\\) inquiries. For each, a vertex set \\(S\\) is given. Your objective is to determine the **induced subgraph** of \\(S\\) and find the weight of its minimum spanning tree.

A minimum spanning tree (MST) is a subset of the edges of a connected, edge-weighted graph that connects all the vertices together without any cycles and with the minimum possible total edge weight.

In the mathematical field of graph theory, an **induced subgraph** of a graph is another graph, formed from a subset of the vertices of the graph and all of the edges, from the original graph, connecting pairs of vertices in that subset.

If the **induced subgraph** of \\(S\\) is disconnected, output \\(-1\\).

***<u>Input</u>***

The first line contains \\(3\\) integers \\(n\\), \\(m\\), \\(q\\) (\\(2 \le n \le 10^5,1 \le m, q \le 10^5\\)), — the number of points, the number of edges, and the number of queries.

Then mmm lines follow, each line contains three integers \\(u_i\\), \\(v_i\\), \\(w_i\\)(\\(1 \le u_i, v_i \le n\\), \\(u_i \ne v_i\\), \\(1 \le w_i \le 10^9\\)), — the two endpoints of the iii-th edge and the edge weight.

Next \\(q\\) lines, each line first contains an integer \\(k_i\\)(\\(1 \le k_i \le n\\)) — the size of the vertex set \\(S\\) for the \\(i\\)-th query.

Then followed by \\(k_i\\) **distinct** integers \\(s_{i,j}\\)(\\(1 \le s_{i,j} \le n\\)) — the numbers of the vertex set \\(S\\) for the \\(i\\\)-th query.

It is guaranteed that the sum of \\(k_i\\) over all queries does not exceed \\(10^5\\).

***<u>Output</u>***

For each query, output one integer representing the answer.

{{< /toggle >}}

</br>

{{< toggle "简体中文（大意）" >}}

给你一张图，求导出子图的最小生成树。

{{< /toggle >}}

## 2. 思路

观察到点和边的数据范围，发现非常相近，可以理解为整体上这个图为一张稀疏图（从邻接矩阵看比较直观）。由于本题求的是导出子图的最小生成树，对于稀疏图在局部上也可能为一张稠密图。

对于最小生成树常见的算法有 **Kruskal** 和 **Prim**，Kruskal 常用于**稀疏图**，Prim 常见于**稀疏图**。具体可以参考下面这篇文章：

> {{< article link="posts/algorithm/graphtheory/mst/" >}}

由于本题对于 Prim 时间复杂度的要求非常高，故使用 Kruskal 搭配边存储优化求解。

Kruskal 的算法就是从小到大遍历所有边，假如给定点集 \\(S\\)，那么在遍历两点相邻的边时，每条边会存两次。因此我们需要降低存的重复边数来减少后续遍历的次数，根据**三元环计数**的原理，我们可以存为**单向边**，每个点存的边数会降为 \\(\sqrt{m}\\)。

>三元环计数参考：
>
>{{< article link="/posts/algorithm/graphtheory/triangle/" >}}

由于有**菊花图**出现的可能，如果单向边的起点从每个菊花图的中心开始，那么中心所连的点可能不在点集 \\(S\\) 中，此时遍历的点数会比较多。但如果从花瓣开始，则会减少这种情况的出现。因此我们需要记录下每个点的**度数**，将从度数小的点指向度数大的边存起来，度数相同则存从下标小到下标大的边。

![菊花图](jh.svg)

## 3. 代码

{{< toggle "C++">}}

```cpp
struct DSU {
    std::vector<int> f, sz;
    DSU(int n) : f(n), sz(n, 1) {
        std::iota(f.begin(), f.end(), 0);
    }
    int find(int x) {
        return f[x] == x ? x : f[x] = find(f[x]);
    }
    bool merge(int x, int y) {
        int fx = find(x), fy = find(y);
        if (fx == fy) {
            return false;
        }
        if (sz[fx] > sz[fy]) {
            std::swap(fx, fy);
        }
        f[fx] = fy;
        sz[fy] += sz[fx];
        return true;
    }
    bool same(int x, int y) {
        return find(x) == find(y);
    }
};
void kruskal(int k, std::vector<std::vector<std::pair<int, int>>> &p, std::vector<bool> &vis, std::vector<int> &s, DSU &node)
{
    std::vector<std::array<int, 3>> l;
    for (auto &u : s) {
        for (auto &[v, w] : p[u]) {
            if (vis[v]) {
                l.push_back({w, u, v});
            }
        }
    }
    std::sort(l.begin(), l.end());
    i64 sum = 0, num = 1;
    for (auto &[w, u, v] : l) {
        if (num == k) {
            break;
        }
        if (node.merge(u, v)) {
            num ++;
            sum += w;
        }
    }
    if (num == k) {
        std::cout << sum << "\n";
    }
    else {
        std::cout << "-1\n";
    }
}
void solve()
{
    int n, m, q;
    std::cin >> n >> m >> q;
    DSU node(n + 1);
    std::vector<int> degree(n + 1);
    std::vector<std::array<int, 3>> op(m + 1);
    for (int i = 1; i <= m; i++) {
        int u, v, w;
        std::cin >> u >> v >> w;
        if (u > v) {
			std::swap(u, v);
        }
        op[i] = {u, v, w};
        degree[u]++;
        degree[v]++;
    }
    std::vector<std::vector<std::pair<int, int>>> p(n + 1);
    for (int i = 1; i <= m; i++) {
        auto &[u, v, w] = op[i];
        if (degree[u] > degree[v]) {
            std::swap(u, v);
        }
        p[u].emplace_back(v, w);
    }
    std::vector<bool> vis(n + 1);
    while (q--) {
        int k;
        std::cin >> k;
        std::vector<int> s(k);
        for (int i = 0; i < k; i++) {
            std::cin >> s[i];
            vis[s[i]] = true;
            node.f[s[i]] = s[i];
            node.sz[s[i]] = 1;
        }
        kruskal(k, p, vis, s, node);
        for (auto &i : s) {
            vis[i] = false;
        }
    }
}
```

{{< /toggle >}}

## 4. 总结

{{< typeit >}}

（由于我太菜了，所以没写点集数较小时的 Prim，不过能过样例就是好做法（雾））

{{< /typeit >}}

这道题其实主体还是考察最小生成树的算法，但是需要考虑存边时候效率问题。

值得注意的是：

- 稀疏图使用 Kruskal，稠密图使用 Prim
- 三元环原理可以帮助降低访问边的次数
- 函数传参的时候一定要带上**引用**`&`，特别是在传递的数组或`vector`特别大时，如果采用形式传参，会增加复制的时间复杂度。要注意对于原始数据的修改的问题。
