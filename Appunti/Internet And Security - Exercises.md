# 1) DLL
In a link, given **C** and **L** the **time to start to transmit all the message** is $T=L/C$
#### Packet Switched Networks
This exercise is only tedious, not hard.
- Draw one line for every interface and it's destination. Start from the source then move to the destination
- On each link calculate, starting from the first packet, the arrival time and the transmission time. Then also add the propagation time separately
	- If a packet arrives while a packet is still being transmitted it is queued and will have arrival time = propagation time of previous
- Remember that often different links have different queues

![[Pasted image 20250705194139.png|Example|450]]
#### UDP
Here you just:
- find the bottleneck
- find how many packets are sent $k$
- $$T = \mathop{\sum}\limits_{i\not=b} (T_i + \tau_i) + kT_b + \tau_b=\sum_i(T_i+\tau_i)+(k-1)T_b$$
>[!rmk|*]
>UDP doesn't offer ACK so the time is just until the reception of the last packet

<div style="page-break-after: always; visibility: hidden;"></div>

#### GBN ARQ
Find number of complete windows $N_C$ and the number of packets in the last window $N_L$$$
\begin{align}
&N_C=\lfloor\frac{k}N\rfloor\\
&N_L=k-N_c\cdot N
\end{align}$$
**On every link:**
- check $\forall$ links if they offer continuous transmission $$N\cdot T_i\geq RTT=T_i+2\tau_i$$
- If one or more links don't satisfy this we must:
	- In non bottleneck links we can send continuously
	- The packets will queue at the start of bottleneck link. Here there will be an idle time between the windows. This can be found by **finding the difference of time of the transmission of the last packet and the arrival of the ack of the first packet** $$\Delta t_\text{idle}=T_b+2\tau_b-NT_b$$
	- The time to send a complete window through the bottleneck link is $RTT_b=T_b+2\tau_b$
	- $$\begin{align}T&=\sum_{i}(T_i+\tau_i)+N_C\cdot RTT_b+(N_L-1)\cdot T_b\ (+ACK\text{ if needed})\\
	&\stackrel{\text{ACK}}\rightarrow\sum_{i}(T_i+2\tau_i)+N_C\cdot RTT_b+(N_L-1)\cdot T_b\end{align}$$
- If all links are continuous it behaves like UDP but **we must add ack**
$$T=T_{UDP}+ACK=T_{UDP}+\sum_\text{all links}\tau_i=\sum_i(T_i+2\tau_i)+(k-1)T_b$$

![[Pasted image 20250707180756.png|Non Continuous GBN For All Links Example|350]]
**End To End:**
- Check with bottleneck link if it allows for continuous stream: $$N\cdot T_b\geq RTT_{e2e}=\sum (T_i+2\tau_i)$$
- If this is not satisfied we have
	- each window is sent every $RTT_{e2e}$
	- The idle time is given by$$\Delta t_\text{idle}=RTT_{e2e}-N\cdot T_1$$
	- $$\begin{align}
	T&=\sum_{i}(T_i+\tau_i)+N_C\cdot RTT_{e2e}+(N_L-1)\cdot T_b\ (+ACK\text{ if needed})
	\\
	&\stackrel{\text{ACK}}\rightarrow\sum_{i}(T_i+2\tau_i)+N_C\cdot RTT_{e2e}+(N_L-1)\cdot T_b=(N_c+1)RTT_{e2e}+(N_L-1)\cdot T_b
	\end{align}$$
- If all links are continuous it behaves like UDP but **we must add ack**
$$T=T_{UDP}+ACK=T_{UDP}+\sum_\text{all links}\tau_i=\sum_i(T_i+2\tau_i)+(k-1)T_b=RTT_{e2e}+(k-1)T_b$$
![[Pasted image 20250707163215.png|Non Continuous GBN E2E Example |400]]
>[!rmk|*]
>Clearly if the idle time is negative then there is NO idle time and the link is not a bottleneck

>[!rmk|*] TO
>The minimum TO is of RTT. Each TO timer starts when a packet is sent. If in the $n$-th window, the $k$-th packet is lost the TO will end at
>$$T^*=(n-1)RTT+(k-1)T_1$$

<div style="page-break-after: always; visibility: hidden;"></div>

