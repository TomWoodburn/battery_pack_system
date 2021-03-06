%% Section 1: Finding The Attainable Set of Battery Cells (given Equality constraints)

load('BatterySet0812.mat');

PackAh = table2array(BatterySet1112(:,19));
PackCost = table2array(BatterySet1112(:,18));
PackMass = table2array(BatterySet1112(:,16));
MaxPackPower = table2array(BatterySet1112(:,20));

%ASetting up Y-Lines to show Equality Constraints
xPower = [0 0.6 1.2];
yPower = [250 250 250];
yPackAh = [40 40 40];

%Figure 1: Max Pack Power vs Pack Mass
figure('Name', 'Figure 1: Max Pack Power vs Pack Mass') %Naming the figure

xpos = [PackMass];
ypos = [MaxPackPower];
xlim([0 1.2]);
ylim([50 2000]);
labels = TransposedSplitString;
h = labelpoints (xpos, ypos, labels, 'N', 0.2, 1); 
hold on
sz = 25;
scatter(PackMass, MaxPackPower, sz,'filled');
hold on
plot(xPower,yPower) 
xlabel('Pack Mass (Kg)') %Labelling X-Axis
ylabel('Max Pack Power (W)') %Labelling Y-Axis
title('Figure 1: Max Pack Power (W) vs Pack Mass (Kg)') %adds a title to the graph
hold off


%Figure 2: Pack Capactiy vs Pack Mass
figure('Name', 'Figure 2: Pack Capacity (Ah) vs Pack Mass (Kg)') %Naming the figure

xpos = [PackMass];
ypos = [PackAh];
xlim([0 1.2]);
ylim([0 60]);
labels = TransposedSplitString;
h = labelpoints (xpos, ypos, labels, 'N', 0.2, 1); 
hold on
sz = 25;
scatter(PackMass, PackAh, sz,'filled');
hold on
plot(xPower,yPackAh);
xlabel('Pack Mass (Kg)') %Labelling X-Axis
ylabel('Pack Energy Capacity (Ah)') %Labelling Y-Axis
title('Figure 2: Pack Capacity (Ah) vs Pack Mass (Kg)') %adds a title to the graph
hold off





%% Section 2: Highlighting Attainable Set of Battery Cells (3D Scatter Plots)



BattAttainableAh = find(abs(PackAh)>40);
x(BattAttainableAh) = [];

BattAttainablePower = find(abs(MaxPackPower)>250);
x(BattAttainablePower) = [];


[val]=intersect(BattAttainableAh,BattAttainablePower);

