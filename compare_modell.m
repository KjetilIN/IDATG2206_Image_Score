%% Compare out index to the SSIM diffrent distortions 

%Original path prefix
original_path_prefix = "Images/Original/";

%Each method
methods = ["JPEG2000", "Gaussian", "Poisson", "SGCK_GAMUT_MAPPING"];

figure();

%For each method 
for j=1:length(methods)
    method = methods(j);
    reprod_path_prefix = "Images/Reproduction/" + method + "/";

    %Empty list of scores 
    Quality_index = [];
    SSIM_score = [];
    
    %For each of the images, add the score of each image to the lists
    for i=1:10
        original_path = original_path_prefix + i + ".bmp";
        reprod_path = reprod_path_prefix + i + ".bmp";
        Quality_index = [Quality_index, image_score(original_path,reprod_path)];
        SSIM_score = [SSIM_score, ssim(imread(reprod_path),imread(original_path))];
    end

    % Compare our quality score to the SSIM score, and add it to the
    % subplot
    subplot(length(methods),1,j);
    hold on;
    plot(SSIM_score)
    plot(Quality_index)
    hold off;
    xlabel("Images");
    ylabel("Score");
    title("Compare Scores to SSIM for " + method + " Images");
    legend("SSIM", "Our Quality Index");

    
end
