<div class="flex-container">
        <img src="https://github.com/ProfessionalLinuxUsersGroup/img/blob/main/Assets/Logos/ProLUG_Round_Transparent_LOGO.png?raw=true" width="64" height="64"></img>
    <p>
        <h1>Unit 12 Lab - Baselines & Benchmarks</h1>
    </p>
</div>

> If you are unable to finish the lab in the ProLUG lab environment we ask you `reboot`
> the machine from the command line so that other students will have the intended environment.

### Resources / Important Links

- [SAR Documentation](https://man7.org/linux/man-pages/man1/sar.1.html)
- [iostat Manual](https://man7.org/linux/man-pages/man1/iostat.1.html)
- [stress GitHub](https://github.com/stress-ng/stress-ng)
- [iperf3 Documentation](https://iperf.fr/)

### Required Materials

- Rocky 9.4+ - ProLUG Lab
  - Or comparable Linux box
- root or sudo command access

#### Downloads

The lab has been provided for convenience below:

- <a href="./assets/downloads/u12/u12_lab.pdf" target="_blank" download>📥 u12_lab(`.pdf`)</a>
- <a href="./assets/downloads/u12/u12_lab.docx" target="_blank" download>📥 u12_lab(`.docx`)</a>

## Pre-Lab Warm-Up

---

1. Create a working directory

   ```bash
   mkdir lab_baseline
   cd lab_baseline
   ```

2. Verify if `iostat` is available

   ```bash
   which iostat
   ```

   If it’s not there:

   ```bash
   # Find which package provides iostat
   dnf whatprovides iostat

   # This should tell you it's sysstat
   rpm -qa | grep -i sysstat

   # Install sysstat if needed
   dnf install sysstat

   # Verify installation
   rpm -qa | grep -i sysstat
   ```

3. Verify if `stress` is available

   ```bash
   which stress
   ```

   If it’s not there:

   ```bash
   # Find which package provides stress
   dnf whatprovides stress

   # Install stress
   dnf install stress

   # Verify installation
   rpm -qa | grep -i stress
   rpm -qi stress  # Read the package description
   ```

4. Verify if `iperf3` is available

   ```bash
   which iperf3
   ```

   If it’s not there:

   ```bash
   # Find which package provides iperf3
   dnf whatprovides iperf

   # Install iperf3
   dnf install iperf

   # Verify installation
   rpm -qa | grep -i iperf
   rpm -qi iperf
   ```

## Lab 🧪

---

### Baseline Information Gathering

The purpose of a baseline is not to find fault, load, or to take corrective action. A
baseline simply determines what is. You must know what is so that you can test
against that when you make a change to be able to objectively say there was or wasn't
an improvement. You must know where you are at to be able to properly plan where you
are going. A poor baseline assessment, because of inflated numbers or inaccurate
testing, does a disservice to the rest of your project. You must accurately draw the
first line and understand your system's performance.

#### Using SAR (CPU and memory statistics)

Some useful sar tracking commands. 10 minute increments.

```bash
# By itself, this gives the last day's processing numbers
sar

# Gives memory statistics
sar -r

# Gives swapping statistics (useful to check if system runs out of physical memory)
sar -W

# List SAR log files
ls /var/log/sa/

# View SAR data from a specific day of the month
sar -f /var/log/sa/sa28
```

For your later labs, you need to collect `sar` data in real time to compare with the
baseline data.

```bash
# View how SAR collects data every 10 minutes
systemctl cat sysstat-collect.timer

# Collect SAR data in real time (every 2 seconds, 10 samples)
sar 2 10

# Memory statistics (every 2 seconds, 10 samples)
sar -r 2 10
```

#### Using IOSTAT (CPU and device statistics)

`iostat` will give you either processing or device statistics for your system.

```bash
# Gives all information (CPU and device)
iostat

# CPU statistics only
iostat -c

# Device statistics only
iostat -d

# 1-second CPU stats until interrupted
iostat -c 1

# 1-second CPU stats, 5 times
iostat -c 1 5
```

#### Using iperf3 (network speed testing)

In the ProLUG lab, `red1` is the iperf3 server, so we can bounce connections off it (`192.168.200.101`).

```bash
# TCP connection with 128 connections
time iperf3 -c 192.168.200.101 -n 1G -P 128

# UDP connection with 128 connections
time iperf3 -c 192.168.200.101 -u -n 1G -P 128
```

#### Using STRESS to generate load

`stress` will produce extra load on a system. It can run against proc, ram, and disk I/O.

```bash
# View stress usage information
stress

# Stress CPU with 1 process (will run indefinitely)
stress -c 1

# Stress multiple subsystems (this will do a lot of things)
stress --cpu 8 --io 4 --vm 2 --vm-bytes 128M -d 1 --timeout 10s
```

Read the usage output and try to figure out what each option does.

### Developing a Test Plan

The company has decided we are going to add a new agent to all machines.
Management has given this directive to you because of PCI compliance standards with
no regard for what it may do to the system. You want to validate if there are any
problems and be able to express your concerns as an engineer, if there are actual
issues. No one cares what you think, they care what you can show, or prove.

#### Determine the right question to ask:

- Do we have a system baseline to compare against?

  - No? Make a baseline.
    ```bash
    iostat -xh 1 10
    ```

- Can we say that this system is not under heavy load?
- What does a system under no load look like permorning tasks in our environment?

  - Assuming our systems are running not under load, capture SAR and baseline stats.
  - Perform some basic tasks and get their completion times.

    - Writing/deleting 3000 empty files #modify as needed for your system

    ```bash
    # Speed: ~10s
    time for i in `seq 1 3000`; do touch testfile$i; done

    # Removing them
    time for i in `seq 1 3000`; do rm -rf testfile$i; done

    # Writing large files
    for i in `seq 1 5`; do time dd if=/dev/zero of=/root/lab_baseline/sizetest$i bs=1024k count=1000; done

    # Removing the files
    for i in `seq 1 5`; do rm -rf sizetest$i ; done
    ```

    - Testing processor speed

      ```bash
      time $(i=0; while (( i < 999999 )); do (( i ++ )); done)
      # if this takes your system under 10 seconds, add a 9
      ```

    - Alternate processor speed test

    ```bash
    time dd if=/dev/urandom bs=1024k count=20 | bzip2 -9 >> /dev/null
    ```

    This takes random numbers in blocks, zips them, and then throws them away.  
     Tune to about ~10 seconds as needed

* What is the difference between systems under load with and without the agent?

Run a load test (with `stress`) of what the agent is going to do against the system.

While the load test is running, do your same functions and see if they perform
differently.

### Execute the plan and gather data

Edit these as you see fit, add columns or rows to increase understanding of system performance. This is
your chance to test and record these things.

#### System Baseline Tests

| Metric                           | Server 1 |
| -------------------------------- | -------- |
| SAR average load (past week)     |          |
| IOSTAT test (10 min)             |          |
| IOSTAT test (2s x 10 samples)    |          |
| Disk write - small files         |          |
| Disk write - small files (retry) |          |
| Disk write - large files         |          |
| Processor benchmark              |          |

**You may baseline more than once, more data is rarely bad.**

Make 3 different assumptions for how load may look on your system with the agent and design your
stress commands around them (examples):

1. I assume no load on hdd, light load on processors

   ```bash
   while true; do stress --cpu 2 --io 4 --vm 2 --vm-bytes 128M --timeout 30; done #
   ```

2. I assume low load on hdd, light load on processors

   ```bash
   while true; do stress --cpu 2-io 4 --vm 2 --vm-bytes 128M -d 1 --timeout 30; done
   ```

3. I just assume everything is high load and it's a mess
   ```bash
   while true; do stress --cpu 4 --io 4 --vm 2 --vm-bytes 256M -d 4 --timeout 30; done
   ```

In one window start your load tests (YOU MUST REMEMBER TO STOP THESE AFTER YOU GATHER
YOUR DATA).
In another window gather your data again, exactly as you did for your baseline with
`sar` and `iostat` just for the time of the test.

#### System Tests while under significant load

Put command you're using for load here:

| Metric                           | Server 1 |
| -------------------------------- | -------- |
| SAR average load (during test)   |          |
| IOSTAT test (10 min)             |          |
| IOSTAT test (2s x 10 samples)    |          |
| Disk write - small files         |          |
| Disk write - small files (retry) |          |
| Disk write - large files         |          |
| Processor benchmark              |          |

---

#### System Tests while under significant load

Put command you're using for load here:

| Metric                           | Server 1 |
| -------------------------------- | -------- |
| SAR average load (during test)   |          |
| IOSTAT test (10 min)             |          |
| IOSTAT test (2s x 10 samples)    |          |
| Disk write - small files         |          |
| Disk write - small files (retry) |          |
| Disk write - large files         |          |
| Processor benchmark              |          |

**Continue copying and pasting tables as needed.**

## Reflection Questions (optional)

- How did the system perform under load compared to your baseline?
- What would you report to your management team regarding the new agent’s impact?
- How would you adjust your test plan to capture additional performance metrics?

> Be sure to `reboot` the lab machine from the command line when you are done.
