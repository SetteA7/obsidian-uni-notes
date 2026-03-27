# 1) Recap

# 2) Feed Forward Neural Networks (FFNN)
## 2.1) Recap On Perceptron
The perceptron is a **binary classification algorithm**, that is: $$f:\R^d\rightarrow\curly{-1,+1},\quad x\rightarrow t$$
It divides the space into two regions divided by a hyperplane. These regions are called **halfspaces**: 
$$H=\curly{x\rightarrow sign(w^Tx+b):w\in \R^d,b\in\R}$$
The decision function f is the sign: $y=f(x)=sign(w^Tx+b)$

#### Hyperplane
The hyperplane is the points that satisfy $w^Tx=K$. The hyperplane has direction given by $w$ and the distance from the origin is $w^Tx=\|w\|\|x\|\cos(\theta)$.

Now add the bias $b$. The hyperplane is the set of points that satisfy
$$w^Tx+b=0$$
and we define $v$ as the vector from the origin to the closest point of the hyperplane (perpendicular)
$$v=d\frac{w}{\|w\|}=d\cdot u_w$$
The distance can be found by substituting $x=v$:
$$w^Tx+b\stackrel{x=v}=w^Td\frac{w}{\|w\|}+b\stackrel{w^Tw=\|w\|^2}=d\|w\|+b=0\rightarrow d=-\frac b{\|w\|}$$
From here we get that: **w gives the orientation and b the distance from origin**

for convenience the bias is added as a weight: 
$$w_{d}=\begin{bmatrix}w_1\\...\\ w_d\end{bmatrix},\ x_{d}=\begin{bmatrix}x_1\\...\\ x_d\end{bmatrix}\rightarrow w_{d+1}=\begin{bmatrix}w_1\\...\\ w_d\\ b\end{bmatrix},\ x_{d+1}=\begin{bmatrix}x_1\\...\\ x_d\\1\end{bmatrix}$$
so that $y=sign(w_{d+1}^Tx_{d+1})=sign(w_d^Tx_d+b)$.
#### Training
Given a dataset of labeled points:
$$\mathcal D=\curly{(x_1,t_1),...,x_N,t_N} \quad t_n\in\curly{-1,+1}$$
start with $w^{(0)}=\vec 0$ 

A correct classification is when $(w^{(i)})^Tx_nt_n>0$. 

We must minimize the loss function:
$$\min\mathcal L(w,\mathcal D)=\min\sum_{n\in\mathcal D}l(w,x_n)=\min\sum_{n\in\mathcal D}\max(0,-w^Tx_nt_n)$$
Weights are updated when a sample is incorrectly classified:
$$w^{(i+1)}=w^{(i)}+x_nt_n$$
**At each iteration we are always improving the loss function**
Proof:
$$(w^{(i+1)})^Tx_nt_n=(w^{(i)}+x_nt_n)^Tx_nt_n=(w^{(i)})^Tx_nt_n+\|x_n\|^2>(w^{(i)})^Tx_nt_n$$
$$\endproof$$
#### Limitations
This only works for linearly separable data.

A possible solution is feature mapping: 
$$\phi(x),\phi:\R^d\rightarrow \R^m$$
but a good $\phi$ is hard to find. **Neural networks learn the feature mapping**
There are infinitely many feature mappings, we base them on two insights:
1. $\phi$ is built as a composition of multiple simpler functions ($\phi=f\ o\ g\ o\ h\ o\ ...$)
2. $\phi$ has a multi-layered stucture with increasing abstraction
## 2.2) FFNN
NN are able to learn the feature mapping. Each smaller function (neuron) is based on the perceptron.
Instead of a sign function a differentiable activation function is used.
$$y_j=f(a_j)=f\par{\sum_{i=1}^d}w_{j,i}x_i+b_j$$
![[Pasted image 20260310104558.png|Representation|250]]
## 2.3) Single Layer FFNN
>[!col]
>A layer of a FFNN is a **stack of multiple neurons**.
>The input vector is fed to a hidden layer (neurons) that have:
> -An affine transformation 
> $$a=W^{in}z+b^{in}$$
> -A non-linear activation function
> $$o=f(a)$$
>The output is therefore:
>$$y=g(W^{out}o+b^{out})$$
>
>![[Pasted image 20260310105102.png|Representation|250]]

>[!thm] Universal Approximation Capability
>Single-layer FFNN can approximate any function with arbitrary accuracy given a suitable activation function

The number of hidden neurons required is exponential in the dimension of the input space $d$. This means single-layer FFNNs are of limited use in solving practical problems. Multiple layers can be used to solve this problem.

## 2.4) Multi-Layered FFNN
#### Notation
Start with some notation:
- $w_{i,j}^{(l)}$: weights that connects neuron $i$ of layer $l-1$ with neuron $j$ of layer $l$
- $W^{(l)},b^{(l)}$: parameters of layer $l$
- $a_j^{(l)},o_j^{(l)}$: activation and output of neuron $j$ of layer $l$
- $\mathcal W$: set of FFNN parameters (weights and biases)
- $\mathcal L(\mathcal W,x)$: loss function of FFNN on input sample x
- $\mathcal D=\curly{(x_1,t_1),...,(x_N,t_N)}$: labeled training data
![[Pasted image 20260310110408.png|Repreentation|350]]
recall: $w_{\mathbf {j,i}}$ means direction $i\rightarrow j$.

