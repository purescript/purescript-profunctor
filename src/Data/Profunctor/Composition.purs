module Data.Profunctor.Composition where

import Prelude

import Data.Exists (Exists, mkExists, runExists)
import Data.Functor.Compose (Compose(..))
import Data.Newtype (class Newtype, over, unwrap, wrap)
import Data.Profunctor (class Profunctor, dimap, lcmap, rmap)
import Data.Profunctor.Choice (class Choice, left, right)
import Data.Profunctor.Cosieve (class Cosieve, cosieve)
import Data.Profunctor.Costar (Costar(..))
import Data.Profunctor.Sieve (class Sieve, sieve)
import Data.Profunctor.Star (Star(..))
import Data.Profunctor.Strong (class Strong, first, second)

type Iso s t a b = forall p f. Profunctor p => Functor f => p a (f b) -> p s (f t)

data ProcomposeF p q d c a = ProcomposeF (p a c) (q d a)
newtype Procompose p q d c = Procompose(Exists (ProcomposeF p q d c))

derive instance newtypeProcompose :: Newtype (Procompose p q d c) _

procompose :: forall p q d c a. p a c -> q d a -> Procompose p q d c
procompose x = wrap <<< mkExists <<< ProcomposeF x

procomposed :: forall p a b. Category p => Procompose p p a b -> p a b
procomposed = runExists(\(ProcomposeF pxc pdx) -> pxc <<< pdx) <<< unwrap

instance profunctorProcompose :: (Profunctor p, Profunctor q) => Profunctor (Procompose p q) where
  dimap l r = over Procompose $ runExists(\(ProcomposeF f g) -> mkExists $ ProcomposeF (rmap r f) (lcmap l g))

instance functorProcompose :: Profunctor p => Functor (Procompose p q a) where
  map k = over Procompose $ runExists(\(ProcomposeF f g) -> mkExists $ ProcomposeF (rmap k f) g)

instance sieveProfunctorCompose :: (Sieve p f, Sieve q g) => Sieve (Procompose p q) (Compose g f) where
  sieve (Procompose p) d = runExists (\(ProcomposeF f g) -> Compose (sieve f <$> sieve g d)) p

instance cosieveProfunctorCompose :: (Cosieve p f, Cosieve q g) => Cosieve (Procompose p q) (Compose f g) where
  cosieve (Procompose p) (Compose d) = runExists(\(ProcomposeF f g) -> cosieve f $ cosieve g <$> d) p

instance strongProcompose :: (Strong p, Strong q) => Strong (Procompose p q) where
  first = over Procompose $ runExists(\(ProcomposeF x y) -> mkExists $ ProcomposeF (first x) (first y))
  second = over Procompose $ runExists(\(ProcomposeF x y) -> mkExists $ ProcomposeF (second x) (second y))

instance choiceProcompose :: (Choice p, Choice q) => Choice (Procompose p q) where
  left = over Procompose $ runExists(\(ProcomposeF x y) -> mkExists $ ProcomposeF (left x) (left y))
  right = over Procompose $ runExists(\(ProcomposeF x y) -> mkExists $ ProcomposeF (right x) (right y))

idl
  :: forall q d c r d' c'
  . Profunctor q 
  => Iso (Procompose (->) q d c) 
         (Procompose (->) r d' c') 
         (q d c) 
         (r d' c')
idl = dimap (runExists (\(ProcomposeF f g) -> rmap f g) <<< unwrap) (map (procompose identity))

idr 
  :: forall q d c r d' c'
  . Profunctor q 
  => Iso (Procompose q (->) d c) 
         (Procompose r (->) d' c') 
         (q d c) 
         (r d' c')
idr = dimap (runExists (\(ProcomposeF f g) -> lcmap g f) <<< unwrap) (map (\x -> procompose x identity))

assoc 
  :: forall p q r a b x y z
  . Iso (Procompose p (Procompose q r) a b) 
        (Procompose x (Procompose y z) a b) 
        (Procompose (Procompose p q) r a b) 
        (Procompose (Procompose x y) z a b)
assoc = dimap f g where
  f = runExists (\(ProcomposeF f' gh) -> runExists (\(ProcomposeF g' h') -> procompose (procompose f' g') h') (unwrap gh)) <<< unwrap
  g = map (runExists (\(ProcomposeF fg h) -> runExists (\(ProcomposeF f' g') -> procompose f' (procompose g' h)) (unwrap fg)) <<< unwrap)

stars 
  :: forall f g d c f' g' d' c'
  . Functor g
  => Iso (Procompose (Star f ) (Star g ) d  c )
         (Procompose (Star f') (Star g') d' c')
         (Star (Compose g  f ) d  c )
         (Star (Compose g' f') d' c')
stars = dimap f (map g') where
  f = runExists(\(ProcomposeF (Star xgc) (Star dfx)) -> Star (Compose <<< map xgc <<< dfx)) <<< unwrap
  g' (Star dfgc) = procompose (Star identity) (Star (unwrap <<< dfgc))

costars 
  :: forall f g d c f' g' d' c'
  . Functor f
  => Iso (Procompose (Costar f ) (Costar g ) d  c )
         (Procompose (Costar f') (Costar g') d' c')
         (Costar (Compose f  g ) d  c )
         (Costar (Compose f' g') d' c')
costars = dimap f (map g') where
  f = runExists(\(ProcomposeF (Costar gxc) (Costar fdx)) -> Costar (gxc <<< map fdx <<< unwrap)) <<< unwrap 
  g' (Costar dgfc) = procompose (Costar (dgfc <<< Compose)) (Costar identity)

eta :: forall p a. Profunctor p => Category p => (a -> a) -> p a a
eta f = rmap f identity

mu :: forall p a. Category p => Procompose p p a a -> p a a
mu = procomposed