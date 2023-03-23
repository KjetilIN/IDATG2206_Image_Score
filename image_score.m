% The main function that should show the score diffrence provided the image
% paths
function image_score(img1_url, img2_url)
    img1 = imread(img1_url);
    img2 = imread(img2_url);
    
    subplot(1,2,1), imshow(img1), title("Image: " + img1_url);
    subplot(1,2,2), imshow(img2), title("Image: " + img2_url);

    qualityIndex = calculateNoise(img1);

    
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
