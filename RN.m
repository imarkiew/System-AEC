
clear all;
close all;
clc;

%Typ interpolacji - interpolacyjne wielomiany sklejane trzeciego rzedu Hermita
interpolacja = 'pchip';

%Wektory energii
dx90 = 1:0.00001:90; %keV
dx65 = 1:0.00001:65; %keV

%Widma liniowe po wyjœciu RTG
I90 =  -dx90 + 90 ; 
I65 =  -dx65 + 65 ; 

%Rysowanie widm po wyjœciu z RTG
figure (1)
plot(dx90, I90, dx65, I65);
axis([0, 100, 0, 100]);
title('Wykres I(E) po wyjœciu z lampy');
xlabel('Ef [kV]');
ylabel('I(E)');
legend('I90', 'I65');
grid on;
pause();


% %filtrowanie po 3 mm Al
energia_Al = 10^3*[1.00000E-03, 1.50000E-03, 1.55960E-03, 1.559611E-03,  2.00000E-03, 3.00000E-03, 4.00000E-03, 5.00000E-03,  6.00000E-03, 8.00000E-03, 1.00000E-02, 1.50000E-02,  2.00000E-02, 3.00000E-02, 4.00000E-02, 5.00000E-02,  6.00000E-02, 8.00000E-02, 1.00000E-01, 1.50000E-01,  2.00000E-01, 3.00000E-01, 4.00000E-01, 5.00000E-01,  6.00000E-01, 8.00000E-01, 1.00000E+00, 1.25000E+00,  1.50000E+00, 2.00000E+00, 3.00000E+00, 4.00000E+00,  5.00000E+00, 6.00000E+00, 8.00000E+00, 1.00000E+01,  1.50000E+01, 2.00000E+01];
mi_do_ro_Al = [1.185E+03, 4.022E+02, 3.621E+02, 3.957E+03, 2.263E+03,  7.880E+02, 3.605E+02, 1.934E+02, 1.153E+02, 5.033E+01,  2.623E+01, 7.955E+00, 3.441E+00, 1.128E+00, 5.685E-01,  3.681E-01, 2.778E-01, 2.018E-01, 1.704E-01, 1.378E-01,  1.223E-01, 1.042E-01, 9.276E-02, 8.445E-02, 7.802E-02, 6.841E-02, 6.146E-02, 5.496E-02, 5.006E-02, 4.324E-02, 3.541E-02, 3.106E-02, 2.836E-02, 2.655E-02, 2.437E-02, 2.318E-02, 2.195E-02, 2.168E-02];

x_Al = 0.3; %0.3 cm = 3mm Al
rho_Al = 2.699; %gêstoœæ Al = 2.699 g/cm^3

%Dla aluminium I0 jest to co wysz³o z RTG
I0_90_Al = I90;
I0_65_Al = I65;

%Obliczanie wektora eksponent dla aluminium
wektor_e_Al = exp(-mi_do_ro_Al * x_Al * rho_Al);

%Interpolowanie wartoœci z wektora eksponent dla energii Al, obliczanie
%wartoœci wspó³czynników dla dx90 i dx65 a nastêpnie mno¿enie przez widmo
%po wyjœciu z RTG
I_90_Al = I0_90_Al.*interp1(energia_Al, wektor_e_Al, dx90, interpolacja);
I_65_Al = I0_65_Al.*interp1(energia_Al, wektor_e_Al, dx65, interpolacja);

%Rysowanie widm po wyjœciu z Aluminium
figure(2)
plot(dx90, I_90_Al, 'r', dx65, I_65_Al, 'b');
title('Wykres I(E) po przejœciu przez 3mm Al');
xlabel('Ef [kV]');
ylabel('I(E)');
legend('I90', 'I65');
grid on;
pause();


