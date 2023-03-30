%% Calculate Score
% The main function that should show the score diffrence provided the image
% paths
function score = image_score(orginal_image_url, secondary_image_url)
    orginal = imread(orginal_image_url);
    secondary = imread(secondary_image_url);
    score = calculateNoise(secondary)/calculateNoise(orginal) + ...
        calculateResolutionDifference(secondary, orginal) + ...
        sharpnessRatio(orginal,secondary) + ...
        image_stats(secondary) / image_stats(orginal) ;

    score = nthroot(score,4);
end

%% Noise
% Calculate the noise diffrence for each image by using the signal to noise
% ratio. 

function snr = calculateNoise(givenImage)
    % Image turned into grayscale
    img = im2gray(givenImage);

    % Calculate each of the variables 
    img = double(img(:));
    ima = max(img(:));
    imi = min(img(:));
    ims = std(img(:));

    % Calculating the noise using the signal to noise ratio
    snr = 10*log((ima-imi)./ims);
end

%% Resolution
% Calculates the resolution difference between two images

function diff = calculateResolutionDifference(givenImage, givenImage2)
    % Get size of the images
    [m1, n1] = size(givenImage);
    [m2, n2] = size(givenImage2);
    
    % Calculate resolution difference
    diff = abs(m1*n1 - m2*n2);
    
    % Converts the scalar diff to a double precision number
    diff = double(diff);

end


%% Sharpness 

function sharpness = sharpnessRatio(originalImage, secondaryImage)
    % Sharpness is a subjective measure of the clarity and detail in an image. 
    % However, there are some objective measures that can be used to estimate the sharpness of an image. 
    % One such measure is the sharpness ratio, which is the ratio of the high-frequency energy (HFE) to the low-frequency energy (LFE) in the image.
    
    
    % Convert the images to grayscale
    image1Grey = im2gray(originalImage);
    image2Grey = im2gray(secondaryImage);
    
    % Calculate the size of the images
    [m,n] = size(image1Grey);
    
    % Define the Laplacian filter
    lap_filter = [0 1 0; 1 -4 1; 0 1 0];
    
    % Calculate the high-frequency energy for both images
    hfe1 = sum(sum(abs(filter2(lap_filter, image1Grey))));
    hfe2 = sum(sum(abs(filter2(lap_filter, image2Grey))));
    
    % Calculate the low-frequency energy for both images
    lfe1 = sum(sum(image1Grey.^2))/(m*n);
    lfe2 = sum(sum(image2Grey.^2))/(m*n);
    
    % Calculate the sharpness ratio for both images
    sr1 = hfe1/lfe1;
    sr2 = hfe2/lfe2;
    
    sharpness = sr2/sr1;
end


%% Stat function

function stat_val = image_stats(img)
    % Convert the image to a double precision array
    img = double(img);
    
    % Compute the sum of pixel values
    sum_val = sum(img(:));
    
    % Count the number of pixels in the image
    num_pixels = numel(img);
    
    % Compute the mean value of the pixel values
    mean_val = sum_val / num_pixels;
    
    % Compute the unbiased estimate of the standard deviation
    std_val = std(img(:), 1);
    
    % Sum the estimate of standard deviation and mean pixel value
    stat_val = std_val + mean_val;
end