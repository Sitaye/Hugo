+++
title = '最小生成树'
date = 2024-08-23T17:21:29+08:00
draft = false
categories = ["算法", "图论"]

+++

{{< katex >}}

**最小生成树**（MST）是连通加权无向图中权重最小的生成树。

求最小生成树的算法主要有两个：**Kruskal** 和 **Prim**

## 1. Kruskal

**Kruskal** 主要用于**稀疏图**的最小生成树的求解。

算法的核心是**选边**：每次贪心地选择当前边集中选择权重最小的、且不构成回路的边。

算法的实现是**并查集**，通过维护一个最小权重的边的并查集来实现最小生成树。

> 并查集可以参考：
>
> {{< article link="/posts/data_structure/dsu/" >}}

![Kruskal](kruskal.gif "Kruskal 动图解释。来源：[OI-Wiki](https://oi-wiki.org/graph/images/mst-2.apng)")

### 1. 1 代码

{{< toggle "C++">}}

```cpp
struct DSU {
    std::vector<int> f, sz;
    DSU(int n) : f(n), sz(n, 1) {
        std::iota(f.begin(), f.end(), 0);
    }
    int find(int x) {
        return f[x] == x ? f[x] : f[x] = find(f[x]);
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

void solve()
{
    int n, m;
    std::cin >> n >> m;
    std::vector<std::array<int, 3>> l;
    DSU node(n + 1);
    for (int i = 0; i < m; i++) {
        int u, v, w;
        std::cin >> u >> v >> w;
        l.push_back({w, u, v});
    }
    std::sort(l.begin(), l.end());
    int sum = 0, num = 1;
    for (auto [w, u, v] : l) {
        if (node.merge(u, v)) {
            sum += w;
            num ++;
        }
        if (num == n) {
            break;
        }
    }
    if (num == n) {
        std::cout << sum;
    }
    else {
        std::cout << "-1";
    }
}
```

{{< /toggle >}}

可以看出，我们按照边权的大小对边进行排序，然后遍历边。判断一条边是否能加入到最小生成树中（即不成回路）的依据是边的两个顶点是否在同一个并查集里面。

### 1. 2 时间复杂度

Kruskal 的时间复杂度为 \\(O(mlog(m))\\)，即遍历边以及维护并查集的时间复杂度。

## 2. Prim

**Prim** 主要用于**稠密图**的最小生成树的求解。

算法的核心是**选点**：随机选择一个点作为起点，每次贪心地选择当前点相邻边集中选择权重最小的、且不构成回路的边。

算法的实现是**DFS**，即逐步选择每一个点。

![Prim](prim.gif "Prim 动图解释。来源：[OI-Wiki](https://oi-wiki.org/graph/images/mst-3.apng)")

### 1. 1 代码

{{< toggle "C++">}}

```cpp
struct cmp {
    bool operator()(const std::pair<int, int> x, const std::pair<int, int> y) {
        return x.second > y.second;
    }
};
void solve()
{
    int n, m;
    std::cin >> n >> m;
    std::vector<std::pair<int, int>> g[n + 1];
    for (int i = 0; i < m; i++) {
        int x, y, z;
        std::cin >> x >> y >> z;
        g[x].push_back({y, z});
        g[y].push_back({x, z});
    }
    std::priority_queue<std::pair<int, int>, std::vector<std::pair<int, int>>, cmp> l;
    std::vector<int> dis(n + 1, 0x3f3f3f3f);
    std::vector<bool> vis(n + 1, false);
    dis[1] = 0, l.push({1, 0});
    int sum = 0, num = 0;
    while (!l.empty()) {
        if (num == n) {
            break;
        }
        auto [u, d] = l.top();
        l.pop();
        if (!vis[u]) {
            vis[u] = true;
            num ++;
            sum += d;
            for (auto [v, w] : g[u]) {
                if (!vis[v] && w < dis[v]) {
                    dis[v] = w, l.push({v, w});
                }
            }
        }
    }
    if (num == n) {
        std::cout << sum;
    }
    else {
        std::cout << "-1";
    }
}
```

{{< /toggle >}}

我们使用**堆优化**的方式实现 Prim ，其实现方式类似于 **Dijkstra** 逐步更新周边点的距离从而找到路径最近的点。

每次都将周围点到当前点的距离都更新一次，然后压入堆中进行选择。由于每次都会只选择堆顶元素加入到 MST 中，后续更新当前点的周围点距离的时候，可能某些点在之前已经更新过了，那么再次加入堆中更有可能出现到堆顶附近，而之前的那次更新自然不会出现到这次更新之上了。

### 1. 2 时间复杂度

Prim 的时间复杂度为 \\(O((n+m)log(n))\\)，即遍历边维护检查堆以及顶点检查的时间复杂度之和。

​		
