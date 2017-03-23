# Crawlex

A mafengwo.cn travel articles crawler in Elixir


## Usage

Create an mnesia database:

```
mix amnesia.create -d MafwDB
```

Run with mix
```elixir
mix run -e Crawlex.run
```
