+++
title = '并查集'
date = 2024-08-26T11:47:44+08:00
draft = false

+++

{{< katex >}}

**并查集**（DSU）是一种负责**合并**、**查询**的集合，用于判断元素之间的所属关系。

并查集的核心思想就是对每个元素都建立一个标记，来表示所属集合的一个**代表元素**。

假如我们用`f[i]`来表示第 \\(i\\) 个元素的代表元素（或者是 *Father* ）。初始化可以将所有元素的代表元素设为自己，即：`f[i] = i`。

## 1. 查询

### 1. 1 一般查询

查询某个元素属于哪一个集合，即**查询这个元素的代表元素是哪一个**。

```cpp
int find(int x)
{
    return f[x] == x ? x : find(f[x]);
}
```

由于代表元素的代表元素即为它本身，故很容易得到上述的代码。

### 1. 2 路径压缩查询

并查集的本质是一种树，通过这种方法得到的树的深度会很大，所以我们可以对树进行**路径压缩**，使得集合中每个元素的代表元素都是整个集合的代表元素。

```cpp
int find(int x)
{
    return f[x] == x ? x : f[x] = find(f[x]);
}
```

## 2. 合并

### 2. 1 一般合并

将两个集合合并，其实就是将两个集合的代表元素更新一下，使得其中一个集合的代表元素是另一个集合代表元素的代表元素。

```cpp
void merge(int x, int y)
{
    f[find(x)] = find(y);
}
```

### 2. 2 启发式合并（按秩合并）

一般合并的问题在于可能会影响未来操作的复杂度，比如深度加深等等问题。所以最好的合并方式就是将**深度较小**（或**元素少**）的集合合并到另一个集合去。

因此我们需要一个`size[i]`数组来记录每个元素所在集合的元素个数。

```cpp
void merge(int x, int y)
{
    int fx = find(x), fy = find(y);
    if (size[fx] > size[fy]) {
		std::swap(fx, fy);
    }
    f[fx] = fy;
    size[fy] += size[fx];
}
```

## 3. 结构体

将上面的函数可以统一为一个结构体的形式便于并查集的生成与操作。

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
```

## 4. 时间复杂度

并查集的时间复杂度取决于实现方式：

- 无优化：\\(O(n)\\)

- 仅路径压缩/按秩合并：\\(O(log(n))\\)

- 路径压缩 + 按秩合并：\\(O(\alpha(n))\\)，其中 \\(\alpha(n)\\) 为 *Ackermann* 函数的反函数

  {{< toggle "Ackermann 函数">}}

  >Ackermann 函数 \\(A(n,m)\\)定义为：
  >
  >\\(A(n,m)=\begin{cases}m+1&\texttt{if}\ n=m\\\A(n-1, 1)&\texttt{if}\ n>0\ \texttt{and}\ m=0\\\A(n-1,A(n,m-1))&\texttt{otherwise}\end{cases}\\)

  {{< /toggle >}}
