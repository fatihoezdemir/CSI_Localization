% extract important data and parameters from the csv file here
% calculate use-for-later parameters here
function [csi,NFFT,no_packets,rssi,agc_compensations,energy,delta_t]=csv_converter(csv)
addpath('data');
%csv='my-experiment-file.csv';
T = readtable(csv);
%summary(T);
data_csi=T.CSI_DATA;
data_rssi=T.rssi;
csi=[];
rssi=[];
for i=1:length(data_csi)
    a=str2num(data_csi{i});
    b=data_rssi(i);
    %b=[ b;complex(a(1:64),a(65:128))];
   csi=[csi; complex(a(2:2:end),a(1:2:end))];
   rssi=[rssi;b];
end
NFFT=size(csi,2);
csi=[csi;zeros(length(rssi)-size(csi,1),NFFT)];
energy=(sum(csi.*conj(csi),2));
agc_compensations=sqrt(db2mag(rssi)./energy); 
[no_packets,NFFT]=size(csi);

delta_t=1/(NFFT*312500); %time resolution