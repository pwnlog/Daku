# Troubleshooting Daku

At the moment this applies to ParrotOS.

> TL;DR: When using `aptitude` install the packages that it's recommending you. If it tells you that is `not installed`, type `n` to find another solution. If `aptitude` doesn't work, try to find an alternative solution. 

# Fix Imlib2 (ParrotOS)

```
┌─[test@parrot]─[~/Daku/nsxiv]
└──╼ $sudo aptitude install libimlib2-dev
The following NEW packages will be installed:
  libbz2-dev{a} libgif-dev{a} libid3tag0-dev{a} libimlib2-dev{b} libjpeg-dev{a} libjpeg62-turbo-dev{a} libwebp-dev{a} 
0 packages upgraded, 7 newly installed, 0 to remove and 2 not upgraded.
Need to get 1,036 kB of archives. After unpacking 3,439 kB will be used.
The following packages have unmet dependencies:
 libimlib2-dev : Depends: libtiff-dev but it is not installable
The following actions will resolve these dependencies:

     Keep the following packages at their current version:
1)     libimlib2-dev [Not Installed]                      



Accept this solution? [Y/n/q/?] n
The following actions will resolve these dependencies:

     Install the following packages:                            
1)     libdeflate-dev [1.10-2~bpo11+1 (parrot-backports)]       
2)     libjbig-dev [2.1-3.1+b2 (parrot)]                        
3)     liblzma-dev [5.2.5-2.1~deb11u1 (parrot, parrot-security)]
4)     libtiff-dev [4.2.0-1+deb11u3 (parrot, parrot-security)]  
5)     libtiffxx5 [4.2.0-1+deb11u3 (parrot, parrot-security)]   



Accept this solution? [Y/n/q/?] Y
The following NEW packages will be installed:
  libbz2-dev{a} libdeflate-dev{a} libgif-dev{a} libid3tag0-dev{a} libimlib2-dev libjbig-dev{a} libjpeg-dev{a} libjpeg62-turbo-dev{a} liblzma-dev{a} 
  libtiff-dev{a} libtiffxx5{a} libwebp-dev{a} 
0 packages upgraded, 12 newly installed, 0 to remove and 2 not upgraded.
Need to get 1,898 kB of archives. After unpacking 5,686 kB will be used.
Do you want to continue? [Y/n/?] Y

```

What does this mean?

```
The following actions will resolve these dependencies:

     Keep the following packages at their current version:
1)     libimlib2-dev [Not Installed]                      
```

In the text above, it's telling us that `libimlib2-dev` is not installed. However, we need this dependency. The following text tells us to consider this as a solution (not installing `libimlib2-dev`) which we need. Therefore, I typed `n` which stands for `no` and look for another solution.

```
Accept this solution? [Y/n/q/?] n
```

After a while, `aptitude` was able to find a solution:

```
The following actions will resolve these dependencies:

     Install the following packages:                            
1)     libdeflate-dev [1.10-2~bpo11+1 (parrot-backports)]       
2)     libjbig-dev [2.1-3.1+b2 (parrot)]                        
3)     liblzma-dev [5.2.5-2.1~deb11u1 (parrot, parrot-security)]
4)     libtiff-dev [4.2.0-1+deb11u3 (parrot, parrot-security)]  
5)     libtiffxx5 [4.2.0-1+deb11u3 (parrot, parrot-security)]   



Accept this solution? [Y/n/q/?] Y
The following NEW packages will be installed:
  libbz2-dev{a} libdeflate-dev{a} libgif-dev{a} libid3tag0-dev{a} libimlib2-dev libjbig-dev{a} libjpeg-dev{a} libjpeg62-turbo-dev{a} liblzma-dev{a} 
  libtiff-dev{a} libtiffxx5{a} libwebp-dev{a} 
0 packages upgraded, 12 newly installed, 0 to remove and 2 not upgraded.
Need to get 1,898 kB of archives. After unpacking 5,686 kB will be used.
Do you want to continue? [Y/n/?] Y
```

As we can see above, I type `Y` which stands for `yes` (accept this solution). This installed the dependencies we need to install `nsxiv`.

# Fix python3-sphinx (ParrotOS)

If `aptitude` fails, we need to find another alternative. 

```
❯ sudo aptitude install python3-sphinx
The following NEW packages will be installed:
  libcommon-sense-perl{a} libjson-perl{a} libjson-xs-perl{a} 
  libtypes-serialiser-perl{a} python3-alabaster{a} python3-imagesize{a} 
  python3-snowballstemmer{a} python3-sphinx{b} sphinx-common{a} 
0 packages upgraded, 9 newly installed, 0 to remove and 2 not upgraded.
Need to get 1,505 kB of archives. After unpacking 7,720 kB will be used.
The following packages have unmet dependencies:
 python3-sphinx : Depends: python3-pygments (>= 2.13) but 2.7.1+dfsg-2.1 is installed
The following actions will resolve these dependencies:

     Keep the following packages at their current version:
1)     python3-sphinx [Not Installed]                     

     Leave the following dependencies unresolved:         
2)     sphinx-common recommends python3-sphinx            



Accept this solution? [Y/n/q/?] n

*** No more solutions available ***

<...SNIP...>
```

Thankfully, `sphinx` can be installed with `pip`.

```
pip install sphinx
```

