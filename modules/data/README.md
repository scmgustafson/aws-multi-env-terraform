# Data Module

The data layer for our example project that includes a private RDS instance, its associated subnet group, and sensitive user credentials set via local .tfvars file.

This module will create:

- An RDS instance (free-tier by default, mysql)
- A subnet group utilizing the private subnet from the `network` module

See `data-module-diagram.png` for further details.
