# Module Documentation

## Module Data.Profunctor

#### `Profunctor`

``` purescript
class Profunctor p where
  dimap :: forall a b c d. (a -> b) -> (c -> d) -> p b c -> p a d
```


#### `lmap`

``` purescript
lmap :: forall a b c p. (Profunctor p) => (a -> b) -> p b c -> p a c
```


#### `rmap`

``` purescript
rmap :: forall a b c p. (Profunctor p) => (b -> c) -> p a b -> p a c
```


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


#### `choiceArr`

``` purescript
instance choiceArr :: Choice Prim.Function
```



## Module Data.Profunctor.Strong

#### `Strong`

``` purescript
class (Profunctor p) <= Strong p where
  first :: forall a b c. p a b -> p (Tuple a c) (Tuple b c)
  second :: forall a b c. p b c -> p (Tuple a b) (Tuple a c)
```


#### `strongArr`

``` purescript
instance strongArr :: Strong Prim.Function
```