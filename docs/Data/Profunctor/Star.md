## Module Data.Profunctor.Star

#### `Star`

``` purescript
newtype Star f a b
  = Star (a -> f b)
```

`Star` turns a `Functor` into a `Profunctor`.

##### Instances
``` purescript
instance profunctorStar :: (Functor f) => Profunctor (Star f)
instance strongStar :: (Functor f) => Strong (Star f)
instance choiceStar :: (Applicative f) => Choice (Star f)
```

#### `runStar`

``` purescript
runStar :: forall f a b. Star f a b -> a -> f b
```

Unwrap a value of type `Star f a b`.
