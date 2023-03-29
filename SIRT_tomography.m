function [I_3D_SIRT] = SIRT_tomography(I_proj, calibration)

res = calibration.res;
W = calibration.W;
K = calibration.K;
it = calibration.it;
n_proj = calibration.n_proj;

n_pad = floor(((size(W,2)/n_proj) - res)/2);

p_all = [];

tic


for i = 1:res

    p_mat = squeeze(I_proj(:,i,:));
    
    p_mat = 0.5*(p_mat + fliplr(p_mat));
    
    %p_mat = padarray(p_mat,[n_pad+1],0,'both');

    %p_mat = p_mat(2:end,:);
   
    p_mat = p_mat(:);
    
    %size(p_mat)
    
    p_all(:,i) = p_mat;
    
end


v_0 = zeros([res,res^2]);

v_k = v_0;

convergance = [];


for i = 1:it

    v_k = v_k + (K*(p_all - (v_k*W)'))';
    
    v_k(v_k<0) = 0;
    
    disp([num2str(100*(i/it)), ' % complete'])
    
    convergance(1,i) = sqrt(sum(sum((p_all - (v_k*W)').^2))/(size(v_k,1)*size(v_k,2)));
    
    
end

disp(['Done in ',num2str(toc),' seconds!'])

I_3D_SIRT = reshape(v_k, [res res res]);

I_3D_SIRT = permute(I_3D_SIRT, [1 3 2]);

plot(1:i, convergance)

end