#### S&W ARQ
**On each link:**
Here each packet get's sent upon receiving the ack of the previous one. The bottleneck link will queue packets. This is easily seen by graphically drawing the first few packets and their times. Therefore the main bottleneck will be given by $$RTT_b=T_b+2\tau_b=\max\{T_i+2\tau_i\}$$
And the time will be
$$\begin{align}
T&=\sum_{i}(T_i+\tau_i)+(k-1)RTT_b\  (+ACK\text{ if needed})\\
&\stackrel{ACK}\rightarrow\sum_\text{all links}(T_i+2\tau_i)+(k-1)RTT_b
\end{align}$$

![[Pasted image 20250707172802.png|S&W On Each Link Example|350]]


**End To End**
Here each packet gets sent after the ack on the last link is received back. This will simply be
$$T=k\cdot RTT_{e2e}=k\cdot\sum_\text{all links}(T_i+2\tau_i)$$
![[Pasted image 20250707173102.png|S&W E2E Example|350]]

<div style="page-break-after: always; visibility: hidden;"></div>

#### Mix Between Links With GBN and S&W ARQ
I believe that this section is better done ad hoc for every exercise by graphically drawing the packets and understanding where the bottlenecks are located and how the transmission behaves.

To find the bottleneck we find how much time a window takes to be sent (even on S&W)
- GBN: N packets are sent in $T+2\tau$ if there is no bottleneck
- S&W: N packets are sent in $N\cdot RTT=N(T+2\tau_i)$
The slowest one is the bottleneck

In generale we can use the rules found in the previous chapters:
- GBN: behaves either like UDP or if the link is bottlenecked  the packets will queue at the end
- S&W: can be seen as e2e on each link that has it

![[Pasted image 20250707175719.png|Example GBN,GBN,S&W|400]]
In fact it turns out that even though the queue happens in 2 places only the last link is the bottleneck. Numerically we obtained that:$$\begin{align}
&\text{GBN}_1: &&T_1+2\tau_1=2.66\ [ms]\\
&\text{GBN}_2: &&T_2+2\tau_2=11.25\ [ms]\\
&\text{S\&W}_3: &&N(T_3+2\tau_3)=20\ [ms]\rightarrow \text{bottleneck}
\end{align}$$
If S&W is bottleneck (all packets queue at start of this link)
$$T=\sum_{i}(T_i+\tau_i)+(k-1)(T_b+2\tau_b)\ (+ACK \text{ if needed})$$
If GBN is bottleneck (all packets queue at start of this link)
$$T=\sum_{i}(T_i+\tau_i)+N_C\cdot RTT_b+(N_L-1)\cdot T_b\  (+ACK \text{ if needed})$$


<div style="page-break-after: always; visibility: hidden;"></div>

#### TCP
Recall that the time to send one MSS is $T_{packet}=L/C \ [s]$  and for one bit it is $T=T_{bit}=1/C \ [s]$.


With TCP we have:
$$\begin{align}
&BDP=R_{net}\cdot RTT&&=R_{bottlenexck}\cdot RTT [bits]\\&&&=\frac{R_{bn}\cdot RTT}{1\  MSS} [pkts]\\
&\text{Throughput} = \frac{cwnd_\max}{RTT}
\end{align}$$
Setup times:
$$\begin{align}
&\text{No Piggyback: } &&T_{setup}=2\cdot\sum\tau_i\\
&\text{No Piggyback: } &&T_{setup}=(SYN)+(ACK+SYN)+(ACK+PIGGY)\\&&&\phantom{T_{setup}}=\sum T_i+3\cdot\sum\tau_i
\end{align}$$
Now let's go to the **send time, here $T_{setup}$ is always with no piggyback assumed since it is already counted in 1st transmission:**

>[!claim|*] Intuition behind the formula
>- ***Non* Continuous Flow:**$$T=T_{setup}+s\cdot RTT+(c-1)T_{bottleneck}+\beta$$
>	- s: is the number of windows sent
>	- c: is the packets sent in the last window (minus 1)
>	- $\beta$ is:
>		- 0 if we want last ack
>		- $\sum(T_b+\tau_i)-RTT$ if we want last bit (we see last window as UDP)
>
>
>- **Continuous Flow:** $$T=T_{setup}+s\cdot RTT+(c-1)T_{bottleneck}+\alpha$$
>	- s: is the number of windows before cf was reached
>	- c: is the packets sent in cf (minus 1)
>	- $\alpha$ is 
>		- RTT if we want the final ack
>		- $\sum (T_i+\tau_i)$ if we want reception of last byte
>	- The final $\alpha$ is due to the fact that cf is "one big last window", that is now coherent with the non continuous case

