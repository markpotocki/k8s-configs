#!/bin/bash

# Default parameters
releaseName="jupyterhub"    # -n
namespace="default"         # -p
config="config.yaml"        # -c


# Flag Overrides
while getopts n:c:p: option
do
    case "${option}" in
            n)releaseName=${OPTARG}
                ;;
            c)config=${OPTARG}
                ;;
            p)namespace=${OPTARG}
                ;;
            *) echo "Invalid option: -$option" ;;
        esac
done

# TODO create ingress service

# Install jupyterhub from helm
helm upgrade --cleanup-on-fail \
    --install $releaseName jupyterhub/jupyterhub \
    --namespace $namespace \
    --create-namespace \
    --version=2.0.0 \
    --values $config

# Forward proxy port
# TODO add check to see if it is already running (ie in an update)
#kubectl --namespace=$namespace port-forward service/proxy-public 8080:http