#### Input-Output Relation: Forward Pass
Given an input $x$, the output is obtained with the forward pass:
- feed $x$ to the first layer: $a^{(1)}=W^{(1)}x+b^{(1)},\ o^{(1)}=f(a^{(1)})$
- Use $o^{(1)}$ as input for the second layer
- Repeat for all layers
- Get output vector as: $a^{(L)}=W^{(L)}o^{(L-1)}+b^{(L)},\ y=g(a^{(L)})$

$a^{(l)},o^{(l)}\ \forall l\in\curly{1,...,L}$ are stored for the back propagation.

#### Loss Function
The loss function represents the optimization objective of the NN training. It should reflect the learning task.

Typically:
- Negative log-likelihood (NLL) of parameters
- Assume **i.i.d** training samples $\rightarrow$ decompose NLL as sum of terms
$$\mathcal L(\mathcal D,\mathcal W)=-\log p(\curly{t_n}_{n=1}^N|\curly{x_n}_{n=1}^N;\mathcal W)=-\sum_{n=1}^N\log p(t_n|x_n;\mathcal W)$$
#### Regression (Continuous Labels and Output)
##### Output Function
for now $g$ is the identity function, therefore $y_n=a_n^{(L)}$
It allows to span the whole target space $\R^n$

##### Error Function: Mean Squared Error (MSE)
Suppose that label is given by the output + some gaussian noise: $t_n=y_n+\text{noise}$
Then the **per sample likelihood** can be written as a gaussian:
$$\underbrace{p(t_n|x_n;\mathcal W)}_\text{objective}=\mathcal N(t_n;y_n,\Sigma)$$
where we suppose $y_n$ is the mean and $\Sigma$ the covariance.

By setting $\Sigma=I$ so to focus on predicting the mean we can find the following loss function:
$$\begin{gather}
\begin{aligned}
-\log(\mathcal N(t_n;y_n,\Sigma))&\ =\frac12\sq{\log\det\Sigma+d\log2\pi+(y_n-t_n)^T\Sigma^{-1}(y_n-t_n)}\\
&\stackrel{\Sigma=I}=\frac12\sq{d\log2\pi+(y_n-t_n)^T(y_n-t_n)}
\end{aligned}\\
\downarrow\\
\mathcal L(\mathcal{D,W})\propto\frac12\sum_{n=1}^N\|y_n-t_n\|^2
\end{gather}$$
#### Classification (Discrete Labels, Continuous Output)
Since this is a classification problem, consider the binary classification case:
- 1 output neuron with $t_n\in\curly{0,1}$
- The two classes are called $\mathcal{C_0,C_1}$
##### Output Function
Usually the sigmoid function is used:
$$y_n=g(a_n^{(L)})=\sigma(a_n^{(L)})=\frac1{1+\exp{-a_n^{(L)}}}$$
This maps $\R\rightarrow[0,1]$
This can be interpreted as the probability of the output being 1 given the input: $p(\mathcal C_1|x_n)$
Or alternatively the *complementary class:* $1-y_n=p(\mathcal C_0|x_n)$.

##### Error Function: Cross-Entropy
Recalling the complementary class, the likelihood can be expressed as:
$$p(t_n|x_n;\mathcal W)=p(\mathcal C_1|x_n)^{t_n}p(\mathcal C_0|x_n)^{1-t_n}$$
and the NLL becomes:
$$\begin{gather}
\begin{aligned}
-\log p(t_n|y_n,\mathcal W)&=-t_n\log p(\mathcal C_1|x_n)-(1-t_n)\log p(\mathcal C_0|x_n)\\
&=-t_n\log y_n-(1-t_n)\log(1-y_n)
\end{aligned}\\
\begin{aligned}
\mathcal {L(D,W)}&=-\sum_{n=1}^N\log p(t_n|x_n;\mathcal W)\\
&=-\sum_{n=1}^Nt_n\log (y_n)+(1-t_n)\log(1-y_n)
\end{aligned}
\end{gather}$$
##### generalization to multi-class
This can be generalized to multi-class classification problems.
- Let there be Q labels
- Labels are expressed in one-of-Q representation (one-hot encoding)
- Use Q output neurons, each one dedicated to one of the labels

if $x_n$ belongs to a class $q$, then set $t_{n,q}=1, t_{n,i}=0 \forall i\not =q$.
this can be seen as $y_{n,q}=p(t_{n,q}=1|x_n)$

The error function is the **categorical cross entropy**
$$\mathcal {L(D,W)}=-\sum_{n\in N}\sum_{q\in Q}t_{n,q}\log (y_{n,q})$$

