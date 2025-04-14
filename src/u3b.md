<div class="flex-container">
        <img src="https://github.com/ProfessionalLinuxUsersGroup/img/blob/main/Assets/Logos/ProLUG_Round_Transparent_LOGO.png?raw=true" width="64" height="64"></img>
    <p>
      <h1>Unit 3 Bonus - Storage</h1>
    </p>
</div>

> **NOTE:** This is an **optional** bonus section. You **do not** need to read it, but if you're interested in digging deeper, this is for you.

When storage issues arise, troubleshooting step by step ensures a quick resolution. This guide flows logically, covering the most common issues you might face, from slow performance to filesystem corruption.

## 🔍 Step 1: Is Storage Performance Slow?

---

If everything feels sluggish, your disk might be the bottleneck.

### Check:

```bash
# Monitor disk I/O, latency, and throughput
iostat -xz 1

# Identify processes consuming high I/O
pidstat -d 1

# Real-time disk activity monitoring
iostat -dx 1
```

- If I/O wait is high, it means the CPU is waiting on slow disk operations.
- If certain processes are consuming all disk bandwidth, they might be the cause.

### Fix:

1. Identify and stop unnecessary high I/O processes:

   ```bash
   # Forcefully terminate a process (use with caution)
   kill -9 <PID>
   ```

2. Optimize filesystem writes (for ext4):

   ```bash
   # Enable writeback mode for better performance
   tune2fs -o journal_data_writeback /dev/sdX
   ```

3. Reduce excessive metadata writes:

   ```bash
   # Disable access time updates and set commit interval
   mount -o noatime,commit=60 /mnt/data
   ```

4. If using LVM, extend the volume to reduce fragmentation:
   ```bash
   # Add 5GB to volume
   lvextend -L +5G /dev/examplegroup/lv_data
   ```

---

## 🔍 Step 2: Is the Filesystem Full? ("No Space Left on Device")

---

👉 Disk space exhaustion is one of the most common causes of storage failures.

### Check:

```bash
# Show disk usage per filesystem
df -hT

# Find the biggest files
du -ahx / | sort -rh | head -20
```

- If a filesystem is 100% full, it prevents writes and can cause application crashes.
- If there's space but files still won't write, check Step 4 (Corrupted Filesystem).

### Fix:

1. Find and remove large unnecessary files:

   ```bash
   # Remove specific log file
   rm -f /var/log/large_old_log.log
   ```

2. Truncate logs safely without deleting them:

   ```bash
   # Clear log contents while preserving file
   truncate -s 0 /var/log/syslog

   # Limit journal size
   journalctl --vacuum-size=100M
   ```

3. Expand disk space if using LVM:

   ```bash
   # Extend logical volume
   lvextend -L +10G /dev/examplegroup/lv_data

   # Resize filesystem
   resize2fs /dev/examplegroup/lv_data  # for ext4
   xfs_growfs /mnt/data                 # for XFS
   ```

## 🔍 Step 3: Are Mounts Failing? (LVM, fstab, NFS, SMB)

---

If files suddenly disappear or applications complain about missing storage, a mount issue may be the cause.

### Check:

```bash
# View current mounts
mount | grep /mnt/data

# Check block devices
lsblk

# Verify permanent mount configuration
cat /etc/fstab
```

### Fix:

1. Manually remount the filesystem (if missing):

   ```bash
   # Remount all fstab entries
   mount -a
   ```

2. Ensure correct fstab entry for persistence:

   ```ini
   # Add to /etc/fstab (replace UUID with actual value)
   UUID=xxx-yyy-zzz /mnt/data ext4 defaults 0 2
   ```

3. If an LVM mount is missing after reboot, reactivate it:

   ```bash
   # Activate volume groups
   vgchange -ay

   # Mount the logical volume
   mount /dev/examplegroup/lv_data /mnt/data
   ```

4. For NFS issues, check connectivity and restart services:

   ```bash
   # Check NFS exports
   showmount -e <NFS_SERVER_IP>

   # Restart NFS service
   systemctl restart nfs-server
   ```

---

## 🔍 Step 4: Is the Filesystem Corrupted?

---

👉 Power losses, unexpected shutdowns, and failing drives can cause corruption.

### Check:

```bash
# Check kernel error messages
dmesg | grep -i "error"

# Check filesystem integrity (non-destructive)
fsck.ext4 -n /dev/sdX  # for ext4
xfs_repair -n /dev/sdX  # for XFS
```

### Fix:

1. Repair the filesystem (if unmounted):

   ```bash
   # Unmount first
   umount /dev/sdX

   # Run filesystem repair
   fsck -y /dev/sdX    # for ext4
   xfs_repair /dev/sdX  # for XFS
   ```

2. If corruption is severe, restore from backup:
   ```bash
   # Restore using rsync
   rsync -av /backup/mnt_data /mnt/data/
   ```

## 🔍 Step 5: Are You Out of Inodes?

---

You might have disk space but still can't create files? Check your inodes!

### Check:

```bash
# Check inode usage
df -i

# Count files in current directory
find . -type f | wc -l
```

- If inode usage shows 100%, you can't create new files even with free space.
- This happens when you have too many small files.

### Fix:

1. Clean up temporary files:

   ```bash
   # Remove old files in /tmp
   rm -rf /tmp/*

   # Clean package cache (Debian/Ubuntu)
   apt-get clean
   ```

2. Find and remove unnecessary files:
   ```bash
   # List directories with most files
   du -a | sort -n -r | head -n 10
   ```
