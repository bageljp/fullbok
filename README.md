fullbok with terraform
===================

Launch JMeter cluster with terraform.

Installation
----

* terraform install.

https://www.terraform.io/
```
# Mac OS X
brew install terraform
```

* Set environments.
```
export AWS_ACCESS_KEY_ID=xxx
export AWS_SECRET_ACCESS_KEY=yyy
export AWS_DEFAULT_REGION=zzz
```

* Setting attributes.
```
vi tarraform.tfvars
```

* Run.
```
terraform plan
terraform apply
```
TODO
----

* JDK version to variable.

