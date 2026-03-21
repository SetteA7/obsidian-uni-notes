# 1) ROS


![[Pasted image 20250905160236.png|Image|350]]
#### rqt
rqt è un servizio utile per dare i comandi ma anche vedere grafici dei nodi/topics/publishers/receivers ecc.
## 1.2) Nodes
Each node in ROS should be responsible for a single, modular purpose, e.g. controlling the wheel motors or publishing the sensor data from a laser range-finder. Each node can send and receive data from other nodes via topics, services, actions, or parameters.

If you use
```
ros2 node list
```
you can see the names of the nodes running and you can access infos by using 
```
ros2 node info <node_name>
```
[Remapping](https://design.ros2.org/articles/ros_command_line_arguments.html#name-remapping-rules) allows you to reassign default node properties, like node name, topic names, service names, etc., to custom values. For example
```
ros2 run turtlesim turtlesim_node --ros-args --remap __node:=my_turtle
```

## 1.3) Topics
ROS 2 breaks complex systems down into many modular nodes. Topics are a vital element of the ROS graph that act as a bus for nodes to exchange messages. A node may publish data to any number of topics and simultaneously have subscriptions to any number of topics.
![[Pasted image 20250905160321.png|Example|350]]
we can use
```
ros2 topic list
```
to see what topics exist, more over with
```
ros2 topic list -t
```
we see the type in brackets
With
```
ros2 topic info < topic name>
```
We get the type, publisher and subscriber count
The interface can be seen with
```
ros2 interface show < msg_type >
```
In fact with
```
ros2 topic echo <topic_name>
```
we create a debug node which logs each time a topic sends a message

Now that you have the message structure, you can publish data to a topic directly from the command line using:
```
ros2 topic pub <topic_name> <msg_type> '< args>'
```

## 1.4) Services
Services are another method of communication for nodes in the ROS graph. Services are based on a call-and-response model versus the publisher-subscriber model of topics. While topics allow nodes to subscribe to data streams and get continual updates, services only provide data when they are specifically called by a client.

![[Pasted image 20250905163027.png|Example|350]]
```
ros2 service list -t
```
lists the services and their type
```
ros2 service info < service name>
ros2 interface show < type>
```
this shows what data is sent and received

You can call this by doing
```
ros2 service call < name> < args >
```
## 1.5) Parameters
A parameter is a configuration value of a node. You can think of parameters as node settings. A node can store parameters as integers, floats, booleans, strings, and lists. In ROS 2, each node maintains its own parameters.

# 2) Netns
**Setup:**
- Create namespaces
```
sudo ip netns add ns_robot
sudo ip netns add ns_ctrl
sudo ip netns add ns_data
```
- Create a veth (virtual ethernet cable)
```
sudo ip link add veth_robot type veth peer name veth_ctrl
```
- Set one in each namespace (the namespaces are connected via the veth extremities)
```
sudo ip link set veth_robot netns ns_robot
sudo ip link set veth_ctrl netns ns_ctrl
```
- Assign ip
```
sudo ip netns exec ns_robot ip addr add 10.0.0.1/24 dev veth_robot
sudo ip netns exec ns_ctrl  ip addr add 10.0.0.2/24 dev veth_ctrl
```
- Activate up and lo interfaces
```
sudo ip netns exec ns_robot ip link set veth_robot up
sudo ip netns exec ns_ctrl  ip link set veth_ctrl up
sudo ip netns exec ns_robot ip link set lo up
sudo ip netns exec ns_ctrl  ip link set lo up
```
- add data collector namespace and full config
	- data to robot
```
sudo ip link add veth_data_robot type veth peer name veth_robot_data
sudo ip link set veth_data_robot netns ns_data
sudo ip link set veth_robot_data netns ns_robot

sudo ip netns exec ns_data ip addr add 10.0.1.1/24 dev veth_data_robot
sudo ip netns exec ns_robot ip addr add 10.0.1.2/24 dev veth_robot_data

sudo ip netns exec ns_data ip link set veth_data_robot up
sudo ip netns exec ns_robot ip link set veth_robot_data up
sudo ip netns exec ns_data ip link set lo up
sudo ip netns exec ns_robot ip link set lo up
```
- data to script
```
sudo ip link add veth_data_ctrl type veth peer name veth_ctrl_data
sudo ip link set veth_data_ctrl netns ns_data
sudo ip link set veth_ctrl_data netns ns_ctrl

sudo ip netns exec ns_data ip addr add 10.0.2.1/24 dev veth_data_ctrl
sudo ip netns exec ns_ctrl ip addr add 10.0.2.2/24 dev veth_ctrl_data

sudo ip netns exec ns_data ip link set veth_data_ctrl up
sudo ip netns exec ns_ctrl ip link set veth_ctrl_data up
sudo ip netns exec ns_data ip link set lo up
sudo ip netns exec ns_ctrl ip link set lo up
```
- firewall (actually tc) to block outgoing packets from data collector NO
```
# Drop all outgoing packets on the robot-data veth
sudo tc qdisc add dev veth_data_robot root netem loss 100%

# Drop all outgoing packets on the ctrl-data veth
sudo tc qdisc add dev veth_data_ctrl root netem loss 100%
```


**Workings:**
Here we must start 2 terminals and bash inside the two namespaces
- Terminal 1
```
sudo ip netns exec ns_robot sudo -u user bash
```
- Terminal 2
```
sudo ip netns exec ns_ctrl sudo -u user bash
```
- Terminal 3
```
sudo ip netns exec ns_data sudo -u user bash
```
`
And now add network specific settings (queueing discipline)(qdisc)
```
sudo ip netns exec ns_robot tc qdisc add dev veth_robot root netem delay 100ms 10ms loss 50%
```
and in the other (ns_ctrl) terminal
```
sudo ip netns exec ns_ctrl tc qdisc add dev veth_ctrl root netem delay 100ms 10ms loss 50%
```
see settings
```
sudo tc qdisc show dev veth_robot
```
Delete settings (qdisk)
```
sudo ip netns exec ns_robot tc qdisc del dev veth_robot root
```
**With ros2/Gazebo:**
- Terminal 1
```
sudo ip netns exec ns_robot sudo -u user bash
source rosbot_ws/install/setup.bash
ros2 launch rosbot_gazebo simulation.launch.py robot_model:=rosbot_xl configuration:=autonomy
```
- Terminal 2`
```
sudo ip netns exec ns_ctrl sudo -u user bash
source rosbot_ws/install/setup.bash
./myscripts.py
```

exit from bash
```
exit
```

see in what namespace I'm in
```
ip netns identify $$ 2>/dev/null
```

# 3) Data Analysis
From the ideal case we obtain that:
- Brake time: 1150.0 ms
- Brake distance: 46.20 cm
- Final distance to object: 45.50 cm
- Max speed: 0.8 m/s

Suppose we want a 5cm margin in the worst case, this means that we can delay the brake for 0.538m. Let's do 0.53 m. Now at the top speed it takes 0,6625 s that is 663 ms.
At a rate of 10 Hz we have a margin of
$$\frac{663 \ [ms]}{100 \ [ms/\text{pkt}]}=6,63\ [\text{pkt}]\longrightarrow \text{max 6 consecuitve packets lost}$$
And from here the probability to crash, having packet loss $p$ is:
$$P[\text{at least one arrives}](p)=1-p^6$$
---
Now consider this system:
- $D=663 \ [ms]$ the max latency
- $T=100 m[s]$ the send period
- $\tau$ the network latency
- $p$ the packet loss probability

Here the packet sent at time $t_i=iT$ will arrive at $t=t_i+\tau$ and it must satisfy $t\leq D$
From here the number of packets that can be sent in time is
$$N(\tau)=\begin{cases}
\displaystyle\left\lfloor\frac{D-\tau}{T}\right\rfloor+1 &\text{if } \tau\leq D\\
0 &\text{if } \tau>D
\end{cases}$$
And then we obtain
$$P_{\geq1}(p,\tau)=\begin{cases}
1-p^{N(\tau)} &\text{if } \tau\leq D\\
0 &\text{if } \tau>D
\end{cases}$$
---
Now consider the full system:
- $S$ brake threshold
- $d_{brake}$ braking distance
- $v_{max}$ top speed
- $m$ required final safety margin
- $T$ send period
- $p$ packet loss probability
- $\tau$ one way network latency
- $d_{final}(S)=S-d_{brake}$ final position

We assume the packets are sent at times $t_i=iT$, $i=0,1,...$ and the packet arrives at $t=t_i+\tau$. 
Now we must find the maximum extra distance the bot can travel before braking. 
$$\Delta d_{max}(S)=d_{final}(S)-m=S-d_{brake}-m\geq 0$$
(if it is $<0$ then we crash)
From here we have the max delay:
$$\Delta t_{max}(S)=\frac{\Delta d_{max}(S)}{v_{max}}$$
As before, the packets that can still arrive in time are
$$N(\tau,S)=\begin{cases}
\displaystyle\left\lfloor\frac{\Delta t_{max}(S)-\tau}{T}\right\rfloor+1 &\text{if } \tau\leq \Delta t_{max}(S)\\
0 &\text{if } \tau>\Delta t_{max}(S)
\end{cases}$$
And finally the crash probability is:
$$P_{\geq1}(p,\tau,S)=\begin{cases}
p^{N(\tau,S)} &\text{if } \tau\leq \Delta t_{max}(S)\\
0 &\text{if } \tau>\Delta t_{max}(S)
\end{cases}$$
---
Now suppose that the braking acceleration is constant. We obtain that it is
$$\begin{align}
&a_{distance}=\frac {v^2}{2d}\approx 0.692 \ [m/s^2]\\
&a_{time}=\frac vt\approx 0.696 \ [m/s^2]
\end{align}
\quad\longrightarrow a\approx 0.694 \ [m/s^2]$$
Now we can also find 
$$d_{brake}(v)=\frac{v^2}{2\cdot 0.694}=\frac{v^2}{1.388}$$
And therefore we can redo the previous calculations by setting 
$$d_{max}(S,v)=S-d_{brake}(v)-m=S-\frac{v^2}{1.388}-m$$



---
Finally notice that the bot has the lidar 18 cm from the front, therefore:
- $S \ [cm]$ brake threshold
- $d_{brake}=46.2 \ [cm]$ braking distance
- $v_{max} = 80 \ [cm/s]$ top speed
- $m \ [cm]$ required final safety margin
- $T = 100\ [ms]$ send period
- $p\in[0,1]$ packet loss probability
- $\tau \ [ms]$ one way network latency
- $L=18 \ [cm]$ sensor distance from front

It therefore should stop when the sensor is at distance $m+L$ and therefore the last instance to brake is at $m+L+d_{brake}$:
$$
\begin{gather}
\Delta d_{max}(S,m)=S-d_{brake}-m-L\geq 0 \ [cm]\\
\Delta t_{max}(S,m)=1000\cdot \frac{\Delta d_{max}(S,m)}{v_{max}} \ [ms]\\
N(\tau,S,m)=\begin{cases}
\displaystyle\left\lfloor\frac{\Delta t_{max}(S,m)-\tau}{T}\right\rfloor+1 &\text{if } \tau\leq \Delta t_{max}(S,m)\\
0 &\text{if } \tau>\Delta t_{max}(S,m)
\end{cases}\\
P_{\geq1}(p,\tau,S,m)=\begin{cases}
1-p^{N(\tau,S,m)} &\text{if } \tau\leq \Delta t_{max}(S,m)\\
0 &\text{if } \tau>\Delta t_{max}(S,m)
\end{cases}
\end{gather}$$

---
Let $\tau,p$ be the one sided network delay and packet loss respectively, then let
$$\tau_t=2\tau\qquad p_t=1-(1-p)^2$$
be the total network delay and packet loss probability.
Now define these parameters:
- $S \ [cm]$ brake threshold
- $d_{brake}=45.6 \ [cm]$ braking distance
- $v_{max} = 83 \ [cm/s]$ top speed
- $m \ [cm]$ required final safety margin
- $T = 100\ [ms]$ send period
- $L=18 \ [cm]$ sensor distance from front

Now, when the sensor reaches the position S the sensor data will arrive after a time $\tau$ and with probability $p$. Also the response will have this properties.
The bot must start braking before reaching the critical distance that is defined as
$$d_{max}=m+d_{brake}$$
Therefore, from the moment the sensor reaches the brake threshold it can still safely travel a distance of
$$\Delta d_{max}=S-L-m-d_{brake}$$
This distance is traveled in
$$\Delta t=1000\cdot\frac{\Delta d_{max}}{v_{max}}$$
Now the problem becomes a sequential probability as the packet of the sensor data must first arrive and only after it gets delivered the brake signal will be sent and it must also be delivered.

First we must find the expected time the data sensor packet gets delivered. 
Packet $i$ arrives at time $t_i=\tau+iT$, but this has a success rate of $1-p$. 
The probability that a packet arrives at time t is $$P(t_i=iT+\tau)=p^i(1-p)$$ and therefore the expected arrival time is
$$\mathbb E[t]=\sum_{n=0}^\infty(nT+\tau)p^n(1-p)=\tau+\frac{pT}{1-p}$$
Proof:
Rewrite the sum as two sums:
$$\sum_{n=0}^\infty(nT+\tau)p^n(1-p)=\sum_{n=0}^\infty nTp^n(1-p)+\sum_{n=0}^\infty\tau p^n(1-p)$$
The firs sum results
$$\sum_{n=0}^\infty nTp^n(1-p)=\sum_{n=0}^\infty nTp^n(1-p)=T(1-p)\sum_{n=0}^\infty np^n=T(1-p)\frac{p}{(1-p)^2}=\frac{pT}{1-p}$$
The second sum is
$$\sum_{n=0}^\infty\tau p^n(1-p)=\tau(1-p)\sum_{n=0}^\infty p^n=\tau(1-p)\frac{1}{p-1}=\tau$$
Finally we have
$$\mathbb E[t]=\tau+\frac{pT}{1-p}$$
$\begin{flalign} &&\square \end{flalign}$
This result is also valid for the brake signal sent by the controller. Therefore to avoid the crash we must have $$2\mathbb E[t]\leq\Delta t$$
Therefore we have found a bound for the safety of the system.

The number of packets that can be safely sent before crashing is
$$N=\left\lfloor\frac{\Delta t-2\tau_p}{T}\right\rfloor$$

Now let X be a geometric rv that tells the time until the sensor packet succeeds.
$$P(X=nT+\tau)=p^n(1-p)$$
Now let Y be a geometric rv that tells the time until the brake packet arrives. Notice how$X\not\perp Y$ as Y has 0 success probability until X has had at least one success.
$$P(Y=mT+\tau)=p^m(1-p)$$

A crash happens if 
$$Z=X+Y>\Delta t$$
Let $n,m$ be the number of retries for X and Y respectively, then $n+m\leq N$.

$$P_{crash}=P_{\text{data fail}}+P_{\text{brake fail}}$$
$P_{\text{data fail}}$ is simple to calculate, this is
$$P_{\text{data fail}}=p^{N+1}$$

$P_{\text{brake fail}}$ is a bit more cumbersome:
Suppose the data packet arrives successfully at attempt $n\leq N$, then the remaining attempts for the brake are $m=N-n$. And therefore The failure of the brake is given for $p^{m+1}=p^{N-n+1}$.
The final probability is $$P=\sum_{0}^{N}(1-p)p^np^{N-n+1}=\sum_{n=0}^m(1-p)p^{N+1}=(1-p)p^{N+1}(N+1)$$
Finally $P_{crash}=p^{N+1}(1+(1-p)(N+1))$



# 4) Something
right now the cmd_vel is only used when received. In case of packet losses it will brake slower. Here is the comparison between an ideal case and a bad case with 300ms latency and 50% packet loss
My mathematical model shows the following curve for 300ms latency
![[Pasted image 20250908203427.png|Model 300ms Latency 50% Packet Drop|450]]
With p=50% we have crash probability of 50% and avg distance of $31.8-L/2=22.8$m. 

![[Pasted image 20250908202918.png|Example|450]]
Brake at 7.300 s (new) vs 7.299 s (old) from start moving
Stop  at 8.450 s (new) vs 9.750 s (old) from start moving
Brake->Stop duration: 1.150 s (new) vs 2.451 s (old)

While this is the best case I obtained
![[Pasted image 20250908204238.png|Best Case|450]]
Brake at 7.300 s (new) vs 7.250 s (old) from start moving
Stop  at 8.450 s (new) vs 8.650 s (old) from start moving
Brake->Stop duration: 1.150 s (new) vs 1.400 s (old)

Finally, after 14 tests I achieved this result of 57% and avg distance of 0.235. Which shows a godd approximation with a conservative model.

However the model breaks a bit when the brake distance varies since constant acceleration was used.
This can be avoided by adding a node on the bot side that keeps doing the last received input. Moreover it is also possible to force a brake if no input was received for more than n seconds (or k ticks). This also works as a packet loss detector

# 5) DATA
Ideal with smart implementation: S=0.87 m


In lab:
175 cm from obstacle and S = 50 cm brake and v=0.50 m/s and brake 9cm L=12.5
200 L 0 P = 8 cm exact with model 20-12.
320L 15%P crash as expected SMART 57-12 cm. 583, 587



S = 101; %202;           % brake threshold (cm)
d_brake = 9; %45.57;   % braking distance (cm)
vmax = 40; %83.18;      % max speed (cm/s)
m = 0; %5;             % safety margin (cm)
bot_length = 12.5; %18;   % bot length (cm)
T = 100;    

STARLINK 50L 2% 30-12. vs 20 ideal 
STARLINK 50L 10%P 0.29-12 vs 17 ideal