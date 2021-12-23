# Домашнее задание к занятию "3.5. Файловые системы"
1. (4)   Command (m for help): i  
Partition number (1,2, default 2): 1

        Device: /dev/sdb1
          Start: 2048
            End: 4196351
        Sectors: 4194304
           Size: 2G
           Type: Linux filesystem
        Type-UUID: 0FC63DAF-8483-4772-8E79-3D69D8477DE4
           UUID: 7E6A069D-DA07-5740-8221-EA848C252A7F

    Command (m for help): i
    Partition number (1,2, default 2): 2

         Device: /dev/sdb2
          Start: 4196352
            End: 5242846
        Sectors: 1046495
           Size: 511M
           Type: Linux filesystem
      Type-UUID: 0FC63DAF-8483-4772-8E79-3D69D8477DE4
           UUID: 4EF50A97-4305-E847-A9B1-22741163D960
           
    fdisk -l

        Device       Start     End Sectors  Size Type
        /dev/sdb1     2048 4196351 4194304    2G Linux filesystem
        /dev/sdb2  4196352 5242846 1046495  511M Linux filesystem

1. (5) sfdisk -d /dev/sdb > /tmp/sdb.back && sfdisk /dev/sdc < /tmp/sdb.back
root@vagrant:~# sfdisk -l /dev/sdc

        Device       Start     End Sectors  Size Type
        /dev/sdc1     2048 4196351 4194304    2G Linux filesystem
        /dev/sdc2  4196352 5242846 1046495  511M Linux filesystem
1. (6) root@vagrant:~# mdadm --create device -l 1 -N RAID1 -n 2 /dev/sdb1 /dev/sdc1  
root@vagrant:~# mdadm --detail /dev/md127

            /dev/md127:
                       Version : 1.2
                 Creation Time : Tue Sep 14 11:41:06 2021
                    Raid Level : raid1
                    Array Size : 2094080 (2045.00 MiB 2144.34 MB)
                 Used Dev Size : 2094080 (2045.00 MiB 2144.34 MB)
                  Raid Devices : 2
                 Total Devices : 2
                   Persistence : Superblock is persistent
            
                   Update Time : Tue Sep 14 11:41:17 2021
                         State : clean
                Active Devices : 2
               Working Devices : 2
                Failed Devices : 0
                 Spare Devices : 0
            
            Consistency Policy : resync

              Name : vagrant:RAID1  (local to host vagrant)
              UUID : 9d605847:17e5a1d8:425314b1:842cd252
            Events : 17

        Number   Major   Minor   RaidDevice State
           0       8       17        0      active sync   /dev/sdb1
           1       8       33        1      active sync   /dev/sdc1
1. (7) mdadm --create /dev/md0 --chunk=11 --level=0 --raid-devices=2  /dev/sdb2 /dev/sdc2  
   root@vagrant:/dev/md# cat /proc/mdstat
    
        Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
        md0 : active raid0 sdc2[1] sdb2[0]
              1044424 blocks super 1.2 11k chunks
        
        md127 : active raid1 sdc1[1] sdb1[0]
              2094080 blocks super 1.2 [2/2] [UU]
1. (8)    
        `root@vagrant:/dev/md# pvcreate /dev/md0`  
          `root@vagrant:/dev/md# pvcreate /dev/md127`
          
        root@vagrant:/dev/md# pvdisplay
          --- Physical volume ---
          PV Name               /dev/sda5
          VG Name               vgvagrant
          PV Size               <63.50 GiB / not usable 0
          Allocatable           yes (but full)
          PE Size               4.00 MiB
          Total PE              16255
          Free PE               0
          Allocated PE          16255
          PV UUID               Mx3LcA-uMnN-h9yB-gC2w-qm7w-skx0-OsTz9z
        
          "/dev/md0" is a new physical volume of "<1019.95 MiB"
          --- NEW Physical volume ---
          PV Name               /dev/md0
          VG Name
          PV Size               <1019.95 MiB
          Allocatable           NO
          PE Size               0
          Total PE              0
          Free PE               0
          Allocated PE          0
          PV UUID               hY9TU8-afUG-etQM-2TAe-ijkL-OiPo-AQ21UC
        
          "/dev/md127" is a new physical volume of "<2.00 GiB"
          --- NEW Physical volume ---
          PV Name               /dev/md127
          VG Name
          PV Size               <2.00 GiB
          Allocatable           NO
          PE Size               0
          Total PE              0
          Free PE               0
          Allocated PE          0
          PV UUID               y2H8LY-7U2i-z3uM-Bmmf-0w54-a4Is-D6SS77
          
