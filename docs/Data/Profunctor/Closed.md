## Module Data.Profunctor.Closed

#### `Closed`

``` purescript
class (Profunctor p) <= Closed p where
  closed :: forall a b x. p a b -> p (x -> a) (x -> b)
```

The `Closed` class extends the `Profunctor` class to work with functions.

##### Instances
``` purescript
instance closedFunction :: Closed Function
```


