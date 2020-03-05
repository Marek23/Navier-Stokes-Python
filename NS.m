clear; close all;

%% nazwa wmalowywanego obrazu
imgName = 'test.png';

%% pomocnicze nazwy plików (nie trzeba zmienia?)
maskName  = 'mask.png';

I = im2double(imread(imgName));

[nx, ny, nz] = size(I);

maska = double(1-((I(:,:,1) == 0 ) & ...
                (  I(:,:,2) == 1) & ...
                (  I(:,:,3) == 0)));
imwrite(~maska, maskName);

%% Navier Stokes
tic
resName = 'output.png';
cmd = sprintf('python %s %s %s %s', 'inpaint.py', imgName, maskName, resName);
system(cmd)
ts = toc;

I = imread(resName);
imshow(I);
imwrite(I, ['output' 't_' num2str(ts) '.png']);
