%Calculate energy and other statistical properties here


h=ifft(csi);
hnorm=ifft(csi)./(NFFT);
energy1=sum(sum(h.*conj(h),2));
energynorm=sum(sum(hnorm.*conj(hnorm),2));
diff=abs(energynorm-energy);
diffnorm=(abs(energy1-energy));

mean_csi=mean(abs(csi),2);
var_csi=var(abs(csi),0,2);
%relation=mean_csi./sqrt(var_csi)).^(-1)