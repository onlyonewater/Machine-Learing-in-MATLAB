clc,clear
blue = [(-5 + 10 .* rand(200, 1)) (-5 + 10 .* rand(200, 1))];
angle = rand(200,1) * 2 * pi;
radius = rand(200,1) * 5 + 5;
red = [(sin(angle) .* radius) (cos(angle) .* radius)];
% Show training data.
figure(1)
hold on
plot(blue(:, 1), blue(:, 2), 'b.');
plot(red(:, 1), red(:, 2), 'r.');
title('Training Data');
dataFeature=[blue;red];
dataClass=[ones(200,1);-ones(200,1)];   %·ÖÀà
numberOfIterations=20;
AdaboostClassifier=trainAdaBoost(dataFeature, dataClass, numberOfIterations);
