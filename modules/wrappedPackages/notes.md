# L17, taskwarrior.nix

Recursion is being used in this way:
We pass value to formatValue function, then it checks if it's a boolean -> if it's boolean, then it checks if it's boolean true -> if yes then return string "true" else return "false". Then it checks if value might be a list and since value list can contain multiple data type values, it recursively formats and appends the formatted value returning a comma separated string.

This is how recursion works: if the list contains a string (or a non-boolean value) it runs the last else block on that list item (value is the list of which the elements are being mapped, i.e., formatValue is running on each of those list items). If one of those items is boolean true, it returns "true" but concatenated with a comma as the separator. So if we pass a list as the value like `["arg" true]` it will give `"arg,true"` as the output
