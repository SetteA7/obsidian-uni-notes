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
##### LOCAL
**FIXED** 
```
--- Averages (mean +- std) ---
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
```


**SMART**
```
--- Averages (mean +- std) ---
Start distance:     121.22 +- 1.12 cm (span 3.50 cm; random offset range 4.35 cm, expected span 3.56 cm for 10 runs)
tau_tx from:        ping (logged tau_rx_ms, bot -> ctrl) [0/10 runs from summary.csv tau_source, the rest from tauSource = ping]
D_BRAKE from:       this run's d_brake_meas_cm 11.05 +- 0.17 cm (10/10 brakes, the rest the bot's); the bot used 11.05 cm
Speed:              v_cruise_cm_s 43.54 +- 0.07 cm/s (10/10 brakes, the rest the bot's VMAX); the bot used VMAX 43.49 cm/s
psi (model input):  24.19 +- 0.86 ms  (psi_ms, the bot's value: a priori P)
psi (per brake):    23.54 +- 1.11 ms  (the STOP's measured wait: E[delay], split, P-P; minus model input -0.65 +- 1.22 ms)
Threshold S:        40.05 +- 0.04 cm
Detected at:        38.15 +- 1.37 cm (1.90 +- 1.40 cm past S)

Expected delay:     74.96 +- 1.11 ms  (E[t_e2e,thresh], model sd 28.87 ms)
Actual delay:       71.38 +- 31.46 ms
Verdict:            MODEL PASSED. Spread (min/max): 1.10 (0.50/1.53), Mean/max Difference: -3.58/20.46 ms, (p=0.573>=0.025)
Split (phi from "past S", rest = actual - phi):
  phi:              43.66 +- 32.07 ms  (model T/2 = 50.00 ms, error -6.34 ms)
  rest:             27.72 +- 2.31 ms  (model tau+psi+T*E[A] = 24.96 ms, error +2.76 ms)
  rest - tau_e2e:   26.30 +- 2.31 ms  (should equal psi = 23.54 ms if psi reaches the stop)

Expected d_min:     25.73 +- 0.16 cm  (model sd 1.26 cm)
Measured d_min:     25.89 +- 1.41 cm
Error (meas-exp):   +0.16 +- 1.38 cm  (mean of the 10 per-brake errors)
Mean |error|:       1.19 cm
Verdict:            MODEL PASSED. Spread (min/max): 1.10 (0.50/1.53), Mean/max Difference: +0.16/0.89 cm, (p=0.573>=0.025)

Scan delay:         100.34 +- 0.03 ms   (over 10 runs)
Peak difference:    2.80 +- 0.79 ms
tau_tx bot->ctrl:   ping (tau_rx_ms) 0.77 +- 0.01 ms, scan_delay - scan_time 1.84 +- 0.03 ms, ping - scan -1.07 +- 0.03 ms
Budget B:           95.00 +- 0.00 ms  (self-check: rebuilt a priori B - logged budget_ms = +0.02 +- 0.07 ms)

Parameters from: CSVs/auto_SUPERSMART_20261111_130957/summary.csv
Note: VMAX/T/D_BRAKE/L/M differ between runs; the pooled values below use their mean.

--- Crash probability (mean S, mean network: tau_e2e 1.42 ms, psi 24.19 ms, p_tx 0.0000, p_rx 0.0000) ---
A priori:      0.049804  (exact, S = 40.05 cm, B = 95.02 ms, tau_e2e 1.42 ms: bot's model for 0/10 brakes)
A posteriori:  0.008509  (exact, S = 40.21 cm, B = 99.15 ms, from the mean measured d_min)
Crashes:       1 / 10 = 0.100  (95% CI 0.003 - 0.445; crash = d_min - L < M), expected 0.50 (sum of a priori P)
```

