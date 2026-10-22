La idea central, en una frase: una simetría de Obs es una perturbación δx que no cambia la salida y que se puede escribir como función del estado actual, δx(t) = ξ(t, x(t)). Ser inobservable solo pide que exista una perturbación invisible, sin esa restricción. En Nick, δx(t) = δx₀·e^{∫u} depende de toda la historia de u, y por eso Obs no la encuentra.

La solución es separar la perturbación en dirección, que sí es función del estado (ξ), y tamaño (g), que puede depender de la historia y se obtiene integrando una EDO lineal g' = −λg. Esa EDO siempre tiene solución, así que basta con encontrar la dirección.

El documento va por pasos:

Notación mínima: D y los jacobianos.
Cómo pasar del sistema determinante finito que ya conoces a la ecuación linealizada.
Por qué Nick no tiene simetría.
λ-simetrías, aplicadas a Nick (ξ = 1, λ = −u, g = e^{∫u}).
σ-simetrías: cuando lo que se conserva es un plano y no una dirección (el ejemplo que gira).
Por qué esto equivale exactamente a ser inobservable (Hermann–Krener), con argumentos intuitivos.
El procedimiento de resolución paso a paso, con un ejemplo de dos estados y salida no nula.
Cómo se relaciona con el truco de añadir w.
Una tabla resumen.
He añadido dos cosas respecto al documento anterior: un argumento intuitivo de por qué Nick no admite simetría, y el ejemplo de dos estados x₁' = 1 + x₁u, x₂' = −x₂ + u, y = x₂. Los dos los he comprobado a mano, pero no con el código.

# λ- y σ-simetrías, explicadas desde cero

Objetivo: entender por qué el método `Obs` no detecta que el modelo de Nick es inobservable, y qué
cambio lo arregla. Solo hace falta una idea: **cómo se propaga una perturbación pequeña del estado**.

## 1. Notación

Modelo $x' = f(x,u)$, $y = h(x,u)$, con $x \in \mathbb R^n$.

- **Derivada a lo largo de soluciones.** Para una función $F(t,x)$,
  $\frac{d}{dt}F(t, x(t)) = F_t + F_x\, f =: D(F)$, es decir $D = \partial_t + f\cdot\partial_x$
  (la misma $D$ del repo; no hay términos en $u_t$ porque $F$ no depende de $u$).
- **Jacobianos.** $f_x$ es la matriz $n\times n$ de derivadas de $f$; $h_x$ es la fila de derivadas de $h$.

## 2. Una simetría es una perturbación invisible

El sistema determinante finito de `Obs` pide $D(X) = f(X,u)$ y $h(X,u) = h(x,u)$. Tomemos una
familia $X = x + \varepsilon\,\xi(t,x) + O(\varepsilon^2)$. A primer orden en $\varepsilon$:

$$D(\xi) = f_x\,\xi, \qquad h_x\,\xi = 0. \tag{S}$$

Es el sistema determinante infinitesimal de `Obs` (`D(xi_i) - V(f_i) = 0`, `V(h) = 0`).

**Qué significa.** Sea $x(t)$ una solución y $\delta x(t) = \xi(t, x(t))$. Entonces
$\delta x' = D(\xi) = f_x\,\delta x$, es decir, $\delta x$ cumple la **ecuación linealizada**

$$\delta x' = f_x\big(x(t), u(t)\big)\,\delta x ,$$

que es como se propaga un cambio pequeño de la condición inicial. Además $h_x\,\delta x = 0$, así
que ese cambio no altera la salida. Por tanto:

> Una simetría de `Obs` es una perturbación invisible **que se puede escribir como función del
> estado actual**: $\delta x(t) = \xi(t, x(t))$.

En cambio, ser inobservable solo exige que exista una perturbación invisible: que $\delta x$ cumpla la
ecuación linealizada con $h_x\,\delta x(t) = 0$ para todo $t$ y toda entrada. **No** exige que
$\delta x(t)$ sea función de $(t, x(t))$. Ese es el hueco por el que se escapa Nick.

## 3. Nick: por qué no hay simetría

$x' = 1 + x u$, $y = 0$. La ecuación linealizada es $\delta x' = u\,\delta x$, así que

$$\delta x(t) = \delta x(0)\, e^{\int_0^t u}.$$

Es invisible, porque $y = 0$. Pero el factor $e^{\int_0^t u}$ depende de toda la historia de la
entrada, no solo de $(t, x(t))$. Por ejemplo, desde $x(0) = 0$ se llega a $x(1) = 1$ con $u \equiv 0$
($\int_0^1 u = 0$) y también con otra entrada que tiene $\int_0^1 u = 1$. Con la misma condición inicial
y el mismo punto final, $\delta x(1)$ sale distinto en los dos casos, así que no puede ser igual a un
único valor $\xi(1, 1)$. No hay $\xi$, y el sistema determinante lo confirma: solo $X = x$.

