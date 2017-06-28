# neighbourhood_component_analysis
MATLAB code for Neighbourhood Component Analysis, based on Jacob Goldberger, Sam Roweis, Geoff Hinton, Ruslan Salakhutdinov's paper.

![image](res.jpg)

The blue dots are the projections (Y = AX) of faces, while yellow dots are nonfaces. So this can be used for clustering.

![image](res_coil.jpg)

COIL100 example. 

Now with a 'faster' version, that uses a stochastic batch update per element, and a non-linear conjugate gradient update.