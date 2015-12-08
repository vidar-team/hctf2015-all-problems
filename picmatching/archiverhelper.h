#ifndef ARCHIVERHELPER_H
#define ARCHIVERHELPER_H

#include <boost/serialization/vector.hpp>
#include "opencv2/core.hpp"
using std::vector;

template<typename T>
class ArchiveHelper
{

public:
    ArchiveHelper(T & any):mVector(any)
    {

    }

    operator T &()
    {
        return mVector;
    }
private:
    T & mVector;
    friend class boost::serialization::access;
    template<class Archive>
    void serialize(Archive & ar, const unsigned int version)
    {
        ar & mVector;
    }

};
BOOST_SERIALIZATION_SPLIT_FREE(cv::Mat)
namespace boost {
namespace serialization {

template<class Archive>
void serialize(Archive & ar, cv::KeyPoint & keypoint, const unsigned int version)
{
    ar & keypoint.class_id;
    ar & keypoint.angle;
    ar & keypoint.octave;
    ar & keypoint.pt;
    ar & keypoint.response;
    ar & keypoint.size;
}
template<class Archive,typename _Tp>
void serialize(Archive & ar, cv::Point_<_Tp> & p, const unsigned int version)
{
    ar & p.x;
    ar & p.y;
}
/** Serialization support for cv::Mat */
template<class Archive>
void save(Archive & ar, const cv::Mat & m, const unsigned int version)
{
    size_t elem_size = m.elemSize();
    size_t elem_type = m.type();

    ar & m.cols;
    ar & m.rows;
    ar & elem_size;
    ar & elem_type;

    const size_t data_size = m.cols * m.rows * elem_size;
    ar & boost::serialization::make_array(m.ptr(), data_size);
}

/** Serialization support for cv::Mat */
template<class Archive>
void load(Archive & ar, cv::Mat & m, const unsigned int version)
{
    int cols, rows;
    size_t elem_size, elem_type;

    ar & cols;
    ar & rows;
    ar & elem_size;
    ar & elem_type;

    m.create(rows, cols, elem_type);

    size_t data_size = m.cols * m.rows * elem_size;
    ar & boost::serialization::make_array(m.ptr(), data_size);
}

} // namespace serialization
} // namespace boost

#endif // ARCHIVERHELPER_H
