# DMulti-Mads algorithm (Extreme Barrier version)

This repertory contains the source code of the DMulti-MADS algorithm, a convergent-based blackbox multiobjective algorithm, described in the following work:

> Jean Bigeon, Sébastien Le Digabel and Ludovic Salomon, *DMulti-MADS: Mesh adaptive direct multisearch for bound-constrained blackbox multiobjective optimization*

**Warning** : This code has no vocation to be used in industry, see [Nomad](https://www.gerad.ca/nomad) for a more robust implementation of state-of-the-art blackbox method.
It aims at guaranteeing the reproducibility of the experiments described in this work.

**NB** : This code contains a bug (the poll center is chosen according to other elements of the Pareto front approximation which satisfy the frame selection criterion, and not according to **all** other elements of the Pareto front approximation, as it is described in the paper), which impacts the real performance of the algorithm. For reproducibility purposes, this bug is not patched. To obtain a more performant version of this algorithm (for comparison or to solve your problems, in this last case, to your own risks), please use the implementation proposed in https://github.com/bbopt/dmultimadspb.

## Use

To use DMulti-MADS, Julia >= 1.4 is required. One can type the following commands, at the root of this repertory:
````
julia> ]

(@v1.4) pkg> activate .

(DMultiMadsEB) pkg> test
````
All tests should pass.

A simple example can be found in the *Examples/* folder.

## Problems

This folder contains an implementation of all multiobjective benchmark problems used in the article implemented in Matlab, Julia and for the Nomad (Bimads) software.
Researchers should not reimplement all the time benchmarks.

> Do you have an implementation in Python ?

Infortunately not, but feel free to do it. We recommand Julia if you want to implement a challenger algorithm. It is quite fast and free.

## Scripts

This folder contains the scripts used to generate benchmark caches analyzed in the article. One has to precise the path for the generation folder, and the benchmark folder. These scripts require the Matlab software.
> **Warning** To generate NSGAII and DMulti-MADS caches, it can take more than three days in total.

It also requires more than 36 G of memory on hardware.
