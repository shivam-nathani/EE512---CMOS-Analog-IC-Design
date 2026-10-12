%% EE512 A#01 - Q3 AC Analysis
% Phase vs Frequency
% Mark phase at GBW

clear;
clc;
close all;

%% Read CSV data
data = readtable('A1Q3_AC_Phase.csv');

freq  = data{:,1};
phase = data{:,2};

%% GBW obtained from Q3 gain analysis
f_GBW = 5.255e9;    % Hz

%% Find phase at GBW by interpolation
phase_GBW = interp1(freq, phase, f_GBW, 'linear');

%% Plot phase
figure;

semilogx(freq, phase, ...
    'LineWidth', 1.8);

hold on;

%% Mark phase at GBW
plot(f_GBW, phase_GBW, 'o', ...
    'MarkerSize', 8, ...
    'MarkerFaceColor', 'r');

%% GBW reference line
xline(f_GBW, '--', ...
    sprintf('GBW = %.3f GHz', f_GBW/1e9), ...
    'LabelHorizontalAlignment', 'left');

%% Annotate phase at GBW
text(f_GBW*0.75, phase_GBW + 3, ...
    sprintf('\\phi(GBW) = %.2f^\\circ', phase_GBW), ...
    'FontSize', 10, ...
    'FontWeight', 'bold');

%% Labels and title
xlabel('Frequency (Hz)');
ylabel('Phase (deg)');
title('A1Q3: Phase vs Frequency');

%% Axis limits
xlim([1 1e10]);
ylim([0 185]);

grid on;
box on;

set(gca, 'FontSize', 11);

%% Display result
fprintf('GBW = %.3f GHz\n', f_GBW/1e9);
fprintf('Phase at GBW = %.3f degrees\n', phase_GBW);