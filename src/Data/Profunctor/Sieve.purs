module Data.Profunctor.Sieve where

import Prelude

import Data.Identity (Identity)
import Data.Profunctor (class Profunctor)
import Data.Profunctor.Star (Star)
import Data.Newtype (wrap, unwrap)

class (Profunctor p, Functor f) <= Sieve p f | p -> f where
  sieve :: forall a b. p a b -> a -> f b

instance sieveFunction :: Sieve (->) Identity where
  sieve f = wrap <<< f

instance sieveStar :: Functor f => Sieve (Star f) f where
  sieve = unwrap