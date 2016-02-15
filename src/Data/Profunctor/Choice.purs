module Data.Profunctor.Choice where

import Prelude (class Category, (>>>), id, (<$>), ($))

import Data.Either (Either(..), either)
import Data.Profunctor (class Profunctor, dimap)

-- | The `Choice` class extends `Profunctor` with combinators for working with
-- | sum types.
-- |
-- | `left` and `right` lift values in a `Profunctor` to act on the `Left` and
-- | `Right` components of a sum, respectively.
class (Profunctor p) <= Choice p where
  left :: forall a b c. p a b -> p (Either a c) (Either b c)
  right :: forall a b c. p b c -> p (Either a b) (Either a c)

instance choiceFn :: Choice (->) where
  left a2b (Left a)  = Left $ a2b a
  left _   (Right c) = Right c
  right = (<$>)

-- | Compose a value acting on a sum from two values, each acting on one of
-- | the components of the sum.
infixr 2 chooseLeftSum as +++
chooseLeftSum :: forall p a b c d. (Category p, Choice p) => p a b -> p c d -> p (Either a c) (Either b d)
chooseLeftSum l r = left l >>> right r

-- | Compose a value which eliminates a sum from two values, each eliminating
-- | one side of the sum.
-- |
-- | This combinator is useful when assembling values from smaller components,
-- | because it provides a way to support two different types of input.
infixr 2 keepOne as |||
keepOne :: forall p a b c. (Category p, Choice p) => p a c -> p b c -> p (Either a b) c
keepOne l r = (l +++ r) >>> join
  where
  join :: p (Either c c) c
  join = dimap (either id id) id id
