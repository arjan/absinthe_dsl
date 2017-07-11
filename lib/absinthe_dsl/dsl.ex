defmodule AbsintheDSL.DSL do


  require Absinthe.Schema.Notation
  import Absinthe.Schema.Notation, only: [list_of: 1, non_null: 1]

  def render_graphql(type, vars, [do: {name, _, [[do: block]]}], schema) do
    "#{type} #{render_var_decls(vars, schema)}{ #{name} { #{render_block(block) } } }"
  end

  def render_graphql(type, vars, [do: {name, _, [args, [do: block]]}], schema) do
    "#{type} #{render_var_decls(vars, schema)}{ #{name}(#{render_args(args)}) { #{render_block(block) } } }"
  end

  def render_var_decls([], _schema) do
    ""
  end
  def render_var_decls(decls, schema) do
    "(" <> (Enum.map(decls, &(render_var_decl(&1, schema))) |> Enum.join(", ")) <> ") "
  end

  defp render_var_decl({name, type}, schema) do
    type = Absinthe.Type.name(resolve_type(type), schema)
    "$#{name}: #{type}"
  end

  defp resolve_type({:non_null, _, [t]}) do
    non_null(resolve_type(t))
  end
  defp resolve_type({:list_of, _, [t]}) do
    list_of(resolve_type(t))
  end
  defp resolve_type(t), do: t

  def render_args(args) do
    Enum.map(args, &render_arg/1)
    |> Enum.join(", ")
  end

  def render_arg({k, {varname, _, nil}}) do
    "#{k}: $#{varname}"
  end
  def render_arg({k, v}) do
    "#{k}: #{inspect v}"
  end

  def render_block({:__block__, _, block}) do
    Enum.map(block, &render_block_item/1)
    |> Enum.join(" ")
  end
  def render_block({_,_,_} = item) do
    render_block_item(item)
  end

  def render_block_item({var, _, [[do: block]]}) do
    to_string(var) <> " { " <> render_block(block) <> " }"
  end
  def render_block_item({var, _, _}) do
    to_string(var)
  end

end
