#!/bin/bash

# Define the regex pattern for pod names
POD_NAME_REGEX="grafana-agent-app-[0-9]+"

# Iterate over all pods matching the regex pattern
for POD_NAME in $(kubectl get pods -n monitoring --no-headers=true -o custom-columns=:metadata.name | grep -E "$POD_NAME_REGEX"); do
    echo "Pod: $POD_NAME"

    # Get the configured resource limits for the pod
    CONFIGURED_CPU_LIMIT=$(kubectl describe pod $POD_NAME | grep "CPU" | awk '{print $2}')
    CONFIGURED_MEMORY_LIMIT=$(kubectl describe pod $POD_NAME | grep "Memory" | awk '{print $2}')

    # Convert CPU limit from nanocpus to millicpus
    CONFIGURED_CPU_LIMIT=$(echo "$CONFIGURED_CPU_LIMIT / 1000000" | bc)

    # Convert Memory limit from kibibytes to mebibytes
    CONFIGURED_MEMORY_LIMIT=$(echo "$CONFIGURED_MEMORY_LIMIT / 1024 / 1024" | bc)

    # Get the current resource usage for the pod
    CURRENT_CPU_USAGE=$(kubectl top pod $POD_NAME | grep "CPU" | awk '{print $2}')
    CURRENT_MEMORY_USAGE=$(kubectl top pod $POD_NAME | grep "MEMORY" | awk '{print $2}')

    # Remove any trailing units from the CPU usage (e.g., m, n)
    CURRENT_CPU_USAGE=${CURRENT_CPU_USAGE//[!0-9]/}
    # Convert CPU usage from milli CPUs to millicpus
    CURRENT_CPU_USAGE=$(echo "$CURRENT_CPU_USAGE * 1000" | bc)

    # Remove any trailing units from the MEMORY usage (e.g., Mi)
    CURRENT_MEMORY_USAGE=${CURRENT_MEMORY_USAGE//[!0-9]/}

    # Calculate the percentage of usage
    CPU_PERCENTAGE=$(echo "scale=2; ($CURRENT_CPU_USAGE / $CONFIGURED_CPU_LIMIT) * 100" | bc)
    MEMORY_PERCENTAGE=$(echo "scale=2; ($CURRENT_MEMORY_USAGE / $CONFIGURED_MEMORY_LIMIT) * 100" | bc)

    # Print the results
    echo "Configured CPU Limit: $CONFIGURED_CPU_LIMIT millicpus"
    echo "Configured Memory Limit: $CONFIGURED_MEMORY_LIMIT MiB"
    echo "Current CPU Usage: $CURRENT_CPU_USAGE millicpus"
    echo "Current Memory Usage: $CURRENT_MEMORY_USAGE MiB"
    echo "CPU Usage Percentage: $CPU_PERCENTAGE%"
    echo "Memory Usage Percentage: $MEMORY_PERCENTAGE%"
    echo "----------------------"
done
