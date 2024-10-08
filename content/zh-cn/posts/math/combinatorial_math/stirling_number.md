+++
title = '第二类斯特林数'
date = 2024-07-29T20:23:30+08:00
draft = false
categories = ["数学", "组合数学"]

+++

{{< katex >}}

**第二类斯特林数**是组合数学上常见的一种概念，用于解决集合拆分的问题。

> 【问题1】将 n 个元素拆分为 m 个非空集合，有多少种方案？
>
> 【问题2】将 n 个苹果分给 m 个人，每人至少有一个苹果，有多少种方案？

上述的两个问题都可以用第二类斯特林数解决。

将 \\(n\\) 个元素拆分为 \\(k\\) (\\(1\leq k\leq m\\)) 个集合的方案数我们表示为 \\(S(n,k)\\)，则我们最终要求的方案数可以表示为 \\(S(n,m)\\)。我们可以得到递推式：
$$
S(n,k)=S(n-1,k-1)+C_k^1\cdot S(n-1,k)
$$


当插入一个元素的时候，有两种方案：

- 将元素插入到新的集合，元素个数从 \\(n-1\\) 变为 \\(n\\)，集合个数从 \\(k-1\\) 变为 \\(k\\)。
- 在已有集合任选一个集合插入元素，元素个数从 \\(n-1\\) 变为 \\(n\\)，集合个数不变。