1) Find the amount of TCP MSS packets to send and also the continuous flow condition:$$\text{swnd}\cdot T_{bottleneck}\geq RTT\rightarrow \text{swnd}\geq\frac{RTT}{T_{bottleneck}}=RTT\frac{R}{L=1 \ MSS}=\lceil BDP\rceil$$
2) **SS**: see how many windows $s$ it takes to reach sshthresh and calculate how many packets were sent: $$\begin{align}
&s=\lfloor\log_2(sshthresh)\rfloor \\
&p = \sum_{i=0}^{s-1}(2^i)=2^{s}-1
\end{align}$$ in some rare cases it is possible that we already sent enough packets before reaching sshthresh.
- **CS**: we set $\lceil BDP\rceil=C$, now calculate **(if rwnd is negligible)**. $C$ is the value of cwnd where we stop (last we send C-1 pkts max)$$\begin{align}
&s'=C-2^s\\
&p'=\left(\sum_{i=p}^{C-1} i\right)=\frac{(C-p)(C+p-1)}{2}\\
&\text{In total have sent p' packets in s+s' windows} 
\end{align}$$
	- If $p'\leq M$ we reach continuous flow  Now the remaining $c=M-(p')$ packets are sent in continuous flow $$T=T_{setup}+(s+s')RTT+(c-1)T_{bottleneck}+\alpha$$
	-  If  $p'\geq M$ continuous flow is **never reached** and thus we send all packets in CS. To solve this find the solution to $p'(C)=M$ for C (often very easy just count, otherwise 2nd deg equation). This is the swnd stop point. The last window sent a total of $c$ packets (find graphically) $$T=T_{setup}+(s+s')RTT+(c-1)T_{bottleneck}+\beta$$


>[!rmk|*]
>IF CS is not reached C is found as
>$$C=\frac{1+\sqrt{1+8M+4p(p-1)}}{2}$$
>If $C\in\mathbb N$ then you can redo the CC step normally.
>
>If $C\not\in\mathbb N$ then take the floor $C\leftarrow \lfloor C\rfloor$ and compute CC now we have the following:
>- $s+s'+1$ windows ($s+s'$ **complete**)
>- $p'\leq M$ and therefore the last window will have $c=M-p'$ packets

>[!rmk|*]
>In general to find the time just expand as much as possible the calculations
>- In CF we are limited by BN:
>$$\begin{align}
T&=T_{set}+(s+s')RTT+T_1+\\
&+\tau_1+...+cT_b+\tau_b+... \text{ here all arrived} + \sum\tau_i \text{ here ACK arrived}
\end{align}$$
>- In CC we have:
>$$\begin{align}
T&=T_{set}+s_{complete}RTT + \text{ here all complete windows are sent}\\
&\stackrel{\text{ACK}}\rightarrow+RTT+(c-1)T_b\text{ here we just count in windows}\\
&\stackrel{\text{last bit}}\rightarrow+(c-1)T_b+\sum(T_i+\tau_i) \text{ here last window is seen as UDP}
\end{align}$$

>[!rmk|*]
>If we are CC and send exactly $s$ windows $N_L=0$ we have
>- Last ack: s=s and c=cwnd
>- Last bit: s=s-1 and c=cwnd

#### Error in Transmission
In general if there is one error in the transmission we split the problem in 2 parts; before and after the error. The second part is seen as an errorless transmission with $M'=M-p'_1$ packets the time starting with an offset $T=T_2+TO+T_1=T_2+T'$. Two main cases occur:

- **We loose all in flight packets** of the $n$-th window.
$$T'=T_{setup}+(n-1)RTT+TO$$
- **We loose a segment instead of a window** we must consider the TO to start when the segment is sent. Segment lost in window $n$ at position $k$. Then the to starts in that window at time $$(k-1)T_1$$
	And the time before the TO becomes$$T=T_{setup}+(n-1)RTT+(k-1)T_1+TO$$

Based on what type of TCP we have, different TO conditions occurr
- In **Fast RETX** after a TO we have **ssh=cwnd/2** and **cwnd=1**

But in TCP Reno and later maybe TO isn't even waited for (see theory part)
#### RWND non negligible
If **rwnd is non negligible** redo point **CS** with $C=$ rwnd to find how many packets were sent until that point. Three cases occurr:
- **rwnd is not reached**: same as before
- **rwnd is reached but after CF threshold**: same as when CF is reached
- **rwnd is reached and limits the connection**

If the last case happens then we just find how many packets and windows were sent until rwnd was hit. The calculate $N_C$ and $N_L$ and then the time is calculated similarly to the case where we're stuck in CC. Just with $c=N_L$ and s the number of windows until rwnd was reached $+N_L$
#### Example
![[Pasted image 20250705194715.png|Example|550]]
This shows 2 areas due to a TO at the 7-th window:
- Recall that the n-th window ends where n is on the x axis
- In the first part SS is shown, then we are limited to rwnd=4
- **After the TO sshthresh is halved (floor)**
- therefore in second part SS goes only until 2, then CC and then at swnd=rwnd we are again limited

Calculations:
$$\begin{align}
&\text{First Part:}
&&\text{Second Part:}\\

&\text{-SS: }\begin{cases}s=2\\p=3\end{cases}
&&\text{-SS: }\begin{cases}s'_{SS}=1\\ p'_{SS}=1\end{cases}\\

&\text{-No CC:}
&&\text{-CC:}\begin{cases}s'_{CC}=4-2^1=2\end{cases}\\

&\text{-Until 7-th window we send another }4\cdot 4=16 \text{ pkts}
&&\text{-Only }M''=M'-p'=15\text{ pkts left}\\&&&\text{this is }3\text{ windows}+3\text{ pkts}\\

&\text{In total: }\begin{cases}s=6\\p=19\end{cases}\rightarrow M'=21 &&\text{In total: }\begin{cases}s'=s'_{SS}+s'_{CC}+3=6\end{cases}
\end{align}$$
Finally we have:
$$\begin{align}T&=T_{set}+T_1+TO+T_2+\alpha\\
&=T_{set}+s\cdot RTT+TO+(s'_{SS}+s'_{CC}+N_C)\cdot RTT+(N_L-1)\cdot T_b+\gamma
\end{align}$$
Keep an eye on $\gamma$ since it might be very different in many cases, it depends on
- final transmission condition (SS, CS, CF, limited)
- ack or last byte

For CC and CF this second part is easily seen as an errorless TCP
- **CF**
	- $\gamma=\alpha$ as stated before
- **CC**
	- $\gamma=\beta$ as stated before

- **limited**
	- $\gamma=\beta$

>[!rmk|*] $\gamma$ MIGHT BE WRONG


<div style="page-break-after: always; visibility: hidden;"></div>

#### Estimate C, $\tau$ from Pin
A ping has this formula:$$RTT=2\left(\sum(T_i+\tau_i)\right)$$
with $T_i,\tau_i$ the parameters of the links the ping goes through. One value of I will be our two values to find. Once you have 2 RTT just solve the system.
>[!rmk|*]
>Recall that everything must have the same unit of measure so if $L$ is in bytes write it in bits and $C$ in bps (not Mbps) and the term $10^3$ is to put it in ms
>$$T_i=\frac{L\cdot 8}{C}\cdot10^3$$

#### Packet Size
LL_header_size = 36 bytes 
This means that TCP pkts are encapsulated into LL ones (1 TCP pkt encapsulated into 1 LL pkt, by adding LL headers)
**LL-pkt-size = LL-hdr-size + TCP-seg-size**

While the payload is:
**TCP_payload = TCP_seg_size - IP_hdr - TCP_hdr**
#### Throughout
E2E:
$$\eta_\max=\frac{W_\max}{RTT} \text{  with: } RTT=\sum RTT_i$$
and then:
$$\boxed{B\approx\min\left\{\frac{W_\max}{RTT}, \displaystyle\frac1{RTT\sqrt\frac{2bp}3+T_o\min\{1,3\sqrt{\frac{3bp}8}\}p(1+2p+4p^2)}\right\}}$$
finally $$\eta=B\times\text{TCP\_payload}$$
in **bits**

at the app layer we have **TCP_payload-APP_hdr_size**

![[Pasted image 20250709130029.png|Example|350]]
When more than one connection is active at a time:
Find the allocation rate of each link
$$\xi_i=\frac{b_i}{\sum b_j}$$
with $\sum b_j=B$ and $\sum \xi_i=1$ and thus $b_i=B\cdot \xi_i$
For each connection the throughput is $$\eta_i=\min\{\eta_{i_{E2E}}, b_i\}$$
#### Packet Error Rate
The error over one link is:
We compute the **error rate for a single TX** of a LL pkt, as
$$\tilde p=1-(1-P_{bit})^L$$

Where (LL encapsulation) : **L=(LL_hdr+TCP_seg_size)$\times$ 8**

The LL **“residual” pkt error rate** is$$p=(\tilde p)^M$$

The E2E pkt error rate from two points is:
$$p_{E2E}=1-\sum(1-p_i)$$
BUT actually if $p_{E2E}=0$ then the slowest link is bottleneck
#### RETX TO
Variance over path:
$$\sigma_{E2E}^2=\sum\sigma_i^2$$
from here $$MAD_{E2E}=\sigma_{E2E}\sqrt\frac2\pi\approx0.798\sigma_{E2E}$$
From here the **retx timeout is estimated as**
$$RTO=RTT_{E2E}+4\cdot MAD_{AE}$$
And finally the **timeout timer is:**$$T_0=\min\{RTO,1\ [s]\}$$

<div style="page-break-after: always; visibility: hidden;"></div>

## 1.2) Theory
#### TCP "Old" Tahoe
**Implements:**
- Slow Start
- Congestion Avoidance
- Error recovery only with time out: it RETX from first unACK pkt

#### TCP Tahoe (Fast Retx)
**Implements:**
- Slow Start
- Congestion Avoidance
- Fast Retransmit (FR)

FR works by sending the missing segment given by dupAck and then restarting the connection (SS, cwnd=1, ssthresh W/2).
#### TCP Reno (Fast Recovery)
**Setting cwnd=1 is too aggressive**, we advance cwnd by sshthrehs+ the number of dupacks recieved (does not violate pkt conservation). In Reno we enter **Fast Recovery** at the third dup ack:
![[Pasted image 20250710224740.png|Pseudocode|450]]
![[Pasted image 20250415170514.png|Pseudocode With K =3 dup acks|450]]
This means that we set the new sshtresh and we retx the missing frame. Then we advance the window by K dup akcs received. We then send the new packets (and advance windows) and receive dupacks (since we have halved W) Finally after sending all missing data we start from CA
#### 4.2.3) TCP New Reno
This implements **Multiple RETX Fast Recovery**
![[Pasted image 20250415172023.png|Pseudocode with K=3|650]]
#### 4.2.3) TCP New Reno with Selective ACK
![[Pasted image 20250415171545.png|Pseudocode|650]]
![[Pasted image 20250710224923.png|Example|600]]
# 2) Network
#### Assign IP 
Hubs don't need IP addresses
Start from lowest

#### Routing Tables
We construct a routing table in the following way:

| Index (not needed) | Name       | Destination | Netmask | Next Hop |
| ------------------ | ---------- | ----------- | ------- | -------- |
| 1                  | LAN A      | 30.20.0.176 | 28      | Direct   |
| 2                  | LAN B      | 40.20.0.0   | 16      | 10.0.0.1 |
| 3                  | LAN C      | 30.20.0.176 | 28      | 10.0.0.2 |
| 4                  | Default Gw | 0.0.0.0     | 0       | 10.0.0.2 |
1) This LAN is directly connected to the router
2) This is a common configuration
3) **CROSSOUT:** in this case the next hop=default gw hop and we can delete it
4) Default gateway is always the last entry.

