object @list
attributes :id, :order, :text

child :todos do
  attributes :id, :order, :text, :done, :list_id
end