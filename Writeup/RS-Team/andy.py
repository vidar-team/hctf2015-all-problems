#!/usr/bin/env python
#-*- coding:utf-8 -*-
import base64

def classical(s):

    array1 = "0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z = A B C D E F G H I J K L M E O P Q R S T U V W X Y Z";
    array2 = "W,p,X,4,5,B,q,A,6,a,V,3,r,b,U,s,E,d,C,c,D,O,t,T,Y,v,9,Q,2,e,8,P,f,h,J,N,g,u,K,k,H,x,L,w,R,I,j,i,y,l,m,S,M,1,0,O,n,2,G,7,=,F,Z";

    a1 = array1.split(' ')
    a2 = array2.split(',')
    
    result = [] 
    for a in s:
        index = classical_find(a,a2)
        if index == -1:
            print 'error'
        result.append(a1[index])

    return ''.join(result)

def classical_find(c,a):
    for index,ch in enumerate(a):
        if ch == c:
            return index

    return -1

def base64_decode(s):
    return base64.b64decode(s)

def main():
    s = 'SRlhb70YZHKvlTrNrt08F=DX3cdD3txmg'
    cs = classical(s)
    print cs
    b64cs = base64_decode(cs)
    print b64cs

    input_str = b64cs[::-1]
    print input_str
    result = input_str.replace('hdu1s8','')
    print result

if __name__ == '__main__':
    main()
