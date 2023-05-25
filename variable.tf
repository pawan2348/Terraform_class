# variable for VPC

variable "vpc" {
    type=string
    
}

#this is my subnet
variable "subnet" {
    type=string
    default="10.0.1.0/24"
}

# this is my instance type
variable "instance_type" {
    default="t2.micro"
}

#this is my ami
variable "myami" {
    default="ami-08333bccc35d71140"
}

variable "ingres" {
        type=list
        default=["0.0.0.0/0"]
    }


    variable "tag" {
   default="vpc-ajay"
}