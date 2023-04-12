%% Compare our image quality score to the SSIM score for different distortion methods
% This script is for comparing to out model to the SSIM model

% Set the path prefix for the original images
original_path_prefix = "Images/Original/";

% Define the distortion methods to evaluate
methods = ["JPEG2000", "Gaussian", "Poisson", "SGCK_GAMUT_MAPPING"];

% Create a figure to plot the results
figure();

% For each distortion method, plot the comparison of image quality score to SSIM score
for j = 1:length(methods)
    method = methods(j);
    
    % Set the path prefix for the reproduced images for the current method
    reprod_path_prefix = "Images/Reproduction/" + method + "/";
    
    % Create empty lists to store the quality scores and SSIM scores for each image
    quality_scores = [];
    ssim_scores = [];
    
    % For each image, calculate the quality score and SSIM score and add them to the lists
    for i = 1:10
        original_path = original_path_prefix + i + ".bmp";
        reprod_path = reprod_path_prefix + i + ".bmp";
        
        % Calculate the quality score using our custom metric and adding it
        % 
        quality_score = image_score(original_path, reprod_path);
        quality_scores = [quality_scores, quality_score];
        
        % Calculate the SSIM score using the built-in function
        ssim_score = ssim(imread(reprod_path), imread(original_path));
        ssim_scores = [ssim_scores, ssim_score];
    end
    
    % Add a subplot for the current method and plot the quality scores and SSIM scores
    subplot(length(methods), 1, j);
    hold on;
    plot(ssim_scores)
    plot(quality_scores)
    hold off;
    
    % Add labels and a title to the subplot
    xlabel("Images");
    ylabel("Score");
    title("Comparison of SSIM Score and Our Quality Index for " + method + " Images");
    legend("SSIM Score", "Our Quality Index");
end