##### Softmax Output
In multi-class, the **output should be a discrete probability distribution overt the Q classes**. Therefore:
- $y_{n,q}\in[0,1], \ \forall q$
- $\sum_{q\in Q}y_{n,q}=1$

The most common choice is the **softmax function**
$$y_{n,q}=\frac{\exp{a_q^{(L)}}}{\sum_{i\in Q}\exp{a_i^{(L)}}}$$

## 2.5) FFNN Training (GD & BP)
The weight are updated via the **gradient descent** rule
$$(w_{j,i}\iter l)\iter {n+1}=(w_{i,j}\iter{l})\iter{n}-\eta\nabla_{w_{i,j}\iter l}L(W,x)$$
This is calculated via the **backpropagation algorithm:**
1. Execute a forward pass to obtain and store the activations and outputs at each layer
2. For the specific loss and output function, compute
$$\delta_m\iter L=\frac{\partial L}{\partial y_m}g'(a_m\iter L)$$
3. Via the backward pass, compute
$$\delta_j\iter l=f'(a_j\iter l)\sum_k\delta_k\iter{l+1}w_{k,j}\iter{l+1}$$
4. Finally obtain the gradients for all weights/biases:
$$\frac{\partial L}{\partial w_{j,i}\iter l}=\delta_j\iter lo_i\iter{l-1}\qquad\frac{\partial L}{\partial b_j\iter l}=\delta_j\iter l$$

#### Mathematical Derivation
The aim of backpropagation is to compute the gradient of the loss function with respect to all weights and biases of the network., that is
$$\frac{\partial L(W,x)}{\partial w_{j,i}\iter l},\frac{\partial L(W,x)}{\partial b_j\iter l}\quad\forall i,j,l$$
Via the chain rule of derivatives this problem can be recursive and efficient
##### Forward Pass
The forward pass consists in computing the activations and outputs at each layer of the network given an input vector:
We will store all of the following quantities:
$$o\iter l,a\iter l\ \forall l, y$$
##### Chain Rule
Consider the weight $w_{j,i}\iter l$ (going from output $i$ at layer $l-1$ to activation $j$ at layer $l$ ). The activation will be influenced by the weight (and bias) since
$$a_j\iter l=\sum_n w_{j,n}\iter lo_n\iter{l-1}+b_j\iter l$$
and the two derivatives become:
$$\begin{align}
\frac{\partial L}{\partial w_{j,i}}&=\frac{\partial L }{\partial a_j\iter l}\frac{\partial a_j\iter l}{\partial w_{j,i}}=\frac{\partial L}{\partial a_j\iter l}o_i\iter{l-1}\\
\frac{\partial L}{\partial  b_j\iter l}&=\frac{\partial L}{\partial a_j\iter l}\frac{\partial a_j\iter l}{\partial b_j\iter l}=\frac{\partial  L}{\partial a_j\iter l}
\end{align}$$
From here define the **error message as**
$$\delta_j\iter l\def\frac{\partial L}{\partial a_j\iter l}$$
which only depends on layers $>l$.

This can be recursively computed as:
$$\delta_j\iter l=\sum_{k}\underbrace{\frac{\partial L}{\partial a_k\iter{l+1}}}_{\delta_k\iter{l+1}}\frac{\partial a_k\iter{l+1}}{\partial a_j\iter l}$$
Then the first term is the error message of the $l+1$ layer while the second term can be computed as
$$\frac{\partial a_k\iter{l+1}}{\partial a_j\iter l}=\frac{\partial a_k\iter{l+1}}{\partial o_j\iter l}\frac{\partial o_j\iter l}{\partial a_j\iter l}=w_{k,j}\iter{l+1}f'(a_j\iter l)$$
(since $o_j=f(a_j)$ and $a_k\iter{l+1}=\sum_m w_{k,m}\iter{l+1}o_m\iter l+b_k\iter{l+1}$ )

Then finally:
$$\delta_j\iter l=f'(a_j\iter l)\sum_k\delta_k\iter{l+1}w_{k,j}\iter{l+1}$$
## 2.6) Activation Functions
A pletora of functions can be used as activation functions.

#### Sigmoid Activation Function
$$ $$
$$\begin{gather}f(a_j\iter a)=\sigma(a_j\iter l)=\frac{1}{1+\exp{-a_j\iter l}}\\
f'(a_j\iter l)=\sigma(a_j\iter l)\cdot\par{1-\sigma(a_j\iter l)}
\end{gather}$$
>[!col]
>This is a **soft and differentiable function** that maps $\mathbb R\rightarrow[0,1]$.
>However the the **derivative is contractive**, that is it gets smaller when the input gets bigger in magnitude. This makes the gradient vanish! The sigmoid works for shallow FFNN ($L<8$).
>Another drawback is the **bias drift** since the  output is not zero centered, that is, there is an additive bias:
>$$\E[a]=0\rightarrow\E[\sigma]\not=0$$
>This slows down the learning process.
>
>![[Pasted image 20260324104849.png|Sigmoid Function|350]]

