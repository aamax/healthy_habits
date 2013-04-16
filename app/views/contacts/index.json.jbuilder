json.array!(@contacts) do |c|
  json.id           c.id
  json.name         c.name
  json.email        c.email
  json.ezine        c.ezine
  json.group        c.group
  json.notifications c.notifications
end