%% EE512 A#01 - A1Q2 AC Analysis
% Phase vs Frequency
% Mark phase at GBW

clear;
clc;
close all;

%% Read CSV data
data = readtable('A1Q2_AC_Phase.csv');

freq  = data{:,1};
phase = data{:,2};

%% GBW obtained from gain analysis
f_GBW = 7.97e6;   % Hz

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

%% Vertical GBW reference line
xline(f_GBW, '--', ...
    sprintf('GBW = %.2f MHz', f_GBW/1e6), ...
    'LabelHorizontalAlignment', 'left');

%% Annotation
text(f_GBW*1.15, phase_GBW, ...
    sprintf('\\phi(GBW) = %.2f^\\circ', phase_GBW), ...
    'FontSize', 10, ...
    'FontWeight', 'bold');

%% Labels and title
xlabel('Frequency (Hz)');
ylabel('Phase (deg)');
title('A1Q2: Phase vs Frequency');

%% Axis limits
xlim([1 1e10]);
ylim([70 185]);

grid on;
box on;

set(gca, 'FontSize', 11);

%% Display result
fprintf('GBW = %.3f MHz\n', f_GBW/1e6);
fprintf('Phase at GBW = %.3f degrees\n', phase_GBW);