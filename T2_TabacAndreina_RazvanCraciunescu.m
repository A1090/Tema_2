%23.Tabac Andreina Elena
T = 40;
Durata = 23;
duty = Durata/T;
w = 2 * pi / T;
N = 50;
pas = T / 100;  
t = -2 * T : pas : 2 * T;

C = zeros(1,N);%vectorul cu coeficienti
A = 0;

fExact = square( w * t, dutyCicle);%semnalul dreptunghiular

fFourier = @(t,k) square( w * t, dutyCicle).*exp( -1j * k * w * t);%functia de integrat

fApprox = 0;

C0 = (1 / T) * integral(@(t) fFourier(t,0),0,T);%componenta continua

for k = 1:1:50
    C(k) = (1 / T) * integral(@(t) fFourier(t,k - 25 ),0,T);%calcularea coeficientilor
    fApprox = fApprox +  C(k) * exp( 1j * (k - 25) * w * t);%reconstruirea semnalului/suma coeficientilor*exp(...)
end

A(1)=abs(C0);%amplitudinea componentei continue

for k=1:N
      A(k+1) = 2 * abs(C(k)); 
      %calcularea coeficientii Seriei Fourier Armonice care vor reprezenta amplitudinile din spectru
end

figure(1);
plot(t, fApprox, t, fExact);

figure(2);
stem((0:N) * w, A), title('Spectrul lui x(t)');
% afisare A in functie de frecventa fundamentala * numarul coeficientului corespunzator