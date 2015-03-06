module Data.Profunctor.Choice where

  import Data.Either (Either(..), either)
  import Data.Profunctor

  class (Profunctor p) <= Choice p where
    left :: forall a b c. p a b -> p (Either a c) (Either b c)
    right :: forall a b c. p b c -> p (Either a b) (Either a c)

  instance choiceArr :: Choice (->) where
    left a2b (Left a)  = Left $ a2b a
    left _   (Right c) = Right c

    right = (<$>)

  infixr 2 +++
  infixr 2 ||| 

  (+++) :: forall p a b c d. (Category p, Choice p) => p a b -> p c d -> p (Either a c) (Either b d)
  (+++) l r = left l >>> right r

  (|||) :: forall p a b c. (Category p, Choice p) => p a c -> p b c -> p (Either a b) c 
  (|||) l r = (l +++ r) >>> join
    where
    join :: p (Either c c) c
    join = dimap (either id id) id id
