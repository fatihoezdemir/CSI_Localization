clear all;
%CANCEL 12 SUBCARRIERS
[csi,NFFT,no_packets,rssi,agc_compensations,energy,delta_t]=csv_converter('my-experiment-file.csv');
csi=fftshift(csi);
csi(:,[33,34])=0;
 % A=cov(csi);
%h_t=abs(ifft(csi)).^2;
%               run('energy.m')

%% Plotting here
%  A=cov(csi);
%h_t=abs(ifft(csi)).^2;
figure('units','normalized','outerposition',[0 0 1 1])
for i=1:no_packets
%extract  parameters for individual samples
csi_energy=energy(i); 
agc_compensation=agc_compensations(i);
csi_scaled=agc_compensation.*csi;
h_t=(abs(ifft(csi(i,:))).^2)./sqrt(NFFT);
h_t(1:2)=0;

hold on
subplot(3,1,1);    
plot(abs(csi(i,:)));title('Channel State Information');xlabel('Subcarriers');
ylabel('quantized amplitude unit in 8 bit');

subplot(3,1,2);
plot((0:delta_t:(NFFT-1)*delta_t),h_t);title('Power Delay Profile');
xlabel('time in seconds');ylabel('Power');xlim([0 3e-6]);ylim([0 3]);

subplot(3,1,3);
plot(unwrap(rad2deg(angle(csi(i,:)))));
title('Phase');xlabel('time in seconds');ylabel('radians -\pi to \pi');
%plot(abs(ifft()));
waitforbuttonpress();
disp(['shown packet number: ',num2str(i)])
end
%% 3D-Plots
 h_t=ifft(csi(),[],1)./(sqrt(1));
    h=fft2(csi());
    h(:,1)=0;
    %mesh((abs(csi_buff)));
    %mesh(abs(csi_buff).^2)

 mesh((abs(h).^2)./sqrt(NFFT));xlim([0,60]);
