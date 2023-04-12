%% About this file.
% Generates a table for checking values 

% List of names that describe the images
Image_Names = ["Pink Flowers"; "Lamps"; "Wall writing"; "Coast"; "Winter House"; "Hand(s)"; "Peacock"; "Hedgehog"; "Ocean"; "Sunflower"];

%Add all the scores lists. 
Gaussian_Image_Score = [];
JPEG2000_Score = [];
Poisson_Score = [];
SGCK_GAMUT_MAPPING_Score = [];

% For each image name, add the scores to the image for each distorion 
for i=1:length(Image_Names)
    orginalImagePath = "Images/Original/" + i + ".bmp";
    pathPrefix = "Images/Reproduction/";
    Gaussian_Image_Score = [Gaussian_Image_Score; image_score(orginalImagePath, pathPrefix + "Gaussian/" + i+".bmp")];
    JPEG2000_Score = [JPEG2000_Score; image_score(orginalImagePath, pathPrefix + "JPEG2000/" + i+".bmp")];
    Poisson_Score = [Poisson_Score; image_score(orginalImagePath, pathPrefix + "Poisson/" + i+".bmp")];
    SGCK_GAMUT_MAPPING_Score = [SGCK_GAMUT_MAPPING_Score; image_score(orginalImagePath, pathPrefix + "SGCK_GAMUT_MAPPING/" + i+".bmp")];
end

% creating a table object using the MATLAB function
mytable = table(Image_Names, Gaussian_Image_Score, JPEG2000_Score, Poisson_Score, SGCK_GAMUT_MAPPING_Score);

%Displaying the table 
mytable