%filtracja po 3mm Al i 12 cm TEP
energia_TEP = 10^3*[1.00000E-03,1.50000E-03,2.00000E-03,3.00000E-03,4.00000E-03,4.03810E-03, 4.03811E-03, 5.00000E-03, 6.00000E-03, 8.00000E-03,1.00000E-02, 1.50000E-02, 2.00000E-02, 3.00000E-02, 4.00000E-02,5.00000E-02, 6.00000E-02, 8.00000E-02, 1.00000E-01, 1.50000E-01,2.00000E-01, 3.00000E-01, 4.00000E-01, 5.00000E-01, 6.00000E-01,8.00000E-01, 1.00000E+00, 1.25000E+00, 1.50000E+00, 2.00000E+00,3.00000E+00, 4.00000E+00, 5.00000E+00, 6.00000E+00, 8.00000E+00,1.00000E+01, 1.50000E+01, 2.00000E+01];
mi_do_ro_TEP = [2.259E+03, 7.282E+02, 3.183E+02, 9.652E+01, 4.081E+01, 3.966E+01, 5.629E+01, 3.069E+01, 1.813E+01, 7.914E+00, 4.186E+00, 1.394E+00, 7.068E-01, 3.481E-01, 2.562E-01, 2.198E-01, 2.008E-01, 1.803E-01, 1.680E-01, 1.485E-01, 1.353E-01, 1.173E-01, 1.049E-01, 9.579E-02, 8.857E-02, 7.777E-02, 6.992E-02, 6.253E-02, 5.691E-02, 4.880E-02, 3.907E-02, 3.335E-02, 2.958E-02, 2.690E-02, 2.338E-02, 2.117E-02, 1.819E-02, 1.675E-02];
 

x_TEP = 12; %12 cm
rho_TEP = 1.127; %gêstoœæ TEP = 1.127 g/cm^3

%Dla TEP I0 jest to co wysz³o z Al
I0_90_TEP = I_90_Al;
I0_65_TEP = I_65_Al;

%Obliczanie wektora eksponent dla TEP
wektor_e_TEP = exp(-mi_do_ro_TEP * x_TEP * rho_TEP);

%Interpolowanie wartoœci z wektora eksponent dla energii TEP, obliczanie
%wartoœci wspó³czynników dla dx90 i dx65 a nastêpnie mno¿enie przez widmo
%po wyjœciu z Al
I_90_TEP = I0_90_TEP.*interp1(energia_TEP, wektor_e_TEP, dx90, interpolacja);
I_65_TEP = I0_65_TEP.*interp1(energia_TEP, wektor_e_TEP, dx65, interpolacja);

%Rysowanie widma po wyjsciu z TEP
figure(3)
plot(dx90, I_90_TEP, 'r', dx65, I_65_TEP, 'b');
title('Wykres I(E) po przejœciu przez 3mm Al i 15 cm TEP');
xlabel('Ef [kV]');
ylabel('I(E)');
legend('I90', 'I65');
grid on;
pause();


%filtracja po 3mm Al, 12 cm TEP i 1 cm Ar
energia_Ar = 10^3*[1.00000E-03, 1.50000E-03, 2.00000E-03, 3.00000E-03, 3.20290E-03, 3.20291E-03, 4.00000E-03, 5.00000E-03, 6.00000E-03, 8.00000E-03, 1.00000E-02, 1.50000E-02, 2.00000E-02, 3.00000E-02, 4.00000E-02, 5.00000E-02, 6.00000E-02, 8.00000E-02, 1.00000E-01, 1.50000E-01, 2.00000E-01, 3.00000E-01, 4.00000E-01, 5.00000E-01, 6.00000E-01, 8.00000E-01, 1.00000E+00, 1.25000E+00, 1.50000E+00, 2.00000E+00, 3.00000E+00, 4.00000E+00, 5.00000E+00, 6.00000E+00, 8.00000E+00, 1.00000E+01, 1.50000E+01, 2.00000E+01];
mi_en_do_ro_Ar = [3.180E+03, 1.102E+03, 5.093E+02, 1.682E+02, 1.403E+02, 1.153E+03, 6.979E+02, 3.953E+02, 2.449E+02, 1.125E+02, 6.038E+01, 1.886E+01, 8.074E+00, 2.382E+00, 9.907E-01, 5.020E-01, 2.904E-01, 1.280E-01, 7.344E-02, 3.703E-02, 2.998E-02, 2.757E-02, 2.727E-02, 2.708E-02, 2.679E-02, 2.601E-02, 2.510E-02, 2.394E-02, 2.288E-02, 2.123E-02, 1.927E-02, 1.827E-02, 1.777E-02, 1.753E-02, 1.742E-02, 1.754E-02, 1.800E-02, 1.842E-02];

