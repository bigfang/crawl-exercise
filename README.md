# Crawlex

A mafengwo.cn travel articles crawler in Elixir


## Usage

Create an mnesia database:

```
mix amnesia.create -d MafwDB
```

Run in iex
```bash
iex(1)> Crawlex.Worker.run
```
