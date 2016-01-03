## Module Data.Profunctor.Cochoice

#### `Cochoice`

``` purescript
class (Profunctor p) <= Cochoice p where
  unleft :: forall a b c. p (Either a c) (Either b c) -> p a b
  unright :: forall a b c. p (Either a b) (Either a c) -> p b c
```

The `Cochoice` class provides the dual operations of the `Choice` class.


