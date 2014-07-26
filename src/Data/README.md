# Module Documentation

## Module Data.Profunctor

### Type Classes

    class Profunctor p where
      dimap :: forall a b c d. (a -> b) -> (c -> d) -> p b c -> p a d


### Type Class Instances

    instance profunctorArr :: Profunctor Prim.Function


### Values

    lmap :: forall a b c p. (Profunctor p) => (a -> b) -> p b c -> p a c

    rmap :: forall a b c p. (Profunctor p) => (b -> c) -> p a b -> p a c



