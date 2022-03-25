%sadra khamoshi
%97521261

%initialization
clc;
clear;

%% 1
amp = 3;    %turn it up loudER
filename_in = 'taunt.wav';
[data, fs] = audioread(filename_in);
new_data = data*amp;  % increase amplitude of signal

player = audioplayer(new_data, fs); % play the new sound
%%%%% UNCOMMENT BELOW LINE TO PLAY THE AUDIO
% play(player);

%% 2
% read audio file
[y, Fs] = audioread('myname.wav');
% Play wav File
player2 = audioplayer(y, Fs);

%%%%% UNCOMMENT BELOW LINE TO PLAY THE AUDIO
% play(player2);

% % draw histogram
histogram(y(:), 'FaceColor', 'red');
grid on;

fprintf('size of y: %d\n', length(y));
fprintf("Frame per second(Fs): %d\n", Fs);


%% 3 make the sound echo
clc;
clear all;
close all;
[y, Fs] = audioread('myname.wav');

delay = 0.4;
alpha = 0.7;
D = delay*Fs;
new_y = zeros(size(y));
new_y(1:D) = y(1:D);

for i=D+1:length(y)
    new_y(i) = y(i) + alpha*y(i-D);
end

b = [1, zeros(1,D), alpha];
new_y = filter(b, 1, y);
sound(new_y, Fs);
audiowrite('myname_echo.wav', y, Fs);

%% 4 noise removal from audio
clc
clear all
close all
[y, Fs] = audioread('myname.wav');
SNR=6;
noisy_signal=awgn(y,SNR,'measured');
audiowrite('myname_noisy.wav', noisy_signal, Fs);
% sound(z, Fs);

[peaksnr_init, snr_init] = psnr(y, y);
disp(['The Peak-SNR value at the begining ', num2str(peaksnr_init)]);

[peaksnr_before_noise_removal, snr_before] = psnr(noisy_signal, y);
disp(['The Peak-SNR value before noise reduction ', num2str(peaksnr_before_noise_removal)]);

subplot(2,2,1);
plot(y);
title('Original signal');
xlabel('Time');
ylabel('Amplitude');
subplot(2,2,2);
plot(noisy_signal);
title('Noise corrupted signal');
xlabel('Time');
ylabel('Amplitude');

g2 = fft(noisy_signal);
subplot(2,2,3);
plot(abs(g2));
title('Magnitude part of fft');

f=find(abs(g2)<50);
g2(f)=zeros(size(f));
w=ifft(g2);
subplot(2,2,4);
plot(w);
title('Signal after noise removal');
xlabel('Time');
ylabel('Amplitude');

% sound(w, Fs);
% sound(noisy_signal, Fs);
audiowrite('myname_fft.wav', w, Fs);

[peaksnr_after_noise_removal, snr_after] = psnr(w, y);
disp(['The Peak-SNR value after noise reduction with  Fast Fourier Transform is ', num2str(peaksnr_after_noise_removal)]);

% remove niose from signal with wiener2
no_noise_audio_wiener2 = wiener2(noisy_signal);
[peaksnr_w, snr_w] = psnr(no_noise_audio_wiener2, y);
disp(['The Peak-SNR value after noise reduction wiht wiener2 is ', num2str(peaksnr_w)]);
% % =============================
sound(no_noise_audio_wiener2, Fs);
audiowrite('myname_wiener2.wav', no_noise_audio_wiener2, Fs);



