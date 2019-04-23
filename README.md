Determining an input matrix, i.e., locating predefined number of nodes (named “key nodes”) connected
to external control sources that provide control signals, so as to minimize the cost of controlling
a preselected subset of nodes (named “target nodes”) in directed networks is an outstanding issue. This
problem arises especially in large natural and technological networks. To address this issue, we focus on
directed networks with linear dynamics and propose an iterative method, termed as “$L_0$-norm constraint
based projected gradient method” (LPGM) in which the input matrix B is involved as a matrix variable.
By introducing a chain rule for matrix differentiation, the gradient of the cost function with respect to
B can be derived. This allows us to search B by applying probabilistic projection operator between two
spaces, i.e., a real valued matrix space R N ×M and a L 0 norm matrix space $R^{N×M}$
$L_0$ by restricting the $L_0$ norm of B as a fixed value of M . Then, the nodes that correspond to the M 
nonzero elements of the obtained input matrix (denoted as $B^{L_0}$ ) are selected as M key nodes, and each 
external control source is connected to a single key node. Simulation examples in real-life networks are presented to verify the
potential of the proposed method. An interesting phenomenon we uncovered is that generally the control
cost of scale free (SF) networks is higher than Erdos-Renyi (ER) networks using the same number of
external control sources to control the same size of target nodes of networks with the same network 
size and mean degree. This work will deepen the understanding of optimal target control problems and
provide new insights to locate key nodes for achieving minimum-cost control of target nodes in directed
networks.

The detailed contents can be seen in https://www.sciencedirect.com/science/article/pii/S0016003218305441

-------------------------------------------------------------------------------------------------------------------------------------
If your want to reproduce the simulations in this paper, you should:
1) the algorithm of PGM has beeb implemented in PGM.m
2) the algorithm of PGME has beeb implemented in PGME.m
3) the algorithm of LPGM has beeb implemented in LPGM.m
