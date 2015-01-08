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


## Module Data.Profunctor.Choice

### Type Classes

    class (Profunctor p) <= Choice p where
      left :: forall a b c. p a b -> p (Either a c) (Either b c)
      right :: forall a b c. p b c -> p (Either a b) (Either a c)


### Type Class Instances

    instance choiceArr :: Choice Prim.Function


## Module Data.Profunctor.Strong

### Type Classes

    class (Profunctor p) <= Strong p where
      first :: forall a b c. p a b -> p (Tuple a c) (Tuple b c)
      second :: forall a b c. p b c -> p (Tuple a b) (Tuple a c)


### Type Class Instances

    instance strongArr :: Strong Prim.Function