name "webapp"
description "Web app role."
run_list(
  "recipe[demo-app]",
  "recipe[demo-app::django]"
  )
