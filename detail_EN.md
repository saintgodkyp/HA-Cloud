# Background

- Increased need for stable and highly available cloud infrastructure in university education environments
- Demand for technology to build own infrastructure to replace the high costs of commercial cloud services
- Need to provide availability and scalability tailored to the service characteristics supporting education and research

# Objectives

- Design and implement a high-availability cloud infrastructure at a commercial level
- Build a cost-effective, highly available infrastructure suitable for educational and research environments
- Develop stable and scalable systems using open-source technologies like DRBD, Pacemaker, and OpenStack
- Maximize operational efficiency by introducing differentiated high-availability strategies based on service importance
- Implement network traffic segregation and stable data management through VIP and HAProxy

# Storage Mirroring Using DRBD and HAFS

## DRBD-Based Storage Mirroring

- Configure each node's NVMe storage with DRBD to perform real-time data replication
- DRBD synchronizes I/O operations at the block device level and sets the file system to mount only on the primary node
- In case of failure recovery, DRBD automatically switches the primary node, maintains data synchronization, and provides recovery procedures to prevent split-brain scenarios

## HAFS File System

- Implement HAFS based on DRBD to support stable data storage
- Store Glance image data and Apache2 configuration files on HAFS, managed by Pacemaker to start services after HAFS is ready
- The file system is mounted only on a single node, and in failover situations, it's configured to automatically mount after switching to the new primary node

# Service Management Based on Pacemaker

## Cluster Resource Management Through Pacemaker

- Manage VIPs (Virtual IPs) and key services with Pacemaker to automate failure recovery between nodes
- Pacemaker monitors service status in real-time, switches the primary node, and reallocates services when anomalies occur
- Ensure uninterrupted service access by alternately binding VIPs on each node

## Service Failover in Case of Failure

- Configure key services like Glance and Keystone to automatically perform failover when a failure occurs
- Ensure data integrity by configuring services to start after data is ready in conjunction with DRBD and HAFS

# Load Balancing with HAProxy

## Load Balancing and Routing Configuration

- Distribute load within the cluster by routing key services like Nova, Glance, and Neutron through HAProxy
- HAProxy operates bound to VIP-10G, routing service requests to each node to prevent traffic collisions between services
- Services operate in a mixed mode of Active-Active and Active-Standby, continuously managing service status in conjunction with Pacemaker

## Service-Specific Settings

- Nova and Neutron utilize service discovery functions to forward requests to nodes registered via VIP
- Glance operates in an active state only on a single node through VIP and HAProxy, maintaining the load-balancing structure even during failover

# Network Segmentation Using VIP

## Separation of Roles Between 1G and 10G Networks

- External-facing services like the Horizon dashboard are served through the 1G network, while services where internal data flow is critical, like Glance, Nova, and Neutron, are configured to use the 10G network
- Utilize VIPs to appropriately segregate internal and external traffic, preventing network collisions and optimizing network bandwidth usage

## Network Binding per Service

- Configure each service's VIP through Apache2 and HAProxy to ensure traffic is delivered over the appropriate network
- Specifically, Nova and Neutron handle data transmission optimized for the 10G network, maximizing performance for data-intensive tasks

# Differentiated Application of Service Availability

## Differentiation Between Educational Research Services and Critical Services

- Operate educational and research services used temporarily with basic availability settings, while providing high stability to critical services requiring long-term operation by applying DRBD and Pacemaker
- For example, Glance and Keystone run only on one node based on HAFS and DRBD, supporting automatic failover through Pacemaker in case of failures

## Optimizing HA Configuration per Service

- Operate some services like Neutron and Nova in Active-Active mode to enhance availability and scalability
- For critical services, apply an Active-Standby method to maintain data integrity and enable stable operation on a single node

# Ensuring Cost Efficiency

## Utilizing NVMe Storage and DRBD

- Configure NVMe-based storage with DRBD to provide both data replication and storage performance
- Increase cost efficiency by using open-source technologies instead of expensive storage solutions from commercial clouds

## Designing an Open-Source-Based OpenStack Infrastructure

- Utilize various services of OpenStack to provide functionality and availability at commercial cloud levels while reducing operating costs with self-managed infrastructure
- Considering the characteristics of educational institutions, maximize the use of existing hardware to reduce new investment costs and ensure maintainability and scalability

# Short Summary

This document outlines the need for stable and highly available cloud infrastructure in university education environments and presents objectives and technical strategies to achieve this. By leveraging open-source technologies like DRBD, Pacemaker, and OpenStack, the goal is to build a cost-effective, high-availability infrastructure that replaces the high costs of commercial cloud services.

Key strategies include:

- **Storage Mirroring with DRBD and HAFS**: Real-time data replication using DRBD and stable data storage with HAFS.
- **Service Management with Pacemaker**: Automated failover and service reallocation using Pacemaker.
- **Load Balancing with HAProxy**: Distributing load across the cluster and preventing traffic collisions.
- **Network Segmentation Using VIP**: Separating internal and external network traffic to optimize performance.
- **Differentiated Service Availability**: Applying high-availability strategies based on service importance.
- **Cost Efficiency**: Using open-source technologies and existing hardware to reduce costs while maintaining high performance and scalability.

Overall, the document provides a detailed plan to build a highly available, cost-effective cloud infrastructure optimized for educational and research environments.
