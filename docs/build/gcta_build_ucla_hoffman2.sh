# compile gcta64 on hoffman2

rootdir=$(pwd)

module load gcc
module load cmake
module load eigen
module load boost
module load intel

mkdir ${rootdir}/gcta_dep

cd ${rootdir}/gcta_dep
# install spectra_pkg
wget https://github.com/yixuan/spectra/archive/v1.0.0.tar.gz
tar -zxf v1.0.0.tar.gz && rm v1.0.0.tar.gz
cd spectra-1.0.0/ && mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=$rootdir/spectra_pkg ..
make install

cd $rootdir

# header ready
export EIGEN3_INCLUDE_DIR=$EIGEN3_INC
export BOOST_LIB=$BOOST_INCLUDEDIR
export MKLROOT=$MKLROOT
export SPECTRA_LIB=$rootdir/spectra_pkg/include

echo $EIGEN3_INCLUDE_DIR $BOOST_LIB $MKLROOT $SPECTRA_LIB

# clone GCTA
cd $rootdir
git clone https://github.com/jianyangqt/gcta.git
cd gcta
git submodule update --init

# make GCTA
mkdir build && cd build
cmake .. && make -j8

