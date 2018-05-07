# Taxes

Bracketed Tax Engine

## Installation

```sh
git clone https://framagit.org/anotherdev/taxes.git
cd taxes
./bin/setup
bundle exec rake install
```

## Usage

A sample `brackets.json` and `incomes.txt` file are provided as part of the
repository.

```sh
./exe/taxes -b samples/brackets.json -i samples/incomes.txt -o taxes.txt
```

Note: the gem contains a `taxes` executable. Depending on your local setup, it
should now be available as part of your `$PATH` environment variable.

## Testing

```sh
bundle exec rake         # run reek, rubocop and rspec
open coverage/index.html # see the code coverage
```

## Improvements

Right now, the `Taxes::Engines` assumes that it's dealing with US Dollars,
hence the rounding is done using `round(2)` in the `Taxes::Engine` class. A
better approach would be to leverage an existing gem such as
[Money](https://github.com/RubyMoney/money) to ensure the rounding follows the
currency rules.
