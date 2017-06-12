###############################
#   FFMPEG Installer Script   #
#   Stephen Simpson / Oijm17  #
#        For RHEL 5/6/7       #
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

    dots "Installing libwmf"
    install_libwmf >>$LOG 2>1
    dots "Installing libwmf" $?

    dots "Installing FlvTool2"
    install_flvtool >>$LOG 2>1
    dots "Installing FlvTool2" $?

    dots "Installing Lame"
    install_lame >>$LOG 2>1
    dots "Installing Lame" $?

    dots "Installing Codecs"
    install_codecs >>$LOG 2>1
    dots "Installing Codecs" $?

    dots "Installing libogg"
    install_libogg >>$LOG 2>1
    dots "Installing libogg" $?

    dots "Installing libvorbis"
    install_libvorbis >>$LOG 2>1
    dots "Installing libvorbis" $?

    dots "Installing VorbisTools"
    install_vorbistools >>$LOG 2>1
    dots "Installing VorbisTools" $?

    dots "Installing libtheora"
    install_libtheora >>$LOG 2>1
    dots "Installing libtheora" $?

    dots "Installing openamr"
    install_openamr >>$LOG 2>1
    dots "Installing openamr" $?

    dots "Installing Liba52" 
    install_liba52 >>$LOG 2>1
    dots "Installing Liba52" $?

    dots "Installing Fdk-AAC"
    install_fdkaac >>$LOG 2>1
    dots "Installing Fdk-AAC" $? 

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

    dots "Installing x264"
    install_x264 >>$LOG 2>1
    dots "Installing x264" $?

    dots "Installing Live555"
    install_live555 >>$LOG 2>1
    dots "Installing Live555" $?

    dots "Installing re2c"
    install_re2c >>$LOG 2>1
    dots "Installing re2c" $?

    dots "Installing amrnb"
    install_amrnb >>$LOG 2>1
    dots "Installing amrnb" $?

    dots "Installing amrwb" 
    install_amrwb >>$LOG 2>1
    dots "Installing amrwb" $?

    dots "Installing libvpx"
    install_libvpx >>$LOG 2>1
    dots "Installing libvpx" $?
    
    dots "Installing libasound"
    install_libasound >>$LOG 2>1
    dots "Installing libasound" $?

    ldconfig 
else
    echo "--- Skipping ---"
fi

### FFMPEG Programs

echo -e "\n#### Installing FFMPEG Binaries #### \n"

dots "Installing FFMPEG"
install_ffmpeg >>$LOG 2>1
dots "Installing FFMPEG" $?

dots "Installing MPlayer"
install_mplayer >>$LOG 2>1
dots "Installing MPlayer" $?

dots "Installing MP4Box"
install_mp4box >>$LOG 2>1
dots "Installing MP4Box" $?

dots "Installing FFMPEG-PHP"
install_ffmpegphp >>$LOG 2>1
dots "Installing FFMPEG-PHP" $?
