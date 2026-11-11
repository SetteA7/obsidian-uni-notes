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

#### 11 Nov 2026
Some runs in local:
FIXED --- Averages (mean +- std) ---
Start distance:     114.68 +- 1.35 cm (span 3.40 cm; random offset range 4.46 cm, expected span 3.65 cm for 10 runs)
tau_tx from:        scan (scan_delay - scan_time, scan_time 98.56 +- 0.05 ms) [0/10 runs from summary.csv tau_source, the rest from tauSource = scan]
D_BRAKE from:       this run's d_brake_meas_cm 10.89 +- 0.23 cm (10/10 brakes, the rest the bot's); the bot used 11.00 cm
Speed:              v_cruise_cm_s 44.58 +- 0.48 cm/s (10/10 brakes, the rest the bot's VMAX); the bot used VMAX 44.13 cm/s
psi (model input):  24.86 +- 0.41 ms  (psi_ms, the bot's value: a priori P)
psi (per brake):    24.35 +- 0.84 ms  (the STOP's measured wait: E[delay], split, P-P; minus model input -0.51 +- 0.80 ms)
Threshold S:        75.00 +- 0.00 cm
Detected at:        73.16 +- 1.29 cm (1.84 +- 1.29 cm past S)

Expected delay:     76.80 +- 0.74 ms  (E[t_e2e,thresh], model sd 28.87 ms)
Actual delay:       73.37 +- 27.86 ms
Verdict:            MODEL PASSED. Spread (min/max): 0.97 (0.50/1.53), Mean/max Difference: -3.42/20.46 ms, (p=0.708>=0.025)
Split (phi from "past S", rest = actual - phi):
  phi:              41.32 +- 29.17 ms  (model T/2 = 50.00 ms, error -8.68 ms)
  rest:             32.06 +- 2.53 ms  (model tau+psi+T*E[A] = 26.80 ms, error +5.26 ms)
  rest - tau_e2e:   29.61 +- 2.51 ms  (should equal psi = 24.35 ms if psi reaches the stop)

Expected d_min:     60.69 +- 0.22 cm  (model sd 1.29 cm)
Measured d_min:     60.84 +- 1.21 cm
Error (meas-exp):   +0.15 +- 1.25 cm  (mean of the 10 per-brake errors)
Mean |error|:       1.03 cm
Verdict:            MODEL PASSED. Spread (min/max): 0.97 (0.50/1.53), Mean/max Difference: +0.15/0.91 cm, (p=0.705>=0.025)

Scan delay:         100.35 +- 0.03 ms   (over 10 runs)
Peak difference:    2.02 +- 0.23 ms
tau_tx bot->ctrl:   ping (tau_rx_ms) 0.78 +- 0.02 ms, scan_delay - scan_time 1.79 +- 0.05 ms, ping - scan -1.01 +- 0.05 ms

Parameters from: CSVs/auto_FIXED_20261111_130621/summary.csv
Note: VMAX/T/D_BRAKE/L/M differ between runs; the pooled values below use their mean.

--- Crash probability (mean S, mean network: tau_e2e 2.45 ms, psi 24.86 ms, p_tx 0.0000, p_rx 0.0000) ---
A priori:      P = 0.000000  (P_low 0.000000, P_high 0.000000; S = 75.00 cm, B = 884.71 ms, tau_e2e 2.45 ms: bot's model for 0/10 brakes)
A posteriori:  P = 0.000000  (P_low 0.000000, P_high 0.000000; S = 75.15 cm, B = 882.04 ms, from the mean measured d_min)
Crashes:       0 / 10 = 0.000  (95% CI 0.000 - 0.308; crash = d_min - L < M), expected 0.00 (sum of a priori P)