1. (9) `vgcreate vg01 /dev/md0 /dev/md127`

          --- Volume group ---
          VG Name               vg01
          System ID
          Format                lvm2
          Metadata Areas        2
          Metadata Sequence No  1
          VG Access             read/write
          VG Status             resizable
          MAX LV                0
          Cur LV                0
          Open LV               0
          Max PV                0
          Cur PV                2
          Act PV                2
          VG Size               <2.99 GiB
          PE Size               4.00 MiB
          Total PE              765
          Alloc PE / Size       0 / 0
          Free  PE / Size       765 / <2.99 GiB
          VG UUID               BUk2Kp-MJ5d-udWB-KPni-2Ysl-n0Et-TGJ8gd

1. (10) `lvcreate -L100 -n raid0_100 /dev/vg01 /dev/md0`

          --- Logical volume ---
          LV Path                /dev/vg01/raid0_100
          LV Name                raid0_100
          VG Name                vg01
          LV UUID                Xz98s9-XwBL-VtIw-lADD-eEJx-956R-s2u7uT
          LV Write Access        read/write
          LV Creation host, time vagrant, 2021-09-15 05:07:23 +0000
          LV Status              available
          # open                 0
          LV Size                100.00 MiB
          Current LE             25
          Segments               1
          Allocation             inherit
          Read ahead sectors     auto
          - currently set to     256
          Block device           253:2
1. (11) `mkfs.ext4 -L fs_raid0_100 /dev/vg01/raid0_100`

        mke2fs 1.45.5 (07-Jan-2020)
        Creating filesystem with 25600 4k blocks and 25600 inodes
        
        Allocating group tables: done
        Writing inode tables: done
        Creating journal (1024 blocks): done
        Writing superblocks and filesystem accounting information: done

1. (12)  `mount -t ext4 /dev/vg01/raid0_100 /tmp/new`
1. (13)  `wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz`
        
        2021-09-15 05:25:11 (6.30 MB/s) - ‘/tmp/new/test.gz’ saved [21107451/21107451]

1. (14)
  
        NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
        sda                    8:0    0   64G  0 disk
        ├─sda1                 8:1    0  512M  0 part  /boot/efi
        ├─sda2                 8:2    0    1K  0 part
        └─sda5                 8:5    0 63.5G  0 part
          ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
          └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
        sdb                    8:16   0  2.5G  0 disk
        ├─sdb1                 8:17   0    2G  0 part
        │ └─md127              9:127  0    2G  0 raid1
        └─sdb2                 8:18   0  511M  0 part
          └─md0                9:0    0 1020M  0 raid0
            └─vg01-raid0_100 253:2    0  100M  0 lvm   /tmp/new
        sdc                    8:32   0  2.5G  0 disk
        ├─sdc1                 8:33   0    2G  0 part
        │ └─md127              9:127  0    2G  0 raid1
        └─sdc2                 8:34   0  511M  0 part
          └─md0                9:0    0 1020M  0 raid0
            └─vg01-raid0_100 253:2    0  100M  0 lvm   /tmp/new
             
1. (16) `pvmove /dev/md0 /dev/md127`  

          /dev/md0: Moved: 24.00%
          /dev/md0: Moved: 100.00%
1. (18)

        [69291.224996] md/raid1:md127: Disk failure on sdb1, disabling device.
                       md/raid1:md127: Operation continuing on 1 devices. 
                       