>[!rmk|*]
>- Avoid slow links
>- If a router is then directly connected to one host we can omit DTS+MASK in the routing table


#### How Packets Are Routed
Som exercises don't require the building of routing tables, but already provide one and also the interface config and ask you how some packets are routed.
![[Pasted image 20250707164023.png|Exercise Example|450]]
There are some easy steps to follow:
- Find the network addresses + range of the IP Addresses in the Interface Config table
- For all entries in the Routing table write the range of IPs, the netmask in decimal and finally what interface is associated to the next hop
Now for every packet to route do the following:
- Check if destination is IP address of one interface. This is **delivered to upper layers**
- Check if the destination is in the interface config, if it is it is **directly forwarded**
- Otherwise check in the routing table by starting with the **biggest netmask**. If no network matches the default gateway is used. In this case the packet is **indirectly forwarded**

- Check what interface the packet is sent from and where it is routed to. If it is sent to the same interface it comes from then no forwarding is done

- Check what interface it is forwarded to to see the MTU
	- If  $\text{Packet Size}<MTU$ nothing happens
	- If $\text{Packet Size}>MTU$ the packet must be fragmented
		- If **Don't Fragment Bit = 1** the packet is dropped
		- If **Don't Fragment Bit = 0** the packet is fragmented in $\lfloor\frac{\text{Packet Size}}{MTU}\rfloor$ complete fragments + one smaller last fragment, this is  $\lceil\frac{\text{Packet Size}}{MTU}\rceil$ fragments.
