%PH0 is row vector in which each element correspond to probability of absence
%of speech for every frame l
% SNR is scalar number which correspond to every coefficient k and every frame l
% sigma is row vector in which each element correspond to sigma of speech for every frame l
function Enk=noise_estimation(yk_2,PH0,SNR,sigma)
    sigma2=sigma.*sigma;
    pyH0=exp(-abs(yk_2)./sigma2)./(sigma2.*pi);
    pyH1=exp(-abs(yk_2)./(sigma2.*(1+SNR)))./(sigma2.*pi.*(1+SNR));
    PH0=repmat(PH0,size(yk_2,1),1);
    PH1=ones(size(PH0))-PH0;
    PH1y=(PH1.*pyH1)./(PH1.*pyH1+PH0.*pyH0);
    PH0y=ones(size(PH1y))-PH1y;
    sigma2_pad=padarray(sigma2,[0 1],0);
    sigma2_pre=sigma2_pad(:,1:size(sigma2_pad,2)-1);
    sigma2_pre_mat=repmat(sigma2_pre,size(yk_2,1),1);
    Enk=PH0y.*yk_2+PH1y.*sigma2_pre_mat;
    
end