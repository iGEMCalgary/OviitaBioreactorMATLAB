%The Script used to Plot Growth Curves and get Production Rate of
%Betacarotene

%Assume that lag phase is negligible 

Xi = 0.0156; %initial cell density in gDW/L
ti = 0;
tf = 24; % h   figure this out 
t = [1:0.01:24]; %a specific point in time

Q = 3000; %L/h Pump input of air 

Sin_O2 = 0.3; %g/L  atmospheric oxygen 

S_O2 = 0; %effluent of substrate

r_O2 = 0.11; %mol gDW^-1 h^-1 SOURCE: https://www.researchgate.net/publication/257309421_Comparing_cellular_performance_of_Yarrowia_lipolytica_during_growth_on_glucose_and_glycerol_in_submerged_cultivations 

Y_XO2 = (r_O2 * 32)^(-1); %yield coefficient of grams of cell mass to oxygen mass


V = 50; %L Size of bioreactor 

D = Q/V; %h^-1

u = 0.24; % h^-1 specific growth rate (double check this) 

X = Xi*exp(u*t); %cell density during log phase gDW



dO2 = -1 * u/Y_XO2 .* X + D*(Sin_O2);

%plotting the rate of change of oxygen at any moment in time (dO2/dt)
subplot(2, 1, 1)
fplot(@(t) -1 * u/Y_XO2 * (Xi*exp(u*t)) + D*(Sin_O2), 'r') 
title('Rate of Change of Oxygen Concentration as a Function of Time')
xlabel('hours')
ylabel('gh^-1/L')
xlim([0 24])




%calculating the total amount of betacarotene production over 24 hours 
Y_XBC = (0.020)^-1; % yield coefficient of biomass to betacarotene (gDW/gBC) SOURCE: https://www.frontiersin.org/articles/10.3389/fbioe.2020.00029/full#F2 

%plotting beta carotene production
figure
syms T
dBC = 1*u/Y_XBC *(Xi*exp(u*T)); %beta carotene production
fplot(dBC, 'r')
title('Rate of Change of Beta Carotene Production as a Function of Time')
xlabel('hours')
ylabel('gh^-1/L')
xlim([0, 25])


%cell density of yarrowia as a function of time
figure
plot(t, X, 'r')
title('Cell Density of Yarrowia Lypolitica as a Function of Time')
xlabel('hours')
ylabel('gDW/L')

%plotting the rate of change of glucose at any moment in time (dG/dt)
Y_XG = 0.262; %gDW over grams of glucose - SOURCE: https://www.frontiersin.org/articles/10.3389/fbioe.2020.00029/full#F2
dG = -1;

figure
syms T
dG = -1*u/Y_XG *(Xi*exp(u*T));
fplot(dG, 'r')
title('Rate of Change of Glucose Concentration as a Function of Time')
xlabel('hours')
ylabel('gh^-1/L')
xlim([0 24])


%--------------- TOTALS ----------------%
%integrate to get total numbers on glucose consumption
fp4 = int(dG, T);
figure
fplot(fp4)
title('Total Amount of Glucose Consumed as a Function of time in Hours')
xlabel('hours')
ylabel('g/L')

%integrate to get total amount of beta carotene produced 
amount_of_BC = double( int(dBC, T, 0, 24));
disp('Amount of betacarotene produce in 24 hours')
disp(amount_of_BC)














