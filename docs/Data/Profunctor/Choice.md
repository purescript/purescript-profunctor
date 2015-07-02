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

##### Instances
``` purescript
instance choiceFn :: Choice Function
```

#### `(+++)`

``` purescript
(+++) :: forall p a b c d. (Category p, Choice p) => p a b -> p c d -> p (Either a c) (Either b d)
```

_right-associative / precedence 2_

Compose a value acting on a sum from two values, each acting on one of
the components of the sum.

#### `(|||)`

``` purescript
(|||) :: forall p a b c. (Category p, Choice p) => p a c -> p b c -> p (Either a b) c
```

_right-associative / precedence 2_

Compose a value which eliminates a sum from two values, each eliminating
one side of the sum.

This combinator is useful when assembling values from smaller components,
because it provides a way to support two different types of input.


