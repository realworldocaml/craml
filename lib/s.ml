type line = [
  | `Output  of string
  | `Command of string
  | `Comment of string
  | `Part    of string
  | `Ellipsis
  | `Non_det of [`Command|`Output]
]
