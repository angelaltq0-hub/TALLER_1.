
---
  title: "MODELOS PROBABILISTICOS"
subtitle: "MODELOS DISCRETOS"
author:
name: Luis Felipe Arenas Ramirez<br>Yari Karoline Lozano Rodriguez<br>Angela Liliana Tique Quiroga
affiliation: "Escuela Superior de Administracion Publica"
affiliation-url: "https://www.esap.edu.co/"
date: today
lang: es
title-block-banner: "#98b6ed"

format:
  html:
  page-layout: full
fontsize: 14pt
toc: true
toc-depth: 3
toc-location: right
number-sections: true
code-fold: true
code-summary: "Ver código"
theme: dark
highlight-style: monokai
html-math-method: katex
smooth-scroll: true
link-external-newwindow: true
code-overflow: scroll

editor: visual

knitr:
  opts_chunk:
  message: false
warning: false
fig.align: center
fig.width: 6
fig.height: 6
out.width: "70%"
---
  
  ```{=html}
<div style="position:absolute; top:10px; right:10px;">
  <img src="Logo_Esap.png" width="150">
  </div>
  ```

```{=html}
<style>
  body {
    background-color: #f7f6ed;
      font-size: 130%;
    text-align: justify;
  }
</style>
  ```

# Activar paquetes

```{r}
library(tidyverse)
library(knitr)
library(kableExtra)
```

# Distribución Binomial

La distribución binomial es un modelo de probabilidad discreta que permite calcular la probabilidad de obtener un número determinado de éxitos en una cantidad fija de ensayos independientes. Cada ensayo tiene únicamente dos resultados posibles: éxito o fracaso, y la probabilidad de éxito permanece constante durante todo el experimento.

**Características de identificación:**
  
  Para que un experimento pueda representarse mediante una distribución binomial, debe cumplir las siguientes condiciones:
  
  - **Número fijo de ensayos (n):** se establece previamente cuántas veces se realizará el experimento.
- **Dos resultados posibles:** cada ensayo tiene dos resultados, que se clasifican como éxito o fracaso.
- **Probabilidad constante (p):** la probabilidad de éxito es la misma en cada ensayo.
- **Independencia:** el resultado de un ensayo no afecta los resultados de los demás.

**Fórmula o expresión matemática:**
  
  La probabilidad de obtener exactamente k éxitos en n ensayos se calcula mediante:
  
  $$
  P(X=k)=\binom{n}{k}p^k(1-p)^{n-k}
$$
  
  **Ejercicio 1**
  
  Una alcaldía municipal está realizando un seguimiento a la gestión de su oficina de atención al ciudadano, con el propósito de evaluar el cumplimiento de los tiempos establecidos para responder las solicitudes de la comunidad.

De acuerdo con los registros administrativos, el 75 % de las solicitudes ciudadanas son respondidas dentro del plazo establecido por la entidad.

La oficina de control interno selecciona aleatoriamente una muestra de 12 solicitudes para evaluar su cumplimiento. Se supone que los resultados son independientes y que la probabilidad de responder oportunamente permanece constante.

Sea $X$ la variable aleatoria que representa el número de solicitudes respondidas dentro del plazo establecido.

**Determine:**
  
  1. ¿Cuál es la probabilidad de que exactamente 9 solicitudes sean respondidas oportunamente?
  2. ¿Cuál es la probabilidad de que más de 9 solicitudes sean respondidas oportunamente?
  3. ¿Cuál es la probabilidad de que menos de 8 solicitudes sean respondidas oportunamente?
  
  **Tabla de distribución binomial**
  
  ```{r}
n <- 12
p <- 0.75

x <- 0:n

fx <- dbinom(x, size = n, prob = p)
Fx <- pbinom(x, size = n, prob = p)

df <- data.frame(
  x = x,
  fx = round(fx, 4),
  Fx = round(Fx, 4)
)

kable(df, align = "c",
      col.names = c("Solicitudes oportunas (x)",
                    "Probabilidad f(x)",
                    "Probabilidad acumulada F(x)")) %>%
  kable_styling("striped", full_width = FALSE) %>%
  column_spec(1, bold = TRUE) %>%
  row_spec(0:13, bold = TRUE,
           color = "#0b0f0b",
           background = "#4af7be")
```

**Gráficas**
  
  ::: panel-tabset

## F. PROBABILIDAD

```{r}
df_1 <- data.frame(
  x = x,
  fx = fx,
  xend = x,
  fxend = 0
)

ggplot(df_1, aes(x = x, y = fx)) +
  geom_segment(aes(xend = xend, yend = fxend),
               color = "#eb093a", linewidth = 1) +
  geom_point(color = "#52f258", size = 2) +
  labs(
    title = "Función de probabilidad binomial",
    x = "Número de solicitudes oportunas",
    y = "Probabilidad f(x)"
  ) +
  theme_minimal()
```

## F. DISTRIBUCIÓN

```{r}
df_2 <- data.frame(
  x = x,
  Fx = Fx
)

ggplot(df_2, aes(x = x, y = Fx)) +
  geom_step(color = "#eb093a", linewidth = 1) +
  geom_point(color = "#52f258", size = 2) +
  labs(
    title = "Función de distribución binomial",
    x = "Número de solicitudes oportunas",
    y = "Probabilidad acumulada F(x)"
  ) +
  theme_minimal()
```

:::
  
  **Solución de los incisos**
  
  ::: panel-tabset

## Inciso 1

Exactamente 9 solicitudes respondidas oportunamente.

```{r}
# Inciso 1: Exactamente 9 solicitudes

n <- 12
p <- 0.75

P1 <- dbinom(9, size = n, prob = p)

P1

# Resultado en porcentaje
P1 * 100
```

## Inciso 2

