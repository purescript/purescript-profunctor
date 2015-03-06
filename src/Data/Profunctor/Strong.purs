module Data.Profunctor.Strong where

  import Data.Profunctor
  import Data.Tuple (Tuple(..))

  class (Profunctor p) <= Strong p where
    first :: forall a b c. p a b -> p (Tuple a c) (Tuple b c)
    second :: forall a b c. p b c -> p (Tuple a b) (Tuple a c)

  instance strongArr :: Strong (->) where
    first a2b (Tuple a c) = Tuple (a2b a) c
    second = (<$>)

  infixr 3 ***
  infixr 3 &&&

  (***) :: forall p a b c d. (Category p, Strong p) => p a b -> p c d -> p (Tuple a c) (Tuple b d)
  (***) l r = first l >>> second r

  (&&&) :: forall p a b c. (Category p, Strong p) => p a b -> p a c -> p a (Tuple b c)
  (&&&) l r = split >>> (l *** r)
    where
    split :: p a (Tuple a a)
    split = dimap id (\a -> Tuple a a) id

