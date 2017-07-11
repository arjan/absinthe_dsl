defmodule AbsintheDSL do

  defmacro __using__(schema) do
    quote do
      import AbsintheDSL.DSL

      defmacro mutation(block) do
        render_graphql("mutation", [], block, unquote(schema))
      end
      defmacro mutation(vars, block) do
        render_graphql("mutation", vars, block, unquote(schema))
      end

      defmacro query(block) do
        render_graphql("query", [], block, unquote(schema))
      end
      defmacro query(vars, block) do
        render_graphql("query", vars, block, unquote(schema))
      end
    end
  end


end