##### STARLINK
**FIXED:**
```
--- Averages (mean +- std) ---
Start distance:     124.26 +- 1.66 cm (span 5.00 cm; random offset range 4.49 cm, expected span 3.67 cm for 10 runs)
tau_tx from:        scan (scan_delay - scan_time, scan_time 98.68 +- 0.05 ms) [0/10 runs from summary.csv tau_source, the rest from tauSource = scan]
D_BRAKE from:       this run's d_brake_meas_cm 10.80 +- 0.25 cm (10/10 brakes, the rest the bot's); the bot used 10.91 cm
Speed:              v_cruise_cm_s 44.92 +- 0.13 cm/s (10/10 brakes, the rest the bot's VMAX); the bot used VMAX 44.22 cm/s
psi (model input):  58.02 +- 3.49 ms  (psi_ms, the bot's value: a priori P)
psi (per brake):    49.56 +- 12.89 ms  (the STOP's measured wait: E[delay], split, P-P; minus model input -8.46 +- 12.05 ms)
Threshold S:        75.00 +- 0.00 cm
Detected at:        73.20 +- 1.02 cm (1.80 +- 1.02 cm past S)

Expected delay:     163.09 +- 1.65 ms  (E[t_e2e,thresh], model sd 28.87 ms)
Actual delay:       157.81 +- 22.82 ms
Verdict:            MODEL PASSED. Spread (min/max): 0.82 (0.50/1.53), Mean/max Difference: -5.28/20.46 ms, (p=0.527>=0.025)
Split (phi from "past S", rest = actual - phi):
  phi:              40.10 +- 22.66 ms  (model T/2 = 50.00 ms, error -9.90 ms)
  rest:             117.71 +- 2.52 ms  (model tau+psi+T*E[A] = 113.09 ms, error +4.63 ms)
  rest - tau_e2e:   54.19 +- 13.59 ms  (should equal psi = 49.56 ms if psi reaches the stop)

Expected d_min:     56.87 +- 0.27 cm  (model sd 1.30 cm)
Measured d_min:     57.11 +- 1.12 cm
Error (meas-exp):   +0.24 +- 1.06 cm  (mean of the 10 per-brake errors)
Mean |error|:       0.90 cm
Verdict:            MODEL PASSED. Spread (min/max): 0.82 (0.50/1.53), Mean/max Difference: +0.24/0.92 cm, (p=0.527>=0.025)

Scan delay:         139.18 +- 5.62 ms   (over 10 runs)
Peak difference:    37.00 +- 26.91 ms
tau_tx bot->ctrl:   ping (tau_rx_ms) 17.72 +- 3.94 ms, scan_delay - scan_time 40.50 +- 5.64 ms, ping - scan -22.77 +- 7.35 ms

Parameters from: CSVs/auto_FIXED_20261111_121609/summary.csv
Note: VMAX/T/D_BRAKE/L/M differ between runs; the pooled values below use their mean.

--- Crash probability (mean S, mean network: tau_e2e 63.52 ms, psi 58.02 ms, p_tx 0.0000, p_rx 0.0000) ---
A priori:      P = 0.000000  (P_low 0.000000, P_high 0.000000; S = 75.00 cm, B = 790.80 ms, tau_e2e 63.52 ms: bot's model for 0/10 brakes)
A posteriori:  P = 0.000000  (P_low 0.000000, P_high 0.000000; S = 75.24 cm, B = 792.72 ms, from the mean measured d_min)
Crashes:       0 / 10 = 0.000  (95% CI 0.000 - 0.308; crash = d_min - L < M), expected 0.00 (sum of a priori P)
```

Now some added packet loss ($1\%$ controller$\rightarrow$bot):
```
--- Averages (mean +- std) ---
Start distance:     120.83 +- 1.65 cm (span 5.30 cm; random offset range 4.47 cm, expected span 3.66 cm for 10 runs)
tau_tx from:        scan (scan_delay - scan_time, scan_time 98.37 +- 0.06 ms) [10/10 runs from summary.csv tau_source, the rest from tauSource = scan]
D_BRAKE from:       this run's d_brake_meas_cm 10.65 +- 0.30 cm (9/10 brakes, the rest the bot's); the bot used 10.08 cm
Speed:              v_cruise_cm_s 44.71 +- 0.67 cm/s (10/10 brakes, the rest the bot's VMAX); the bot used VMAX 44.68 cm/s
psi (model input):  77.36 +- 1.89 ms  (psi_ms, the bot's value: a priori P)
psi (per brake):    71.93 +- 5.13 ms  (the STOP's measured wait: E[delay], split, P-P; minus model input -5.43 +- 4.59 ms)
p_tx bot->ctrl:     check uses what the bot used 0.1980 +- 0.0301; the bot used 0.1980 +- 0.0301; scan loss from stamp gaps 0.1846
Threshold S:        75.00 +- 0.00 cm
Detected at:        72.41 +- 2.01 cm (2.59 +- 2.01 cm past S)

Expected delay:     195.59 +- 4.44 ms  (E[t_e2e,thresh], model sd 62.67 ms)
Actual delay:       179.97 +- 47.59 ms
Verdict:            MODEL PASSED. Spread (min/max): 0.80 (0.50/1.53), Mean/max Difference: -15.62/44.58 ms, (p=0.432>=0.025)
Split (phi from "past S", rest = actual - phi):
  phi:              58.05 +- 44.96 ms  (model T/2 = 50.00 ms, error +8.05 ms)
  rest:             121.92 +- 6.60 ms  (model tau+psi+T*E[A] = 145.59 ms, error -23.67 ms)
  rest - tau_e2e:   73.11 +- 8.23 ms  (should equal psi = 71.93 ms if psi reaches the stop)

Expected d_min:     55.61 +- 0.42 cm  (model sd 2.80 cm)
Measured d_min:     56.31 +- 1.89 cm
Error (meas-exp):   +0.70 +- 2.21 cm  (mean of the 10 per-brake errors)
Mean |error|:       1.82 cm
Verdict:            MODEL PASSED. Spread (min/max): 0.80 (0.50/1.53), Mean/max Difference: +0.70/1.99 cm, (p=0.429>=0.025)

Scan delay:         137.52 +- 3.70 ms   (over 10 runs)
Peak difference:    25.32 +- 22.58 ms
tau_tx bot->ctrl:   ping (tau_rx_ms) 30.83 +- 3.09 ms, scan_delay - scan_time 39.15 +- 3.70 ms, ping - scan -8.32 +- 1.86 ms

Parameters from: CSVs/auto_FIXED_20261111_152427/summary.csv
Note: VMAX/T/D_BRAKE/L/M differ between runs; the pooled values below use their mean.

--- Crash probability (mean S, mean network: tau_e2e 48.81 ms, psi 77.36 ms, p_tx 0.1980, p_rx 0.0000) ---
A priori:      P = 0.000003  (P_low 0.000002, P_high 0.000012; S = 75.00 cm, B = 797.80 ms, tau_e2e 46.30 ms: bot's model for 10/10 brakes)
A posteriori:  P = 0.000002  (P_low 0.000000, P_high 0.000002; S = 75.70 cm, B = 803.13 ms, from the mean measured d_min)
Crashes:       0 / 10 = 0.000  (95% CI 0.000 - 0.308; crash = d_min - L < M), expected 0.00 (sum of a priori P)
```

