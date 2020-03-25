# DMulti-Mads algorithm

This repertory contains the source code of the DMulti-MADS algorithm, a convergent-based blackbox mul

Jean Bigeon, Sébastien Le Digabel and Ludovic Salomon, *DMulti-MADS: Mesh adaptive direct multisearch

**Warning** : This code has no vocation to be used in industry, see [Nomad](https://www.gerad.ca/noma

## Use

To use DMulti-MADS, $\texttt{Julia}$  $\geq 1.4$ is required. One can type the following commands, at
````
julia> ]

(@v1.4) pkg> activate .

(DMultiMadsEB) pkg> test
````
All tests should pass.

A simple example can be found in the *Examples/* folder.

## Problems

This folder contains an implementation of all multiobjective benchmark problems used in the article a

> Do you have an implementation in $\texttt{Pytho}$ ?·

Infortunately not, but feel free to do it. We recommand $\texttt{Julia}$ if you want to implement a c

## Scripts

This folder contains the scripts used to generate benchmark caches analyzed in the article. One has t
> **Warning** To generate NSGAII and DMulti-MADS caches, it can take more than three days in total.

It also requires more than $36$ G of memory on hardware.
