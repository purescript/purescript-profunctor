## Module Data.Profunctor.Strong

#### `Strong`

``` purescript
class (Profunctor p) <= Strong p where
  first :: forall a b c. p a b -> p (Tuple a c) (Tuple b c)
  second :: forall a b c. p b c -> p (Tuple a b) (Tuple a c)
```

##### Instances
``` purescript
instance strongArr :: Strong Function
```

The `Strong` class extends `Profunctor` with combinators for working with
product types.

`first` and `second` lift values in a `Profunctor` to act on the first and
second components of a `Tuple`, respectively.

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


