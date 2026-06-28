(string
  (string_content) @injection.content
  (#match? @injection.content "INSERT|SELECT|UPDATE|DELETE|WITH|AND|OR")
  (#set! injection.language "sql")
)
