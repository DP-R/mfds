fprintf('As part of an experiment to determine the efficacy of a vaccine, a test drive is conducted and certain parameters were measured during the process like gender,age and weight\n')
fprintf('Determine what type of data they were?\n')
answer=['nominal interval ratio'];
dupe1=['ordinal','interval', 'ordinal'];
dupe2=['ratio','interval', 'ordinal'];
dupe3=['nominal','ratio', 'ordinal'];
fprintf('A: %s\n',answer)
fprintf('B: %s\n',dupe1)
fprintf('C: %s\n',dupe2)
fprintf('D: %s\n',dupe3)
fprintf('\n')
fprintf('')

fprintf('Explanation:\n')
fprintf('Gender is nominal as it is purely an id label for collection.\n')
fprintf('Age is interval data as the order and intervals within it are meaningful and used for data segregation.\n')
fprintf('Weight is a ratio variable as it has the properties of an interval and also zero weight is meaningful and two weight variables can be compared by division.\n')
