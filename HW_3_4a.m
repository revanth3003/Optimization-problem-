
clc
clear

matrix_scenarios = readmatrix('matrix_scenarios.txt');
matrix_returns = readmatrix('matrix_returns.txt');
matrix_budget = readmatrix('matrix_budget.txt');

toolboxstruc_arr(1) = tbpsg_matrix_pack('matrix_scenarios',matrix_scenarios);
toolboxstruc_arr(2) = tbpsg_matrix_pack('matrix_returns',matrix_returns);
toolboxstruc_arr(3) = tbpsg_matrix_pack('matrix_budget',matrix_budget);

expected_return = [0.01; 0.0125; 0.015; 0.020; 0.025; 0.035];

for i=1:6
  problem_statement = sprintf('%s\n',...
  'minimize',...
  'st_dev(matrix_scenarios)',...
'Constraint: == 1',...
  'linear(matrix_budget)',...
  ['Constraint: >= ',num2str(expected_return(i))],...
  'linear(matrix_returns)',...
'Box: >= 0',...
'Value: ',...
   'avg(matrix_scenarios)',...
   'var_risk(0.99, matrix_scenarios)',...
   'cvar_risk(0.99, matrix_scenarios)',...
   'cvar_dev(0.99, matrix_scenarios)',...
   'max_risk(matrix_scenarios)',...
   'pr_pen(2.268479339670E-03,matrix_scenarios)',...
   'st_dev(matrix_scenarios)',...
   'variance(matrix_scenarios)');

[solution_str, outargstruc_arr] = tbpsg_run(problem_statement,toolboxstruc_arr);
output_structure = tbpsg_solution_struct(solution_str, outargstruc_arr);
output = tbpsg_function_data(solution_str, outargstruc_arr);
std(i) = output(9);
end

figure;
plot(std,expected_return,'.','MarkerSize', 20)
axis([0 1.20E-02 0 0.040]);
title('Minimal value of standard deviation')
xlabel('Standard Deviation') 
ylabel('Expected return') 


















