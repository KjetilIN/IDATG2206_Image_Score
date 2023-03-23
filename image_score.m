%% Calculate Score
% The main function that should show the score diffrence provided the image
% paths
function score = image_score(orginal_image_url, secondary_image_url)
    orginal = imread(orginal_image_url);
    secondary = imread(secondary_image_url);
    score = calculateNoise(secondary)/calculateNoise(orginal);

    
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