#### Hyperbolic Tangent (tanh) Activation Function
$$ $$
$$\begin{gather}f(a_j\iter a)=\tanh(a_j\iter l)=\frac{e^{a_j\iter a}-e^{-a_j\iter a}}{e^{a_j\iter a}+e^{-a_j\iter a}}\\
f'(a_j\iter l)=1-\tanh^2(a_j\iter a)
\end{gather}$$
>[!col]
>This is a scaled version of the sigmoid function. 
>This maps $\R\rightarrow[0,1]$ and is differentiable. The **derivative is still contractive** but it **solves the bias drift problem** 
>
>![[Pasted image 20260324105444.png|Tanh Function|350]]

#### Linear Activation Functions
A composition of linear functions is linear and can be expressed as a matrix product.
 $a_j$ is a linear function and therefore also $f(a_j$) is.

##### Rectified Linear Unit (ReLU) Activation Function
$$ $$
$$\begin{align}
ReLU(a_j\iter l)=\max(0,a_j\iter l)\\
ReLU(a_j\iter l)=\begin{cases}0,&z<0\\1,&z>0\end{cases}
\end{align}$$
>[!col]
>Simplicity of linear function but non-linear. This speeds up the learning process and returns a sparse output
>For $z>0$ the derivative is $1$, but ReLU can die out if the bias of a layer becomes too negative:
>
>![[Pasted image 20260324111615.png|ReLU|350]]

$$\begin{align}a_j\iter l=\sum...\underbrace{-10^{10}}_b<0\rightarrow f'(a_j\iter l)=0\end{align}$$
Moreover the output is not zero centered.

##### Leaky ReLU (LReLU) Activation Function
$$ $$
$$\begin{gather}
LReLU(z)=\begin{cases}\alpha z,&z<0\\ z,&z\geq0\end{cases}\\
LReLU'(z)=\begin{cases}\alpha,&z<0\\ 1,&z>0\end{cases}
\end{gather}$$
>[!col]
>This mitigates the dying ReLU problem but gives less sparse output. Moreover the magnitude increases for large negative values and could amplify the noise.
>
>![[Pasted image 20260324112651.png|LReLU|350]]

##### Exponential Linear Unit (ELU) Activation Function
$$ $$
$$\begin{gather}
ELU(z)=\begin{cases}\alpha (\exp z-1),&z<0\\ z,&z\geq0\end{cases}\\
ELU'(z)=\begin{cases}\alpha\exp z,&z<0\\ 1,&z>0\end{cases}
\end{gather}$$


>[!col]
>This saturates for large negative values and is more robust to noise, however it is more complex to compute and can result in a slower learning process.
>
>![[Pasted image 20260324113258.png|ELU|350]]

## 2.7) Parameters
#### Initialization
A bad initialization can result in a slow learning process, but an analytical solution is not available: therefore **initialization strategies are random and heuristic**

These are the common sense rules:
- Weight should be initialized randomly to ensure **diversity**
- No large values to avoid **instability and numerical issues**
- Common choice is zero mean gaussian distribution with small variance
- Another common choice is the uniform distribution on the layer input size

##### Glorot Initialization
Default initialization for most DL frameworks:
$$w_{j,i}\iter 0\sim u\par{-\sqrt{\frac{6}{d+n}},\sqrt{\frac{6}{d+n}}}$$
Where $d,n$ are the input and output dimensions of the network

Biases are initialized to zero.

#### Hyperparameters
We call hyper-parameters of a NN all the additional parameters that are **not learned**

##### Learning Rate
We call an **epoch** one entire run of the training phase. 


TODO

## 2.8) Limitations
Since each layer is 1D we have:
- **large number of parameters** to learn.
- **loss of structural information**

>[!example|*] Size
>A 256px square RGB image has size $256\times256\times3\rightarrow196608\times 1$ vector
>Let each layer be made of 50 neurons, one single layer brings to $196608\times 50=9.8 M$ parameters and occupies roughly $9.8M\times 32 bits=315 Mb$


# 3) Convolutional Neural Network (CNN)
## 3.1) Intro to CNNs
CNNs support input of up to 3 dimensions $i,j,q$  (length, height, depth).

They replace Matrix Multiplication with Convolutional (cross-correlation) Operations:
$$o_{l,i,j}=\overbrace{f\par{\underbracket{\sum_{q=1}^{D_{in}}(K_{l,q}*X_q)(l,i,j)+b}_{\text{activation map}}}}^{\text{feature map}}\quad l=1,...,D_{out}$$
![[Pasted image 20260324184227.png|Representation|350]]
1. $\sum$: sum over the input depth
2. $(*)()$: convolve filter with input at depth $q$
3. $b$: adds bias, $f$: activation function

In general at every layer we have $D_{out}$ filters (hyperparameter) that is slid over the whole input to generate a new activation map. The collection of $D_{out}$ feature maps is sent to the next layer.

Notice that each filter is a collection of weights that will be randomly initialized and learned during the training phase.

