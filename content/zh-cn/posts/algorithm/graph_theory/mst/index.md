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
struct DSU { // 具体参考【并查集】那篇文章
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
    std::cin >> n >> m; // 输入节点数 n 和边数 m
    DSU node(n + 1); // 建立并查集
    
    std::vector<std::array<int, 3>> l; // 定义存边数组 l
    for (int i = 0; i < m; i++) { // 输入边的信息
        int u, v, w;
        std::cin >> u >> v >> w;
        l.push_back({w, u, v}); // 边权 w 在前便于排序
    }
    std::sort(l.begin(), l.end()); // 按边权排序
    
    int sum = 0, num = 1; // 定义生成树的长度 sum 和节点数 num
    for (auto [w, u, v] : l) { // 遍历边集
        if (node.merge(u, v)) { // 对两个点进行合并，更新信息
            sum += w;
            num ++;
        }
        if (num == n) { // 遍历完所有的节点
            break;
        }
    }
    if (num == n) { // 判断是不是生成树
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

Kruskal 的时间复杂度为 \\(O(m\log(m))\\)，即遍历边以及维护并查集的时间复杂度。

## 2. Prim

**Prim** 主要用于**稠密图**的最小生成树的求解。

算法的核心是**选点**：随机选择一个点作为起点，每次贪心地选择当前点相邻边集中选择权重最小的、且不构成回路的边。

算法的实现是**DFS**，即逐步选择每一个点。

![Prim](prim.gif "Prim 动图解释。来源：[OI-Wiki](https://oi-wiki.org/graph/images/mst-3.apng)")

### 2. 1 代码

{{< toggle "C++">}}

```cpp
struct cmp { // 比较函数类型
    bool operator()(const std::pair<int, int> x, const std::pair<int, int> y) {
        return x.second > y.second;
    }
};
void solve()
{
    int n, m;
    std::cin >> n >> m; // 输入节点数 n 和边数 m
    
    std::vector<std::pair<int, int>> g[n + 1]; // 定义邻接表
    for (int i = 0; i < m; i++) { // 输入边的信息
        int x, y, z;
        std::cin >> x >> y >> z;
        g[x].push_back({y, z});
        g[y].push_back({x, z});
    }
    
    std::priority_queue<std::pair<int, int>, std::vector<std::pair<int, int>>, cmp> l; // 定义小根堆
    std::vector<int> dis(n + 1, 0x3f3f3f3f); // 初始化距离
    std::vector<bool> vis(n + 1, false); // 初始化是否已经访问
    
    dis[1] = 0, l.push({1, 0}); // 将节点 1 设为初始点，并加入小根堆
    int sum = 0, num = 0; // 定义生成树的长度 sum 和节点数 num
    while (!l.empty()) {
        if (num == n) {
            break;
        }
        auto &[u, d] = l.top();
        l.pop();
        if (!vis[u]) { // 判断当前点是否被访问过
            vis[u] = true;
            num ++;
            sum += d;
            for (auto [v, w] : g[u]) {
                if (!vis[v] && w < dis[v]) { // 没有访问的点被记录
                    dis[v] = w, l.push({v, w}); // 更新该点到已经访问过的点集的最段距离，压入小根堆
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

### 2. 2 时间复杂度

Prim 的时间复杂度为 \\(O((n+m)\log(n))\\)，即遍历边维护检查堆以及顶点检查的时间复杂度之和。

​		