## 2.2) Theory
Ipv4 is a **32-bit ($2^{4+1}$) address** (with a total of $2^{32}$ addresses) that addresses an unique connection to the internet. It is universal since it is accepted by any host

IPv4 is **hierarchical** as it is divided into two parts:
- NetID: prefix of length $n$ and defines the network
- HostID: suffix of length $32-n$ and defines the host in the network
![[Pasted image 20250323170931.png|IPv4|550]]
Nodes on the same network have same NetID and different HostID. Nodes in different networks have different NetID and can have same HostID.


Originally IP were thought as **classfull**, that is there were 3 fixed lengths (8, 16, 24) with 5 spaces (A, B, C, D, E) that had a fixed prefix
![[Pasted image 20250423122450.png|Classfull|450]]
This approach has many flaws, therefore we resort to **classless** addressing, where n has a variable length.


| Class | First bits | # net bits | # node bits    | # networks | # nodes    | from      | to              |
| ----- | ---------- | ---------- | -------------- | ---------- | ---------- | --------- | --------------- |
| A     | 0          | 7+1        | $32-(7+1)=24$  | $2^7-2$    | $2^{24}-2$ | 0.0.0.0   | 127.255.255.255 |
| B     | 10         | 14+2       | $32-(14+2)=16$ | $2^14$     | $2^{16}-2$ | 128.0.0.0 | 191.255.255.255 |
| C     | 110        | 21+3       | $32-(21+3)=8$  | $2^21$     | $2^{8}-2$  | 192.0.0.0 | 223.255.255.255 |
Where the -2 in the # nodes tab is for the broadcast/network addresses and the -2 in the A class # networks are the two reserved network addresses

