module Data.Profunctor.Star where

import Prelude (class Applicative, class Functor, map, (<<<), pure, ($), (>>>))

import Data.Tuple (Tuple(Tuple))
import Data.Either (Either(Right, Left), either)
import Data.Profunctor (class Profunctor)
import Data.Profunctor.Strong (class Strong)
import Data.Profunctor.Choice (class Choice)

-- | `Star` turns a `Functor` into a `Profunctor`.
newtype Star f a b = Star (a -> f b)

-- | Unwrap a value of type `Star f a b`.
runStar :: forall f a b. Star f a b -> a -> f b
runStar (Star f) = f

instance profunctorStar :: (Functor f) => Profunctor (Star f) where
  dimap f g (Star ft) = Star (f >>> ft >>> map g)

instance strongStar :: (Functor f) => Strong (Star f) where
  first  (Star f) = Star \(Tuple s x) -> map (`Tuple` x) (f s)
  second (Star f) = Star \(Tuple x s) -> map (Tuple x) (f s)

instance choiceStar :: (Applicative f) => Choice (Star f) where
  left  (Star f) = Star $ either (map Left <<< f) (pure <<< Right)
  right (Star f) = Star $ either (pure <<< Left) (map Right <<< f)
