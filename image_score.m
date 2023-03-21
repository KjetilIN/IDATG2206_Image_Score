function image_score(img1_url, img2_url)
    img1 = imread(img1_url);
    img2 = imread(img2_url);
    
    subplot(1,2,1), imshow(img1), title("Image: " + img1_url);
    subplot(1,2,2), imshow(img2), title("Image: " + img2_url);
    
end