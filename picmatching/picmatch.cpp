#include <stdio.h>
#include <iostream>
#include <fstream>

#include <boost/archive/binary_oarchive.hpp>
#include <boost/archive/binary_iarchive.hpp>
#include <boost/iostreams/filtering_streambuf.hpp>
#include <boost/iostreams/filter/zlib.hpp>

#include "opencv2/core.hpp"
#include "opencv2/xfeatures2d.hpp"
#include "opencv2/highgui.hpp"
#include "archiverhelper.h"

#define minHessian 400
#define siftPoints 0

using namespace std;
using namespace cv;
using namespace cv::xfeatures2d;

using namespace boost;
using namespace boost::archive;


void readme();
/* @function main */

int main( int argc, char** argv )
{
    if( argc != 4 )
    { readme(); return -1; }
    namespace io = boost::iostreams;
    if(strncmp(argv[1],"detect",6)==0)
    {
        const char* fname_pic = argv[2];
        const char* fname_kps = argv[3];
        Mat img = imread(fname_pic,IMREAD_GRAYSCALE);
        if(!img.data)
        {
            cout<< "Error reading images!" << std::endl;
            return -1;
        }
        Ptr<SIFT> sift_detector = SIFT::create(siftPoints);
        Ptr<SURF> surf_detector = SURF::create(minHessian);
        vector<KeyPoint> surf_keypoints,sift_keypoints;
        Mat sift_descriptors,surf_descriptors;
        sift_detector->detectAndCompute(img, Mat(),sift_keypoints, sift_descriptors);
        surf_detector->detectAndCompute(img, Mat(),surf_keypoints, surf_descriptors);

        ofstream ofs(fname_kps,ios_base::binary);
        {
            io::filtering_streambuf<io::output> out;
            out.push(io::zlib_compressor(io::zlib::best_compression));
            out.push(ofs);
            binary_oarchive oa(out);
            ArchiveHelper<vector<KeyPoint> > sift_archiver(sift_keypoints);
            ArchiveHelper<vector<KeyPoint> > surf_archiver(surf_keypoints);
            ArchiveHelper<Mat> ar1(sift_descriptors);
            ArchiveHelper<Mat> ar2(surf_descriptors);
            oa << sift_archiver;
            oa << surf_archiver;
            oa << ar1;
            oa<<ar2;
        }
        ofs.close();
    }
    else if(strncmp(argv[1],"match",5)==0)
    {
        const char* fname_pic = argv[2];
        const char* fname_kps = argv[3];
        vector<KeyPoint> isift_keypoints,isurf_keypoints,psift_keypoints,psurf_keypoints;
        Mat isift_descriptors,isurf_descriptors;

        ifstream ifs(fname_kps,ios_base::binary);
        {
            io::filtering_streambuf<io::input> in;
            in.push(iostreams::zlib_decompressor());
            in.push(ifs);
            binary_iarchive ia(in);
            ArchiveHelper<vector<KeyPoint> > sift_archiver(isift_keypoints),surf_archiver(isurf_keypoints);
            ArchiveHelper<Mat> ar1(isift_descriptors),ar2(isurf_descriptors);

            ia>>sift_archiver;
            ia>>surf_archiver;
            ia>>ar1;
            ia>>ar2;
        }
        ifs.close();
        Mat img = imread(fname_pic,IMREAD_GRAYSCALE);
        Ptr<SIFT> sift_detector = SIFT::create(siftPoints);
        Ptr<SURF> surf_detector = SURF::create(minHessian);
        Mat psift_descriptors, psurf_descriptors;

        sift_detector->detectAndCompute(img, Mat(),psift_keypoints, psift_descriptors);
        surf_detector->detectAndCompute(img, Mat(),psurf_keypoints, psurf_descriptors);

        BFMatcher matcher;
        vector< DMatch > sift_matches,surf_matches;
        vector<vector<DMatch> > sift_knnMatches,surf_knnMatches;
        matcher.knnMatch(psift_descriptors,isift_descriptors,sift_knnMatches,2);
        matcher.knnMatch(psurf_descriptors,isurf_descriptors,surf_knnMatches,2);

        for( size_t i = 0; i < sift_knnMatches.size(); i++ )
        {
            const DMatch& bestMatch = sift_knnMatches[i][0];
            const DMatch& betterMatch1 = sift_knnMatches[i][1];
            float  distanceRatio = bestMatch.distance / betterMatch1.distance;
            if(distanceRatio<0.61)
            {
                sift_matches.push_back(bestMatch);
            }
        }
        for( size_t i = 0; i < surf_knnMatches.size(); i++ )
        {
            const DMatch& bestMatch = surf_knnMatches[i][0];
            const DMatch& betterMatch1 = surf_knnMatches[i][1];
            float  distanceRatio = bestMatch.distance/betterMatch1.distance;
            if(distanceRatio<0.65)
            {
                surf_matches.push_back(bestMatch);
            }
        }
        printf("-- SIFT KNN Matching rate:%f\n",sift_matches.size()/(0.0+psift_keypoints.size()));
        printf("-- SURF KNN Matching rate:%f\n\n",surf_matches.size()/(0.0+psurf_keypoints.size()));
        //-- Quick calculation of max and min distances between keypoints
        double mx_sift_dist = 0; double mn_sift_dist = 999;
        double mx_surf_dist = 0; double mn_surf_dist = 999;
        for( size_t i = 0; i < sift_matches.size(); i++ )
        {
            double dist = sift_matches[i].distance;
            if( dist < mn_sift_dist ) mn_sift_dist = dist;
            if( dist > mx_sift_dist ) mx_sift_dist = dist;
        }
        for( size_t i = 0; i < surf_matches.size(); i++ )
        {
            double dist = surf_matches[i].distance;
            if( dist < mn_surf_dist ) mn_surf_dist = dist;
            if( dist > mx_surf_dist ) mx_surf_dist = dist;
        }

        std::vector< DMatch > final_sift_matches,final_surf_matches;

        for( size_t i = 0; i < sift_matches.size(); i++ )
        {
            if( sift_matches[i].distance <= max(1.8*mn_sift_dist+1,90.0))
            {
                final_sift_matches.push_back(sift_matches[i]);
            }
        }
        for( size_t i = 0; i < surf_matches.size(); i++ )
        {
            if( surf_matches[i].distance <= max(1.8*mn_surf_dist+0.0016,0.16))
            {
                final_surf_matches.push_back(surf_matches[i]);
            }
        }

        printf("-- SIFT Max dist: %f \n", mx_sift_dist);
        printf("-- SIFT Min dist: %f \n", mn_sift_dist);
        printf("-- SIFT Total matches: %d, good matches: %d\n",sift_matches.size(),final_sift_matches.size());
        printf("-- SIFT Matching rate: %f\n\n",(final_sift_matches.size()+0.0) / sift_matches.size());

        printf("-- SURF Max dist: %f \n", mx_surf_dist);
        printf("-- SURF Min dist: %f \n", mn_surf_dist);
        printf("-- SURF Total matches: %d, good matches: %d\n",surf_matches.size(),final_surf_matches.size());
        printf("-- SURF Matching rate: %f\n\n",(final_surf_matches.size()+0.0) / surf_matches.size());

        Mat img_white(img.rows,img.cols,CV_8UC3,cv::Scalar(255,255,255));
        Mat img_matches1,img_matches2;
        drawMatches(img,psift_keypoints,img_white,isift_keypoints,final_sift_matches,img_matches1);
        //-- Show detected matches
        namedWindow("SIFT Matches",WINDOW_FREERATIO|WINDOW_NORMAL);
        imshow( "SIFT Matches", img_matches1 );

        drawMatches(img,psurf_keypoints,img_white,isurf_keypoints,final_surf_matches,img_matches2);
        //-- Show detected matches
        namedWindow("SURF Matches",WINDOW_FREERATIO|WINDOW_NORMAL);
        imshow( "SURF Matches", img_matches2 );
    }
    else if(strncmp(argv[1],"test",4)==0)
    {
        vector<KeyPoint> sift_keypoints,surf_keypoints;
        ifstream ifs(argv[3],ios_base::binary);
        {
            io::filtering_streambuf<io::input> in;
            in.push(iostreams::zlib_decompressor());
            in.push(ifs);
            binary_iarchive ia(in);
            ArchiveHelper<vector<KeyPoint> > sift_archiver(sift_keypoints),surf_archiver(surf_keypoints);
            ia>>sift_archiver;
            ia>>surf_archiver;
        }
        ifs.close();
        printf("-- SIFT key points:%d\n",sift_keypoints.size());
        printf("-- SURF key points:%d\n",surf_keypoints.size());

        Mat img = imread(argv[2],IMREAD_GRAYSCALE);
        Mat img_kp_sift; Mat img_kp_surf;

        drawKeypoints( img, sift_keypoints, img_kp_sift, Scalar::all(-1), DrawMatchesFlags::DRAW_RICH_KEYPOINTS);
        drawKeypoints( img, surf_keypoints, img_kp_surf, Scalar::all(-1), DrawMatchesFlags::DRAW_RICH_KEYPOINTS);
        namedWindow("SIFT Keypoints",WINDOW_NORMAL);
        imshow("SIFT Keypoints", img_kp_sift );
        namedWindow("SURF Keypoints",WINDOW_NORMAL);
        imshow("SURF Keypoints", img_kp_surf );
    }
    else
    {
        readme();
        return -1;
    }
    waitKey(0);
    return 0;
}
/* @function readme */
void readme()
{ std::cout << " Usage: ./picmatch <detect|match> <image> <keypoint_file>" << std::endl; }