x_Ar = 1; %1 cm
rho_Ar = 1.662E-03; %gêstoœæ Ar = 0.001662 g/cm^3

%Dla Ar I0 jest tym co wysz³o z TEP 
I0_90_Ar = I_90_TEP;
I0_65_Ar = I_65_TEP;

%Obliczanie wektora eksponent dla Ar
wektor_e_Ar = exp(-mi_en_do_ro_Ar * x_Ar * rho_Ar);

%Interpolowanie wartoœci z wektora eksponent dla energii Ar, obliczanie
%wartoœci wspó³czynników dla dx90 i dx65 a nastêpnie mno¿enie przez widmo
%po wyjœciu z TEP
I_90_Ar = I0_90_Ar.*interp1(energia_Ar, wektor_e_Ar, dx90, interpolacja);
I_65_Ar = I0_65_Ar.*interp1(energia_Ar, wektor_e_Ar, dx65, interpolacja);

%Calkowanie I(E) tego co zostalo w Ar  : 
%I0 - I0*exp(-mi_en_do_ro_Ar * rho_Ar * x_Ar) = 
%I0(1 - exp(-mi_en_do_ro_Ar * rho_Ar * x_Ar))
y_Ar_90 = I0_90_Ar.*interp1(energia_Ar, ones(1, length(energia_Ar)) - wektor_e_Ar, dx90, interpolacja);
pochloniete_Ar_90 = trapz(dx90, y_Ar_90)
y_Ar_65 = I0_65_Ar.*interp1(energia_Ar, ones(1, length(energia_Ar)) - wektor_e_Ar, dx65, interpolacja);
pochloniete_Ar_65 = trapz(dx65, y_Ar_65)
pochloniete_Ar = pochloniete_Ar_90/pochloniete_Ar_65


%Rysowanie widma tego co zostalo w Ar
figure(4)
plot(dx90, y_Ar_90, 'r', dx65, y_Ar_65, 'b');
title('Wykres I(E) tego co zostalo w 1cm Argonu');
xlabel('Ef [kV]');
ylabel('I(E)');
legend('I90', 'I65');
grid on;
pause();

%Rysowanie widma po wyjsciu z Ar
figure(5)
plot(dx90, I_90_Ar, 'r', dx65, I_65_Ar, 'b');
title('Wykres I(E) po przejœciu przez 3mm Al, 15 cm TEP i 1 cm Ar');
xlabel('Ef [kV]');
ylabel('I(E)');
legend('I90', 'I65');
grid on;
pause();