Notice that usually the convolution is defined as:
$$(X*D)(i,j)=\sum_m\sum_nX(i-m,j-n)K(m,n)$$
but CNNs use a different definition, that is the **cross-correlation** which corresponds to a $180^\circ$ rotation of the filter and practically results changing the sign:
$$\boxed{(X*D)(i,j)=\sum_m\sum_nX(i\mathbf +m,j\mathbf +n)K(m,n)}$$
The rotation will be learned by the network, so we don't need to rotate it manually. Moreover cross-correlation is efficient to implement and is a **similarity** indicator

#### Definitions
- **Feature Map:** result of convolving one filter of the layer with the whole input and applying the activation function (element-wise)
- **Stride:** number of steps by which the filter is shifted
- **(Zero) Padding:** add zeros to the input so that the filter fits an integer number of times (symmetrically on all sides)

Now call Stride $S$, Padding $P$, Filter size $F$ and input dimension $d$, then the output dimension is (one for each $D_{out}$):
$$O=\frac{d-F+2P}S+1$$
An easy way to see the cross-correlation computation:
![[Pasted image 20260324190806.png|Cross-Correlation|350]]
## 3.2) Strengths
#### Local Connectivity
Since the size of the filter is much smaller than the input we have some advantages:
- Each neuron depends on a small subset of inputs of previous layers (filter size) (FFNN uses all neurons for next layer single neuron)
- Patterns are learned in a hierarchical way, each layer learns patterns of the previous layer, stacking them creates global patterns

This can be seen by analyzing the **receptive field:** Number of elements in the input that influence a given neuron at a given layer.

![[Pasted image 20260324191619.png|Receptive Field Example|250]]
The receptive field can be increased by **dilating** the convolution. Instead os using subsequent features, at eahc layer the filter is dilated so that the receptive field is maximized.

![[Pasted image 20260324192054.png|Non Dilated In Red|350]]
The **size of receptive field increases with its depth** $\rightarrow$ neurons closer to input depend on local features, deeper neuron son global ones (generalization of local features)

**This shows that CNNs work well on structured data**

#### Weight Sharing
Since weights are shared in the filter, the number of parameters is drastically reduced

>[!example|*]
>Recall the $256\times256\times3$ RGB image.
>- CNN with $3\times 3$ filter has 9 weights per depth $27$ total weights per output feature map, we want 3 output maps so $81$ weights
>- FFNN in one layer would have $(256\times256\times3)\times(256\times256\times3)=38 M$ weights

this also brings:
- higher efficiency in encoding information (spatial structure)
- less overfitting
- more layers, deeper features

#### Translation Equivariance
First define equivariance:

>[!def] Equivariance
>Given two functions $\phi, \xi$ and an input x, they are equivariant if:
>$$\phi(\xi(x))=\xi(\phi(x))$$
>Let the functions be a convolution and a translation, then the equivariance holds. In neural networks terms:
><div style="text-align: center;">If a pattern in the input is shifted, the learned features are shifted but unchanged</div>
>

Quick proof:
Translate the convolution
$$(f*g)(x)\stackrel{\text{translate}}\rightarrow(f*g)(x-z)=\int f(\tau)g(x-z-\tau)d\tau$$
Now translate $f$ and then convolve
$$f(x-z)*g(x)=\int f(\tau-z)g(x-\tau)d\tau\stackrel{u=\tau-z}=\int f(u)g(x-z-u)du=(f*g)(x-z)$$
$\endproof$
>[!rmk|*]
>Equivariant to translations doesn't mean equivariant to rotations!

#### Pooling Layers
It can be useful to reduce the dimension of the tensors between layers.

This can be achieved by:
- Using $S>1$
- Pooling layers

![[Pasted image 20260325102212.png|Pooling|350]]
This adds **invariance** to small translations. Useful for classification (object present, not where it is present)

Usually the pooling function is a mean or max function

In BP (see later) the pooling affects the error message in two possible ways:
- Max pooling: error message is assigned to the max value of the patch
- Avg pooling: all inputs receive error message but ut is divided by the surface of the pooling patch

## 3.3) Training (SGD & BP) 
Recall some notation:
- Layers: $l=1,...,L$
- Input feature map: Size $H\times W$ indices $i,j$
- Filter: Size $M\times N$ indices $m,n$
- Weight between layers $l-1,l$: $w_{m,n}^l$, bias $b$
- Activation (conv of prev. output and filter)
$$a_{i,j}^l=\sum_{m=0}^{M-1}\sum_{n=0}^{N-1}o_{i+m,j+n}^{l-1}w_{m,n}^l+b^l$$

In CNNs the last layer is usually a FFNN (easier to have 1D for regression and classification). CNN learns features, FFNN classifies/regress based on features.


