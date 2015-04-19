# Module Documentation

## Module Data.Profunctor

#### `Profunctor`

``` purescript
class Profunctor p where
  dimap :: forall a b c d. (a -> b) -> (c -> d) -> p b c -> p a d
```

A `Profunctor` is a `Functor` from the pair category `(Type^op, Type)`
to `Type`.

In other words, a `Profunctor` is a type constructor of two type
arguments, which is contravariant in its first argument and covariant
in its second argument.

The `dimap` function can be used to map functions over both arguments
simultaneously.

A straightforward example of a profunctor is the function arrow `(->)`.

Laws:

- Identity: `dimap id id = id`
- Composition: `dimap f1 g1 <<< dimap f2 g2 = dimap (f1 >>> f2) (g1 <<< g2)`

#### `lmap`

``` purescript
lmap :: forall a b c p. (Profunctor p) => (a -> b) -> p b c -> p a c
```

Map a function over the (contravariant) first type argument only.

#### `rmap`

``` purescript
rmap :: forall a b c p. (Profunctor p) => (b -> c) -> p a b -> p a c
```

Map a function over the (covariant) second type argument only.

#### `arr`

``` purescript
arr :: forall a b p. (Category p, Profunctor p) => (a -> b) -> p a b
```

Lift a pure function into any `Profunctor` which is also a `Category`.

#### `profunctorArr`

``` purescript
instance profunctorArr :: Profunctor Prim.Function
```



## Module Data.Profunctor.Choice

#### `Choice`

``` purescript
class (Profunctor p) <= Choice p where
  left :: forall a b c. p a b -> p (Either a c) (Either b c)
  right :: forall a b c. p b c -> p (Either a b) (Either a c)
```

The `Choice` class extends `Profunctor` with combinators for working with
sum types.

`left` and `right` lift values in a `Profunctor` to act on the `Left` and
`Right` components of a sum, respectively.

#### `choiceArr`

``` purescript
instance choiceArr :: Choice Prim.Function
```


#### `(+++)`

``` purescript
(+++) :: forall p a b c d. (Category p, Choice p) => p a b -> p c d -> p (Either a c) (Either b d)
```

Compose a value acting on a sum from two values, each acting on one of
the components of the sum.

#### `(|||)`

``` purescript
(|||) :: forall p a b c. (Category p, Choice p) => p a c -> p b c -> p (Either a b) c
```

Compose a value which eliminates a sum from two values, each eliminating
one side of the sum.

This combinator is useful when assembling values from smaller components,
because it provides a way to support two different types of input.


## Module Data.Profunctor.Strong

#### `Strong`

``` purescript
class (Profunctor p) <= Strong p where
  first :: forall a b c. p a b -> p (Tuple a c) (Tuple b c)
  second :: forall a b c. p b c -> p (Tuple a b) (Tuple a c)
```

The `Strong` class extends `Profunctor` with combinators for working with
product types.

`first` and `second` lift values in a `Profunctor` to act on the first and
second components of a `Tuple`, respectively.

#### `strongArr`

``` purescript
instance strongArr :: Strong Prim.Function
```


#### `(***)`

``` purescript
(***) :: forall p a b c d. (Category p, Strong p) => p a b -> p c d -> p (Tuple a c) (Tuple b d)
```

Compose a value acting on a `Tuple` from two values, each acting on one of
the components of the `Tuple`.

#### `(&&&)`

``` purescript
(&&&) :: forall p a b c. (Category p, Strong p) => p a b -> p a c -> p a (Tuple b c)
```

Compose a value which introduces a `Tuple` from two values, each introducing
one side of the `Tuple`.

This combinator is useful when assembling values from smaller components,
because it provides a way to support two different types of output.



