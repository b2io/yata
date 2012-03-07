object @list
attributes :id, :position, :text

child :todos do
  attributes :id, :position, :text, :done, :list_id, :description, :checklist_items
end