The following steps are used:
1. Apply forward pass to compute all outputs and activations $a_{i,j}^l,o_{i,j}^l$
2. Last layer is FFNN, so compute error message
$$\mathbf \delta ^L=\nabla_yL\odot f'(\mathbf a^L)=\begin{bmatrix}\delta_1^L\\\vdots\\\delta_M^L\end{bmatrix}, \ 
\delta_i^l=\frac{\partial L}{\partial y_i}f'(a_i^L)$$
3. Recursively compute error signal matrices
$$\mathbf \delta^l=f'(a_{i,j}^l)\mathbf \delta^{l+1}*rot(180^\circ)(K^{l+1})$$
4. Compute gradient using error signal matrices
$$\frac{\partial L(W,X)}{\partial w_{m,n}^l}=(\mathbf {\delta}^l*\mathbf o^{l-1})(m,n)\qquad \frac{\partial L(W,X)}{\partial b^l}=\sum_{i=0}^{H-M}\sum_{j=0}^{W-N}\delta_{i,j}^l$$
The learning rule is the SGD:
$$w_{m,n}\iter{l+1}=w_{m,n}\iter l-\eta\frac{\partial L(W,X)}{\partial w_{m,n}\iter l}\qquad b\iter{l+1}=b\iter l-\eta\frac{\partial L(W,X)}{\partial b\iter l}$$

##### Mathematical Derivation
Back propagation analysis with $S=1,P=0,D_{in}=D_{out}=1$ but can be generalized

The aim is to compute the gradient of the loss function wrt the weights:
$$\frac{\partial L(W,X)}{\partial w_{m,n}^l}\stackrel{\text{chain rule}}=\sum_{i=0}^{H-M}\sum_{j=0}^{W-N}\underbrace{\frac{\partial L(W,X)}{\partial a_{i,j}^l}}_{\delta_{i,j}^l}\underbrace{\frac{\partial a_{i,j}^l}{\partial w_{m,n}^l}}_{o_{i+m,j+n}^l}=(\delta^l*o^{l-1})(m,n)$$
where $\delta_{i,j}^l$ is the error signal and $o_{i+m,j+n}^l$ is obtained like in FFNN where teh derivative is 0 besides for $i,j=m,n$ (in the activation this results in the output at $i+m,j+n$).

**The gradient is therefore just the convolution of the error signal and the output.**

How does the loss function behave wrt the activations? They are not fully connected, so how is the error signal computed?

In general he output $o_{i,j}^l$ is used in the calculation of the activations $a_{i-n,j-m}^{l+1}$ where $n,m\in\curly{0,1}$ and the indices $i-n\in\curly{0,...,H-N+1}$, $j-m\in\curly{0,...,W-M+1}$.

Knowing this the error signal can be computed as
$$\begin{align}
\delta_{i,j}^l&=\frac{\partial L(W,X)}{\partial a_{i,j}^l}=\sum_m\sum_n\underbrace{\frac{\partial L(W,X)}{\partial a_{i-n,j-m}^{l+1}}}_{\delta_{i-m,j-n}^{l+1}}\frac{\partial a_{i-n,j-m}^{l+1}}{\partial a_{i,j}^l}
\end{align}$$
which brings to the calculation of 
$$\frac{\partial a_{i-n,j-m}^{l+1}}{\partial a_{i,j}^l}=\frac{\partial}{\partial a_{i,j}^l}\par{\sum_{m'}\sum_{n'}w_{m',n'}^{l+1}f(a_{i-m+m',j-n+n'}^l)+b^{l+1}}\stackrel{m'=m,n'=n}=w_{m,n}^{l+1}f'(a_{i,j}^l)$$
so the error message is
$$\delta_{i,j}^l=\sum_m\sum_n\delta_{i-m,j-n}^{l+1}w_{m,n}^{l+1}f'(a_{i,j}^l)\longrightarrow\mathbf \delta^l=f'(a_{i,j}^l)\mathbf\delta^{l+1}*rot(180^\circ)(K^{l+1})$$

todo update bias.

# 4) Overfitting and Regularization in Neural Networks
NN can easily have > 100M parameters and therefore overfitting is a common problem.

## 4.1) Overfitting Avoidance
Consider the validation vs training error:
![[Pasted image 20260325145713.png|Graph|350]]
The **train-validation** curves are essential in understanding the status of the model. When the training and validation error start to diverge, the model is overfitting

#### Early Stopping
**Early stopping** is a common technique to prevent overfitting by stopping training when the validation error starts to diverge from the training error.

#### Data Augmentation
Another way to prevent overfitting is to train on more data! It is possible to generate artificial data from the original dataset via simple transformations. This removes the iid assumption in the original dataset. Active development is happening.
#### Inductive Bias
ML asks to compute the distribution $p(x|t)$ given some samples $x_i|t_i$. This is ill posed as there are infinitely many distributions. **Inductive bias** consist in expressing a preference for a certain class of distributions. (a priori knowledge).

>[!thm] No Free Lunch Theorem
>Every algorithm is as good as any other when averaged over all possible problems. If one is better than average for some problem, it must be worse than average for others.

This shows that **it is not possible to purely learn from data in absence of bias**

## 4.2) Regularization
Regularization is a form of inductive bias.

#### L2 Regularization
Works by adding the sum of the square of the weights to the loss function:
$$L(D,W)+\lambda\sum_{w_i\in W}w_i^2$$
It is like calculating the L2 norm (energy) of the weight vectors.

