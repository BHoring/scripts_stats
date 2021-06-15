% Alpha correction for correlated variables
% X is the n*k matrix of correlated predictors
%
% Based on
% Cheverud, J. M. (2001). A simple correction for multiple comparisons in interval mapping
% genome scans. Heredity, 87 (1), 52–58.
% Nyholt, D. R. (2004). A simple correction for multiple testing for single-nucleotide
% polymorphisms in linkage disequilibrium with each other. The American Journal of
% Human Genetics, 74 (4), 765–769.
% via
% Derringer, J. (2016) A simple correction for non-independent tests.
% 
% Version: 1.1
% Author: Björn Horing, bjoern.horing@gmail.com
% Date: 2021-06-15
%
% Version notes
% 1.1
% - function description, comments for Git

function eff = Meff(X) 

    eigens = eig(corr(X,'rows','complete'));    
    eff = 1 + (numel(eigens) - 1) * (1 - var(eigens) / numel(eigens));
    
    fprintf('Absolute number of predictors: %d.\n',size(X,2));
    fprintf('Effective number of predictors: %1.3f.\n',eff);