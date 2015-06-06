module Data.Profunctor.Strong where

import Prelude

import Data.Profunctor
import Data.Tuple (Tuple(..))

-- | The `Strong` class extends `Profunctor` with combinators for working with
-- | product types.
-- |
-- | `first` and `second` lift values in a `Profunctor` to act on the first and
-- | second components of a `Tuple`, respectively.
class (Profunctor p) <= Strong p where
  first :: forall a b c. p a b -> p (Tuple a c) (Tuple b c)
  second :: forall a b c. p b c -> p (Tuple a b) (Tuple a c)

instance strongArr :: Strong (->) where
  first a2b (Tuple a c) = Tuple (a2b a) c
  second = (<$>)

infixr 3 ***
infixr 3 &&&

-- | Compose a value acting on a `Tuple` from two values, each acting on one of
-- | the components of the `Tuple`.
(***) :: forall p a b c d. (Category p, Strong p) => p a b -> p c d -> p (Tuple a c) (Tuple b d)
(***) l r = first l >>> second r

-- | Compose a value which introduces a `Tuple` from two values, each introducing
-- | one side of the `Tuple`.
-- |
-- | This combinator is useful when assembling values from smaller components,
-- | because it provides a way to support two different types of output.
(&&&) :: forall p a b c. (Category p, Strong p) => p a b -> p a c -> p a (Tuple b c)
(&&&) l r = split >>> (l *** r)
  where
  split :: p a (Tuple a a)
  split = dimap id (\a -> Tuple a a) id
