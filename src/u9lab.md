<div class="flex-container">
        <img src="https://github.com/ProfessionalLinuxUsersGroup/img/blob/main/Assets/Logos/ProLUG_Round_Transparent_LOGO.png?raw=true" width="64" height="64"></img>
    <p>
        <h1>Unit 9 Lab - Containerization on Linux</h1>
    </p>
</div>

> If you are unable to finish the lab in the ProLUG lab environment we ask you `reboot`
> the machine from the command line so that other students will have the intended environment.

### Resources / Important Links

- [Killercoda Labs](https://killercoda.com/learn)
- [https://podman.io/docs](https://podman.io/docs)
- [https://docs.docker.com/build/concepts/dockerfile/](https://docs.docker.com/build/concepts/dockerfile/)
- [https://docs.podman.io/en/latest/markdown/podman-exec.1.html](https://docs.podman.io/en/latest/markdown/podman-exec.1.html)

### Required Materials

- Rocky 9.4+ - ProLUG Lab
  - Or comparable Linux box
- root or sudo command access

#### Downloads

The lab has been provided for convenience below:

- <a href="./assets/downloads/u9/u9_lab.pdf" target="_blank" download>📥 u9_lab(`.pdf`)</a>
- <a href="./assets/downloads/u9/u9_lab.docx" target="_blank" download>📥 u9_lab(`.docx`)</a>

## Pre-Lab Warmup

---

1. `which podman`

2. `dnf whatprovides podman`

3. `rpm -qi podman`  
   When was this installed?  
   What version is it?  
   Why might this be important to know?

4. `podman images`

5. `podman ps`  
   What do you learn from those two commands?  
   Why might it be important to know on a system?

## Lab 🧪

---

### Building and running containers

Your tasks in this lab are designed to get you thinking about how container
deployments interact with our Linux systems that we support.

1. Pull and run a container

```bash
podman run -dt -p 8080:80/tcp docker.io/library/httpd
```

What do you see on your screen as this happens?

2. Check your images again (from your earlier exercises)

```bash
podman images
```

Is there a new image, and if so, what do you notice about it?

3. Check your podman running containers

```bash
podman ps
```

What appears to be happening? Can you validate this with your Linux knowledge?

```bash
ss -ntulp
curl 127.0.0.1:8080
```

4. Inspect the running pod

```bash
podman inspect -l
```

What format is the output in?  
What important information might you want from this in the future?

```bash
podman logs -l
```

What info do you see in the logs?  
Do you see your connection attempt from earlier? What is the return code and
why is that important for troubleshooting?

```bash
podman top -l
```

What processes is the pod running?  
What other useful information might you find here?  
Why might it be good to know the user being run within the pod?

5. Stop the pod by its name

```bash
podman stop <podname>
```

Can you verify it is stopped from your previous commands?

```bash
podman ps
ss -ntulp
curl 127.0.0.1:8080
```

Does the container still exist? Why might you want to know this?

```bash
podman image
```

### Build an application in a container

The ProLUG lab will already have a version of this setup for you to copy and run.
If you are in a different environment, follow https://docs.docker.com/build/concepts/dockerfile/
for the general same steps.

1. Setup your lab environment

```bash
[root@rocky11 stream]# cd /lab_work/
[root@rocky11 lab_work]# ls
[root@rocky11 lab_work]# mkdir scott_lab9
[root@rocky11 lab_work]# cd scott_lab9/
[root@rocky11 scott_lab9]# ls
[root@rocky11 scott_lab9]# cp /labs/lab9.tar.gz .
[root@rocky11 scott_lab9]# tar -xzvf lab9.tar.gz
lab9/
lab9/Dockerfile
lab9/hello.py
[root@rocky11 scott_lab9]# ls
lab9 lab9.tar.gz
[root@rocky11 scott_lab9]# cd lab9
[root@rocky11 lab9]# pwd
/lab_work/scott_lab9/lab9
[root@rocky11 lab9]# ls
Dockerfile hello.py
```

2. Create a docker image from the docker file:

```bash
time podman build -t scott_hello .
#Use your name
```

What output to your screen do you see as you build this?  
Approximately how long did it take?

If this breaks in the lab, how might you fix it? What do you suspect?

3. Verify that you have built the container

```bash
podman images
```

4. Run the container as a daemon

```bash
podman run -dt localhost/scott_example
```

5. Verify the name and that it is running

```bash
podman ps
```

6. Exec into the pod and see that you are on the Ubuntu container

```bash
podman exec -it festive_pascal sh
cat /etc/*release
exit
```

### Conclusion

There are a lot of ways to use these tools. There are a lot of ways you will support them.
At the end of the day you're a Linux System Administrator, you're expected to understand
everything that goes on in your system. To this end, we want to know the build process and
run processes so we can help the engineers we support keep working in a Linux environment.

> Be sure to `reboot` the lab machine from the command line when you are done.
