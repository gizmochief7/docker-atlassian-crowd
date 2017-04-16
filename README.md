atlassian-crowd
===============

The atlassian-crowd container can be used to spin up an instance of
[Atlassian Crowd®](https://www.atlassian.com/software/crowd).


Quick Start
-----------

To quickly spin up an instance of Atlassian Crowd®, simply specify a port
forwarding rule and run the container:

    $ docker run \
        -p 8095:8095 \
        gizmochief7/atlassian-crowd

Usage
-----

If you are not planning on running Atlassian Crowd® behind a reverse proxy, you
can follow the instructions in the [simple](#simple) section. If you plan to use
a reverse proxy, further instructions can be found in the
[reverse proxy](#reverse-proxy) section of this document.

### Simple

Atlassian Crowd® stores instance-specific data inside a folder it defines as the
`crowd.home` directory. This container defines the `crowd.home` directory as
`/var/opt/atlassian` and exposes it as a volume. As such, it is recommended to
either map this volume to a host directory, or to create a data container for
the volume.

A data container can be created by running the following command:

    $ docker create \
        --name crowd-data \
        gizmochief7/atlassian-crowd

The application container can then be started by running:

    $ docker run \
        --name crowd \
        --volumes-from crowd-data \
        -p 8095:8095 \
        gizmochief7/atlassian-crowd

### Reverse Proxy

If you are using a reverse proxy to proxy connections to Atlassian Crowd®, you
will need to specify two extra environment variables when starting this
container.

The variables are as follows:

- *TC_PROXYNAME*: the domain name at which Atlassian Crowd® will be accessible.
- *TC_PROXYPORT*: the port on which Atlassian Crowd® will be accessible.

For example, if you are planning on running Atlassian Crowd® at
https://example.com/crowd, you would use the following command:

    $ docker run \
        --name crowd \
        --volumes-from crowd-data \
        -p 8095:8095 \
        -e TC_PROXYNAME=example.com \
        -e TC_PROXYPORT=443 \
        gizmochief7/atlassian-crowd

Once your proxy server is configured, Atlassian Crowd® should be accessible at
https://example.com/crowd.
