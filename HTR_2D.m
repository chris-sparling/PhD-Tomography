function [I] = HTR_2D(P,N)

%% Hankel-Transform Reconstruction - 2D

% Takes sinogram data measured at regular intervals between 0º and 180º and
% finds the inverse Radon transform.

% If using please cite https://doi.org/10.1063/5.0101789 and acknowledge
% Chris Sparling and Dave Townsend for providing this code.

% Good luck!

% Last update 08/09/2022

%%

P = [P, flipud(P)]; % delete if sinogram P has been sampled between 0º and 360º

res = size(P,1)/2; % resolution of sinogram

F = fft(P(:,1:end-1),[],2); % calulate Fourier transform along projection angle direction

F = (fftshift(F,1));

F_ = fft(F,[],1); % Fourier transform of these Fourier coefficients

F_ = F_(1:res,:);

F_(:,1) = (1/sqrt(2))*(F_(:,1));

H = zeros([size(F_,1),N+1]); % Create space for Hankel transformed coefficients

for idx = 1:N+1
    
    n = idx-1;
    
    % Hankel transform Fourier coefficients
    
    %H(:,idx) = (1i^n)*hankel(F_(:,idx),n); % my version
    
    H(:,idx) = (1i^n)*hat(F_(:,idx),[],[],n); % FIle Exchange version
    
end

H(:,1) = H(:,1)/sqrt(2);

H = H.*(H(:,1)>0);

theta = linspace(0,2*pi,size(P,1)); % set up space and variables for polar transform

I_pol_recon = zeros([0.5*size(P,1),size(P,1)]);

for idx = 1:size(H,2)
    
    n = idx - 1;
    
    I_pol_recon = I_pol_recon + real(H(:,idx)).*cos(n*theta) + imag(H(:,idx)).*sin(n*theta); % Polar Fourier transform to reconstruct the original image
    
end

I = (polar_2_cart(I_pol_recon',size(P,1))); % bin the polar image back into Cartesian coordinates

I(I<0) = 0; % remove unphysical negative pixels

end

