RDS Custom VIVO Distribution
============================

[![Build Status](https://travis-ci.org/tetherless-world/rds-vivo.svg?branch=master)](https://travis-ci.org/tetherless-world/rds-vivo)

This project uses the [VIVO three tiered build approach](https://wiki.duraspace.org/display/VIVO/Building+VIVO+in+3+tiers) to produce a customized VIVO distribution for RDS.  The Vitro and VIVO project dependencies are tracked using [Git Submodules](http://git-scm.com/book/en/v2/Git-Tools-Submodules).

# Intro

A three-tiered VIVO build with docker and fig configuration files to support development and deployment of RDS VIVO using Docker.

Two containers are required to run VIVO using docker
- rds-vivo (customized VIVO webapp)
- mysql (5.7.5 official - webapp database)

The rds-vivo container must be linked to a mysql container.  The included fig service definition provides the correct linkage and can be used to start and stop both containers.

# Requirements

|Name			|Version		|Comment										|
|:--------------|:-------------:|:----------------------------------------------|
|Docker			|>= 1.3 		|works with Boot2docker 1.3						|
|Fig 			|>= 1.0 		|on the host or with Dockerfile provided		|
|OS				|any	 		|as long as you can run Docker 1.3				|

# Usage

VIVO Customizations
===================

TODO

Docker
======

Build a docker image of RDS VIVO by running this command at the project root.

```
$ sudo docker build -t="rds-vivo" .
```

Now check that the image was successfully created and stored to the local docker repository

```
$ sudo docker images
```

Fig
===

Fig is used to coordinate docker containers.

We use fig to
- define what containers should be started as part of our service
- define the linkages between the containers
- define what ports should be exposed between containers
- define how ports should be mapped between the host system and containers
- volumes that should be mounted when our containers are started
- environment variables that should be passed to our containers

See more at Fig's homepage: [http://www.fig.sh](http://www.fig.sh)

Note - Edit the fig.yml file so that the desired environment variables passed to your containers (perhaps changing passwords ;-))

To start the RDS VIVO service run:

```
$ sudo fig up -d
```

To stop the RDS VIVO service run:

```
$ sudo fig stop
```