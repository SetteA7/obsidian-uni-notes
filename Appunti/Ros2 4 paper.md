# 1) Bot Setup
The setup involves:
- building the package
- starting zenoh bridge
- starting lidar

#### Building the Package
Package (saved in google drive) needs to be built with:
```
colcon build --symlink-install
```
This command must be run inside the workspace directory where the /src folder was extracted (from zip in google drive).

Finally add the source:
```
source install/setup.bash
```

To test if this worked out, run
```
ros2 interface show link_monitor_msg/msg/LinkMetrics
```
 It should return 
```
# Standard ROS 2 64-bit integer type
uint64 sequence_number
# A nested message type pulled from a core ROS 2 package builtin_interfaces/msg/Time stamp
	int32 sec
	uint32 nanosec
```

#### Start Zenoh Bridge
Open a terminal for the rosbot and run:
```
zenoh-bridge-ros2dds --listen tcp/0.0.0.0:7447
```
keep this terminal open and running

On the controller open a terminal and run:
```
zenoh-bridge-ros2dds --connect tcp/IP OF ROSBOT:7447
```
 In the lab it is (local network):
```
zenoh-bridge-ros2dds --connect tcp/192.168.77.2:7447
```
or (tailscale VPN)
```
zenoh-bridge-ros2dds --connect tcp/100.79.118.80:7447
```

It is possible to use UDP instead of TCP.
_Quick copy paste:_
```
zenoh-bridge-ros2dds --listen udp/0.0.0.0:7447
```

```
zenoh-bridge-ros2dds --connect udp/100.79.118.80:7447
```

#### Start Lidar
In the lab there is an alias, use the one that works (only one works):
```
lidar0
lidar1
```

#### Start Nodes
For the client node, which only runs the networks estimator run:
```
ros2 run monitor_pkg bot_monitor
```

# 2) Starlink Setup

The **mikrotic routerboard** is setup to handle the DHCP for the network. (somehow doing it with the rosbot interefered with ros2 motor nodes). 

#### DHCP Offloading
The MikroTik RouterBOARD is configured to handle the network DHCP. This prevents the ROSbot from managing local routing, which previously interfered with ROS2 motor node communication (DDS discovery).
This is automatically enabled when setting up the router.

#### Subnet Alignment
The MikroTik DHCP server is set to the `192.168.77.0/24` network. This natively matches the ROSbot's existing static IP (`192.168.77.2`), requiring no internal IP changes on the robot. To do so the default `192.168.88.0/24` of the DHCP server was changed. Additionally also the IP pool needed to be modified and 

#### DNS and Routing On RosBOT via Netplan
To ensure the ROSbot correctly resolves DNS and routes internet traffic over the wired connection (`eth0`), the default Netplan configuration was updated to explicitly define the MikroTik as the default gateway with a prioritized metric.

```yaml
network:
  version: 2
  ethernets:
    all-eths:
      match:
        name: eth*
      dhcp4: no
      dhcp6: no
      optional: true
      addresses:
        - 192.168.77.2/24
      routes:
        - to: default
          via: 192.168.77.1
          metric: 100
      nameservers:
        addresses:
          - 8.8.8.8
          - 1.1.1.1

    all-enps:
      match:
        name: enP8p1s*
      dhcp4: no
      dhcp6: no
      optional: true
      addresses:
        - 192.168.77.2/24 

  wifis:
    wlan0:
      optional: true
      nameservers:
        addresses:
        - 8.8.8.8
        - 1.1.1.1
      dhcp4: true
      dhcp6: true
      access-points:
        "WLAN064E":
          auth:
            key-management: "psk"
            password: "yourpassword"
```

Additionally also a ip def route was added
```
sudo ip route add default via 192.168.77.1 dev eth0 metric 100
```

# 3) Packet Loss (?)

```
sudo tc qdisc add dev eth0 root netem loss 10% limit 10000
```

```
sudo tc qdisc del dev eth0 root netem
```

```
ros2 run monitor_pkg controller_monitor            # defaults from the top of the file (SMART off, CSV on)
ros2 run monitor_pkg controller_monitor SMART      # SMART on
ros2 run monitor_pkg controller_monitor SMART NOCSV
ros2 run monitor_pkg controller_monitor nosmart csv  # upper or lower case both work
```

# 4) Tests
#### 10 Nov 2026
Today is rainy so starlink might perform a bit worse (36ms latency).

Brakes analysed:   5
Constant-speed v:  45.02 +- 0.13 cm/s  (range 44.86 - 45.17, 5 brake(s), phase 0.62 s, d >= 70 cm)  vs commanded 50.00, VMAX 45.20
Pre-brake v:       41.72 +- 0.82 cm/s  (last 1.0 s before the brake: depends on where the brake happens)
Time to brake:     0.321 +- 0.060 s     (range 0.264 - 0.415)
Braking distance:  6.71 +- 1.38 cm    (range 5.48 - 8.96)  vs D_BRAKE 12.14 cm
  ... from VMAX:   7.84 +- 1.31 cm    (comparable across sessions; use this for D_BRAKE)
Mean deceleration: 133.1 +- 21.1 cm/s^2


Brakes analysed:   5
Constant-speed v:  45.03 +- 0.28 cm/s  (range 44.75 - 45.39, 5 brake(s), phase 0.62 s, d >= 70 cm)  vs commanded 50.00, VMAX 45.20
Pre-brake v:       42.94 +- 1.60 cm/s  (last 1.0 s before the brake: depends on where the brake happens)
Time to brake:     0.400 +- 0.104 s     (range 0.296 - 0.515)
Braking distance:  8.66 +- 2.55 cm    (range 6.11 - 11.58)  vs D_BRAKE 12.14 cm
  ... from VMAX:   9.46 +- 2.11 cm    (comparable across sessions; use this for D_BRAKE)
Mean deceleration: 112.5 +- 25.5 cm/s^2

44.91/44.92
14.42/15.06