In a SGD context, this applies a **weight decay** to the coefficients at every step.  If the gradient of the loss wrt a weight is small, this weight will progressively decay to about 0 during the training. This has the effect of reducing the unimportant weights.

$$\begin{align}w_j\iter{n+1}&=w_j\iter n-\frac\eta K\sum_k\nabla\sq{L(x_k,t_k)+\lambda \sum_iw_i^2}\\
&=w_j\iter n-\frac\eta K\sum_k\nabla L(x_k,t_k)-\frac\eta K\lambda\cdot K\nabla\sum_iw_i^2\\
&=(1-2\eta\lambda)w_j\iter n-\frac\eta K\sum_k\nabla L(x_k,t_k)\\
\end{align}$$
$\endproof$
#### L1 Regularization
Used in some selected layers
$$L(D,W)+\lambda\sum_{w_i\in W}|w_i|$$
And by the same logic as before it will yield the SGD update:
$$w_j\iter{n+1}=w_j\iter n-\lambda \eta \text{sign}(w_j\iter n)-\frac\eta K\sum_k\nabla L(x_k,t_k)$$
#### $L^q$ Regularization
In general the regularization can consist in adding the power of $L^q$ signal:
$$\Omega(w)\propto\sum_{w_i\in W}|w_m|^q$$
Which creates a plethora of different contours:
![[Pasted image 20260327104833.png|Regularization|250]]
#### Dropout
The idea of dropout is called **model ensembling**: Combine multiple models and average their predictions (reduces overfitting)

However, this requires a lot of computation. Suppose infinite time, 1 model for each weight in $W$. They can be combined with the bayesian ensembling:
$$y=\int F(x,W)p(W|D)dW$$
**Dropout allows to achieve similar results by only training one model**

Overfitting consists in the NN learning the noise in the training data and correct based on it. 

<div style="text-align: center;"> While training the NN, randomly remove (drop) some of the neurons at every epoch. Removing means temporarily excluding it from the network along with all its incoming and outgoing connections</div>

This is done by dropping a neuron with probability $1-p$ _at training time_. This prevents the neuron to fix the mistakes of the other neurons. The layers become more unreliable BUT the model learns more general features.

This approximates the Bayesian ensembling considering $2^{|W|}$ networks. Where a scaling by $p$ is used to keep the expected value of the output

##### Formalization
Introduce the dropout vector
$$r\in\curly{0,1}^{N^{l-1}}\quad r_i\sim\text{Bernoulli}(p)$$
By using the element wise product ($\odot$) The output at layer $l$ is written as
$$o^l=f(W^l(o^{l-1}\odot r)+b^l)$$
How does this introduce regularization?
Suppose linear regression (only analytical solution) (consider $w$ with bias added)
$$y_n=w^T(x_n\odot r)$$
The error function over the training is:
$$||(X\odot R)w-t||^2$$
where $X=vec(D)$ and $R\in\curly{0,1}^{N\times d}$ is a matrix of bernoulli entries.
This matrix has the following properties:
$$\begin{align}
&\E[R_{i,j}]=p\cdot 1+(1-p)\cdot 0=p\\
&\E[R_{i,j}R_{k,h}]=E[]E[]=p^2\\
&\E[R_{i,j}^2]=p\cdot 1^2+(1-p)\cdot 0^2=p
\end{align}$$

Consider the expected value in order to minimize wrt weights:
$$\begin{align}
\E[||(X\odot R)w-t||^2]&=\E[((X\odot R)w-t)^T((X\odot R)w-t)]\\
&=\E[\underbrace{w^T(X\odot R)^T(X\odot R)w}_1-\underbrace{2w^T(X\odot R)^Tt}_2+\underbrace{t^Tt}_3]\\
\end{align}$$
Analyze the terms:
1: To do so we need to better understand the element wise product:
$$A=X\odot R\rightarrow (A^TA)_{i,j}=\sum_{k=1}^N(A^T)_{ik}(A)_{kj}=\sum_{k=1}^NA_{ki}A_$$


# 5) Optimization Methods for Neural Networks
#### 5) Momentum
>[!col]
>Imagine the loss function as a landscape. Imagine a ball rolling on the landscape. The slope makes it descent but constant slope in the same direction gives it momentum. More momentum means more force necessary to divert the ball $\rightarrow$ This region gives robustness to to momentary changes in the update direction.
>$$ $$
>How do we give SGD this property?
>
>![[Pasted image 20260320123926.png|Example|350]]

##### Smoothing
Find the **cumulative average**
$$h\iter k=\sum_{i=1}^k\frac {w\iter i}k\stackrel{\text{Recursively}}=\underbrace{\frac{k-1}k}_{\alpha}h\iter{k-1}+\underbrace{\frac1k}_\beta w\iter k$$
with $\alpha+\beta =1$
The recursive form is used to compute average without needing to save all of the weights at every time $k$
**Samples are all of equal weight**

We can also use the **exponential average**
$$h\iter k=\beta h\iter{k-1}+(1-\beta)w\iter k$$
with $\beta\in[0,1]$ that controls the smoothness of the trajectory.
**Samples are not of equal weight: more recent samples are more valuable**

