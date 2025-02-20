%--------------------------------------------------------------------------
% This function takes a NxN matrix CMat as adjacency of a graph and
% computes the segmentation of data from spectral clustering.
% CMat: NxN adjacency matrix
% n: number of groups for segmentation
% K: number of largest coefficients to choose from each column of CMat
% Grps: [grp1,grp2,grp3] for three different forms of Spectral Clustering
% SingVals: [SV1,SV2,SV3] singular values for three different forms of SC
% LapKernel(:,:,i): n last columns of kernel of laplacian to apply KMeans
%--------------------------------------------------------------------------
% Copyright @ Ehsan Elhamifar, 2010
%--------------------------------------------------------------------------


function [Grps , SingVals, LapKernel] = SpectralClustering_svd(CKSym,n,mth)

N = size(CKSym,1);
MAXiter = 1000; % Maximum iteration for KMeans Algorithm
REPlic = 100; % Replication for KMeans Algorithm

if ~exist('mth','var') || isempty(mth)
    mth = 'Normalized';
end

switch lower(mth)
    case 'unnormalized'
        % Method 1: Unnormalized Method
        DKU = diag( sum(CKSym) );
        LapKU = DKU - CKSym;
        [uKU,sKU,vKU] = svd(LapKU);
        f = size(vKU,2);
        kerKU = vKU(:,f-n+1:f);
        SingVals = diag(sKU);
        %% implementation of kmean clustering
        Grps = kmeans(kerKU,n,'start','sample','maxiter',MAXiter,'replicates',REPlic,'EmptyAction','singleton');

        

        LapKernel = kerKU;
    case 'randomwalk'
        % Method 2: Random Walk Method
        DKN=( diag( sum(CKSym) ) )^(-1);
        LapKN = speye(N) - DKN * CKSym;
        [uKN,sKN,vKN] = svd(LapKN);
        f = size(vKN,2);
        kerKN = vKN(:,f-n+1:f);
        SingVals = diag(sKN);
        %% implementing kmean clustering
        Grps = kmeans(kerKN,n,'start','sample','maxiter',MAXiter,'replicates',REPlic,'EmptyAction','singleton');
        
        %% implementing fuzzy c mean clusterig
        options = fcmOptions(NumClusters=3,MaxNumIteration=50,MinImprovement=0.001,Verbose=false);
        [centers,U] = fcm(G,options);

        LapKernel = kerKN;
    case 'normalized'
        
        % Method 3: Normalized Symmetric
        DKS = ( diag( sum(CKSym) ) )^(-1/2);
        LapKS = speye(N) - DKS * CKSym * DKS;
        [uKS,sKS,vKS] = svd(LapKS);
        f = size(vKS,2);
        kerKS = vKS(:,f-n+1:f);
        for i = 1:N
            kerKS(i,:) = kerKS(i,:) ./ norm(kerKS(i,:));
        end
        SingVals = diag(sKS);
        %% implementing kmean clustering
        Grps = kmeans(kerKS,n,'start','sample','maxiter',MAXiter,'replicates',REPlic,'EmptyAction','singleton');

        %%implementing fuzy for normalized data
         options = fcmOptions(NumClusters=3,MaxNumIteration=50,MinImprovement=0.001,Verbose=false);
        [centers,U] = fcm(Grps,options);
        
        LapKernel = kerKS;
end
%
% Grps = [group1,group2,group3];
% SingVals = [svalKU,svalKN,svalKS];
% LapKernel(:,:,1) = kerKU;
% LapKernel(:,:,2) = kerKN;
% LapKernel(:,:,3) = kerKS;