AttainableTable = BatterySet1112(val',:);

AttainablePackAh = table2array(AttainableTable(:,19));
AttainablePackCost = table2array(AttainableTable(:,18));
AttainablePackMass = table2array(AttainableTable(:,16));
AttainableMaxPackPower = table2array(AttainableTable(:,20));
AttainableRunTime250W = table2array(AttainableTable(:,23));
AttainablePackCost = table2array(AttainableTable(:,18));


AttainableBatteryNames = table2array(AttainableTable(:,1));

n2 = AttainableBatteryNames;
allOneString2 = sprintf('%s,' , n2);
allOneString2 = allOneString2(1:end-2); %strip final comma
splitString2 = split(allOneString2,',');
TransposedSplitString2 = splitString2';


figure('Name', 'Figure 3: Pack Mass (Kg) vs Max Pack Power (W) vs Pack Capacity (Ah)') %Naming the figure
xpos = [AttainableMaxPackPower];
ypos = [AttainablePackAh];
zpos = [AttainablePackMass];
xlim([200 2000]);
ylim([35 55]);
zlim([0.5 1.2]);
labels2 = TransposedSplitString2;
%h2 = labelpoints (xpos, ypos, zpos, labels2, 'N', 0.2, 1);
S = 25;
scatter3(AttainableMaxPackPower, AttainablePackAh, AttainablePackMass, S,'filled')
xlabel('Max Pack Power (W)') %Labelling X-Axis
ylabel('Pack Capacity (Ah)') %Labelling Y-Axis
zlabel('Pack Mass (Kg)') %Labelling Y-Axis
text(AttainableMaxPackPower, AttainablePackAh, AttainablePackMass, TransposedSplitString2);
title('Figure 3: Pack Mass (Kg) vs Max Pack Power (W) vs Pack Capacity (Ah)') %adds a title to the graph

figure('Name', 'Figure 4: Pack Mass (Kg) vs Max Pack Power (W) vs Pack Run Time @ 250W (Hours)') %Naming the figure
xpos = [AttainableMaxPackPower];
ypos = [AttainableRunTime250W];
zpos = [AttainablePackMass];
xlim([200 2000]);
ylim([0.5 0.8]);
zlim([0.5 1.2]);
labels2 = TransposedSplitString2;
%h2 = labelpoints (xpos, ypos, zpos, labels2, 'N', 0.2, 1);
S = 25;
scatter3(AttainableMaxPackPower, AttainableRunTime250W, AttainablePackMass, S,'filled')
xlabel('Max Pack Power (W)') %Labelling X-Axis
ylabel('Pack Run Time @ 250W (Hours)') %Labelling Y-Axis
zlabel('Pack Mass (Kg)') %Labelling Y-Axis
text(AttainableMaxPackPower, AttainableRunTime250W, AttainablePackMass, TransposedSplitString2);
title('Figure 4: Pack Mass (Kg) vs Max Pack Power (W) vs Pack Run Time @ 250W (Hours)') %adds a title to the graph

%% Section 3: Selection of Battery based on minimising mass 

%Figure X: Cost of Cells in the attainable Dataset
figure('Name', 'Figure 5: Pack Mass (Kg) of Attainable cells') %Naming the figure
 %adds a title to the graph
XBattNames = 1:1:7;
YMass = AttainablePackMass';

hStem = stem(XBattNames,YMass);

%// Create labels.
Labels2 = {"3.6V 3000mAh FT";"3.6V 3.5Ah FT";"3.6V 3.4Ah CT";"3.7V 4200mAh FT";"40T 3.6V 4000mAh FT";"Li-Mn 3.7V 3500mAh FT";"Li-Mn HD 3.7V 4200mAh FT"}

%// Get position of each stem 'bar'. Sorry I don't know how to name them.
X_data2 = get(hStem, 'XData');
Y_data2 = get(hStem, 'YData');

%// Assign labels.
for labelID = 1 : numel(X_data2)
   text(X_data2(labelID), Y_data2(labelID) + 0.1, Labels2{labelID}, 'HorizontalAlignment', 'left','rotation',90);
end
 
xlabel('Battery Names') %Labelling X-Axis
ylabel('Battery Pack Mass (Kg)') %Labelling Y-Axis
xlim([0 8]);
ylim([0.5 2]);
title('Figure 5: Pack Mass (Kg) of Attainable cells')

%% Section 4: Cost as Secondary Objective Function

%Figure X: Cost of Cells in the attainable Dataset
figure('Name', 'Figure 6: Pack Cost (GBP) of Attainable cells') %Naming the figure
 %adds a title to the graph
XBattNames = 1:1:7;
YCost = AttainablePackCost';

hStem = stem(XBattNames,YCost);

%// Create labels.
Labels = {"3.6V 3000mAh FT";"3.6V 3.5Ah FT";"3.6V 3.4Ah CT";"3.7V 4200mAh FT";"40T 3.6V 4000mAh FT";"Li-Mn 3.7V 3500mAh FT";"Li-Mn HD 3.7V 4200mAh FT"}

%// Get position of each stem 'bar'. Sorry I don't know how to name them.
X_data = get(hStem, 'XData');
Y_data = get(hStem, 'YData');

%// Assign labels.
for labelID = 1 : numel(X_data)
   text(X_data(labelID), Y_data(labelID) + 3, Labels{labelID}, 'HorizontalAlignment', 'left','rotation',90);
end
 
xlabel('Battery Names') %Labelling X-Axis
ylabel('Battery Pack Cost (GBP)') %Labelling Y-Axis
xlim([0 8]);
ylim([130 300]);
title('Figure 6: Pack Cost (GBP) of Attainable cells')

%% Section 5: Self Adjudged Pareto Set (Mass vs Cost) - for the Attainable Set

%Figure 1: Max Pack Power vs Pack Mass
figure('Name', 'Figure 7: Attainable Set Mass (Kg) vs Attainable Set Cost (GBP)') %Naming the figure

xpos = [AttainablePackCost];
ypos = [AttainablePackMass];
xlim([130 260]);
ylim([0.5 1.5]);
labels = TransposedSplitString2;
h = labelpoints (xpos, ypos, labels, 'N', 0.2, 1); 
hold on
sz = 25;
scatter(AttainablePackCost, AttainablePackMass, sz,'filled');

xlabel('Pack Cost (GBP)') %Labelling X-Axis
ylabel('Pack Mass (Kg))') %Labelling Y-Axis
title('Figure 7: Attainable Set Mass (Kg) vs Attainable Set Cost (GBP)') %adds a title to the graph
hold off

%% Section 6: Printing the Values of the Selected Battery 

%Run this section to print the selected Battery type

SelectedBatteryPack = AttainableTable(2,:)



%% Further Incomplete Optimisation: Residuals 

%[fitobject,gof,output] = fit(AttainableMaxPackPower,AttainableRunTime250W, AttainablePackMass, 'Style', 'Residual' );
%residuals=output.residuals; 



%p=polyfit(AttainableMaxPackPower,AttainableRunTime250W,1);
%residuals=polyval(p,x)-y;

%MassRTPoweroutput.residuals;
%MassAhPoweroutput.residuals;


%% Further Incomplete Optimisation: Normalising Data Ahead of Finding Multiobjective Pareto Set 
%{
Test = num2str(AttainablePackAh);

A1 = normalize(Test);

[,]


Np = normalize(A1,'norm',1)
%}

BatterySet1112Cut = BatterySet1112(:,3:23);
BatterySet1112CutArray = table2array(BatterySet1112Cut);

NormArray = normc(BatterySet1112CutArray);

NormPackCost = (NormArray(:,16));
NormPackMass = (NormArray(:,14));
NormMaxPackPower = (NormArray(:,18));
NormRunTime250W = (NormArray(:,21));
NormPackAh = (NormArray(:,17));

%{
%Using Polyfit to test quality of polynomial curve fitting of normalised
%data

p = polyfit(NormPackMass, NormPackAh,2)
f = polyval(p,NormPackMass); 
plot(NormPackMass, NormPackAh,'o',NormPackMass,f,'-') 
legend('data','linear fit')
hold on
%plot(xPower,yPackAh);
xlabel('Normalised Pack Mass (Kg)') %Labelling X-Axis
ylabel('Normalised Pack Energy Capacity (Ah)') %Labelling Y-Axis
title('Figure x: Normalised Pack Capacity (Ah) vs Pack Mass (Kg)') %adds a title to the graph
hold off



[p,S] = polyfit(NormPackMass, NormPackAh,1)
[y_fit,delta] = polyval(p,NormPackMass,S);

plot(NormPackMass, NormPackAh,'bo')
hold on
plot(NormPackMass,y_fit,'r-')
plot(NormPackMass,y_fit+2*delta,'m--',NormPackMass,y_fit-2*delta,'m--')
title('Linear Fit of Data with 95% Prediction Interval')
legend('Data','Linear Fit','95% Prediction Interval')


f = polyval(p,NormPackMass); 
plot(NormPackMass, NormPackAh,'o',NormPackMass,f,'-') 
legend('data','linear fit')
hold on
%plot(xPower,yPackAh);
xlabel('Normalised Pack Mass (Kg)') %Labelling X-Axis
ylabel('Normalised Pack Energy Capacity (Ah)') %Labelling Y-Axis
title('Figure x: Normalised Pack Capacity (Ah) vs Pack Mass (Kg)') %adds a title to the graph
hold off
%}
%Scatter Plots to get Equations 

%Figure 2: Pack Capactiy vs Pack Mass
figure('Name', 'Figure x: Normalised Pack Capacity (Ah) vs Pack Mass (Kg)') %Naming the figure
%{
xpos = [NormPackMass];
ypos = [NormPackAh];
xlim([0 1]);
ylim([0 1]);
labels = TransposedSplitString;
h = labelpoints (xpos, ypos, labels, 'N', 0.2, 1); 
hold on
%}
sz = 25;

scatter(NormPackMass, NormPackAh, sz,'filled');
xlabel('Normalised Pack Mass (Kg)') %Labelling X-Axis
ylabel('Normalised Pack Energy Capacity (Ah)') %Labelling Y-Axis
title('Figure x: Normalised Pack Capacity (Ah) vs Pack Mass (Kg)') %adds a title to the graph
hold off

%Figure 2: Pack Max Power vs Pack Mass
figure('Name', 'Figure x: Normalised Pack Max. Power (W) vs Pack Mass (Kg)') %Naming the figure
%{
xpos = [NormPackMass];
ypos = [NormPackAh];
xlim([0 1]);
ylim([0 1]);
labels = TransposedSplitString;
h = labelpoints (xpos, ypos, labels, 'N', 0.2, 1); 
hold on
%}
sz = 25;

scatter(NormPackMass, NormMaxPackPower, sz,'filled');
xlabel('Normalised Pack Mass (Kg)') %Labelling X-Axis
ylabel('Normalised Pack Max. Power (W)') %Labelling Y-Axis
title('Figure x:Normalised Pack Max. Power (W) vs Pack Mass (Kg)') %adds a title to the graph
hold off





%Plot Coefficients
%Plot NormPackAh vs NormPackMass

xNormMass = linspace(0,1);  %adjust as needed
p = [-2.73768873269127,2.12332858117414,-0.105693287574911];
NormPackAhVsNormMassCurve = p(1)*(xNormMass.^2) + p(2)*(xNormMass) + p(3);

%NEEED THESEEE 08:33
%Plot PackAh vs Mass curve
q = [2.62161727407408,0.205568391612961,0.00569023401222044];
NormMaxPowervsNormMassCurve = q(1)*(xNormMass.^2) + q(2)*(xNormMass) + q(3);


figure('Name', 'Figure x: Comparing Normalised Variables against Normalised Mass') %Naming the figure
title('Figure x: Comparing Normalised Variables against Normalised Mass') %adds a title to the graph
plot(xNormMass,NormMaxPowervsNormMassCurve);
hold on 
plot(xNormMass,NormPackAhVsNormMassCurve);

xlabel('Normalised Pack Mass (Kg)') %Labelling X-Axis
ylabel('Normalised Pack Max. Power (W) & Pack Power (Ah)') %Labelling Y-Axis
title('Figure x: [Normalised] Pack Max. Power (W) & Pack Power (Ah) vs Pack Mass (Kg)') %adds a title to the graph

%y(1) = NormPackAhVsNormMassCurve;
%y(2) = NormMaxPowervsNormMassCurve;

FitnessFunction = @simple_multiobjective;
numberOfVariables = 1;
[x,fval] = gamultiobj(FitnessFunction,numberOfVariables);



