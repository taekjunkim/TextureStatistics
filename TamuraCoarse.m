function CoarseIndex = TamuraCoarse(imgMtx,pixSize)
%%% compute tamura feature - coarseness
%%% CoarseIndex = TamuraCoarse(imgMtx,pixSize);
%%% imgMtx: input image. Square, grayscale, resolution of pixSize x pixSize
%%% pixSize: resolution of input image, 2^n, cannot be larger than 256
%%% Taekjun Kim, 1-21-2016


%%% tamura feature
Nx = pixSize;   Ny = pixSize;

%%% Tamura - Coarseness
Sbest=zeros(Nx,Ny);
E0h=zeros(Nx,Ny);   E0v=zeros(Nx,Ny);
E1h=zeros(Nx,Ny);   E1v=zeros(Nx,Ny);
E2h=zeros(Nx,Ny);   E2v=zeros(Nx,Ny);
E3h=zeros(Nx,Ny);   E3v=zeros(Nx,Ny);
E4h=zeros(Nx,Ny);   E4v=zeros(Nx,Ny);
E5h=zeros(Nx,Ny);   E5v=zeros(Nx,Ny);
E6h=zeros(Nx,Ny);   E6v=zeros(Nx,Ny);           
E7h=zeros(Nx,Ny);   E7v=zeros(Nx,Ny);                      

flag=0;
% 1x1 size
for i=1:Nx
   for j=1:Ny-1
       E0h(i,j) = imgMtx(i,j)-imgMtx(i,j+1);
   end
end
for i=1:Nx-1
   for j=1:Ny
       E0v(i,j) = imgMtx(i,j)-imgMtx(i+1,j);
   end
end
E0h = abs(E0h);   E0v = abs(E0v);

% 2x2 size
if (Nx<4||Ny<4), flag=1; end
imgNow = conv2(imgMtx,ones(2,2)/4,'same');
if flag==0
  for i=1:Nx-1
      for j=1:Ny-1-2
          E1h(i,j)=imgNow(i,j)-imgNow(i,j+2);
      end
  end
  for i=1:Nx-1-2
      for j=1:Ny-1
          E1v(i,j)=imgNow(i,j)-imgNow(i+2,j);
      end
  end
end
E1h = abs(E1h);   E1v = abs(E1v);

% 4x4 size
if (Nx<8||Ny<8), flag=1; end
imgNow = conv2(imgMtx,ones(4,4)/16,'same');
if flag==0
  for i=2:Nx-2
      for j=2:Ny-2-4
          E2h(i,j)=imgNow(i,j)-imgNow(i,j+4);
      end
  end
  for i=2:Nx-2-4
      for j=2:Ny-2
          E2v(i,j)=imgNow(i,j)-imgNow(i+4,j);
      end
  end
end
E2h = abs(E2h);   E2v = abs(E2v);

% 8x8 size
if (Nx<16||Ny<16), flag=1; end
imgNow = conv2(imgMtx,ones(8,8)/64,'same');
if flag==0
   for i=4:Nx-4
       for j=4:Ny-4-8
           E3h(i,j)=imgNow(i,j)-imgNow(i,j+8);
       end
   end
   for i=4:Nx-4-8
       for j=4:Ny-4
           E3v(i,j)=imgNow(i,j)-imgNow(i+8,j);
       end
   end
end
E3h = abs(E3h);   E3v = abs(E3v);

% 16x16 size
if (Nx<32||Ny<32), flag=1; end
imgNow = conv2(imgMtx,ones(16,16)/256,'same');
if flag==0
  for i=8:Nx-8
      for j=8:Ny-8-16
          E4h(i,j)=imgNow(i,j)-imgNow(i,j+16);
      end
  end
  for i=8:Nx-8-16
      for j=8:Ny-8
          E4v(i,j)=imgNow(i,j)-imgNow(i+16,j);
      end
  end
end
E4h = abs(E4h);   E4v = abs(E4v);

% 32x32 size
if (Nx<64||Ny<64), flag=1; end
imgNow = conv2(imgMtx,ones(32,32)/1024,'same');
if flag==0
  for i=16:Nx-16
      for j=16:Ny-16-32
          E5h(i,j)=imgNow(i,j)-imgNow(i,j+32);
      end
  end
  for i=16:Nx-16-32
      for j=16:Ny-16
          E5v(i,j)=imgNow(i,j)-imgNow(i+32,j);
      end
  end
end
E5h = abs(E5h);   E5v = abs(E5v);

% 64x64 size
if (Nx<128||Ny<128), flag=1; end
imgNow = conv2(imgMtx,ones(64,64)/4096,'same');
if flag==0
  for i=32:Nx-32
      for j=32:Ny-32-64
          E6h(i,j)=imgNow(i,j)-imgNow(i,j+64);
      end
  end
  for i=32:Nx-32-64
      for j=32:Ny-32
          E6v(i,j)=imgNow(i,j)-imgNow(i+64,j);
      end
  end
end
E6h = abs(E6h);   E6v = abs(E6v);

% 128x128 size           
if (Nx<256||Ny<256), flag=1; end
imgNow = conv2(imgMtx,ones(128,128)/16384,'same');
if flag==0
  for i=64:Nx-64
      for j=64:Ny-64-128
          E7h(i,j)=imgNow(i,j)-imgNow(i,j+128);
      end
  end
  for i=64:Nx-64-128
      for j=64:Ny-64
          E7v(i,j)=imgNow(i,j)-imgNow(i+128,j);
      end
  end
end
E7h = abs(E7h);   E7v = abs(E7v);

for i=1:Nx
   for j=1:Ny
       [maxv,index]=max([E0h(i,j),E0v(i,j),E1h(i,j),E1v(i,j),...
                         E2h(i,j),E2v(i,j),E3h(i,j),E3v(i,j),...
                         E4h(i,j),E4v(i,j),E5h(i,j),E5v(i,j),...
                         E6h(i,j),E6v(i,j),E7h(i,j),E7v(i,j)]);
       kk=floor((index+1)/2);
       Sbest(i,j)=2.^kk;
   end
end
CoarseIndex = sum(sum(Sbest))/(Nx*Ny);