%co zosta³o po 3mm Al, 12 cm TEP, 1 cm Ar w 0.05 cm Gd_2O_2S
energia_Gd2O2S = 10^3*[1.00000E-03, 1.08867E-03, 1.18520E-03, 1.18521E-03, 1.20109E-03, 1.21720E-03, 1.21721E-03, 1.50000E-03, 1.54400E-03, 1.54401E-03, 1.61454E-03, 1.68830E-03, 1.68831E-03, 1.78195E-03, 1.88080E-03, 1.88081E-03, 2.00000E-03, 2.47200E-03, 2.47201E-03, 3.00000E-03, 4.00000E-03, 5.00000E-03, 6.00000E-03, 7.24280E-03, 7.24281E-03, 7.57876E-03, 7.93030E-03, 7.93031E-03, 8.00000E-03, 8.37560E-03, 8.37561E-03, 1.00000E-02, 1.50000E-02, 2.00000E-02, 3.00000E-02, 4.00000E-02, 5.00000E-02, 5.02391E-02, 5.02392E-02, 6.00000E-02, 8.00000E-02, 1.00000E-01, 1.50000E-01, 2.00000E-01, 3.00000E-01, 4.00000E-01, 5.00000E-01, 6.00000E-01,8.00000E-01, 1.00000E+00, 1.25000E+00, 1.50000E+00,2.00000E+00, 3.00000E+00, 4.00000E+00, 5.00000E+00,6.00000E+00, 8.00000E+00, 1.00000E+01, 1.50000E+01,2.00000E+01];
mi_do_ro_Gd2O2S = [2.497E+03, 2.103E+03, 1.765E+03, 1.984E+03, 2.465E+03, 3.644E+03, 4.311E+03, 4.390E+03, 4.092E+03, 4.699E+03, 4.235E+03, 3.819E+03, 4.046E+03, 3.585E+03, 3.175E+03, 3.311E+03, 2.883E+03, 1.752E+03, 1.909E+03, 1.205E+03, 5.916E+02, 3.371E+02, 2.118E+02, 1.306E+02, 3.312E+02, 2.994E+02, 2.625E+02, 3.539E+02, 3.470E+02, 3.096E+02, 3.560E+02, 2.285E+02, 7.902E+01, 3.689E+01, 1.254E+01, 5.854E+00, 3.274E+00, 3.234E+00, 1.555E+01, 9.815E+00, 4.666E+00, 2.613E+00, 9.381E-01, 4.812E-01, 2.185E-01, 1.423E-01, 1.095E-01, 9.153E-02, 7.225E-02, 6.163E-02, 5.335E-02, 4.832E-02, 4.271E-02, 3.829E-02, 3.699E-02,3.685E-02, 3.722E-02, 3.864E-02, 4.038E-02, 4.478E-02, 4.837E-02];

x_Gd2O2S = 0.05 ; %0.05 cm
rho_Gd2O2S = 7.440E+00; %gêstoœæ TEP = 7.44 g/cm^3

%Dla Gd2O2S I0 jest tym co wyszlo z Ar
I0_90_Gd2O2S = I_90_Ar;
I0_65_Gd2O2S = I_65_Ar;

%Obliczanie wektora wartosci typu 1 - exp(-mi_do_ro_Gd2O2S * x_Gd2O2S * rho_Gd2O2S);
wektor_e_Gd2O2S = ones(1, length(energia_Gd2O2S)) - exp(-mi_do_ro_Gd2O2S * x_Gd2O2S * rho_Gd2O2S);

%Interpolacja wektora exponent dla wektora energii Gd2O2S i mno¿enie przez
%I0
I_90_Gd2O2S = I0_90_Gd2O2S.*interp1(energia_Gd2O2S, wektor_e_Gd2O2S, dx90, interpolacja);
I_65_Gd2O2S = I0_65_Gd2O2S.*interp1(energia_Gd2O2S, wektor_e_Gd2O2S, dx65, interpolacja);

%Rysowanie widma tego co zostalo w Gd2O2S 
figure(6)
plot(dx90, I_90_Gd2O2S, 'r', dx65, I_65_Gd2O2S, 'b');
title('Wykres I(E) co zosta³o w 0.5mm Gd_2O_2S');
xlabel('Ef [kV]');
ylabel('I(E)');
legend('I90', 'I65');
grid on;

%Calkowanie I(E) tego co zostalo w Gd2O2S : 
pochloniete_Gd2O2S_90 = trapz(dx90, I_90_Gd2O2S)
pochloniete_Gd2O2S_65 = trapz(dx65, I_65_Gd2O2S)
pochloniete_Gd2O2S = pochloniete_Gd2O2S_90/pochloniete_Gd2O2S_65

%Liczenie poprawki
Poprawka = pochloniete_Ar/pochloniete_Gd2O2S

