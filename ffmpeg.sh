###############################
#   FFMPEG Installer Script   #
#   Stephen Simpson / Oijm17  #
#        For RHEL 6/7       #
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
    dots "Installing Libpng"
    install_libpng >>$LOG 2>1
    dots "Installing Libpng" $?
        
    dots "Installing Freetype"
    install_freetype >>$LOG 2>1
    dots "Installing Freetype" $?

    dots "Installing Libwmf"
    install_libwmf >>$LOG 2>1
    dots "Installing Libwmf" $?

    dots "Installing Lame"
    install_lame >>$LOG 2>1
    dots "Installing Lame" $?

    dots "Installing MPlayer Codecs"
    install_codecs >>$LOG 2>1
    dots "Installing Mplayer Codecs" $?

    dots "Installing Libogg"
    install_libogg >>$LOG 2>1
    dots "Installing Libogg" $?

    dots "Installing Libvorbis"
    install_libvorbis >>$LOG 2>1
    dots "Installing Libvorbis" $?

    dots "Installing VorbisTools"
    install_vorbistools >>$LOG 2>1
    dots "Installing VorbisTools" $?

    dots "Installing Libtheora"
    install_libtheora >>$LOG 2>1
    dots "Installing Libtheora" $?

    dots "Installing Opencore-AMR"
    install_openamr >>$LOG 2>1
    dots "Installing Opencore-AMR" $?

    dots "Installing Liba52" 
    install_liba52 >>$LOG 2>1
    dots "Installing Liba52" $?

    dots "Installing Libfdk"
    install_fdkaac >>$LOG 2>1
    dots "Installing Libfdk" $? 

    dots "Installing Libopus"
    install_libopus >>$LOG 2>1
    dots "Installing Libopus" $?

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

    dots "Installing Libvpx"
    install_libvpx >>$LOG 2>1
    dots "Installing Libvpx" $?
    
    dots "Installing Libasound"
    install_libasound >>$LOG 2>1
    dots "Installing Libasound" $?

    dots "Installing Psstream For Apache"
    install_psstream >>$LOG 2>1
    dots "Installing Psstream For Apache" $?

    ldconfig 
else
    echo "--- Skipping ---"
fi

### FFMPEG Programs

echo -e "\n#### Installing FFMPEG Binaries #### \n"

dots "Installing ffmpeg + Presets"
install_ffmpeg >>$LOG 2>1
dots "Installing ffmpeg + Presets" $?

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

dots "Installing ffmpeg-php"
install_ffmpegphp >>$LOG 2>1
dots "Installing ffmpeg-php" $?
