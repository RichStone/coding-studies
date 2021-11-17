# 3rd Coding Study - Create Lotti Karotti Board Game

![](meta/boardgame.jpg)

Coding Study dedicated to practicing TDD, OOP, and SRP.

Following the Mediator pattern, all the core classes:

* Board
* Player
* Deck
* (maybe) Figure

Are planned not to know anything about each other and not communicate with each
other.

They will be orchestrated by the `Gamemaster` (mediator) who has knowledge about
the core classes.

Latest design plan:

![](meta/design2.png)

### Live Stream Recording Walkthrough

Part 1: https://youtu.be/fsM6selQOw8

Part 2: https://youtu.be/zidyMaFyGHo

Part 3: https://youtu.be/VhY0Mo2ShAQ

[STUDY.md](STUDY.md)

## Installation & Usage

```shell
$ irb
> require "~/your-path/gamemaster.rb"
true
> gamemaster = Gamemaster.new
> gamemaster.show_board
- Lotti Karotti Game Board -

#-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-⚪️-#-⚪️-#-⚪️-#-🥕

> gamemaster.spin_carrot
> gamemaster.show_board
- Lotti Karotti Game Board -

#-#-#-⚪️-#-#-⚪️-#-#-⚪️-#-#-🔥-#-#-⚪️-#-#-⚪️-#-⚪️-#-⚪️-#-⚪️-#-🥕

```

## Development

1. Fork repo
2. Clone repo to your local
3. Run tests

```shell
$ cd coding_studies/003_lotti_karotti_boardgame
$ rspec .
.......................

Finished in 0.0134 seconds (files took 0.16408 seconds to load)
23 examples, 0 failures
```

4. Red => Green => Refactor 🔄
