
---

---

## **Introduction**

This worksheet supports **Unit 10: Kubernetes & K3s**, where we explore **container orchestration, deploying applications, and troubleshooting Kubernetes clusters**. Use this worksheet to track your progress, **document findings**, and **engage in discussions**.

### **Resources / Important Links**

- [Kubernetes Overview](https://kubernetes.io/docs/concepts/overview/)
- [K3s Official Documentation](https://k3s.io/)
- [Kubernetes Security Best Practices](https://kubernetes.io/docs/concepts/security/)
- [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
- [Interactive Kubernetes Labs](https://killercoda.com/)

---

## **Instructions**

This worksheet is designed to **track your learning progress** and **guide you through the lab and discussions**. Fill out each section as you complete the exercises.

---

## **Discussion Questions**

### **Discussion Post #1**

📖 Read: [Kubernetes Overview](https://kubernetes.io/docs/concepts/overview/)

1. **What are the two most compelling reasons to implement Kubernetes in your organization?**
    
    - _Answer:_
2. **The article states that Kubernetes is not a PaaS. What does that mean? How does Kubernetes compare to a traditional PaaS?**
    
    - _Answer:_

---

### **Discussion Post #2**

📌 **Scenario:** Your team is troubleshooting a Kubernetes cluster where applications are failing to deploy. They send you the following output:

```sh
[root@Test_Cluster1 ~]# kubectl version
Client Version: v1.31.6+k3s3
Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
Server Version: v1.30.6+k3s1

[root@rocky15 ~]# kubectl get nodes
NAME            STATUS      ROLES                  AGE   VERSION
Test_Cluster1   Ready       control-plane,master   17h   v1.30.6+k3s1
Test_Cluster2   NotReady    worker                 33m   v1.29.6+k3s1
Test_Cluster3   Ready       worker                 17h   v1.28.6+k3s1
```

1. **How would you validate the error?**
    
    - _Answer:_
2. **What do you suspect is causing the problem?**
    
    - _Answer:_
3. **Has someone already attempted to fix this problem? Why or why not?**
    
    - _Answer:_

---

### **Discussion Post #3**

📌 **Scenario:** You are the **Network Operations Center (NOC) lead**, and your team is responsible for monitoring **development, test, and QA Kubernetes clusters**.

**Write a basic cluster health check procedure for new NOC personnel.**

1. **What online resources did you use to figure this out?**
    
    - _Answer:_
2. **What did you learn during this process?**
    
    - _Answer:_

---

## **Key Terminology & Definitions**

Define the following Kubernetes terms:

- **Kubernetes/K8s:**
    - _Answer:_
- **K3s:**
    - _Answer:_
- **Control Plane:**
    - _Answer:_
- **Node:**
    - _Answer:_
- **Pod:**
    - _Answer:_
- **Deployment:**
    - _Answer:_
- **Service:**
    - _Answer:_
- **ETCD:**
    - _Answer:_
- **Kubelet:**
    - _Answer:_
- **Kube-proxy:**
    - _Answer:_
- **Scheduler:**
    - _Answer:_
- **API Server:**
    - _Answer:_

---

## **Lab Notes & Observations**

### **Lab 1: Installing K3s**

✅ **Tasks:**

1. Install K3s:
    
    ```sh
    curl -sfL https://get.k3s.io | sh -
    ```
    
2. Verify the installation:
    
    ```sh
    systemctl status k3s
    systemctl is-enabled k3s
    ```
    
3. Check systemd configuration:
    
    ```sh
    systemctl cat k3s
    ```
    

📌 **Observations:**

- _What files were installed?_
- _Did the installation complete successfully?_
- _What startup services are configured?_

---

### **Lab 2: Deploying Applications**

✅ **Tasks:**

1. Deploy an Nginx web server:
    
    ```sh
    kubectl run webpage --image=nginx
    ```
    
2. Deploy a Redis database:
    
    ```sh
    kubectl run database --image=redis --labels=tier=database
    ```
    
3. Expose the Redis database:
    
    ```sh
    kubectl expose pod database --port=6379 --name=redis-service --type=ClusterIP
    ```
    
4. Create a deployment with multiple replicas:
    
    ```sh
    kubectl create deployment web-deployment --image=nginx --replicas=3
    ```
    

📌 **Observations:**

- _Did all pods deploy successfully?_
- _If not, what errors did you encounter?_
- _What does `kubectl describe pod <name>` show?_

---

### **Lab 3: Debugging Kubernetes Clusters**

📌 **Scenario:** Your Kubernetes cluster is experiencing issues. Here is the current node status:

```sh
[root@Test_Cluster1 ~]# kubectl get nodes
NAME            STATUS      ROLES                AGE     VERSION
Test_Cluster1   Ready       control-plane,master 17h     v1.30.6+k3s1
Test_Cluster2   NotReady    worker               33m     v1.29.6+k3s1
Test_Cluster3   Ready       worker               17h     v1.28.6+k3s1
```

✅ **Troubleshooting Steps:**

1. **Check node status:**
    
    ```sh
    kubectl describe node Test_Cluster2
    kubectl get pods -A
    ```
    
2. **Investigate logs and service failures:**
    
    ```sh
    journalctl -xeu k3s
    systemctl status k3s
    ```
    

📌 **Findings & Fixes:**

- _What was the root cause of the failure?_
- _What steps resolved the issue?_

---

## **Digging Deeper**

1. **Build a custom container** and deploy it in Kubernetes securely.
2. **Read about container security:**
    - [Docker Security Best Practices](https://docs.docker.com/build/building/best-practices/)
    - [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
3. **Complete this Kubernetes security lab:**
    - [KillerShell Kubernetes Security](https://killercoda.com/killer-shell-cks/scenario/static-manual-analysis-k8s)

---

## **Reflection Questions**

1. **What questions do you still have about Kubernetes?**
    
    - _Answer:_
2. **How can you apply this knowledge in your current IT role?**
    
    - _Answer:_
3. **If you’re not in IT, how could this experience contribute to your resume or portfolio?**
    
    - _Answer:_

---

## **Additional Resources**

- [Kubernetes Documentation](https://kubernetes.io/docs/concepts/overview/)
- [Interactive Kubernetes Labs](https://killercoda.com/)
- [Docker Best Practices](https://docs.docker.com/build/building/best-practices/)
- [Kubernetes Troubleshooting Guide](https://kubernetes.io/docs/tasks/debug/)

---

