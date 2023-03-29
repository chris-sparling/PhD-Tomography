function [calibration] = SIRT_calibration(res,n_proj)

W = RadonMatrix(res,n_proj,'no');

tic

R = zeros(1,size(W,1));

C  = zeros(1,size(W,2));

for i = 1:length(R)
    
    R(1,i) = 1/sum(W(i,:),2);
    
end


for j = 1:length(C)
    
    C(1,j) = 1/sum(W(:,j),1);
    
    if C(1,j) == Inf
        
        C(1,j) = 1/eps;
        
    end
    
end

disp(['C and R matrices written in ', num2str(toc), ' seconds'])

tic

disp('Calculating K...')

%K = ((diag(C))*W'*(diag(R)))';
% too slow and intensive!
% destroyed my MacBook battery trying to run this!

size(C)
size(W)
size(R)


%K1 = (W').*R;

%disp('Halfway there...')

%K = ((C').*K1)';

K = ((C').*(W').*R)';

disp(['K calculated in ', num2str(toc), ' seconds'])

calibration.res = res;
calibration.W = sparse(W);
calibration.C = C;
calibration.R = R;
calibration.K = K;
calibration.n_proj = n_proj;

disp('Done!')

end

