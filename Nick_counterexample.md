# Nick's counterexample: unobservable without Lie point symmetries

## 1. Nick's model

$$x' = 1 + x\,u, \qquad y = 0$$

(`Models/Nick_counterexample.jl`). The output carries no information, so $x$ is unobservable. Two solutions with the same input differ by

$$\tilde x(t) - x(t) = (\tilde x_0 - x_0)\, e^{\int_0^t u\,ds}.$$

**Finite determining system** (method `Obs`: $T = t$, $U = u$, unknown $X(t,x)$). With
$D = \partial_t + (1 + xu)\,\partial_x$, the state condition $f(X,u) - D(X) = 0$ is

$$1 + X u - X_t - X_x\,(1 + x u) = 0,$$

and the output condition is $0 = 0$. Splitting in powers of $u$
(`Results/coefficients_Nick_counterexample_Obs.txt`):

| | coefficient |
|---|---|
| $u^0$ | $1 - X_t - X_x$ |
| $u^1$ | $X - x X_x$ |

The second gives $X = a(t)\,x$ and the first $a' x + a = 1$, so $X = x$. **Only the identity**:
the model is unobservable but has no nontrivial symmetry, so "no symmetries $\Rightarrow$
observable" fails.

The reason: the indistinguishability map $x \mapsto x + \varepsilon\, e^{\int_0^t u}$ depends on the
whole input history. It is nonlocal, so it cannot be of the form $X(t,x)$.

## 2. Augmented model

Add $w' = u$ and measure it. This is legitimate: $w$ is known whenever $u$ is.

$$x' = 1 + x u, \qquad w' = u, \qquad y_1 = 0, \qquad y_2 = w$$

(`Models/Nick_counterexample_w.jl`). Unknowns $X(t,x,w)$, $W(t,x,w)$, with $D = \partial_t + (1 + xu)\,\partial_x + u\,\partial_w$:

$$1 + X u - D(X) = 0, \qquad u - D(W) = 0, \qquad W - w = 0.$$

Coefficients (`Results/coefficients_Nick_counterexample_w_Obs.txt`):

| origin | coefficient |
|---|---|
| $x$ equation, $u^0$ | $1 - X_t - X_x$ |
| $x$ equation, $u^1$ | $X - X_w - x X_x$ |
| $w$ equation, $u^0$ | $-W_t - W_x$ |
| $w$ equation, $u^1$ | $1 - W_w - x W_x$ |
| output $y_2$ | $W - w$ |

**Solution.** $W = w$ satisfies the last three. The first gives $X = x + G(s, w)$ with $s = x - t$.
Substituting in the second, $(s + t)\,G_s + G_w = G$; since $G$ does not depend on $t$, $G_s = 0$
and $G = c\,e^{w}$:

$$X = x + c\,e^{w}, \qquad W = w, \qquad \text{generator } e^{w}\,\partial_x .$$

Since $e^{w} = e^{w_0}\, e^{\int_0^t u}$, this is the nonlocal map of Section 1, now a point symmetry.

## 3. The fix: λ- and σ-symmetries

### Idea

In the original model $[D, \partial_x] = -u\,\partial_x$: not zero, but proportional to $\partial_x$.
Unobservability only needs the **direction** $\partial_x$ to be invariant, not the vector field.

### Determining system

For `Obs` ($T = t$, $P = p$, $U = u$), look for $\Xi(t,x) \in \mathbb R^{n\times k}$ of rank $k \ge 1$,
with columns $\xi_a$ and vector fields $V_a = \xi_a \cdot \partial_x$, and $\Lambda(t,x,u) \in \mathbb R^{k\times k}$ such that

$$D(\Xi) - f_x(x,u)\,\Xi = \Xi\,\Lambda, \qquad h_x\,\Xi = 0,$$

where $D = \partial_t + f\cdot\partial_x$ acts componentwise and $f_x$ is the Jacobian. Equivalently,
$[D, V_a] = \sum_b \Lambda_{ba} V_b$ and $V_a(h) = 0$. For $k = 1$:
$D(\xi_i) - V(f_i) = \lambda\,\xi_i$, $V(h) = 0$.

These are λ-symmetries [2] for $k = 1$ and σ-symmetries [3] for $k \ge 1$. The infinitesimal `Obs`
symmetries are the case $\Lambda = 0$. For autonomous models $\Xi$ can be taken independent of $t$.

