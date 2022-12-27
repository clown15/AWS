variable "ingresses" {
  type = map(object({
    from_port = number
    to_port = number
    protocol = string
  }))
}

variable "egresses" {
  type = map(object({
    from_port = number
    to_port = number
    protocol = string
  }))
}