Más de 9 solicitudes respondidas oportunamente.

```{r}
# Inciso 2: Más de 9 solicitudes

n <- 12
p <- 0.75

P2 <- 1 - pbinom(9, size = n, prob = p)

P2

# Resultado en porcentaje
P2 * 100
```

## Inciso 3

Menos de 8 solicitudes respondidas oportunamente.

```{r}
# Inciso 3: Menos de 8 solicitudes

n <- 12
p <- 0.75

P3 <- pbinom(7, size = n, prob = p)

P3

# Resultado en porcentaje
P3 * 100
```

:::
  
  # Distribución de Poisson
  
  La distribución de Poisson es un modelo de probabilidad discreta que permite determinar la probabilidad de que ocurra una cantidad específica de eventos dentro de un intervalo de tiempo o espacio determinado, cuando estos suceden de manera independiente y mantienen una tasa promedio constante.

**Definición y origen**
  
  Esta distribución fue desarrollada por el matemático francés Siméon Denis Poisson en 1837. Se utiliza para estudiar la frecuencia con la que ocurren determinados acontecimientos en un periodo o espacio establecido.

En la Administración Pública permite analizar situaciones como la cantidad de solicitudes recibidas, las quejas ciudadanas, los reportes de incidentes y las demandas de atención en las entidades gubernamentales.

**Características clave**
  
  - **Eventos discretos:** representa cantidades enteras de acontecimientos, como llamadas, solicitudes o quejas.
- **Independencia:** la ocurrencia de un evento no determina la ocurrencia de otro.
- **Tasa promedio constante:** los eventos ocurren con una frecuencia promedio representada por el parámetro lambda (λ).
- **Intervalo definido:** los eventos se estudian dentro de un periodo de tiempo o espacio específico.

**Fórmula y expresión matemática**
  
  La probabilidad de que ocurran exactamente k eventos, cuando el promedio es λ, se calcula mediante:
  
  $$
  P(X=k)=\frac{\lambda^k e^{-\lambda}}{k!}
$$
  
  **Ejercicio 2**
  
  Una alcaldía municipal cuenta con una oficina de gestión documental encargada de recibir y registrar las solicitudes de información presentadas por los ciudadanos.

De acuerdo con los registros de la entidad, se reciben en promedio 4 solicitudes de información por hora.

Se supone que las solicitudes llegan de manera independiente y que la tasa promedio de recepción permanece constante durante el periodo analizado.

Sea $X$ la variable aleatoria que representa el número de solicitudes de información recibidas durante una hora.

**Determine:**
  
  1. ¿Cuál es la probabilidad de recibir exactamente 3 solicitudes durante una hora?
  2. ¿Cuál es la probabilidad de recibir más de 5 solicitudes durante una hora?
  3. ¿Cuál es la probabilidad de recibir entre 2 y 6 solicitudes durante una hora, inclusive?
  
  Por tanto:
  
  $$
  X\sim Poisson(\lambda=4)
$$
  
  **Tabla de distribución de Poisson**
  
  ```{r}
n <- 12
lambda <- 4

x <- 0:n

fx <- dpois(x, lambda = lambda)
Fx <- ppois(x, lambda = lambda)

df <- data.frame(
  x = x,
  fx = round(fx, 4),
  Fx = round(Fx, 4)
)

kable(df, align = "c",
      col.names = c("Número de solicitudes (x)",
                    "Probabilidad f(x)",
                    "Probabilidad acumulada F(x)")) %>%
  kable_styling("striped", full_width = FALSE) %>%
  column_spec(1, bold = TRUE) %>%
  row_spec(0:13, bold = TRUE,
           color = "#0b0f0b",
           background = "#4af7be")
```

**Gráficas**
  
  ::: panel-tabset

## F. PROBABILIDAD

```{r}
df_1 <- data.frame(
  x = x,
  fx = fx,
  xend = x,
  fxend = 0
)

ggplot(df_1, aes(x = x, y = fx)) +
  geom_segment(aes(xend = xend, yend = fxend),
               color = "#eb093a", linewidth = 1) +
  geom_point(color = "#52f258", size = 2) +
  labs(
    title = "Función de probabilidad de Poisson",
    x = "Número de solicitudes recibidas",
    y = "Probabilidad f(x)"
  ) +
  theme_minimal()
```

## F. DISTRIBUCIÓN

```{r}
df_2 <- data.frame(
  x = x,
  Fx = Fx
)

ggplot(df_2, aes(x = x, y = Fx)) +
  geom_step(color = "#eb093a", linewidth = 1) +
  geom_point(color = "#52f258", size = 2) +
  labs(
    title = "Función de distribución de Poisson",
    x = "Número de solicitudes recibidas",
    y = "Probabilidad acumulada F(x)"
  ) +
  theme_minimal()
```

:::
  
  **Solución de los incisos**
  
  ::: panel-tabset

## Inciso 1

Exactamente 3 solicitudes recibidas durante una hora.

```{r}
# Inciso 1: Exactamente 3 solicitudes

lambda <- 4

P1 <- dpois(3, lambda = lambda)

P1

# Resultado en porcentaje
P1 * 100
```

## Inciso 2

Más de 5 solicitudes recibidas durante una hora.

```{r}
# Inciso 2: Más de 5 solicitudes

lambda <- 4

P2 <- 1 - ppois(5, lambda = lambda)

P2

# Resultado en porcentaje
P2 * 100
```

## Inciso 3

Entre 2 y 6 solicitudes recibidas durante una hora, inclusive.

```{r}
# Inciso 3: Entre 2 y 6 solicitudes inclusive

lambda <- 4

P3 <- ppois(6, lambda = lambda) -
  ppois(1, lambda = lambda)

P3

# Resultado en porcentaje
P3 * 100
```

:::
  