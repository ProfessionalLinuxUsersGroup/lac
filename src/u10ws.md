<div class="flex-container">
        <img src="https://github.com/ProfessionalLinuxUsersGroup/img/blob/main/Assets/Logos/ProLUG_Round_Transparent_LOGO.png?raw=true" width="64" height="64"></img>
    <p>
        <h1>Unit 10 Worksheet - Kubernetes</h1>
    </p>
</div>

## Instructions

---

Fill out the worksheet as you progress through the lab and discussions.
Hold your worksheets until the end to turn them in as a final submission packet.

### Resources / Important Links

- [Kubernetes Overview](https://kubernetes.io/docs/concepts/overview/)
- [K3s Official Documentation](https://k3s.io/)
- [Kubernetes Security Best Practices](https://kubernetes.io/docs/concepts/security/)
- [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
- [Interactive Kubernetes Labs](https://killercoda.com/)

#### Downloads

The worksheet has been provided below. The document(s) can be transposed to
the desired format so long as the content is preserved. For example, the `.txt`
could be transposed to a `.md` file.

- <a href="./assets/downloads/u10/u10_worksheet.txt" target="_blank" download>📥 u10_worksheet(`.txt`)</a>
- <a href="./assets/downloads/u10/u10_worksheet.docx" target="_blank" download>📥 u10_worksheet(`.docx`)</a>

### Unit 10 Recording

<iframe
    style="width: 100%; height: 100%; border: none;
    aspect-ratio: 16/9; border-radius: 1rem; background:black"
    src="https://www.youtube.com/embed/KycsHfZoAQs"
    title="Unit 10 Recording - ProLUG Linux Systems Administration Course - Free in Discord"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    referrerpolicy="strict-origin-when-cross-origin"
    allowfullscreen>
</iframe>

#### Discussion Post #1

Read: [Kubernetes Overview](https://kubernetes.io/docs/concepts/overview/)

1. What are the two most compelling reasons to implement Kubernetes in your organization?

2. The article states that Kubernetes is not a PaaS. What does that mean? How does Kubernetes compare to a traditional PaaS?

#### Discussion Post #2

Scenario:

<blockquote>

Your team is troubleshooting a Kubernetes cluster where applications are failing to deploy. They send you the following output:

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

</blockquote>

1. How would you validate the error?

2. What do you suspect is causing the problem?

3. Has someone already attempted to fix this problem? Why or why not?

### Discussion Post #3

Scenario:

<blockquote>

You are the Network Operations Center (NOC) lead, and your team is responsible
for monitoring development, test, and QA Kubernetes clusters.

</blockquote>

Write a basic cluster health check procedure for new NOC personnel.

1. What online resources did you use to figure this out?

2. What did you learn during this process?

<div class="warning">
Submit your input by following the link below.

The discussion posts are done in Discord threads. Click the 'Threads' icon on the top right and search for the discussion post.

</div>

- [Link to Discussion Posts](https://discord.com/channels/611027490848374811/1365776270800977962)

## Key Terminology & Definitions

---

Define the following Kubernetes terms:

- Kubernetes/K8s:

- K3s:

- Control Plane:

- Node:

- Pod:

- Deployment:

- Service:

- ETCD:

- Kubelet:

- Kube-proxy:

- Scheduler:

- API Server:

### Lab and Assignment

Unit 10 Lab k3s

Continue working on your project from the Project Guide

Topics:

1.  System Stability
2.  System Performance
3.  System Security
4.  System monitoring
5.  Kubernetes
6.  Programming/Automation
    You will research, design, deploy, and document a system that improves your administration of Linux systems in some way.

## Digging Deeper

---

1. Build a custom container and deploy it in Kubernetes securely.

2. Read about container security:
   - [Docker Security Best Practices](https://docs.docker.com/build/building/best-practices/)
   - [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)

3. Complete this Kubernetes security lab:
   - [KillerShell Kubernetes Security](https://killercoda.com/killer-shell-cks/scenario/static-manual-analysis-k8s)

## Reflection Questions

---

1. What questions do you still have about Kubernetes?

2. How can you apply this knowledge in your current IT role?

3. If you’re not in IT, how could this experience contribute to your resume or portfolio?
