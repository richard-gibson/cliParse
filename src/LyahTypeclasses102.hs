module LyahTypeclasses102
( Point(..)
, Shape(..)
, surface
, nudge
, revText
) where

import Data.Char
-- Type classes
data Point = Point Float Float deriving Show
type Radius = Float
data Shape = Circle { centreCoord :: Point
                    , radius :: Float} |
             Rectangle { p1 :: Point
                        , p2 :: Point
                        }

instance Show Shape where
    show (Circle p1 r) =
      "its a cirle" ++ show p1 ++", " ++ show r
    show (Rectangle p1 p2) =
      "its a Rectangle " ++ show p1 ++", " ++ show p2

surface :: Shape -> Float
surface (Circle _ r) =
  pi * r ^ 2
surface (Rectangle (Point x1 y1) (Point x2 y2)) =
  (abs $ x2 - x1) * (abs $ y2 - y1)


nudge :: Shape -> Float -> Float -> Shape
nudge (Circle (Point x y) r) a b = Circle (Point (x + b) (y + b)) r
nudge (Rectangle (Point x1 y1) (Point x2 y2)) a b =
  Rectangle (Point (x1+a) (y1+b)) (Point (x2+a) (y2+b))

revText :: IO ()
revText = do line <- fmap (reverse . map toUpper) getLine
             putStrLn $ "You said " ++ line ++ " backwards"
             putStrLn $ "Yes, You said " ++ line ++ " backwards"


data TrafficLight = Red | Yellow | Green

instance Show TrafficLight where
    show Red = "Red light"
    show Yellow = "Yellow light"
    show Green = "Green light"

instance Eq TrafficLight where
    Red == Red = True
    Yellow == Yellow = True
    Green == Green = True
    _ == _ = False


class YesNo a where
    yesno :: a -> Bool

instance YesNo Int where
    yesno 0 = False
    yesno _ = True

instance YesNo Float where
    yesno 0 = False
    yesno _ = True

instance YesNo Double where
    yesno 0 = False
    yesno _ = True

instance (YesNo a) => YesNo [a] where
    yesno [] = False
    yesno x =  foldl (&&) True $ map yesno x

instance YesNo Bool where
    yesno = id

instance (YesNo m) => YesNo (Maybe m) where
    yesno (Just x) = yesno x
    yesno Nothing = False


yesnoIf :: (YesNo y) => y -> a -> a -> a
yesnoIf yesnoVal yesRes noRes = if yesno yesnoVal then yesRes else noRes



data Tree t = EmptyTree | Node t (Tree t) (Tree t) deriving (Show, Read, Eq)

instance Functor Tree where
  fmap _ EmptyTree = EmptyTree
  fmap f (Node a left right) = Node (f a) (fmap f left) (fmap f right)

leaf :: t -> Tree t
leaf x = Node x EmptyTree EmptyTree

insert :: (Ord t) => Tree t -> t -> Tree t
insert EmptyTree x = leaf x
insert (Node a left right) x
    | x == a = Node x left right
    | x < a  = Node a (left `insert` x) right
    | x > a  = Node a left (right `insert` x)

contains :: (Ord a) => Tree a -> a -> Bool
contains EmptyTree _ = False
contains (Node a left right) x
    | x == a = True
    | x < a  = left `contains` x
    | x > a  = right `contains` x
