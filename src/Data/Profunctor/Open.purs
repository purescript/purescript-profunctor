module Data.Profunctor.Open where

import Prelude

import Data.Profunctor (class Profunctor)

-- | The `Open` class extends the `Profunctor` class to work with function domains.
class Profunctor p <= Open p where
  open :: forall a b x. p a b -> p (b -> x) (a -> x)

instance openFunction :: Open Function where
  open = (>>>)
