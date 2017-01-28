# Chef Server

This is a Docker image providing a [Chef Server](https://downloads.chef.io/chef-server) with [Chef Manage](https://downloads.chef.io/manage).

The Chef server makes it easy to automate your infrastructure, manage scale and complexity, and safeguard your systems. Chef Manage is an Enterprise Chef add-on that enables a web-based user interface for visualizing and managing nodes, data bags, roles, environments, cookbooks and role-based access control (RBAC).

## Build

```console
$ make build
```

## Usage

Starting the Chef Server container:

```console
docker run -ti -v $(pwd):/volumes/keys -p 443:443 chef-server:stable
```

To access the Chef Server Management Console open a web browser https://127.0.0.1 or https://\<ip of docker host\>:443

At login enter user ```super``` and password ```password```

## Where to Store Data


1. Create a chef directory on a suitable volume on your host system, e.g. ```$HOME/chef```.
2. Start the Chef Server container like this:

```console
docker run -ti -v $HOME/chef:/volumes/keys -p 443:443 chef-server:stable
```

## License

View [Chef Server license information](https://downloads.chef.io/chef-server/stable/12.11.1/ubuntu/14.04/license) and [Chef Manage license information](https://downloads.chef.io/manage/stable/2.4.4/ubuntu/14.04/license) for the software contained in this image.