**Nick.** $n = 1$, $\xi = 1$: $D(1) - \partial_x(1 + xu) = -u$, so $\lambda = -u$, and $h_x = 0$.
Unobservability is detected in the original model, without $w$.

### Theorem

For analytic models, on an open dense set: a nontrivial σ-symmetry exists $\iff$ the model is not
locally weakly observable.

*Proof sketch.* Let $\Delta = \operatorname{span}\{V_a\}$ and let $\mathcal O$ be the observation
space ($h$ and its repeated Lie derivatives along $f(\cdot,u)$, $u$ constant).

- ($\Leftarrow$) $V(L_f\varphi) = L_f(V\varphi) - [f, V]\,\varphi$. If $\Delta$ annihilates $\varphi$ and
  $[f, \Delta] \subset \Delta$, it annihilates $L_f\varphi$. Starting from $V(h) = 0$, $\Delta$
  annihilates $\mathcal O$, so $\operatorname{rank} d\mathcal O < n$.
- ($\Rightarrow$) $\Delta = \ker d\mathcal O$ is invariant because $L_{f(\cdot,u)}\mathcal O \subset \mathcal O$,
  and it annihilates $dh$ because $h \in \mathcal O$.

This is the Hermann–Krener characterisation of observability [1], written as a determining system.

### How to solve it

1. **Eliminate $\Lambda$.** For $k = 1$, require $D(\xi) - f_x\xi \parallel \xi$:
   $(D\xi - f_x\xi)_i\,\xi_j - (D\xi - f_x\xi)_j\,\xi_i = 0$. Alternatively fix the gauge: solutions
   are invariant under $\xi \to g\,\xi$ (with $\lambda \to \lambda + D(g)/g$), so set $\xi_j = 1$ for
   some $j$, trying each $j$. For $k > 1$, $\Xi \to \Xi A$ allows normalising a $k\times k$ block to $I$.
2. **Split.** $\Xi$ does not depend on $u$, so split in powers of $u$ and $u_t$ as in `Obs`.
3. **Increase $k$.** Try $k = 1, 2, \dots, n$; $\Xi = 0$ does not count. Rank 1 is not enough:
   $x_1' = u_1 - u_2 x_2$, $x_2' = u_2 x_1$, $y = 0$ has no point symmetry and no λ-symmetry (the
   inputs generate $\mathfrak{se}(2)$, which leaves no line field invariant), but $\Xi = I$ is a
   σ-symmetry with $\Lambda = -u_2 J$, $J = \begin{pmatrix} 0 & -1 \\ 1 & 0 \end{pmatrix}$.

The price: the system is nonlinear (Riccati type) in $\Xi$, unlike classical determining systems,
and it is only infinitesimal.

### Link with the augmentation

$\Xi G$ satisfies the equation with $\Lambda = 0$ (a symmetry) iff $D(G) = -\Lambda\,G$, since
$D(\Xi G) - f_x \Xi G = \Xi\,(\Lambda G + D(G))$.

| $\Lambda$ | meaning | equations |
|---|---|---|
| $0$ | point symmetry $X(t,x)$ (current `Obs`) | linear |
| $\Lambda(t,u)$ | $G' = -\Lambda G$ is driven by $u$ only, so $G$ is known: adding it as outputs gives a point symmetry of the augmented model | linear after augmenting |
| $\Lambda(t,x,u)$ | $\Xi G$ is a nonlocal symmetry; the σ-symmetry still certifies unobservability | nonlinear |

- Nick: $\Lambda = -u$, $G' = uG$, $G = e^{w}$: Section 2.
- $\mathfrak{se}(2)$ example: $G' = u_2 J G$, $G = R(w)$ (rotation by $w$, $w' = u_2$): the augmented
  model has the point symmetries $X = x + R(w)\,c$, $c \in \mathbb R^2$.

The augmentation is the finite counterpart of σ-symmetries with $\Lambda = \Lambda(t,u)$.

## References

1. R. Hermann, A. J. Krener. Nonlinear controllability and observability. *IEEE Trans. Automat. Control* 22 (1977) 728–740.
2. C. Muriel, J. L. Romero. New methods of reduction for ordinary differential equations. *IMA J. Appl. Math.* 66 (2001) 111–125.
3. G. Cicogna, G. Gaeta, S. Walcher. A generalization of λ-symmetry reduction for systems of ODEs: σ-symmetries. *J. Phys. A* 45 (2012) 355205.
