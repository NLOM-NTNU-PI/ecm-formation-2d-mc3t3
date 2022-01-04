%This script loads, displays and save images from dataset ecm-formation-2d-mc3t3-4
%Data: Aurora: ecm-formation-2d-mc3t3-4
%Journal notes: https://github.com/NLOM-NTNU-PI/labbook/blob/main/ecm-formation-2d-mc3t3

%Place data (.lif file) in  folder .\data\
%Load data
if ~(exist('data','var')) %load data unless already loaded
    data = bfopen('.\data\ecm-formation-2d-mc3t3-4.lif');
end
%data is an nx4 cell array of n rows of images where the image data are stored in
%the first position of the second dimension (columns). The other columns are metadata.
%Note: This are not the same as the numbers in the journal, see metadata
%for series number in the lif file which corresponds to journal notes

na = [1]; %Wrong spectra for channels
nb = [2]; %Calcein and propidium iodide
nc = [3]; %Hoechst
%12-18 Different seeding densities
%19-24 Different media
nd = [4:6,8:14,16,18,21:24,26]; 
%7 at 400 Hz, repeated in 8. 15, 17 at 400Hz
%19,20 Detector saturation
%27-30 63x water objective
ne = [28];
nf = [30];
%27, 29, Saturation
%Oil objectve
ng = [31];

n = 31;
filter = 1 ;
adjust = 1 ;
shg = 1;
%Different contrast adjustments for different images.
switch n
    case 4
        low = [0,0,0;1,0.4,1];
        high = [0,0,0;1,1,0.6];
    case {5,6}
        low = [0,0,0;1,0.4,1];
        high = [0,0,0;0.6,1,0.6];
    case {21,22,23,24,25,26}
        low = [0,0,0;1,0.2,1];
        high = [0,0,0;0.6,1,0.6];
    otherwise
        low = [];
        high = [];
end

if any(n==na || n==nb || n==nc)
    channels = size(data{n,1},1);
    imgtype = class(data{n,1}{1,1});
    dim = size(data{n,1}{1,1});   
    img = zeros([dim,3],imgtype); 
    for i = 1:1:channels
        if i> 3; break; end        
        img(:,:,i) = data{n,1}{i,1}; 
        if filter == 1
            img(:,:,i) = medfilt2(img(:,:,i));
        end
    end
    imshow(img)     
elseif any(n==nd)
    channels = size(data{n,1},1);
    imgtype = class(data{n,1}{1,1});
    dim = size(data{n,1}{1,1});   
    img = zeros([dim,3],imgtype); 
    %1-calcein, 2- PI, 3-DAPI, 4-SHG
    img(:,:,1) = data{n,1}{1,1}; 
    if shg == 1
        img(:,:,2) = data{n,1}{4,1}; %SHG in green channel
    else
        img(:,:,2) = imadjust(data{n,1}{2,1},[0.01,0.02]); %Propidium iodide in green channel        
    end
    img(:,:,3) = data{n,1}{3,1};
    if adjust == 1
        img = imadjust(img, low, high);
    end
    imshow(img)     
elseif any(n==ne)
     dim = size(data{n,1});
     %channels = size(data{n,1},1);
     channels = 3;
     len = (dim(1)/channels); %4 channels
     
     temp = data{n,1}{1,1};
     
     img_series = zeros([size(temp),3,len],class(temp));
     for i = [1:len]
        img_series(:,:,1,i) = data{n,1}{i*4-3,1};
        img_series(:,:,2,i) = imadjust(data{n,1}{i*channels,1},[0,0.15]);
        img_series(:,:,3,i) = imadjust(data{n,1}{i*channels-1,1},[0,0.8]);
     end
     mov = immovie(img_series);
     implay(mov)
elseif any(n==nf)
     dim = size(data{n,1});
     channels = 2;
     
     len = (dim(1)/channels); %3 channels
     
     temp = data{n,1}{1,1};
     
     img_series = zeros([size(temp),3,len],class(temp));
     for i = [1:len]
        %img_series(:,:,1,i) = data{n,1}{i*4-3,1};
        img_series(:,:,2,i) = imadjust(data{n,1}{i*channels,1});
        img_series(:,:,3,i) = imadjust(data{n,1}{i*channels-1,1});
     end
     mov = immovie(img_series);
     implay(mov)
end
%channels = size(data{n,1},1);
%imgtype = class(data{n,1}{1,1});
%dim = size(data{n,1}{1,1});
%temp = data{n,1}{1,1};
%img = zeros([dim,3],imgtype);   
%img(:,:,1) = data{n,1}{1,1}; %1-calcein, 2- PI, 3-DAPI, 4-SHG
%img(:,:,2) = data{n,1}{2,1};
%img(:,:,3) = data{n,1}{3,1};
%img = imadjust(img, [0,0,0;0.8,0.4,1]);
%for i = 1:1:channels
%    if i> 3; break; end
%    img(:,:,i) = data{n,1}{i,1}; %TPEF
    %img(:,:,2) = data{n,1}{2,1}; %BSHG
%end
%img(:,:,3) = temp; %FSHG

%image(img)   