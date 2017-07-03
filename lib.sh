#!/bin/bash
##### Install Libraries #####

ERROR=0

install_libpng() {
    echo " -------------- Installing Png -------------- "
    cd $DOWNDIR
    rm -vrf libpng-*
    wget -N ftp://ftp.simplesystems.org/pub/png/src/libpng16/$(curl -L ftp://ftp.simplesystems.org/pub/png/src/libpng16/ 2>1 | grep -E ".tar.gz$" | awk '{ print $NF }')
    tar -xzf libpng-*
    cd libpng-*
    ./configure --prefix=/usr --enable-shared || local ERROR=1
    make -j$cpu || local ERROR=1
    make install || local ERROR=1

    ldconfig
    return $ERROR
}

install_freetype() {
    echo " -------------- Installing FreeType -------------- "
    FREETYPE_VER="2.8" #2017-05-13
    cd $DOWNDIR
    rm -vrf freetype-$FREETYPE_VER
    wget -N http://download.savannah.gnu.org/releases/freetype/freetype-$FREETYPE_VER.tar.gz
    tar -zxvf freetype-$FREETYPE_VER.tar.gz
    cd freetype-$FREETYPE_VER
    ./configure --prefix=/usr --enable-shared || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libwmf() {
    echo " -------------- Installing Wmf -------------- "    
    LIBWMF_VER="0.2.8.4" #2005-7-27
    cd $DOWNDIR
    rm -vrf libwmf-$LIBWMF_VER
    wget -N http://downloads.sourceforge.net/project/wvware/libwmf/$LIBWMF_VER/libwmf-$LIBWMF_VER.tar.gz
    tar -xvzf  libwmf-$LIBWMF_VER.tar.gz
    cd libwmf*
    ./configure --enable-shared --prefix=/usr --with-freetype=/usr/  || local ERROR=1
    make -j$cpu  || local ERROR=1
    make install $DESTDIR  || local ERROR=1

    ldconfig
    return $ERROR
}

install_lame() {
    echo " -------------- Installing Lame -------------- "
    LAME_MJVER="3.99" #2012-02-28
    LAME_MNVER=".5"
    cd $DOWNDIR
    rm -vrf lame-$LAME_MJVER$LAME_MNVER
    wget -N http://downloads.sourceforge.net/project/lame/lame/$LAME_MJVER/lame-$LAME_MJVER$LAME_MNVER.tar.gz
    tar -zxvf lame-$LAME_MJVER$LAME_MNVER.tar.gz
    cd lame-$LAME_MJVER$LAME_MNVER
    ./configure --enable-shared --prefix=/usr --enable-mp3x --enable-mp3rtp  || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1

    ldconfig
    return $ERROR
}

install_codecs() {
    echo " -------------- Installing Mplayer Codecs -------------- "
    FFMPEG_CODECS_VER="20110131"
    cd $DOWNDIR
    rm -vfr all-$FFMPEG_CODECS_VER
    #wget -N http://mirror.ffmpeginstaller.com/source/codecs/all-$FFMPEG_CODECS_VER.tar.bz2
    wget -N http://www.mplayerhq.hu/MPlayer/releases/codecs/all-$FFMPEG_CODECS_VER.tar.bz2
    tar -xvjf all-$FFMPEG_CODECS_VER.tar.bz2
    chown -R root.root all-$FFMPEG_CODECS_VER/
    mkdir -pv /usr/lib/codecs/
    /bin/cp -vrf all-$FFMPEG_CODECS_VER/* /usr/lib/codecs/
    chmod -R 755 /usr/lib/codecs/

    ldconfig
    return $?
}

install_libogg() {
    echo " -------------- Installing Ogg -------------- "
    LIBOGG_VER="1.3.2" #2014-05-27
    cd $DOWNDIR
    rm -vrf libogg-$LIBOGG_VER
    wget -N http://downloads.xiph.org/releases/ogg/libogg-$LIBOGG_VER.tar.gz
    tar -xvzf libogg-$LIBOGG_VER.tar.gz
    cd libogg-$LIBOGG_VER
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libvorbis() {
    echo " -------------- Installing Vorbis -------------- "
    LIBVORBIS_VER="1.3.5" #2015-03-03
    cd $DOWNDIR
    rm -vrf libvorbis-$LIBVORBIS_VER
    wget -N http://downloads.xiph.org/releases/vorbis/libvorbis-$LIBVORBIS_VER.tar.gz
    tar -xvzf libvorbis-$LIBVORBIS_VER.tar.gz
    cd libvorbis-$LIBVORBIS_VER/
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_vorbistools() {
    echo " -------------- Installing VorbisTools -------------- "
    VORBISTOOLS_VER="1.4.0" #2010-03-26
    cd $DOWNDIR
    rm -vrf vorbis-tools-$VORBISTOOLS_VER
    wget -N http://downloads.xiph.org/releases/vorbis/vorbis-tools-$VORBISTOOLS_VER.tar.gz
    tar -xvzf vorbis-tools-$VORBISTOOLS_VER.tar.gz
    cd vorbis-tools-$VORBISTOOLS_VER
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libtheora() {
    echo " -------------- Installing Theora -------------- "
    LIBTHEORA_VER="1.1.1" #2010-01-25
    cd $DOWNDIR
    rm -vrf libtheora-$LIBTHEORA_VER
    wget -N http://downloads.xiph.org/releases/theora/libtheora-$LIBTHEORA_VER.tar.bz2
    tar -xvjf libtheora-$LIBTHEORA_VER.tar.bz2
    cd libtheora-$LIBTHEORA_VER
    ./configure --enable-shared --prefix=/usr --with-ogg=/usr --with-vorbis=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_openamr() {
    echo " -------------- Installing Opencore-AMR -------------- "
    OPENAMR_VER="0.1.5" #2017-03-16
    cd $DOWNDIR
    rm -vrf opencore-$OPENAMR_VER
    wget -N http://downloads.sourceforge.net/project/opencore-amr/opencore-amr/opencore-amr-$OPENAMR_VER.tar.gz
    tar -zxvf opencore-amr-$OPENAMR_VER.tar.gz
    cd opencore-amr-$OPENAMR_VER
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_liba52() {
    echo " -------------- Installing A52 -------------- "
    LIBA52_VER="0.7.4" #2002-07-27
    cd $DOWNDIR
    rm -rf a52dec-$LIBA52_VER
    wget -N http://liba52.sourceforge.net/files/a52dec-$LIBA52_VER.tar.gz
    tar -xvzf a52dec-$LIBA52_VER.tar.gz
    cd a52dec-$LIBA52_VER/
    ./bootstrap
    ARCH=`arch`
    #64bit processor bug fix
    if [[ $ARCH == 'x86_64' ]];then
      ./configure --prefix=/usr --enable-shared 'CFLAGS=-fPIC'  || local ERROR=1	
    else
      ./configure --prefix=/usr --enable-shared || local ERROR=1
    fi
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_fdkaac() {
    echo " -------------- Installing Fdk -------------- "
    cd $DOWNDIR
    rm -vrf fdk-aac
    git clone https://github.com/mstorsjo/fdk-aac.git
    cd fdk-aac/
    ./autogen.sh
    ./configure  --prefix=/usr --enable-shared --enable-static || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libopus() {
    echo " -------------- Installing Opus -------------- "
    cd $DOWNDIR
    rm -vrf opus
    git clone git://git.opus-codec.org/opus.git
    cd opus/
    ./autogen.sh || local ERROR=1
    ./configure  --prefix=/usr --enable-static --enable-shared || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_yasm() {
    echo " -------------- Installing Yasm -------------- " 
    YASM_VER="1.3.0" #2014-08-11
    cd $DOWNDIR
    rm -vrf yasm-$YASM_VER
    wget -N http://www.tortall.net/projects/yasm/releases/yasm-$YASM_VER.tar.gz
    tar -xvzf yasm-$YASM_VER.tar.gz
    cd  yasm-$YASM_VER
    sh autogen.sh
    ./configure --enable-shared --prefix=/usr  || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1

    ldconfig
    return $ERROR
}

install_nasm() {
    echo " -------------- Installing Nasm -------------- "
    NASM_VER="2.14rc0" #2017-05-01
    cd $DOWNDIR
    rm -vrf nasm-$NASM_VER
    wget -N http://www.nasm.us/pub/nasm/releasebuilds/$NASM_VER/nasm-$NASM_VER.tar.gz
    tar -xvzf nasm-$NASM_VER.tar.gz
    cd nasm-$NASM_VER
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_xvid() {
    echo " -------------- Installing Xvid -------------- "
    cd $DOWNDIR
    #need latest for MP4Box to work
    rm -vrf xvid_*
    wget -N http://downloads.xvid.org/downloads/xvid_latest.tar.gz
    tar -xvzf xvid_latest.tar.gz
    cd xvid_*/trunk/xvidcore/build/generic/
    ./bootstrap.sh
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_x264() {
    echo " -------------- Installing X264 -------------- "
    cd $DOWNDIR
    rm -vrf x264
    git clone http://repo.or.cz/r/x264.git x264
    cd x264/
    #broken centos5/32bit./configure  --prefix=/usr --enable-shared --disable-asm
    ./configure  --prefix=/usr --enable-shared || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_x265() {
    echo " -------------- Installing X265 -------------- "
    cd $DOWNDIR
    rm -vrf x265
    hg clone https://bitbucket.org/multicoreware/x265
    cd x265/build/linux/
    cmake -G "Unix Makefiles" cmake -DCMAKE_INSTALL_PREFIX:PATH="/usr/" ../../source || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_live555() {
    echo " -------------- Installing Live555 -------------- "
    cd $DOWNDIR
    rm -vrf live
    wget -N http://www.live555.com/liveMedia/public/live555-latest.tar.gz
    tar xvf live555-latest.tar.gz
    cd live
    ./genMakefiles linux || local ERROR=1
    make -j$cpu || local ERROR=1
    make install  || local ERROR=1
    make clean || local ERROR=1

    ldconfig
    return $ERROR
}

install_re2c() {
    echo " -------------- Installing Re2c -------------- "
    RE2C_VER="0.16" #2016-01-21
    cd $DOWNDIR
    echo "Removing old source"
    rm -vrf re2c-$RE2C_VER
    wget -N https://github.com/skvadrik/re2c/releases/download/$RE2C_VER/re2c-$RE2C_VER.tar.gz
    tar -xvzf re2c-$RE2C_VER.tar.gz
    cd re2c-$RE2C_VER/
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_amrnb() {
    echo " -------------- Installing Amrnb -------------- "
    AMR_VER="11.0.0.0" #2013-04-05
    cd $DOWNDIR
    rm -vrf amrnb-$AMR_VER
    wget --no-check-certificate -N ftp://ftp.penguin.cz/pub/users/utx/amr/amrnb-$AMR_VER.tar.bz2
    tar -xvjf amrnb-$AMR_VER.tar.bz2
    cd amrnb-$AMR_VER
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_amrwb() {
    echo " -------------- Installing Amrwb -------------- "
    cd $DOWNDIR
    rm -vrf amrwb-$AMR_VER
    wget -N ftp://ftp.penguin.cz/pub/users/utx/amr/amrwb-$AMR_VER.tar.bz2
    tar -xvjf amrwb-$AMR_VER.tar.bz2
    cd amrwb-$AMR_VER
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libvpx() {
    echo " -------------- Installing Vpx -------------- "
    cd $DOWNDIR
    rm -vrf libvpx
    git clone https://chromium.googlesource.com/webm/libvpx libvpx
    cd libvpx
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libasound() {
    echo " -------------- Installing Asound -------------- "
    cd $DOWNDIR
    rm -rf alsa-lib*
    wget -N ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.1.4.1.tar.bz2
    tar xjf alsa-lib*
    cd alsa-lib-*
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_flac() {
    echo " -------------- Installing Flac -------------- "
    cd $DOWNDIR
    rm -vrf flac-1.3.2
    wget -N http://downloads.xiph.org/releases/flac/flac-1.3.2.tar.xz
    tar -Jxf flac-1.3.2.tar.xz
    cd flac-1.3.2
    ./configure --prefix=/usr --enable-shared || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libao() {
    echo " -------------- Installing Ao -------------- "
    cd $DOWNDIR
    rm -vrf libao-1.2.0
    wget -N http://downloads.xiph.org/releases/ao/libao-1.2.0.tar.gz
    tar -zxvf libao-1.2.0.tar.gz
    cd libao-1.2.0
    ./configure --prefix=/usr --enable-shared || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_voaacenc() {
    echo " -------------- Installing Vo-AacEnc -------------- "
    cd $DOWNDIR
    rm -vrf vo-aacenc-0.1.3
    wget -N http://downloads.sourceforge.net/project/opencore-amr/vo-aacenc/vo-aacenc-0.1.3.tar.gz
    tar -zxvf vo-aacenc-0.1.3.tar.gz
    cd vo-aacenc-0.1.3
    ./configure --prefix=/usr --enable-shared || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libvidstab() {
    echo " -------------- Installing VidStab -------------- "
    cd $DOWNDIR
    rm -vrf vid.stab
    git clone https://github.com/georgmartius/vid.stab.git
    cd vid.stab
    cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr/
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libopenjpeg() {
    echo " -------------- Installing OpenJPEG -------------- "
    cd $DOWNDIR
    rm -vrf openjpeg
    git clone https://github.com/uclouvain/openjpeg.git
    cd openjpeg
    autoreconf -fiv
    rm -fr build/
    mkdir build/
    cd build/
    cmake .. -DCMAKE_INSTALL_PREFIX:PATH=/usr/ || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    make clean || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libmp4v2() {
    echo " -------------- Installing Mp4v2 -------------- "
    cd $DOWNDIR
    rm -vrf libmp4v2
    git clone https://github.com/sergiomb2/libmp4v2.git
    cd libmp4v2
    autoreconf -fiv
    rm -fr build/
    mkdir build/
    cd build/
    ../configure --prefix=/usr/ --enable-shared --disable-static || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    make install-man || local ERROR=1
    make dist || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libbluray() {
    echo " -------------- Installing Bluray -------------- "
    cd $DOWNDIR
    rm -vrf libbluray-1.0.0
    wget -N ftp://ftp.videolan.org/pub/videolan/libbluray/1.0.0/libbluray-1.0.0.tar.bz2
    tar -xjvf libbluray-1.0.0.tar.bz2
    cd libbluray-1.0.0
    ./bootstrap
    ./configure --prefix=/usr/ --enable-shared  --disable-static || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libcaca() {
    echo " -------------- Installing Caca -------------- "
    cd $DOWNDIR
    rm -vrf libcaca
    git clone https://github.com/cacalabs/libcaca.git
    cd libcaca
    ./bootstrap
    git submodule update --init
    ./configure --prefix=/usr/ --enable-shared  --disable-static || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libass() {
    echo " -------------- Installing Ass -------------- "
    cd $DOWNDIR
    rm -vrf libass-0.13.7
    wget -N https://github.com/libass/libass/releases/download/0.13.7/libass-0.13.7.tar.gz
    tar -zxvf libass-0.13.7.tar.gz
    cd libass-0.13.7
    ./configure --prefix=/usr/ --enable-shared  --disable-static || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libvoamrwbenc() {
    echo " -------------- Installing Vo-AmrwBenc -------------- "
    cd $DOWNDIR
    rm -vrf vo-amrwbenc-0.1.3
    wget -N https://downloads.sourceforge.net/project/opencore-amr/vo-amrwbenc/vo-amrwbenc-0.1.3.tar.gz
    tar -zxvf vo-amrwbenc-0.1.3.tar.gz
    cd vo-amrwbenc-0.1.3
    ./configure --prefix=/usr/ --enable-shared  --disable-static || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_libspeex() {
    echo " -------------- Installing Speex -------------- "
    cd $DOWNDIR
    rm -vrf speex-1.2.0
    wget -N http://downloads.us.xiph.org/releases/speex/speex-1.2.0.tar.gz
    tar -zxvf speex-1.2.0.tar.gz
    cd speex-1.2.0
    ./configure --prefix=/usr/ --enable-shared  --disable-static || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_liboggz() {
    echo " -------------- Installing Oggz -------------- "
    cd $DOWNDIR
    rm -vrf liboggz-1.1.1
    wget -N http://downloads.xiph.org/releases/liboggz/liboggz-1.1.1.tar.gz
    tar -zxvf liboggz-1.1.1.tar.gz
    cd liboggz-1.1.1
    ./configure --prefix=/usr/ --enable-shared  --disable-static || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    
    ldconfig
    return $ERROR
}

install_psstream() {
    echo " -------------- Installing Psstream For Apache -------------- "
    cd $DOWNDIR
    rm -rf psstream
    mkdir -pv /etc/httpd/conf.d
    wget -N wget http://saaplugin.no-ip.info/lostandfound/psstream-1.0.tar.gz
    tar xzvf psstream-*
    cd psstream
    phpize || local ERROR=1
    ./configure --enable-psstream || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1
    cp -vrf psstream.ini /etc/httpd/conf.d/
    
    ldconfig
    return $ERROR
}
