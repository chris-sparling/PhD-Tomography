function [I_3D_recon] = tomographyreconstruct(I_proj,an,res,tol)

tic

rad = [];

I_3D_recon = zeros(res,res,res);

I_proj_new = zeros(res,res,size(I_proj,3));

for i = 1:size(I_proj,3)
    
    I_proj_new(:,:,i) = imresize(I_proj(:,:,i),[res,res]);
    
    norm = max(max(I_proj_new(:,:,i)));
    
    I_proj_new(:,:,i) = I_proj_new(:,:,i)/norm;
    
    
end

for idx = 1:size(I_proj_new,2)
    
    for pro = 1:length(an)
    
        rad(:,pro) = squeeze(I_proj_new(:,idx,pro));
        
    end
    
    i_rad = iradon(rad,an(1:end),'spline','Ram-Lak',1,res);
    
    I_3D_recon(:,:,idx) = i_rad;
    
    disp([num2str(100*(idx/size(I_proj_new,2))), ' % complete'])
    
end

disp(['Done in ', num2str(toc), ' seconds!'])


norm = max(max(max(abs(I_3D_recon))));

%I_3D_recon = smooth3(I_3D_recon,'gaussian',1*[1 1 1],1);

%I_3D_recon(abs(I_3D_recon)<tol*norm) = 0;

%I_3D_recon(I_3D_recon<0) = 0;

end

