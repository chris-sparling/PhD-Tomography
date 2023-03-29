function [I_3D] = HTR_3D(I_proj,N)

%% Hankel-Transform Reconstruction - 3D

% Takes sinogram data measured at regular intervals between 0º and 180º
% along multiple z-positions and finds the inverse Radon transform -
% reconstructing full distributions in 3D.

% If using please cite https://doi.org/10.1063/5.0101789 and acknowledge
% Chris Sparling and Dave Townsend for providing this code.

% Good luck!

% Last update 08/09/2022

%%

tic

I_3D = zeros([1 1 1]*size(I_proj,1)); % create space for reconstruction

for idx = 1:size(I_3D,2)
    
    P = squeeze(I_proj(:,idx,:)); % define singoram
    
    I = HTR_2D(P,N); % reconstruct using HTR_2D
    
   %I = imrotate(I,3,'bicubic','crop');
    
    I_3D(:,:,idx) = I; % add into 3D array
    
    %disp([num2str(100*(idx/size(I_3D,2))), ' % complete'])
    
end

I_3D = permute(I_3D,[3 2 1]); % change order to be in correct orientation

disp(['Done in ',num2str(toc),' seconds!'])

end

