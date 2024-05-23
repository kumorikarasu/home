# Overview of the network

## Workstation

AMD Ryzon 7 7950X3D  
96GB DDR4 RAM  
1TB NVMe SSD  
2TB NVMe SSD  
AMD Radeon RX 6800 XT 16GB  
10 GBe Ethernet  
2.5 GBe Ethernet

## Proxmox Node 1

2x Intel(R) Xeon(R) CPU E5-2470 v2  
126GB DDR3 ECC RAM  
2x 500GB HDD  
10 GBe SPF+ NIC  

## Proxmox Node 2

AMD Ryzen 5 3600X  
64GB DDR4 RAM  
1TB NVMe SSD  
1Gbe (Not enough PCI lanes for 10Gbe, sadly)  
Nvidia GTX 4060 Ti 16GB  
Nvidia GTX 2060 Super

## TrueNAS

Intel(R) Core(TM) i7-4790K CPU  
32GB DDR3 RAM  
2x 256GB SSD Boot RAID0  
6x 4TB HDD  
3x 8TB HDD  
10 GBe SPF+ NIC

### RAID Configuration

3x 8TB HDD in RAIDZ1  
3x 4TB HDD in RAIDZ1  
3x 4TB HDD in RAIDZ1  
Pool Size: 22TB

## PFSense Router

Intel(R) Celeron(R) J4125 CPU  
8GB DDR4 RAM  
128GB SSD  
4x 2.5GbE NIC

## Switches

Ubiquiti 16 Port PoE 1Gbe + 2x 10Gbe SPF+  
Ubiquiti 8 Port 10Gbe SPF+  
Ubiquiti Cloud Key 

## Access Points

Ubiquiti U6 LR  
Ubiquiti NanoHD
