<head>
    <style> .flex-container { display: flex; align-items: center; gap: 20px; } </style>
</head>
<div class="flex-container">
        <img src="https://github.com/ProfessionalLinuxUsersGroup/img/blob/main/Assets/Logos/ProLUG_Round_Transparent_LOGO.png?raw=true" width="64" height="64">
    <p>
        <h1>Unit 7 Lab</h1>
    </p>
</div>

## Introduction

---

The Unit 7 Lab has students exploring and practicing the lessons they learned
from the unit recording and worksheet. This lab explores managing packages through the Red Hat
Enterprise Linux (RHEL) package manager front end [DNF (Dandified YUM)](<https://en.wikipedia.org/wiki/DNF_(software)>).

### Resources / Important Links

- [Rocky Documentation](https://docs.rockylinux.org/)
- [Rocky DNF Guidance](https://docs.rockylinux.org/guides/package_management/dnf_package_manager/)
- [Rocky Repository Guidance](https://wiki.rockylinux.org/rocky/repo/)

## Required Materials

---

Rocky 9.3 – ProLUG Lab

Root or sudo command access

## Part 1: Pre-Lab Warm-Up

---

```bash
cd ~
rpm -qa | more
rpm -qa | wc -l
# pick any <name of package> from the above list

rpm -qi {name of package}
rpm -qa | grep -i imagemagick

dnf install imagemagick

# What is the error here? Read it
dnf install ImageMagick

# What are some of the dependencies here? Look up the urw-base35
# and see what functionality that adds.
rpm -qa | grep -i imagemagick

# Why did this work when the other one didn’t with dnf?
```

### 1.1: Math Practice

Some fun with the command line and basic scripting tools. I want you
to see some of the capabilities. That are available to you. Your system
can do a lot of basic arithmetic for you and this is a very small set of
examples.

```bash
# Check to see if you have bc tool.
rpm –q bc

#Install it if you need to
dnf install bc

for i in 'seq 1 5'; do free | grep -i mem | awk '{print $3}'; done

# Collect the 5 numbers (what do these numbers represent? Use free to find out)
echo "(79 + 79 + 80 + 80 + 45) / 5" | bc

# Your numbers will vary. Is this effective? Is it precise enough?
echo "(79 + 79 + 80 + 80 + 45) / 5" | bc -l
# Is this precise enough for you?

# Read the man to see what the -l option does to bc
man bc
```

It would be astute to point out that I did not have you do bash arithmetic. There
is a major limitation of using bash for that purpose in that it only wants to deal
with integers (whole numbers) and you will struggle to represent statistical data
with precision. There are very useful tools though, and I would highly encourage
you to examine them. <http://tldp.org/LDP/abs/html/arithexp.html>

## Part 2: Lab 🧪

---

Log into your Rocky server and become root.

### 2.1: RPM

RPM is the Redhat package manager. It is a powerful tool to see what is installed
on your system and to see what dependencies exist with different software packages.
This is a toolset that was born of the frustration of “dependency nightmare” where
system admins used to compile from source code only to find they had dependencies.
RPM helps to deconflict and save huge amounts of time and engineering headaches.

Run through these commands and read `man rpm` to see what they do.

```bash
# Read about the capabilities of systemd
rpm -qi systemd

# query the package given
rpm -q systemd

# query all packages on the system (is better used with | more or | grep)
rpm –qa

#for example shows all kernels and kernel tools
rpm -qa | grep -i kernel

# List out files, but only show the configuration files
rpm -qc systemd

# What good information do you see here? Why might it be good to know
# that some piece of software was installed last night, if there is now
# a problem with the system starting last night?
rpm -qi systemd

# Will list all the files in the package. Why might this be useful to you to know?
rpm -ql systemd

# List capabilities on which this package depends
rpm -qR systemd

# Probably going to scroll too fast to read. This output is in reverse order.
rpm -q -changelog systemd

# So let’s make it useful with this command
rpm -q -changelog systemd | more

# What are some of the oldest entries?
# What is the most recent entry?
# Is there a newer version of systemd for you to use?

# If there isn’t don’t worry about it.
dnf update systemd
```

Use `rpm -qa | more` to find 3 other interesting packages and perform
`rpm -qi <package>` on them to see information about them.

### 2.2: DNF

Yum comes from a long decrepit version of Linux called Yellow dog. It is
originally the Yellowdog Update Manager. It has a very interesting history
surrounding the PS3, but that and other nostalgia can be found here:
<https://en.wikipedia.org/wiki/Yellow_Dog_Linux> if you’re interested. We’re
going to use it to update our system. RHEL and CentOS systems look to repositories
of software for installation and updates. We have a base set of them provided with
the system, supported by the vendor or open source communities, but we can also
create our own from file systems or web pages. We’ll be mostly dealing with the
defaults and how to enable or disable them, but there are many configurations that
can be made to customize software deployment.

```bash
# Checking how dnf is configured and seeing it’s available repositories
cat /etc/dnf/dnf.conf

# has some interesting information about what is or isn’t going to be checked.
# You can include a line here called exclude= to remove packages from installation
# by name. Where a repo conflicts with this, this takes precedence.
dnf repolist
dnf history

# Checking where repos are stored and what they look like
ls /etc/yum.repos.d/

# Repos are still stored in /etc/yum.repos.d
cat /etc/yum.repos.d/rocky.repo
```

The mirror list system uses the connecting IP address of the client and the
update status of each mirror to pick current mirrors that are geographically
close to the client. You should use this for Rocky updates unless you are
manually picking other mirrors.

If the mirrorlist does not work for you, you can try the commented out
baseurl line instead.

```bash
[baseos]
name=Rocky Linux $releasever - BaseOS
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=BaseOS-$releasever$rltype
#baseurl=http://dl.rockylinux.org/$contentdir/$releasever/BaseOS/$basearch/os/
gpgcheck=1
enabled=1
countme=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-9
#Output truncated for brevity’s sake….
```

Something you’ll find out in the next section looking at repos is that when they
are properly defined they are enabled by default. enabled=1 is implied and doesn’t
need to exist when you create a repo.

```bash
# Let’s disable a repo and see if the output changes at all
dnf config-manager --disable baseos

# Should now have the line enabled=0 (or false, turned off)
cat /etc/yum.repos.d/rocky.repo

[baseos]
name=Rocky Linux $releasever - BaseOS
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=BaseOS-$releasever$rltype
# baseurl=http://dl.rockylinux.org/$contentdir/$releasever/BaseOS/$basearch/os/
gpgcheck=1
enabled=0
countme=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-9
# Output truncated for brevity’s sake….

# Re-enable the repo and verify the output
dnf config-manager --enable base

# Should now have the line enabled=1 (or true, turned back on)
cat /etc/yum.repos.d/rocky.repo

# Output:
[baseos]
name=Rocky Linux $releasever - BaseOS
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=BaseOS-$releasever$rltype
#baseurl=http://dl.rockylinux.org/$contentdir/$releasever/BaseOS/$basearch/os/
gpgcheck=1
enabled=1
countme=1
metadata_expire=6h
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-9
# Output truncated for brevity’s sake….
```

### Part 2.3: Installing software you were asked by an application team

So someone has asked for some software and assured you it’s been tested in
similar environments, so you go to install it on their system for them.

```bash
# See if we already have a version.
rpm –qa mariadb

# See if dnf knows about it
dnf search mariadb
dnf search all mariadb

# What is DNF showing you? What are the differences between these commands based on the output?

# Try to install it
dnf install mariadb
# hit “N”

# Make note of any dependencies that are added on top of mariadb (there’s at least one)
# What does DNF do with the transaction when you cancel it? Can you compare this
# to what you might have used before with YUM? How are they different?
# (You can look it up if you don’t know.)

# Ok, install it
dnf -y install mariadb

# Will just assume yes to everything you say.
# You can also set this option in /etc/dnf/dnf.conf to always assume yes,
# it’s just safer in an enterprise environment to be explicit.
```

### Part 2.4: Removing packages with dnf

Surprise, the user calls back because that install has made the system unstable.
They are asking for you to remove it and make the system back to the recent version.

```bash
dnf remove mariadb
# hit “N”

# this removes mariadb from your system
dnf –y remove mariadb

# But did this remove those dependencies from earlier?
rpm –q {dependency}
rpm –qi {dependency}

# How are you going to remove that if it’s still there?
# Checking where something came from. What package provides something in your system

# One of the most useful commands dnf provides is the ability to know “what provides”
# something. Sar and iostat are powerful tools for monitoring your system.
# Let’s see how we get them or where they came from, if we already have them.
# Maybe we need to see about a new version to work witha new tool.
dnf whatprovides iostat
dnf whatprovides sar

# Try it on some other tools that you regularly use to see where they come from.
dnf whatprovides systemd
dnf whatprovides ls
dnf whatprovides python

# Using Dnf to update your system or individual packages
# Check for how many packages need update
dnf update

# How many packages are going to update?
# Is one of them the kernel?
# What is the size in MB that is needed?
# Hit “N”

# Your system would have stored those in /var/cache/dnf
# Let’s check to see if we have enough space to hold those
df -h /var/cache/dnf

# Is there more free space than there is needed size in MB from earlier?
# There probably is, but this becomes an issue. You’d be surprised.

# Let’s see how that changes if we exclude the kernel
dnf update --exclude=kernel

# How many packages are going to update?
# Is one of them the kernel?
# What is the size in MB that is needed?
# Hit “N”
```

You can update your system if you like. You’d have to reboot for your
system to take the new kernel. If you do that you can then redo the grubby
portion and the ls /boot/ will show the new installed kernel, unless you excluded it.

### Part 2.5: Using dnf to install group packages

Maybe we don’t even know what we need to get a project going. We know that
we need to have a web server running but we don’t have an expert around to
tell us everything that may help to make that stable. We can scour the interwebs
(our normal job) but we also have a tool that will give us the base install needed
for RHEL or CentOS to run that server.

```bash
dnf grouplist
dnf group install “Development Tools”

# How many packages are going to update?
# Is one of them the kernel?
# What is the size in MB that is needed?
# Hit “N”
# Do you see a pattern forming?
```

If you install this you’re going to have developer tools installed on the server
but they won’t be configured. How would you figure out what tools and versions were
just installed? How might you report this for your own documentation and to a
security team that keeps your security baselines?
