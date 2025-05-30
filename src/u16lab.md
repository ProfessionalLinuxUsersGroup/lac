<div class="flex-container">
        <img src="https://github.com/ProfessionalLinuxUsersGroup/img/blob/main/Assets/Logos/ProLUG_Round_Transparent_LOGO.png?raw=true" width="64" height="64"></img>
    <p>
        <h1>Unit 16 Lab - Incident Response</h1>
    </p>
</div>

> If you are unable to finish the lab in the ProLUG lab environment we ask you `reboot`
> the machine from the command line so that other students will have the intended environment.

### Resources / Important Links

### Required Materials

- Rocky 9.4+ - ProLUG Lab
  - Or comparable Linux box
- root or sudo command access

#### Downloads

The lab has been provided for convenience below:

- <a href="./assets/downloads/u16/u16_lab.pdf" target="_blank" download>📥 u16_lab(`.pdf`)</a>
- <a href="./assets/downloads/u16/u16_lab.txt" target="_blank" download>📥 u16_lab(`.txt`)</a>
- <a href="./assets/downloads/u16/u16_lab.docx" target="_blank" download>📥 u16_lab(`.docx`)</a>

> Be sure to `reboot` the lab machine from the command line when you are done.

---

## LAB

You have the answers here, if they ask, you may give them hints. Otherwise, you can help them find the
right solution any way you want to.

---

### Scenario 1:

- Connect to `tshoot1@prolug.asuscomm.com`
- Password:

A ticket has come in that the web server is not running on the web server.
To complete this event the following three must be correct.
Web server must be running.

- HINT:
  ```bash
  systemctl status httpd
  ```

<!-- - Answer: -->
<!--   ```bash -->
<!--   systemctl enable --now httpd # or some variation of that must have been run -->
<!--   ``` -->

Web server must respond on port 80.

- HINT: Can you check the open ports?

<!-- - Answer: -->
<!--   ```bash -->
<!--   ss -ntulp  # Will show port 80 -->
<!--   ``` -->

The server is currently set on `8087` and needs to be fixed in `/etc/httpd/conf/http.conf`.  
The "Listen 8087" line must be changed to "Listen 80" and the service restarted `systemctl restart httpd`.

Ensure that the server can be reached by external connection attempts on port 80.

- HINT: Is the firewall running?
  ```bash
  systemctl status firewalld
  ```

<!-- - Answer: Easiest is to turn off the firewall. -->
<!--   ```bash -->
<!--   systemctl stop firewalld. -->
<!--   ``` -->
<!--   - If they want to open the port, they can do that too. -->

<div class="warning">
**Reboot the lab machine when finished.**
</div>

---

### Scenario 2:

- Connect to `tshoot2@prolug.asuscomm.com`
- Password:

A ticket has come in that a mount point /space is not working correctly. The team expected a
9GB partition to be built there on the 3 attached disks, but found that it was not a separate
partition.
Verify that `/space` is not set up correctly.

To complete this event the following two must be correct.

- HINT: They may want to revisit lab 3 of the course for this one. This is a challenge here.

  - The three disks must be properly set up in LVM.

- HINT: use your pvs, vgs, lvs tools

<!-- - Answer: -->
<!--   - First identify all disks: `fdisk -l | grep -i xvd`. Then `pvcreate /dev/xvd<whatever>`. -->
<!--   - Then `vgcreate space /dev/xvd<disk1> /dev/xvd<disk2> /dev/xvd<disk3>`. -->
<!--   - Then `lvcreate -n space -l +100%FREE space_vg` -->

EXT4 or XFS must be installed on the logical volume.

- HINT: use `mkfs` to make a filesystem.

<!-- - Answer: -->
<!--   ```bash -->
<!--   mkfs.ext4 /dev/mapper/<name of logical volume> -->
<!--   ``` -->

`/space` must be created and mounted off on this filesystem.

- Hint: Make the directory

<!-- - Answer: -->
<!--   ```bash -->
<!--   mkdir /space -->
<!--   vi /etc/fstab -->
<!--   ``` -->
<!--   Add an entry like this: -->
<!--   ```plaintxt -->
<!--   /dev/mapper/<name of logical volume> /space <NFS or XFS> defaults 1 2 -->
<!--   ``` -->

`/etc/fstab` or `systemd` must have an entry for `/space` (do not reboot during the lab, as this will not work).  
Same way as above.

<div class="warning">
**Reboot the lab machine when finished.**
</div>

---

### Scenario 3:

- Connect to `tshoot3@prolug.asuscomm.com`
- Password:

Your team is trying to update your servers during a maintenance window. Your junior
administrator kicks you over a server that they cannot get to update.
To complete this event the following two must be correct.

Fix the system to be able to update via `dnf`.

- HINT: DNF isn’t updating, so where are the repos that it looks for?

<!-- - Answer: -->
<!--   ```bash -->
<!--   vi /etc/yum.repos.d/rocky.repo -->
<!--   ``` -->
<!--   Look for `enabled=0`. This needs to be changed back to `1`. -->
<!--     * If you need a reference, the original is over in `/etc/yum.repos.d/rocky.repo.orig`. -->
<!--       The EPEL repo is busted the same way, as it needs to be enabled. -->

Verify that kernel updates are happening.

- HINT: Where can updates be excluded in DNF or Yum?

<!-- - Answer: You need to comment out the line in `/etc/yum.conf` about `"exclude=kernel*"` because -->
<!--   this is stopping any kernel updates from happening. -->

> Be sure to `reboot` the lab machine from the command line when you are done.
