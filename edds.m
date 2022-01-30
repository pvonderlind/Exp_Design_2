%% file edds.m
% This file is based on the example_cmtl.m file from the MALSAR package

clc;
clear;
close all;

addpath('./MALSAR/MALSAR/functions/cASO/'); % load function
addpath('./MALSAR/MALSAR/utils/'); % load utilities

rng(1)

%rng('default'); % Available from Matlab 2011.
clus_num    = 1; % clusters

clus_task_num = 4;                  % task number of each cluster
task_num = clus_num * clus_task_num; % total task number.

%%%% Generate Input/Output
X = cell(task_num, 1);
Y = cell(task_num, 1);
X_train = cell(task_num, 1);
Y_train = cell(task_num, 1);
X_val = cell(task_num, 1);
Y_val = cell(task_num, 1);
X{1} = table2array(readtable('./X_cnn25.csv'));
Y{1} = table2array(readtable('./Y_cnn25.csv'));
X{2} = table2array(readtable('./X_reu25.csv'));
Y{2} = table2array(readtable('./Y_reu25.csv'));
X{3} = table2array(readtable('./X_bbc25.csv'));
Y{3} = table2array(readtable('./Y_bbc25.csv'));
X{4} = table2array(readtable('./X_pre25.csv'));
Y{4} = table2array(readtable('./Y_pre25.csv'));

for i = 1:4
    l = length(X{i})
    ind = randperm(l)
    cut = floor(l*0.8)
    ind_t = ind(1:cut)
    ind_v = ind((cut+1):l)
    X_train{i} = X{i}(ind_t,:)
    X_val{i} = X{i}(ind_v,:)
    Y_train{i} = Y{i}(ind_t,:)
    Y_val{i} = Y{i}(ind_v,:)
end


rho_1_tune = [0.1, 0.2, 0.3, 0.5]
rho_2_tune = [0.001, 0.01, 0.1, 0.5]

best_f1 = 0.0

for r1 = rho_1_tune
    rho_1 = r1;
    for r2 = rho_2_tune
        rho_2 = r2;
    
        [W,c] = Logistic_CASO(X_train, Y_train, rho_1, rho_2, 1);
    
        for i = 1:4
            y_hat = sign(X_val{i}*W(:,i)+c(i));
            C = confusionmat(int64(Y_val{i}),int64(y_hat))
            tp = C(2,2)
            fp = C(1,2)
            fn = C(2,1)
            f1(i) = tp/(tp+(fp+fn)/2)
        end
        f1_avg = mean(f1)
        if f1_avg > best_f1
            best_rho1_25 = r1
            best_rho2_25 = r2
            best_W = W
            best_c = c
            best_f1 = f1_avg
        end
    end
end

W = best_W
c = best_c

csvwrite('./train_w25.csv',W)
csvwrite('./train_c25.csv',c)


X{1} = table2array(readtable('./X_cnn5.csv'));
Y{1} = table2array(readtable('./Y_cnn5.csv'));
X{2} = table2array(readtable('./X_reu5.csv'));
Y{2} = table2array(readtable('./Y_reu5.csv'));
X{3} = table2array(readtable('./X_bbc5.csv'));
Y{3} = table2array(readtable('./Y_bbc5.csv'));
X{4} = table2array(readtable('./X_pre5.csv'));
Y{4} = table2array(readtable('./Y_pre5.csv'));

for i = 1:4
    l = length(X{i})
    ind = randperm(l)
    cut = floor(l*0.8)
    ind_t = ind(1:cut)
    ind_v = ind((cut+1):l)
    X_train{i} = X{i}(ind_t,:)
    X_val{i} = X{i}(ind_v,:)
    Y_train{i} = Y{i}(ind_t,:)
    Y_val{i} = Y{i}(ind_v,:)
end


rho_1_tune = [0.0001, 0.001, 0.01, 0.1]
rho_2_tune = [0.000001, 0.00001, 0.001, 0.01]

best_f1 = 0.0

for r1 = rho_1_tune
    rho_1 = r1;
    for r2 = rho_2_tune
        rho_2 = r2;
    
        [W,c] = Logistic_CASO(X_train, Y_train, rho_1, rho_2, 1);
    
        for i = 1:4
            y_hat = sign(X_val{i}*W(:,i)+c(i));
            C = confusionmat(int64(Y_val{i}),int64(y_hat))
            tp = C(2,2)
            fp = C(1,2)
            fn = C(2,1)
            f1(i) = tp/(tp+(fp+fn)/2)
        end
        f1_avg = mean(f1)
        if f1_avg > best_f1
            best_rho1_5 = r1
            best_rho2_5 = r2
            best_W = W
            best_c = c
            best_f1 = f1_avg
        end
    end
end

W = best_W
c = best_c

csvwrite('./train_w5.csv',W)
csvwrite('./train_c5.csv',c)