**SMART**
```
--- Averages (mean +- std) ---
Start distance:     135.41 +- 1.42 cm (span 4.00 cm; random offset range 4.41 cm, expected span 3.61 cm for 10 runs)
tau_tx from:        scan (scan_delay - scan_time, scan_time 98.43 +- 0.03 ms) [10/10 runs from summary.csv tau_source, the rest from tauSource = ping]
D_BRAKE from:       this run's d_brake_meas_cm 11.20 +- 0.29 cm (10/10 brakes, the rest the bot's); the bot used 10.75 cm
Speed:              v_cruise_cm_s 44.08 +- 0.10 cm/s (10/10 brakes, the rest the bot's VMAX); the bot used VMAX 43.90 cm/s
psi (model input):  86.55 +- 3.56 ms  (psi_ms, the bot's value: a priori P)
psi (per brake):    84.70 +- 3.14 ms  (the STOP's measured wait: E[delay], split, P-P; minus model input -1.85 +- 3.38 ms)
Threshold S:        44.84 +- 0.14 cm
Detected at:        42.77 +- 1.26 cm (2.07 +- 1.22 cm past S)

Expected delay:     186.94 +- 3.02 ms  (E[t_e2e,thresh], model sd 29.90 ms)
Actual delay:       183.35 +- 24.84 ms
Verdict:            MODEL PASSED. Spread (min/max): 0.82 (0.50/1.53), Mean/max Difference: -3.59/21.20 ms, (p=0.524>=0.025)
Split (phi from "past S", rest = actual - phi):
  phi:              47.05 +- 27.71 ms  (model T/2 = 50.00 ms, error -2.95 ms)
  rest:             136.30 +- 8.04 ms  (model tau+psi+T*E[A] = 136.94 ms, error -0.65 ms)
  rest - tau_e2e:   84.66 +- 8.46 ms  (should equal psi = 84.70 ms if psi reaches the stop)

Expected d_min:     25.40 +- 0.25 cm  (model sd 1.32 cm)
Measured d_min:     25.56 +- 1.22 cm
Error (meas-exp):   +0.16 +- 1.10 cm  (mean of the 10 per-brake errors)
Mean |error|:       0.82 cm
Verdict:            MODEL PASSED. Spread (min/max): 0.82 (0.50/1.53), Mean/max Difference: +0.16/0.93 cm, (p=0.524>=0.025)

Scan delay:         133.11 +- 4.00 ms   (over 10 runs)
Peak difference:    19.84 +- 14.99 ms
tau_tx bot->ctrl:   ping (tau_rx_ms) 15.45 +- 4.24 ms, scan_delay - scan_time 34.68 +- 3.99 ms, ping - scan -19.23 +- 1.33 ms
Budget B:           95.58 +- 0.50 ms  (self-check: rebuilt a priori B - logged budget_ms = +0.04 +- 0.05 ms)

Parameters from: CSVs/auto_SUPERSMART_20261111_123639/summary.csv
Note: VMAX/T/D_BRAKE/L/M differ between runs; the pooled values below use their mean.

--- Crash probability (mean S, mean network: tau_e2e 51.64 ms, psi 86.55 ms, p_tx 0.0000, p_rx 0.0060) ---
A priori:      0.049591  (exact, S = 44.84 cm, B = 95.61 ms, tau_e2e 53.46 ms: bot's model for 10/10 brakes)
A posteriori:  0.088776  (exact, S = 45.00 cm, B = 91.67 ms, from the mean measured d_min)
Crashes:       1 / 10 = 0.100  (95% CI 0.003 - 0.445; crash = d_min - L < M), expected 0.50 (sum of a priori P)
```

# 5) CHRONY IMPORTANT
I changed the config of chrony:
