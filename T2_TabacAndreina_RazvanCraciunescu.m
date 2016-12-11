T = 40;
D = 23;
dutyCicle = 57.5;
w0 = 2 * pi / T;
N = 50;
pas = T / 100;  
t = -2 * T : pas : 2 * T;


coeficienti = zeros(1,N);
A = 0;

fexact = square( w0 * t, dutyCicle);

finitial = @(t,k) square( w0 * t, dutyCicle).*exp( -1j * k * w0 * t);
fapprox = 0;

C0 = (1 / T) * integral(@(t) finitial(t,0),0,T);

for k = 1:1:50
    coeficienti(k) = (1 / T) * integral(@(t) finitial(t,k - 25 ),0,T);
    fapprox = fapprox + coeficienti(k) * exp( 1j * (k - 25) * w0 * t);
end

A(1)=abs(C0);

for k=1:N
      A(k+1) = 2 * abs(coeficienti(k)); 
      %calculam coeficientii Seriei Fourier Armonice care vor reprezenta amplitudinile din spectru
end

figure(1);
plot(t, fapprox, t, fexact);

figure(2);
stem([0:N] * w0, A), title('Spectrul lui x(t)');
% reprezentam A in functie de frecventa fundamentala * numarul coeficientului corespunzator