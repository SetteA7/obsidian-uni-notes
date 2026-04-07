# 1) Setup
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
