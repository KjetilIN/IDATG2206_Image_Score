original_path_prefix = "Images/Original/";
methods = ["JPEG2000", "Gaussian", "Poisson", "SGCK_GAMUT_MAPPING"];

figure();
for j=1:length(methods)
    method = methods(j);
    reprod_path_prefix = "Images/Reproduction/" + method + "/";
    Quality_index = [];
    SSI_score = [];
    for i=1:10
        original_path = original_path_prefix + i + ".bmp";
        reprod_path = reprod_path_prefix + i + ".bmp";
        Quality_index = [Quality_index, image_score(original_path,reprod_path)];
        SSI_score = [SSI_score, ssim(imread(reprod_path),imread(original_path))];
    end
    subplot(length(methods),1,j);
    hold on;
    plot(SSI_score)
    plot(Quality_index)
    hold off;
    xlabel("Images");
    ylabel("Score");
    title("Compare Scores to SSIM for " + method + " Images");
    legend("SSIM", "Our Quality Index");
end
