# Exp_Design_2
This repository contains the code used to create the reproduction attemps of 
the paper Analyzing and Predicting News Popularity
in an Instant Messaging Service by Naseri et. al 2019.

This report can be found under the following DOI:
10.5281/zenodo.5920074

## Installation instructions
The bulk of the experiment is contained within edds-ws21_grp15.ipynb. Please consult
requirements.txt for the necessary packages and versions to execute the notebook.
To install jupyter notebook please consult https://jupyter.org/

An additional MATLAB file edds.m is provided. It requires the installation of
MALSAR (we used version 1.1): http://jiayuzhou.github.io/MALSAR/

Our MATLAB script expects MALSAR to be installed in a subfolder ./MALSAR

The precalculated model coefficients train_c5.csv, train_c25.csv, train_w5.csv, train_w25.csv 
are included in this folder, to enable convenient reexecution without the need to install 
additional packages or software
