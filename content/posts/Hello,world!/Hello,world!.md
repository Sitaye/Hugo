+++
title = 'Hello,world!'
date = 2024-07-12T10:00:47+08:00
draft = true

+++

```cpp
#include<bits/stdc++.h>
using i64 = long long;
void solve()
{
    int n, m, k;
    std::cin >> n >> m >> k;

    std::string s;
    std::cin >> s;

    int now = -1, aft = 0;
    bool inside = false;

    while (aft < n) {
        if (s[aft] == 'L') {
            now = aft;
            inside = false;
        }
        else if (s[aft] == 'C') {
            if (aft - now == m) {
                if (!inside) {
                    now = aft;
                    inside = true;
                }
            }
            if (inside) {
                std::cout << "NO\n";
                return;
            }
        }
        else {
            if (inside && k - 1 < 0) {
                std::cout << "NO\n";
                return;
            }
            if (aft - now == m) {
                if (!inside) {
                    now = aft;
                    inside = true;
                }
            }
        }
        if (inside) {
            k--;
            if (k < 0) {
                std::cout << "NO\n";
                return;
            }
        }
        aft ++;
    }
    std::cout << "YES\n";
}
int main()
{
    std::ios::sync_with_stdio(false);
    std::cin.tie(nullptr);
    int t;
    std::cin >> t;
    while (t--) {
        solve();
    }
    return 0;
}
```

$$
h_{\theta}(x) = g(\omega^T x + b)
$$

{{< katex >}}

\\(\varphi = \dfrac{1+\sqrt5}{2}= 1.6180339887…\\)

# 1

## 2
### 3
#### 4

{{< alert >}}
**警告！**此操作具有破坏性！
{{< /alert >}}
