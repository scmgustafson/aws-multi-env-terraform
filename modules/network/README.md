# Network Module

The network layer for our example project that includes all necessary network infrastructure for a given environment.

This module will create:

- A VPC
- a public and 2 private subnets (necessary for RDS instance)
- an internet gateway and a nat gateway
- all necessary route tables and associations

See `network-module-diagram.png` for further details.
