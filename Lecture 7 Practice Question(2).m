%% Lecture 7 Practice Question
% Matrix Mathematics and Comparison
% Environmental Engineering + Geological Engineering
%
% This script solves:
% Part (a): Water quality after treatment
% Part (b): Groundwater inflow from fractures
%
% Students should run this code in MATLAB and then write the final answers
% in the answer table by hand.

clc;        % Clears the Command Window
clear;      % Removes all variables from the Workspace
close all;  % Closes all open figure windows


%% ============================================================
% PART (a): Environmental Engineering
% Water Quality After Treatment
% ============================================================

% The matrix C contains the initial concentrations of contaminants.
% Rows represent sampling locations:
% Row 1 = Sampling Location 1
% Row 2 = Sampling Location 2
% Row 3 = Sampling Location 3
%
% Columns represent contaminants:
% Column 1 = Nitrate
% Column 2 = Phosphate

C = [14.0  0.30;
      9.0  0.18;
     16.0  0.12];

% The matrix removal contains the removal efficiency in percent.
% For example, 25 means 25% removal.
% This matrix has the same size as C because each concentration value
% has its own removal percentage.

removal = [25  40;
           20  30;
           35  20];

% The matrix limit contains the maximum allowed concentration.
% Each row is for one sampling location.
% Column 1 is the nitrate limit.
% Column 2 is the phosphate limit.

limit = [10  0.15;
         10  0.15;
         10  0.15];

% Check the size of the concentration matrix.
% This is useful because we should not assume the number of rows and columns.

[numRows, numCols] = size(C);

% Display the number of rows and columns.
% numRows should be 3 and numCols should be 2.

disp('Size of concentration matrix C:')
disp([numRows, numCols])


% Calculate the final concentration after treatment.
%
% removal/100 converts percent values to decimal values.
% Example: 25% becomes 0.25.
%
% 1 - removal/100 gives the fraction remaining after treatment.
% Example: if removal is 25%, then 75% remains.
%
% The operator .* is used for element-wise multiplication.
% This means each element in C is multiplied by the corresponding element
% in (1 - removal/100).

Cfinal = C .* (1 - removal/100);

% Display the final concentration matrix.

disp('Final concentration matrix Cfinal:')
disp(Cfinal)


% Calculate the average final nitrate concentration.
% Nitrate is in column 1 of Cfinal.
% Cfinal(:,1) means all rows from column 1.

avgNitrate = mean(Cfinal(:,1));

% Calculate the average final phosphate concentration.
% Phosphate is in column 2 of Cfinal.

avgPhosphate = mean(Cfinal(:,2));


% Compare final concentrations with the guideline limits.
% The result is a logical matrix containing 1 and 0.
% 1 means the value is greater than the limit.
% 0 means the value is not greater than the limit.

exceedMatrix = Cfinal > limit;

% Count the total number of exceedances.
% sum(exceedMatrix,'all') adds all the true values in the logical matrix.

numExceedances = sum(exceedMatrix, 'all');


% Find the sampling locations where final nitrate concentration is greater than 10.
% Cfinal(:,1) selects nitrate concentrations.
% > 10 checks which nitrate values are greater than 10.
% find returns the row number where this condition is true.

nitrateExceedLocations = find(Cfinal(:,1) > 10);


% Display final answers for Part (a).

disp('---------------- PART (a) FINAL ANSWERS ----------------')
disp('Average final nitrate concentration:')
disp(avgNitrate)

disp('Average final phosphate concentration:')
disp(avgPhosphate)

disp('Number of values greater than the limit:')
disp(numExceedances)

disp('Sampling location(s) where final nitrate > 10:')
disp(nitrateExceedLocations)


%% ============================================================
% PART (b): Geological Engineering
% Groundwater Inflow from Fractures
% ============================================================

% We have three equations:
%
% 2q1 + q2 + q3 = 13
% q1 + 3q2 + 2q3 = 18
% q1 + q3 = 7
%
% These equations can be written in matrix form:
%
% A*q = b
%
% A is the coefficient matrix.
% q is the unknown vector [q1; q2; q3].
% b is the known right-hand-side vector.

A = [2  1  1;
     1  3  2;
     1  0  1];

b = [13;
     18;
      7];

% Calculate the determinant of A.
% The determinant helps us check whether the system can have a unique solution.
% If det(A) is not zero, the matrix is non-singular and the system has a unique solution.

detA = det(A);

% Solve the system of linear equations.
%
% In MATLAB, A\b is the preferred way to solve A*q = b.
% It is better than using inv(A)*b because it is more efficient and accurate.

q = A\b;

% q(1) is q1
% q(2) is q2
% q(3) is q3

q1 = q(1);
q2 = q(2);
q3 = q(3);

% Find which fracture has an inflow rate greater than 4 L/min.
% q > 4 creates a logical vector.
% find(q > 4) returns the fracture number where the condition is true.

highInflowFractures = find(q > 4);

% Calculate the total inflow by summing q1, q2, and q3.

totalInflow = sum(q);


% Display final answers for Part (b).

disp('---------------- PART (b) FINAL ANSWERS ----------------')
disp('Determinant of A:')
disp(detA)

disp('Fracture inflow rates q1, q2, q3:')
disp(q)

disp('Fracture number(s) where q > 4 L/min:')
disp(highInflowFractures)

disp('Total inflow:')
disp(totalInflow)


%% ============================================================
% Optional: Display final answers in a cleaner format
% ============================================================

fprintf('\nFINAL ANSWER SUMMARY\n')
fprintf('====================\n')

fprintf('\nPart (a): Environmental Engineering\n')
fprintf('Average final nitrate concentration = %.2f\n', avgNitrate)
fprintf('Average final phosphate concentration = %.2f\n', avgPhosphate)
fprintf('Number of exceedances = %d\n', numExceedances)
fprintf('Sampling locations where nitrate > 10 = ')
fprintf('%d ', nitrateExceedLocations)
fprintf('\n')

fprintf('\nPart (b): Geological Engineering\n')
fprintf('det(A) = %.2f\n', detA)
fprintf('q1 = %.2f L/min\n', q1)
fprintf('q2 = %.2f L/min\n', q2)
fprintf('q3 = %.2f L/min\n', q3)
fprintf('Fracture number(s) where q > 4 L/min = ')
fprintf('%d ', highInflowFractures)
fprintf('\n')
fprintf('Total inflow = %.2f L/min\n', totalInflow)