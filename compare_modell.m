%% This script is used for comparing the models to eachother:

original_path_prefix = "Images/Original/";
method = "JPEG2000";
reprod_path_prefix = "Images/Reproduction/"+ method + "/";

Quality_index = [];
SSI_score= [];

for i=1:5
    original_path = original_path_prefix + i + ".bmp";
    reprod_path = reprod_path_prefix + i + ".bmp";
    Quality_index = [Quality_index, image_score(original_path,reprod_path)];
    SSI_score = [SSI_score, ssim(imread(reprod_path),imread(original_path))];
end

%Plotting the result:
hold on;
plot(SSI_score)
plot(Quality_index)
hold off;
xlabel("Images");
ylabel("Score");
title("Compare Scores to SSIM");
legend("SSIM", "Our Quality Index");