---

Return to the ball metaphor
- Position of ball: current parameters of vector $w\iter i$
- Velocity of ball $v\iter i$ is equal to momentum of unit mass ball 
- Gravity force = gradient of the loss function $$\frac{\eta\iter i}K\sum_{k=1}^K\nabla L(x_k,t_k;w\iter i)$$
- Update rule:
$$\begin{gather}v\iter {i+1}=\alpha v\iter i-\frac{\eta\iter i}K\sum_{k=1}^K\nabla L(x_k,t_k;w\iter i)\\
w\iter{i+1}=w\iter i+v\iter{i+1}
\end{gather}$$
Only the momentum is stored, not the gradients or weights.

Call $g\iter i=\frac1K\sum_{k=1}^K\nabla L(x_k,t_k;w\iter i)$. Now we can see that: (TO FIX THIS FORMULA THERE IS AN ERROR)
$$\begin{align}
v\iter 1&=-\eta\iter 0g\iter 0\\
v\iter 2&=\alpha v\iter 1-\eta\iter 1g\iter 1=\alpha(-\eta\iter 0g\iter 0)-\eta\iter 1g\iter 1\\
&\ \ \vdots\\
v\iter k&=\alpha^{k-1}(-\eta\iter 0g\iter0)+\alpha^{k-2}()...+\alpha(-\eta\iter{k-1}h\iter{k-1})-\eta\iter {k}g\iter {k}
\end{align}$$
At first iteration we suppose the ball is at rest, moreover it shows that since $\alpha^n\stackrel{n\rightarrow\infty}\longrightarrow0$ it is clear that more recent weights are more important (similar to exponential smoothing).

Weight updates are less affected by quick changes in direction. Long-term trends in the gradient direction bring acceleration

For gradient based optimization it:
- Accelerates convergence, smooths out wandering behavior
- Makes it easier to escape from local minima

![[Pasted image 20260320130303.png|1D Example|350]]
##### Variation: Nesterov Momentum
Look-ahead method: anticipate update to increase responsiveness

This means to consider the gradient in a forward position (possible overshoot scenario) so to have better response:
$$\nabla L(x_k,t_k;w\iter i+\alpha v\iter i)$$
#### Adaptive Learning Rate Methods
##### Normalized Gradient Descent
Near stationary points the gradient is close to zero, so the learning gets slower. To solve this we ignore the magnitude of the gradient by normalizing it:
$$w\iter {i+1}=w\iter i-\eta\frac{g\iter i}{|g\iter i|}$$
So the magnitude of the gradient is ignored 
$$|w\iter {i+1}-w\iter i|=|-\eta\frac{g\iter i}{|g\iter i|}|=\eta$$
In practice we use
$$w\iter {i+1}=w\iter i-\eta\frac{g\iter i}{|g\iter i|+\epsilon}$$
with $\epsilon$ small ($10^{-8}$)

##### AdaGrad
New idea: component-wise adaptive learning rate (LR)
In fact using the same LR for all components is not recommended as some weights require slower/faster updates than others

![[Pasted image 20260320132706.png|Intuition|350]]
Recall the gradient on a mini-batch at iteration i $g\iter i$
Maintain a running sum of squared gradients **for m-th weight**
$$\alpha_m\iter i=\sum_{j=1}^i(g_m\iter j)^2=(g_m\iter i)^2+\alpha_m\iter{i-1}$$
And now compute the weight specific LR
$$\eta_m\iter i=\frac{\eta\iter 0}{\sqrt{\alpha_m\iter i+\epsilon}}$$
and thus for the m-th weight:
$$w_m\iter{i+1}=w_m\iter i+\eta_m\iter i g_m\iter i$$
However the sum only grows so the learning rate decreases and might prematurely stop. Use exponentially decaying moving average:
$$r_m\iter i=\beta r_m\iter{i-1}+(1-\beta)(g_m\iter i)^2=\sum_{k=1}^i\beta^{i-k}(1-\beta)(g_m\iter k)^2$$

this is an IIR filter
The exponents (from i to 1) decay exponentially fast: finite memory approximation by neglecting the terms that $\beta^j<T\rightarrow j>\log T/\log \beta$ are after the j-th iteration in the past

##### Adaptive Moment Estimation (Adam)
Also keep track of the second moment:
$$\begin{align}
\text{1st Gradient: }\ &\xi_m\iter i=\beta_1\xi_m\iter{i-1}+(1-\beta_1)g_m\iter i\\
\text{2nd Gradient: }\ &\psi_m\iter i=\beta_2\psi_m\iter{i-1}+(1-\beta_2)(g_m\iter i)^2
\end{align}$$
But this **is not biased** since we set $g_m\iter 0=0$.

The bias correction just resorts to
$$\hat \xi_m\iter i=\frac{\xi_m\iter i}{1-\beta_1^i}\qquad\hat\psi_m\iter i=\frac{\psi_m\iter i}{1-\beta_2^i}$$
Proof:
todo
$\endproof$
