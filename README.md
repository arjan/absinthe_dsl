# Absinthe DSL

**Warning: experimental code! Not all features might work.**

This library allows you to write GraphQL queries using Elixir
constructs. This has 2 upsides:

* Queries are checked on compile-time, against an existing Absinthe schema;
* Tool support is better: identation of the queries works because it uses normal Elixi syntax.



## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `absinthe_dsl` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:absinthe_dsl, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/absinthe_dsl](https://hexdocs.pm/absinthe_dsl).
