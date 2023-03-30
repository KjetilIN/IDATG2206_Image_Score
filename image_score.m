%% Calculate Score
% The main function that should show the score diffrence provided the image
% paths
function score = image_score(orginal_image_url, secondary_image_url)
    %Reading the images provided
    orginal = imread(orginal_image_url);
    secondary = imread(secondary_image_url);
    
    % Assigning each constant
    noise_constant = 0.5;
    resolution_constant = 0.25; 
    sharpness_constant = 1.4; 
    statistics_constant = 0.25; 
    color_similarity_constant = 0.4; 

    % Assigning adjustment constant, delta
    adjustment_constant = 0.26; 
    
    %Compute the sum of each factor multiplied with each of their constant
    score = noise_constant * calculateNoise(secondary)/calculateNoise(orginal) + ...
        resolution_constant * calculateResolutionDifference(secondary, orginal) + ...
        sharpness_constant * sharpnessRatio(orginal,secondary) + ...
        statistics_constant * image_stats(secondary) / image_stats(orginal)+ ...
        color_similarity_constant * get_color_similarity(orginal, secondary);
    
    %Take the 4th root of score
    score = nthroot(score,4)- adjustment_constant;
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
    image1Grey = rgb2gray(originalImage);
    image2Grey = rgb2gray(secondaryImage);
    
    % Calculate the size of the images
    
    % Calculate the size of the images
    [m, n] = size(image1Grey);
    
    % Define the Laplacian filter
    lap_filter = [0 1 0; 1 -4 1; 0 1 0];
    
    % Calculate the high-frequency energy for both images
    padded1 = padarray(image1Grey, [1, 1], 'replicate');
    padded2 = padarray(image2Grey, [1, 1], 'replicate');
    hfe1 = sum(abs(conv2(padded1, lap_filter, 'valid')), 'all');
    hfe2 = sum(abs(conv2(padded2, lap_filter, 'valid')), 'all');
    
    % Calculate the low-frequency energy for both images
    kernel = ones(5, 5)/25;
    blurred1 = conv2(double(image1Grey), kernel, 'same');
    blurred2 = conv2(double(image2Grey), kernel, 'same');
    lfe1 = sum(blurred1(:).^2)/(m*n);
    lfe2 = sum(blurred2(:).^2)/(m*n);
    
    % Calculate the sharpness ratio for both images
    sr1 = hfe1/lfe1;
    sr2 = hfe2/lfe2;
    
    % Calculate the ratio of sharpness
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



%% Color

function color_ratio = get_color_ratio(img)
    % Convert the image to a double precision array
    img = double(img);
    
    % Compute the sum of pixel values along each color channel
    red_sum = sum(img(:,:,1), 'all');
    green_sum = sum(img(:,:,2), 'all');
    blue_sum = sum(img(:,:,3), 'all');
    
    % Compute the total sum of pixel values
    total_sum = red_sum + green_sum + blue_sum;
    
    % Compute the ratio of pixels in each color channel
    red_ratio = red_sum / total_sum;
    green_ratio = green_sum / total_sum;
    blue_ratio = blue_sum / total_sum;
    
    % Return the color ratio as a vector
    color_ratio = [red_ratio, green_ratio, blue_ratio];
end

function color_similarity = get_color_similarity(original, distorted)
    % Compute the color ratio for the original image
    original_ratio = get_color_ratio(original);
    
    % Compute the color ratio for the distorted image
    distorted_ratio = get_color_ratio(distorted);
    
    % Compute the color similarity as the percentage of difference
    color_similarity = 1 - norm(original_ratio - distorted_ratio) / sqrt(numel(original_ratio));
end