>[!rmk|*] How to obtain addresses
>The start/finish addresses are done by:
>- start: all bits (besides class) to 0
>- finish: all bits (besides class) to 1
>
>Network address:
>- All HostID bits to 0
>
>Broadcast address:
>- All HostID bits to 1

#### Classless InterDomain Routing (CIDR) & Netmask
Classless addressing sets an arbitrary value for n, therefore we need to define a new way to identify a network.

>[!def] Classless InterDomain Routing
The slash notation represent the **Classless InterDomain Routing** (CIDR) representation:
>$$1\text x8.1\text x8.1\text x8.1\text x8/\text n, \space \text n\in[0,32]\in\mathbb N$$
>
>
|                         | Operation                                     |
| ----------------------- | --------------------------------------------- |
| Number of Addresses (N) | $N=2^{32-n}$                                  |
| Number of Hosts         | $N-2=2^{32-n}-2$                              |
| Network Address         | last $32-n$ bits $= 0$$\iff$HostID bits to 0  |
| Broadcast Address       | first $32-n$ bits $= 1$$\iff$HostID bits to 1 |


>[!def] Netmask
>Given an address and a value for n we define the **netmask** as a 32-bit sequence starting with n ones and the rest are all zeroes 
>Example:$$192.168.1.7/27 \rightarrow \text{netmask: } 1\text x8.1\text x8.1\text x8.11100000$$
>This allows to find the related info with bit-wise operations (NOT, AND, OR)
>
|                     | Operation                         |
| ------------------- | --------------------------------- |
| Number of Addresses | **NOT**(mask)+1                   |
| Number of Hosts     | **NOT**(mask)-1                   |
| Network Address     | Any address in block **AND** mask |
| Broadcast Address   | Any address in block **OR** **NOT**(mask)  |

>[!example|*]
>Suppose we have the ip:
>$$192.168.1.7/27\iff11000000.10101000.00000001.00000111/27$$
>CIDR:
>- Number of Addresses = $2^{32-27}=32$
>- Network (first) Address: $$32-27=5\rightarrow11000000.10101000.00000001.00000000/27\rightarrow192.168.1.0/27$$
>- Broadcast (last) Address:$$32-27=5\rightarrow11000000.10101000.00000001.00011111/27\rightarrow192.168.1.31/27$$
>- From here we can see that we have exactly 32 addresses (from .0 to .31)
>
>Netmask:
>- Netmask: $$11111111.11111111.11111111.11100000\rightarrow 255.255.255.112$$
>- Number of Addresses: $$00000000.0000000.00000000.0001111+1=10000\stackrel{\text{dec}}=32$$
>- Network Address: $$\begin{matrix}
& 11111111 & 11111111 & 11111111 & 11100000\\
& 11000000 & 10101000 & 00000001 & 00000111\\
\text{AND:}& 11000000 & 10101000 & 00000001 & 00000000 & \rightarrow 192.168.1.0/27
\end{matrix}$$
>- Broadcast Address: (OR)
>$$\begin{matrix}
& 00000000 & 00000000 & 00000000 & 00011111\\
& 11000000 & 10101000 & 00000001 & 00000111\\
\text{OR:} & 11000000 & 10101000 & 00000001 & 00011111 & \rightarrow 192.168.1.31/27
\end{matrix}$$
>- This is the same as before

