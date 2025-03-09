# Unit 10: Introduction to Kubernetes

## Overview

### What is the skill/tech/concept we are dealing with?

This unit introduces **Kubernetes (K8s)**, an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications. The unit covers:

- **Understanding Kubernetes Architecture** – Nodes, Control Plane, and Cluster Components.
- **Installing K3s** – A lightweight Kubernetes distribution optimized for resource efficiency.
- **Interacting with Kubernetes** – Using `kubectl` to manage and troubleshoot clusters.
- **Deploying Applications** – Creating and managing **Pods, Deployments, and Services**.
- **Security and Best Practices** – Implementing security measures and troubleshooting issues.

Kubernetes plays a critical role in **modern enterprise infrastructure**, enabling **scalability, high availability, and automation** in cloud-native applications.

---

## Learning Objectives

By the end of this unit, learners will:

1. **Understand the Core Concepts of Kubernetes:**
    
    - Define Kubernetes and explain its role in container orchestration.
    - Differentiate between **Kubernetes vs. PaaS (Platform as a Service)**.
2. **Deploy and Manage Kubernetes Clusters:**
    
    - Install **K3s** and verify its functionality.
    - Manage cluster resources using `kubectl`.
3. **Perform Basic Kubernetes Operations:**
    
    - Create and manage **Pods, Deployments, and Services**.
    - Understand the role of **Namespaces, ConfigMaps, and Secrets**.
4. **Troubleshoot Kubernetes Clusters:**
    
    - Identify common cluster issues and validate node status.
    - Diagnose networking and pod scheduling problems.
5. **Apply Security Best Practices in Kubernetes:**
    
    - Secure containerized applications using best practices.
    - Implement **Kubernetes Pod Security Standards**.

---

## Relevance & Context

### Why is Kubernetes important to Linux Administrators/Engineers?

Kubernetes is a **foundational technology in modern DevOps and cloud computing**. Understanding it is critical for system administrators, DevOps engineers, and site reliability engineers (SREs) for several reasons:

- **Scalability & Automation** – Automates containerized application deployments, scaling, and management.
- **Resource Efficiency** – Optimizes workload distribution across multiple nodes.
- **Infrastructure as Code (IaC)** – Kubernetes configurations can be defined declaratively using YAML.
- **Cross-Cloud Compatibility** – Supports deployment across on-premises, hybrid, and multi-cloud environments.
- **High Availability & Self-Healing** – Detects and replaces failed instances automatically.

---

## Prerequisites

Before beginning this unit, learners should have:

- A working knowledge of **Linux system administration**.
- Experience using the **command line (`bash`, `ssh`, `vim`)**.
- Familiarity with **containers** and tools like Docker.
- Basic **networking knowledge**, including IP addressing and port management.

---

## Key Terms and Definitions

- **Kubernetes (K8s):** An open-source system for managing containerized applications across multiple hosts.
- **K3s:** A lightweight Kubernetes distribution designed for resource-constrained environments.
- **Control Plane:** The central component that manages Kubernetes nodes and orchestrates workloads.
- **Nodes:** Worker machines in a Kubernetes cluster that run containerized applications.
- **Pods:** The smallest deployable unit in Kubernetes, containing one or more containers.
- **Deployments:** Manage and scale applications across multiple replicas.
- **Services:** Enable network access to a set of Pods, abstracting their internal IPs.
- **Kubelet:** An agent running on each node that ensures containers are running as expected.
- **Scheduler:** Assigns workloads to appropriate nodes.
- **ETCD:** A key-value store that maintains cluster configuration data.
- **Kube-proxy:** Manages network communication between nodes.
- **Static Pod:** A manually defined Pod that runs directly on a node without being managed by the API Server.

---

## Exercises and Lab Work

### **Warmup Exercises**

1. Download and inspect the K3s installer:
    
    ```sh
    curl -sfL https://get.k3s.io > /tmp/k3_installer.sh
    more /tmp/k3_installer.sh
    ```
    
    - What system checks does the installer perform?
    - How does it determine the system architecture?
2. Verify system compatibility:
    
    ```sh
    uname -m
    grep -iE “selinux|sestatus” /tmp/k3_installer.sh
    ```
    
    - Does K3s check for SELinux status?

---

### **Lab 1: Installing and Configuring K3s**

1. Install K3s:
    
    ```sh
    curl -sfL https://get.k3s.io | sh -
    ```
    
2. Verify installation:
    
    ```sh
    systemctl status k3s
    systemctl is-enabled k3s
    ```
    
3. Inspect systemd service configuration:
    
    ```sh
    systemctl cat k3s
    ```
    
4. Validate Kubernetes API accessibility:
    
    ```sh
    kubectl get nodes
    ```
    
    - What output do you see? Is the control plane functioning properly?

---

### **Lab 2: Deploying Applications in Kubernetes**

1. Create a simple **web server pod** using Nginx:
    
    ```sh
    kubectl run webpage --image=nginx
    ```
    
2. Deploy a **Redis database pod** with labels:
    
    ```sh
    kubectl run database --image=redis --labels=tier=database
    ```
    
3. Create a **service** to expose the Redis database:
    
    ```sh
    kubectl expose pod database --port=6379 --name=redis-service --type=ClusterIP
    ```
    
4. Create a **replicated web deployment**:
    
    ```sh
    kubectl create deployment web-deployment --image=nginx --replicas=3
    ```
    
5. Verify deployments:
    
    ```sh
    kubectl get deployments
    kubectl get pods
    ```
    

---

### **Lab 3: Debugging and Troubleshooting a Kubernetes Cluster**

#### **Scenario: Application Deployment Failing**

A team reports an issue with their Kubernetes test cluster. Here is the current node status:

```sh
[root@Test_Cluster1 ~]# kubectl get nodes
NAME            STATUS      ROLES                AGE     VERSION
Test_Cluster1   Ready       control-plane,master 17h     v1.30.6+k3s1
Test_Cluster2   NotReady    worker               33m     v1.29.6+k3s1
Test_Cluster3   Ready       worker               17h     v1.28.6+k3s1
```

#### **Tasks**

1. **Validate errors:** Run `kubectl describe node Test_Cluster2` and `kubectl get pods -A` to check failures.
2. **Possible causes:**
    - Version mismatch between the worker node and control plane.
    - Insufficient system resources (CPU, RAM).
    - Network connectivity issues.
    - Kubelet service failure.
3. **Troubleshoot solutions:**
    - Restart the node or update the K3s installation.
    - Check logs: `journalctl -xeu k3s`
    - Verify network settings: `kubectl get services -A`

---

### **Discussion & Reflection**

#### **Discussion Post 1:**

- What are two key benefits of implementing Kubernetes in your organization?
- Why is Kubernetes **not** considered a Platform-as-a-Service (PaaS)?

#### **Discussion Post 2:**

- How do you investigate and troubleshoot cluster issues?
- How do you determine if someone else has attempted a fix?

#### **Discussion Post 3:**

- As an **NOC lead**, outline a **basic Kubernetes cluster health check** procedure.

---

## Additional Resources

- [Kubernetes Overview](https://kubernetes.io/docs/concepts/overview/)
- [Docker Security Best Practices](https://docs.docker.com/build/building/best-practices/)
- [Kubernetes Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
- [Interactive Kubernetes Security Lab](https://killercoda.com/killer-shell-cks/scenario/static-manual-analysis-k8s)

---

