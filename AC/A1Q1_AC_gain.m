%% EE512 A#01 - Q1 AC Analysis
% Gain vs Frequency
% Mark 3-dB bandwidth and GBW

clear;
clc;
close all;

%% Read CSV data
data = readtable('A1Q1_ac_gain.csv');

freq = data{:,1};
gain_dB = data{:,2};

%% Low-frequency gain
A0_dB = gain_dB(1);

%% 3-dB level
gain_3dB = A0_dB - 3;

%% Find 3-dB bandwidth
idx_3dB = find( ...
    (gain_dB(1:end-1) >= gain_3dB) & ...
    (gain_dB(2:end) <= gain_3dB), 1);

% Interpolation on logarithmic frequency axis
logf1 = log10(freq(idx_3dB));
logf2 = log10(freq(idx_3dB+1));

f_3dB = 10^(logf1 + ...
    (gain_3dB - gain_dB(idx_3dB)) * ...
    (logf2 - logf1) / ...
    (gain_dB(idx_3dB+1) - gain_dB(idx_3dB)));

%% Find GBW (0-dB crossing)
idx_GBW = find( ...
    (gain_dB(1:end-1) >= 0) & ...
    (gain_dB(2:end) <= 0), 1);

% Interpolation on logarithmic frequency axis
logf1 = log10(freq(idx_GBW));
logf2 = log10(freq(idx_GBW+1));

f_GBW = 10^(logf1 + ...
    (0 - gain_dB(idx_GBW)) * ...
    (logf2 - logf1) / ...
    (gain_dB(idx_GBW+1) - gain_dB(idx_GBW)));

%% Plot
figure;

semilogx(freq, gain_dB, ...
    'LineWidth', 1.8);

hold on;

%% Mark 3-dB bandwidth
plot(f_3dB, gain_3dB, 'o', ...
    'MarkerSize', 8, ...
    'MarkerFaceColor', 'r');

%% Mark GBW
plot(f_GBW, 0, 'o', ...
    'MarkerSize', 8, ...
    'MarkerFaceColor', 'r');

%% Reference lines
yline(gain_3dB, '--', ...
    '3-dB level', ...
    'LabelHorizontalAlignment', 'left');

yline(0, '--', ...
    '0 dB', ...
    'LabelHorizontalAlignment', 'left');

%% Mark low-frequency gain
plot(freq(1), A0_dB, 'o', ...
    'MarkerSize', 8, ...
    'MarkerFaceColor', 'r');

text(2*freq(1), A0_dB + 0.8, ...
    sprintf('A_v = %.3f dB', A0_dB), ...
    'FontSize', 10, ...
    'FontWeight', 'bold');

%% Annotate 3-dB bandwidth
text(f_3dB*1.08, gain_3dB, ...
    sprintf('f_{3dB} = %.3f MHz', f_3dB/1e6), ...
    'FontSize', 10);

%% Annotate GBW
text(f_GBW*0.72, 2, ...
    sprintf('GBW = %.3f MHz', f_GBW/1e6), ...
    'FontSize', 10);

%% Labels and title
xlabel('Frequency (Hz)');
ylabel('Gain (dB)');

title('A1Q1: Voltage Gain vs Frequency');

%% Y-axis range
ylim([-65 10]);

grid on;
box on;

set(gca, 'FontSize', 11);

%% Display results
fprintf('Low-frequency gain = %.3f dB\n', A0_dB);
fprintf('Linear voltage gain = %.3f V/V\n', ...
    10^(A0_dB/20));

fprintf('3-dB bandwidth = %.3f MHz\n', ...
    f_3dB/1e6);

fprintf('GBW = %.3f MHz\n', ...
    f_GBW/1e6);