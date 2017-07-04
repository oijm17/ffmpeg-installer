###############################
#   FFMPEG Installer Script   #
#   Stephen Simpson / Oijm17  #
#        For RHEL 6/7         #
#       v0.5 - 10/06/17       #
###############################

## Includes
source ./req.sh
source ./lib.sh
source ./bin.sh
source ./functions.sh

export global binonly=false

#Parse Args
opts $@

#PreInstall

tabs 16
export global cpu=`cat "/proc/cpuinfo" | grep "processor"|wc -l`
export global TMPDIR=$HOME/tmp
mkdir -p $HOME/tmp
export global DOWNDIR=/root/ffmpeginstall
mkdir -p $DOWNDIR
export global DESTDIR=""
export global ARCH=$(arch)
export global LOG=$DOWNDIR/log

traps >$LOG 2>1

## Header
echo -e "\n FFMPEG Installer Script \n"
echo -e "\n Log File: $LOG\n"

## Presetup 
echo -e "\n#### Running PreSetup #### \n"

dots "Installing Ruby"
install_ruby >>$LOG 2>1
dots "Installing Ruby" $?

dots "Removing Files"
remove_stuff >>$LOG 2>1
dots "Removing Files" $?

dots "Running Yum Installs"
run_yum >>$LOG 2>1
dots "Running Yum Installs" $?

dots "Checking Threads"
check_threads >>$LOG 2>1
dots "Checking Threads" $?

dots "Installing Git"
install_git >>$LOG 2>1
dots "Installing Git" $?

## Libraries

echo -e "\n#### Installing Libraries #### \n"

if ! $binonly
then
    dots "Installing Png"
    install_libpng >>$LOG 2>1
    dots "Installing Png" $?
        
    dots "Installing Freetype"
    install_freetype >>$LOG 2>1
    dots "Installing Freetype" $?

    dots "Installing Wmf"
    install_libwmf >>$LOG 2>1
    dots "Installing Wmf" $?

    dots "Installing Lame"
    install_lame >>$LOG 2>1
    dots "Installing Lame" $?

    dots "Installing MPlayer Codecs"
    install_codecs >>$LOG 2>1
    dots "Installing Mplayer Codecs" $?

    dots "Installing Ogg"
    install_libogg >>$LOG 2>1
    dots "Installing Ogg" $?

    dots "Installing Vorbis"
    install_libvorbis >>$LOG 2>1
    dots "Installing Vorbis" $?

    dots "Installing VorbisTools"
    install_vorbistools >>$LOG 2>1
    dots "Installing VorbisTools" $?

    dots "Installing Theora"
    install_libtheora >>$LOG 2>1
    dots "Installing Theora" $?

    dots "Installing Opencore-AMR"
    install_openamr >>$LOG 2>1
    dots "Installing Opencore-AMR" $?

    dots "Installing A52" 
    install_liba52 >>$LOG 2>1
    dots "Installing A52" $?

    dots "Installing Fdk"
    install_fdkaac >>$LOG 2>1
    dots "Installing Fdk" $? 

    dots "Installing Opus"
    install_libopus >>$LOG 2>1
    dots "Installing Opus" $?

    dots "Installing Yasm"
    install_yasm >>$LOG 2>1
    dots "Installing Yasm" $?

    dots "Installing Nasm"
    install_nasm >>$LOG 2>1
    dots "Installing Nasm" $?

    dots "Installing Xvid"
    install_xvid >>$LOG 2>1
    dots "Installing Xvid" $?

    dots "Installing X264"
    install_x264 >>$LOG 2>1
    dots "Installing X264" $?

    dots "Installing X265"
    install_x265 >>$LOG 2>1
    dots "Installing X265" $?
    
    dots "Installing Live555"
    install_live555 >>$LOG 2>1
    dots "Installing Live555" $?

    dots "Installing Re2c"
    install_re2c >>$LOG 2>1
    dots "Installing Re2c" $?

    dots "Installing Amrnb"
    install_amrnb >>$LOG 2>1
    dots "Installing Amrnb" $?

    dots "Installing Amrwb" 
    install_amrwb >>$LOG 2>1
    dots "Installing Amrwb" $?

    dots "Installing Vpx"
    install_libvpx >>$LOG 2>1
    dots "Installing Vpx" $?
    
    dots "Installing Asound"
    install_libasound >>$LOG 2>1
    dots "Installing Asound" $?

    dots "Installing Flac"
    install_flac >>$LOG 2>1
    dots "Installing Flac" $?

    dots "Installing Ao"
    install_libao >>$LOG 2>1
    dots "Installing Ao" $?

    dots "Installing Vo-AacEnc"
    install_voaacenc >>$LOG 2>1
    dots "Installing Vo-AacEnc" $?

    dots "Installing VidStab"
    install_libvidstab >>$LOG 2>1
    dots "Installing VidStab" $?

    dots "Installing OpenJPEG"
    install_libopenjpeg >>$LOG 2>1
    dots "Installing OpenJPEG" $?

    dots "Installing Mp4v2"
    install_libmp4v2 >>$LOG 2>1
    dots "Installing Mp4v2" $?

    dots "Installing Bluray"
    install_libbluray >>$LOG 2>1
    dots "Installing Bluray" $?

    dots "Installing Caca"
    install_libcaca >>$LOG 2>1
    dots "Installing Caca" $?

    dots "Installing Ass"
    install_libass >>$LOG 2>1
    dots "Installing Ass" $?

    dots "Installing Vo-AmrwBenc"
    install_libvoamrwbenc >>$LOG 2>1
    dots "Installing Vo-AmrwBenc" $?

    dots "Installing Speex"
    install_libspeex >>$LOG 2>1
    dots "Installing Speex" $?

    dots "Installing Oggz"
    install_liboggz >>$LOG 2>1
    dots "Installing Oggz" $?

    dots "Installing Psstream For Apache"
    install_psstream >>$LOG 2>1
    dots "Installing Psstream For Apache" $?

    ldconfig 
else
    echo "--- Skipping ---"
fi

### FFMPEG Programs

echo -e "\n#### Installing FFMPEG Binaries #### \n"

dots "Installing FFmpeg + Presets"
install_ffmpeg >>$LOG 2>1
dots "Installing FFmpeg + Presets" $?

dots "Installing Mediainfo"
install_mediainfo >>$LOG 2>1
dots "Installing Mediainfo" $?

dots "Installing MPlayer"
install_mplayer >>$LOG 2>1
dots "Installing MPlayer" $?

dots "Installing MP4Box"
install_mp4box >>$LOG 2>1
dots "Installing MP4Box" $?

dots "Installing FlvTool2"
install_flvtool2 >>$LOG 2>1
dots "Installing FlvTool2" $?

dots "Installing Flvtool++"
install_flvtoolpp >>$LOG 2>1
dots "Installing Flvtool++" $?

dots "Installing Yamdi"
install_yamdi >>$LOG 2>1
dots "Installing Yamdi" $?

dots "Installing FFmpeg-Php"
install_ffmpegphp >>$LOG 2>1
dots "Installing FFmpeg-Php" $?
