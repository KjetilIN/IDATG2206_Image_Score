%% Testing of diffrent images
% A script for comparing scores of our model based on the distorion method

% Define the paths to the different image sets
paths = {"Gaussian", "JPEG2000", "Poisson", "SGCK_GAMUT_MAPPING"};

% Create an empty list to store the final scores for each image set
final_scores = cell(1, length(paths));

% Loop over the image sets and calculate the scores
for k = 1:length(paths)
    % Define the range of image numbers
    image_numbers = 1:10;
    
    % Preallocate an array of zeros to store the scores
    scores = zeros(1, length(image_numbers));
    
    % Loop over the image numbers and calculate the scores
    for i = image_numbers
        % Create the image path string using the image number
        image_path = "Images/Reproduction/" + paths{k} + "/";
        score = image_score("Images/Original/" + i + ".bmp", image_path + i + ".bmp");
        scores(i) = score;
    end

    final_scores{k} = scores;
end

% Plot the final scores for all image sets in a single plot
hold on;
for i = 1:length(final_scores)
    plot(final_scores{i});
end

% Add labels to the plot
xlabel('Image number');
ylabel('Score');
title("Score Based on Each type of picture");

% Plot each array in the same plot
legend("Gaussian", "JPEG2000", "Poisson", "SGCK GAMUT MAPPING");