Here is a quick reference table with some useful numbers

| Binary   | Decimal |
| -------- | ------- |
| 11111111 | 255     |
| 11111110 | 254     |
| 11111100 | 252     |
| 11111000 | 248     |
| 11110000 | 240     |
| 11100000 | 224     |
| 11000000 | 192     |
| 10000000 | 128     |


The association that assigns blocks of addresses to an ISP is called **Internet Corporation for Assigned Names and Numbers (ICANN)** and has to follow these rules:
- The requested number of addresses (M) must be a power of 2
- The prefix length of each block (n) is then $n=32-\log_2 M$
- The network address of the block will have $\log_2 M$ zeroes

>[!rmk|*]
If we need $k$ addresses we need to ask for $M=2^{\lceil\log_2 k\rceil}\implies n=32-\lceil\log_2 k\rceil$
#### Subnetting
A large network can be divided into further subnetworks by creating a subnetmask
![[Pasted image 20250423124934.png|Example|550]]
Here the initial HostID is divided into SubID + (new) HostID. From here the same rules as before work. Let's call $n$ the netmask, $m\leq32-n$ the subnetmask, then:
- HostID has length $32-n-m$
- Number of subnetworks: $2^m$
- Number of Addresses per subnetwork: $2^{32-m-n}$

In real world scenarios both a class and a netmask are assigned. For subnetting the netmask > class NetID bits. The class NetID bits can't be changed and thus **the number of bits $m$ for the subnet is given by netmask-class HostID bits**.

**Subnetting is achieved by having a netmask different from the bits of the class NetID**

The following steps are used fro a correct subnetting:
- $N_{sub}$ must be a power of 2
- each network has a prefix of $n=32-\log_2 N_{sub}$
- The starting address in subnetwork should be divisible by the number of addresses in the subnetwork → we need to start the process by assigning first addresses to larger subnetworks. ???

here are some useful examples:

>[!example|*]
>Suppose to have a class B (n=16) address with netmask of $255.255.255.0=24$. Then we have:
>- $32-24=8$ HostID bits
>- $24-16=8$ SubnetID bits $\implies2^8=256$ addresses
>
>Suppose to have the following IP: $147.162.8.3/24$ we can find the SubID:
>- Rewrite the IP: $147.162.8.3\rightarrow 10010011.10100010.00001000.00000011$
>- We know that the first 16 bits are used for the NetID, and the following 8 are the SubID
>- The SubID is $00001000\stackrel{\text{dec}}=8$ and the HostID is $00000011\stackrel{\text{dec}}=3$

>[!example|*]
>Create subnets with at least 500 hosts with network address $132.78.0.0$ and NetID of 16 bits:
>- Since 500 is not a power of 2 we find the closest bigger power$\rightarrow\log_2500=9\rightarrow 2^9=512$
>- Then we have HostID=9 and thus $n=\text{NetID}+m=32-\text{HostID}=23\rightarrow m = 7$
>- We subnetted to have 128 subnets with 510 hosts each

>[!example|*]
>Create at least 1000 subnets with Network address $128.234.0.0$ and NetID 16:
>- 1000 is not a power of 2$\rightarrow m=\log_21000=10\rightarrow 1024$ subnets
>- Then we have that $n=\text{NetID}+m=32-\text{HostID}=26\rightarrow \text{HostID}=6$
>- We have created 1024 subnets with 62 hosts each

>[!example|*] Uneven Subnetting
>We have the addresses $14.27.74.0/24$ and want to split them in 3 subnetworks of type:
>1) one subblock of $10\rightarrow16$ addresses $\implies\text{HostID}_1=4$
>2)  one of $60\rightarrow64$$\implies\text{HostID}_2=6$
>3) one of $120\rightarrow 128$$\implies\text{HostID}_3=7$
>
>Since we already calculated the HostID in the 3 cases we already know that $\text{HostID}_\max32-24=8$ satisfies our requirements. We use rule 3 $\rightarrow$ we start with the biggest subnetwork:
>-  $n_3=32-\text{HostID}_3=25$ and thus the network address is $14.27.74.0/25$ and broadcast $14.27.74.0.01111111/25\rightarrow14.27.74.127/25$ (128-1 difference)
>- $n_2=26$. Notice that we can't use net address of $14.27.74.0/26$ since these addresses are already taken by subnet 3. All addresses until $14.27.74.128$ are taken, these relate to SubID $00,01$ so we choose SubID=$10$ and we have net/broad addresses $14.27.74.128/26$ and $14.27.74.191/26$ (64-1 difference)
>- $n_1=28$. As before the SubIDs starting with 0 or 10 are already taken, so we use $1100$. We have net/broad addresses $14.27.74.192/28$ and $14.27.74.207/28$ (16-1 difference)

