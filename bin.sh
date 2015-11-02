#!/bin/bash

ERROR=0

install_ffmpeg() {
    echo " -------------- Installing FFMPEG -------------- "
    cd $DOWNDIR
    rm -vrf FFmpeg-master
    wget -N https://www.ffmpeg.org/releases/ffmpeg-2.4.11.tar.gz -O ffmpeg.tar.gz
    tar -zxvf ffmpeg.tar.gz
    mv ffmpeg-2.4.11 FFmpeg-master
    cd FFmpeg-master/
    ./configure --prefix=/usr --enable-shared --enable-nonfree \
    --enable-gpl --enable-pthreads --enable-decoder=liba52 \
    --enable-libfaac  --enable-libmp3lame \
    --enable-libtheora --enable-libvorbis  --enable-libx264  --enable-libxvid \
    --extra-cflags=-I/usr/include/ --extra-ldflags=-L/usr/lib \
    --enable-version3 --extra-version=syslint --enable-libopencore-amrnb \
    --enable-libopencore-amrwb --enable-avfilter --enable-libvpx || local ERROR=1
    make || local ERROR=1
    make tools/qt-faststart || local ERROR=1
    make install $DESTDIR || local ERROR=1
    cp -vf tools/qt-faststart /usr/bin/
    ldconfig

    return $ERROR
}

install_mplayer() {
    echo " -------------- Installing MPlayer -------------- "
    cd $DOWNDIR
    rm -vrf mplayer-export*
    svn checkout svn://svn.mplayerhq.hu/mplayer/trunk mplayer
    cd mplayer
    git clone --depth 1 https://github.com/FFmpeg/FFmpeg ffmpeg; touch ffmpeg/mp_auto_pull #Grabbing ffmpeg first for verbosity
    sed -i 1521d configure
    ./configure --prefix=/usr --codecsdir=/usr/lib/codecs/ \
    --extra-cflags=-I/usr/include/ --extra-ldflags=-L/usr/lib \
    --confdir=/usr/etc/mplayer || local ERROR=1
    make || local ERROR=1
    make install $DESTDIR || local ERROR=1
    cp -f etc/codecs.conf /usr/etc/mplayer/codecs.conf

    return $ERROR
}

install_mp4box() {
    echo " -------------- Installing MP4Box -------------- "
    cd $DOWNDIR
    rm -rf gpac
    svn co https://github.com/gpac/gpac/trunk gpac
    cd gpac/
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    #./configure --prefix=/usr --extra-cflags=-I/usr/include/ \
    #--extra-ldflags=-L/usr/lib --disable-wx --strip
    make || local ERROR=1
    make install $DESTDIR  || local ERROR=1
    
    return $ERROR
}

install_ffmpegphp() {
    echo " -------------- Installing PHP-FFMPEG -------------- "
    cd $DOWNDIR
    rm -rfv ffmpeg-php
    git clone https://github.com/tony2001/ffmpeg-php.git
    cd ffmpeg-php
    phpize
    ./configure --enable-shared --prefix=/usr || local ERROR=1
    make -j$cpu || local ERROR=1
    make install $DESTDIR || local ERROR=1


    if grep -q "^extension=ffmpeg.so" /usr/local/lib/php.ini
    then
      echo "Extension already enabled in php.ini, ignoring"
    else
      echo "Installing extension in php.ini"
      echo "extension=ffmpeg.so" >> /usr/local/lib/php.ini
      php -m | grep ffmpeg
      /etc/init.d/httpd restart
    fi
    
    return $ERROR
}
