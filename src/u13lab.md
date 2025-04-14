<div class="flex-container">
        <img src="https://github.com/ProfessionalLinuxUsersGroup/img/blob/main/Assets/Logos/ProLUG_Round_Transparent_LOGO.png?raw=true" width="64" height="64"></img>
    <p>
        <h1>Unit 13 Lab - System Hardening</h1>
    </p>
</div>

> If you are unable to finish the lab in the ProLUG lab environment we ask you `reboot`
> the machine from the command line so that other students will have the intended environment.

### Resources / Important Links

- <https://killercoda.com/het-tanis/course/Linux-Labs/207-OS_STIG_Scan_with_SCC_Tool>
- <https://public.cyber.mil/stigs/srg-stig-tools/>
- <https://nvd.nist.gov/vuln/search>

### Required Materials

- Rocky 9.4+ - ProLUG Lab
  - Or comparable Linux box
- root or sudo command access

#### Downloads

The lab has been provided for convenience below:

- <a href="./assets/downloads/u13/u13_lab.pdf" target="_blank" download>📥 u13_lab(`.pdf`)</a>
- <a href="./assets/downloads/u13/u13_lab.docx" target="_blank" download>📥 u13_lab(`.docx`)</a>

## Pre-Lab Warm-Up

---

**EXERCISES** (Warmup to quickly run through your system and familiarize yourself)

1. `ss -ntulp`

   - What ports are open on this server?
   - What is open on port 9080?
   - What does this service do?

2. `systemctl --failed`

   - Are there any failed units?

3. `systemctl list-units --state=active`

   - About how many active units are there?
     - `systemctl list-units --state=active | wc -l`

4. `rpm -qa | wc -l`

   - Approximately how many software packages do you have?

5. `rpm -qa | grep -i ssh`

   - How many ssh packages do you have?
   - What is the version of openssh?
   - Do you know if there are any known vulnerabilities for that version?
     - <https://nvd.nist.gov/vuln/search>

## Lab 🧪

---

There will be three basic tasks for today’s labs:

1.  You will scan a server for a SCC Report and get a STIG Score
2.  You will remediate some of the items from the scan
3.  You will rescan and verify a better score.

### SCC Report:

This lab portion can be done in the ProLUG Rocky servers, or in killercoda at this location:
<https://killercoda.com/het-tanis/course/Linux-Labs/207-OS_STIG_Scan_with_SCC_Tool>

Testing hardening on the ProLUG Lab may take over an hour. You are welcome to perform the
test there, but make sure you have some time.

`ssh` into a Rocky sever

```bash
cd /opt/scc
time ./cscc

# ---- Wait over an hour ------

cd /root/SCC/sessions #find the most recent run
```

Look in the results to see output.

### Harden the system

1. Harden sshd

   <img src="./assets/downloads/u13/image2.jpeg"></img>

   - Is your system hardened in this capacity?
   - How did you check?
   - Did the fix check work for you?
   - How did you check?

2. Remove unneeded Software

   - Read about cowsay – `man cowsay`
   - Remove cowsay – `dnf remove cowsay`

<img src="./assets/downloads/u13/image3.png"></img>

#### Rescan to validate change

`ssh` into a Rocky sever

```bash
cd /opt/scc
time ./cscc

# ---- Wait over an hour ------

cd /root/SCC/sessions #find the most recent run
```

Look in the results to see output.

> Be sure to `reboot` the lab machine from the command line when you are done.
