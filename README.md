FFMPEG Auto Installer
===
A series of scripts used to help install the latest version of FFMPEG. This currently is only tested with CentOS. It may work with fedora but unless you translate the prerequisites with apt-get first it wont work with Ubunutu. This was also designed to work within a cpanel environment where many other prerequisites were already installed. This project was originally started by the ffmpeg auto installer folks [here][1]. I ran into tons of issues with the newer version of FFMPEG so rather than continually fixing it I just forked it and with the help of a colleague simplified and fixed it.  

Install
---
1. Clone the repo or download the zip
2. run ```sh ffmpeg.sh```

That's it! Pretty simple right! You should start seeing green "completed" if everything went well. If you see any "failed" messages you can check the log in $DOWNDIR/log. By default this is located in /root/ffmpeginstall/log. Each library will begin with the "Installing lib" so you can can easily search and find. 

Libraries Installed
---
- Png
- FreeType
- Wmf
- Lame
- Ogg
- Vorbis
- VorbisTools
- Theora
- Opencore-AMR
- A52
- Fdk-Aac
- Opus
- Yasm
- Nasm
- Xvid
- X264
- Live555
- Re2c
- Amrnb
- Amrwb
- Vpx
- Asound
- Flac
- Ao
- Vo-AacEnc
- VidStab
- OpenJPEG
- Mp4v2
- Bluray
- Caca
- Ass
- Vo-AmrwBenc
- Speex
- Oggz
- Psstream For Apache

Programs Installed
---
- FFmpeg
- MPlayer
- MP4Box
- FlvTool2
- FlvTool++
- Yamdi
- FFmpeg-Php (GitHub Fork) - (Discontinued For lastest FFmpeg Version)

Future
---
- Add all necessary prereq's

[1]: http://www.ffmpeginstaller.com/