From the last exercise we can derive the following important remark:

>[!rmk|*] No overlapping
>Subnets can't have blocks that overlap. Since the IP datagram doesn't contain the netmask it will cause confusion to the routing.
>
>Moreover when deciding the network address of a block it must start with an address with HostID=0. If all the addresses from the network to the broadcast address (HostID=1) aren' already occupied the block can be used for subnetting

From here another remark can be made:
>[!rmk] Constraints on Network and Broadcast Addresses
>The final conclusion is that a network address must have HostID=0 and the broadcast address must have HostID=1. If this is not the case the given address is not a network/broadcast address or the network is badly set up.
#### Supernetting
Class A, B networks are running out, therefore we can group many class C networks to join them into a bigger network 

>[!example|*]
>We have the following blocks$$\begin{align}
193.23.136.0/24\\
193.23.137.0/24\\
193.23.138.0/24\\
193.23.139.0/24
\end{align}$$
All these go from $.0$ to $.255$ so the full range from $193.23.136.0/24$ to $192.23.139.255/24$ are covered.
These are $256\cdot4=2^{10}=1024$ addresses, exactly the number of addresses of a /22 network. From here it is clear that these can be grouped into the single block $$193.23.136.0/22$$

#### Datagram
Here is the datagram of the IP in detail:
![[Pasted image 20250427154638.png|IP Datagram|350]]
Let's focus on the header:
![[Pasted image 20250427154544.png|IP Datagram Header|550]]

| Name                  | Length (Bits) | Description                                                                                                     | More in depth                                                                                                                             |
| --------------------- | ------------- | --------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| Vers                  | 4             | version of protocol used                                                                                        | clearly always 0100                                                                                                                       |
| HLeng                 | 4             | stores the total length of the header in *bytes*                                                                | The minimum is defined as $0101\|_2=5\|_{10}\rightarrow5\cdot4=20$ Bytes. The maximum is $1111\|_2=15\|_{10}\rightarrow15\cdot4=60$ Bytes |
| Type Of Service (TOS) | 8             | defines how datagram should be handled.                                                                         | See below                                                                                                                                 |
| Total Length          | 8             | length of header + data in *bytes*                                                                              | Length of data can be found by data=Total Length - HLeng                                                                                  |
| Time To Live (TTL)    | 8             | maximum # of hops before getting dropped.                                                                       | On drop an ICMP may be sent                                                                                                               |
| Protocol              | 8             | Upper layer protocol used                                                                                       | TCP = 06, UDP=17                                                                                                                          |
| Checksum              | 16            | rough form of error detection                                                                                   | covers only header                                                                                                                        |
| IP Source/Destination | 32x2          | IP Address of Source/Destination                                                                                | These can't be changed while in flight. Netmasks are NOT included. Routing tables should handle this                                      |
| Identification        | 16            | helps destination in reassembling datagram (all fragments with same flag should be assembled into one datagram) | Same for all fragments                                                                                                                    |
| Flags                 | 3             | Fragmentation control                                                                                           | R = reserved. D = don't fragmen (if bigger than MTU send error message). M = More Fragment, this is not the last fragment                 |
| Offset                | 13            | Relative position of fragment with respect to the whole datagram                                                | It is the offset of the data in the og datagram measured in units of 8 bytes (first bit/8)                                                |
| Options/padding       | up to 40      | used for testing and debugging                                                                                  |                                                                                                                                           |

>[!rmk|*] TOS in detail
>Here are some more details on the TOS
>![[Pasted image 20250427155324.png|TOS|250]]
>![[Pasted image 20250427155401.png|TOS Bits|250]]

![[Pasted image 20250427161040.png|Fragmentation Example|650]]
The biggest problem with fragmentation is that the loss of one fragment means to lose the entire datagram. To avoid this the IP layer shouldn't exceed the MTU of the network(s) it will go to

Fragmentation **changes** the following fields:
- **Length, Flags, Offset, Header Checksum**
And doesn't change:
- Version, TOS, Id, TTL, Protocol, IP src/dst


<div style="page-break-after: always; visibility: hidden;"></div>

<div style="page-break-after: always; visibility: hidden;"></div>


![[Pasted image 20250706085742.png|Table|650]]