## 4. La idea: fijar la dirección, no el tamaño (λ-simetrías)

Separemos la perturbación en una **dirección**, que sí es función del estado, y un **tamaño**, que
puede depender de la historia:

$$\delta x(t) = g(t)\,\xi\big(t, x(t)\big), \qquad g \text{ escalar}.$$

Sustituyendo en la ecuación linealizada: $g'\,\xi + g\,D(\xi) = g\,f_x\,\xi$, es decir,
$D(\xi) - f_x\,\xi = -(g'/g)\,\xi$. Por tanto la condición es que $D(\xi) - f_x\,\xi$ sea **paralelo**
a $\xi$:

$$D(\xi) - f_x\,\xi = \lambda\,\xi, \qquad h_x\,\xi = 0 \tag{λ}$$

para alguna función escalar $\lambda(t,x,u)$.

Al revés: si se cumple (λ), basta tomar $g$ con $g' = -\lambda\,g$, que es una EDO escalar lineal y
siempre tiene solución, $g(t) = g(0)\,e^{-\int_0^t \lambda}$. Entonces $g\,\xi$ es una perturbación
invisible. En resumen:

- $\xi(t,x)$ da la dirección;
- $\lambda$ dice cómo crece o decrece el tamaño;
- $g$ es el tamaño, que se calcula después integrando a lo largo de cada solución.

Con $\lambda = 0$, (λ) es (S): una simetría ordinaria, con $g$ constante.

**Nick.** $\xi = 1$: $D(1) - u \cdot 1 = -u$, así que $\lambda = -u$; y $h_x = 0$. Entonces
$g' = u\,g$, $g = e^{\int u}$: es justo la perturbación de la sección 3.

En la literatura se llaman **λ-simetrías** (Muriel y Romero). En notación de corchetes, con
$V = \xi\cdot\partial_x$, (S) es $[D, V] = 0$ y (λ) es $[D, V] = \lambda V$.

## 5. Varias direcciones a la vez (σ-simetrías)

A veces ninguna dirección se conserva, pero sí un plano.

**Ejemplo.** $x_1' = u_1 - u_2 x_2$, $x_2' = u_2 x_1$, $y = 0$. Aquí $f_x = u_2 J$, con
$J = \begin{pmatrix} 0 & -1 \\ 1 & 0 \end{pmatrix}$, así que la perturbación **gira** un ángulo
$\int u_2$. Con $u_1 = 0$ el punto $x = 0$ no se mueve, pero la perturbación gira un ángulo
arbitrario, y ninguna dirección $\xi(t, 0)$ puede seguirla. Como con $u_1$ y $u_2$ se puede volver a
cualquier punto con cualquier giro, pasa lo mismo en todo el plano: **no hay λ-simetría**.

**Generalización.** Se usan $k$ direcciones a la vez, las columnas de una matriz $\Xi(t,x)$ de tamaño
$n\times k$ y rango $k$, con coeficientes $g(t) \in \mathbb R^k$:
$\delta x(t) = \Xi\big(t, x(t)\big)\,g(t)$. La misma cuenta da

$$D(\Xi) - f_x\,\Xi = \Xi\,\Lambda, \qquad h_x\,\Xi = 0, \tag{σ}$$

con $\Lambda(t,x,u)$ de tamaño $k\times k$, y $g' = -\Lambda\,g$, que es un sistema lineal y siempre tiene
solución.

**Qué significa.** La dinámica linealizada nunca saca una perturbación del subespacio generado por las
columnas de $\Xi$; $\Lambda$ describe cómo se mueve dentro de él.

**En el ejemplo.** $\Xi = I$: $D(I) = 0$, así que $\Lambda = -u_2 J$ y $g' = u_2 J g$ ($g$ gira).

Con $k = 1$ se recupera (λ). Se llaman **σ-simetrías** (Cicogna, Gaeta y Walcher).

## 6. Por qué esto caracteriza exactamente la inobservabilidad

**Espacio de observación.** Las derivadas de la salida son funciones del estado:
$y = h$, $y' = h_x f$, $y''$, ..., cada una para cualquier valor (constante) de $u$. Al conjunto de
todas ellas se le llama $\mathcal O$. El modelo es (localmente) observable si sus gradientes generan
$\mathbb R^n$; esta es la condición de rango. Las **direcciones inobservables** en $x$ son las que no
cambian ninguna de esas funciones: $\ker d\mathcal O(x)$.

- **σ-simetría ⇒ inobservable.** $\delta x = \Xi g$ es invisible para todo $t$ y toda entrada, así que
  no cambia ninguna derivada de la salida. Por tanto las columnas de $\Xi$ están en $\ker d\mathcal O$
  y el rango es menor que $n$.
- **Inobservable ⇒ σ-simetría.** Se toma como $\Xi$ una base de $\ker d\mathcal O$. Por un lado,
  $h_x\,\Xi = 0$ porque $h \in \mathcal O$. Por otro, si una perturbación es invisible desde $t_0$ en
  adelante, al propagarla hasta $t_1$ sigue siendo invisible desde $t_1$ en adelante (el futuro desde
  $t_1$ es parte del futuro desde $t_0$). Así que la dinámica linealizada lleva $\ker d\mathcal O$ en
  sí mismo, y eso es (σ).

Es el teorema de Hermann y Krener (1977): para modelos analíticos, y en un abierto denso, el rango de
$d\mathcal O$ es menor que $n$ si y solo si el modelo no es localmente débilmente observable. Así que
"no hay perturbaciones invisibles de primer orden" equivale a ser observable.

**Conclusión.** "No hay σ-simetrías ⇒ observable" es cierto, mientras que "no hay simetrías (S) ⇒
observable" es falso (Nick).

## 7. Cómo se resuelve

Incógnita $\xi(t,x)$, para $k = 1$:

1. Calcular $r = D(\xi) - f_x\,\xi$. Es un vector lineal en $\xi$ y polinómico en $u$.
2. Imponer $r \parallel \xi$, eliminando $\lambda$. Hay dos formas:
   - **Normalizar.** Si $\xi$ es solución, $c(t,x)\,\xi$ también lo es (solo importa la dirección).
     Se fija $\xi_j = 1$; entonces $\lambda = r_j$ y quedan $r_i - r_j\,\xi_i = 0$ para $i \ne j$.
     Hay que probar cada $j$.
   - **Menores.** $r_i\,\xi_j - r_j\,\xi_i = 0$ para $i < j$.
3. Añadir la condición de salida $h_x\,\xi = 0$.
4. Separar por potencias de $u$ (y de $u_t$), como en `Obs`, porque $\xi$ no depende de $u$.
5. Resolver:
   - Si hay una solución no nula, el modelo es inobservable y $\xi$ es una dirección inobservable.
   - Si no la hay, se prueba con $k = 2$ (normalizando un bloque $k\times k$ de $\Xi$ a la identidad),
     y así hasta $k = n$.
   - Si no hay solución para ningún $k$, el modelo es observable.

**Diferencia con el método actual.** Términos como $r_j\,\xi_i$ son productos de incógnitas, así que
el sistema deja de ser lineal (es de tipo Riccati).

**Ejemplo con salida.** $x_1' = 1 + x_1 u$, $x_2' = -x_2 + u$, $y = x_2$.

- Paso 3: $\xi_2 = 0$.
- Con $\xi_1 = 1$, $f_x = \begin{pmatrix} u & 0 \\ 0 & -1 \end{pmatrix}$, $r = (-u,\ 0) = -u\,\xi$.
  Así que $\lambda = -u$ y la dirección inobservable es $\partial_{x_1}$.
- Con (S), en cambio, $D(\xi_1) = u\,\xi_1$ solo admite $\xi_1 = 0$, porque $x_2$ no contiene
  $\int u$: no hay simetría.

## 8. Relación con añadir $w$

El tamaño cumple $g' = -\Lambda\,g$.

- **Si $\Lambda$ depende solo de $(t,u)$**, $g$ se calcula a partir de la entrada, así que es una
  señal conocida. Se puede añadir como estado con su propia salida, y entonces la perturbación
  $\Xi g$ pasa a ser función del estado del modelo aumentado: es una **simetría puntual** de ese
  modelo. En Nick, $\lambda = -u$, $g = e^{w}$ con $w' = u$, que es `Models/Nick_counterexample_w.jl`.
  En el ejemplo de la sección 5, $g = R(w)\,c$ con $w' = u_2$.
- **Si $\Lambda$ depende de $x$**, $g$ depende de la trayectoria, que es desconocida, así que no se
  puede añadir como salida. Pero tampoco hace falta: la σ-simetría ya prueba la inobservabilidad.

## 9. Resumen

| | forma de la perturbación invisible | ¿caracteriza la inobservabilidad? | ecuaciones |
|---|---|---|---|
| Simetría (S), `Obs` actual | $\delta x = \xi(t,x)$ | no (Nick) | lineales |
| λ-simetría | $\delta x = g(t)\,\xi(t,x)$, $g$ escalar | no (ejemplo de la sección 5) | no lineales |
| σ-simetría, $k = 1,\dots,n$ | $\delta x = \Xi(t,x)\,g(t)$, $g \in \mathbb R^k$ | sí | no lineales |

Cada fila incluye a la anterior.

## Referencias

1. R. Hermann, A. J. Krener. Nonlinear controllability and observability. *IEEE Trans. Automat. Control* 22 (1977) 728–740.
2. C. Muriel, J. L. Romero. New methods of reduction for ordinary differential equations. *IMA J. Appl. Math.* 66 (2001) 111–125.
3. G. Cicogna, G. Gaeta, S. Walcher. A generalization of λ-symmetry reduction for systems of ODEs: σ-symmetries. *J. Phys. A* 45 (2012) 355205.
