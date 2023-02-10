# Troubleshooting Daku

At the moment this applies to ParrotOS.

> TL;DR: When using `aptitude` install the packages that it's recommending you. If it tells you that is `not installed`, type `n` to find another solution. If `aptitude` doesn't work, try to find an alternative solution. 

# Installation Script Example in ParrotOS

If you're using the provided installation script in ParrotOS; eventually you'll see these lines of text:

```
[-] Command:  'sudo apt install -y libimlib2-dev'  has failed



[!] User interaction required, please read the TROUBLESHOOTING.md file for more information 



libdeflate0 is already installed at the requested version (1.10-2~bpo11+1)
libdeflate0 is already installed at the requested version (1.10-2~bpo11+1)
The following packages will be REMOVED:
  graphicsmagick{u} libgraphicsmagick-q16-3{u} 
0 packages upgraded, 0 newly installed, 2 to remove and 196 not upgraded.
Need to get 0 B of archives. After unpacking 8,711 kB will be freed.
Do you want to continue? [Y/n/?] Y
(Reading database ... 573078 files and directories currently installed.)
Removing graphicsmagick (1.4+really1.3.36+hg16481-2) ...
Removing libgraphicsmagick-q16-3 (1.4+really1.3.36+hg16481-2) ...
Processing triggers for man-db (2.10.1-1~bpo11+1) ...
Processing triggers for menu (2.1.48) ...
Processing triggers for mailcap (3.69) ...
Processing triggers for libc-bin (2.31-13+deb11u5) ...
Scanning application launchers
Removing duplicate launchers or broken launchers
Launchers are updated
                                         
Current status: 196 (-2) upgradable.
The following NEW packages will be installed:
  libdeflate-dev{b} 
0 packages upgraded, 1 newly installed, 0 to remove and 196 not upgraded.
Need to get 46.9 kB of archives. After unpacking 124 kB will be used.
The following packages have unmet dependencies:
 libdeflate-dev : Depends: libdeflate0 (= 1.7-1) but 1.10-2~bpo11+1 is installed
The following actions will resolve these dependencies:

     Keep the following packages at their current version:
1)     libdeflate-dev [Not Installed]                     



Accept this solution? [Y/n/q/?] n
The following actions will resolve these dependencies:

     Downgrade the following packages:                                       
1)     libdeflate0 [1.10-2~bpo11+1 (now, parrot-backports) -> 1.7-1 (parrot)]



Accept this solution? [Y/n/q/?] Y
The following packages will be DOWNGRADED:
  libdeflate0 
The following NEW packages will be installed:
  libdeflate-dev 
0 packages upgraded, 1 newly installed, 1 downgraded, 0 to remove and 196 not upgraded.
Need to get 100.0 kB of archives. After unpacking 87.0 kB will be used.
Do you want to continue? [Y/n/?] Y
Get: 1 https://deb.parrot.sh/parrot lts/main amd64 libdeflate0 amd64 1.7-1 [53.1 kB]
Get: 2 https://deb.parrot.sh/parrot lts/main amd64 libdeflate-dev amd64 1.7-1 [46.9 kB]
Fetched 100.0 kB in 1s (143 kB/s)         
dpkg: warning: downgrading libdeflate0:amd64 from 1.10-2~bpo11+1 to 1.7-1
(Reading database ... 572937 files and directories currently installed.)
Preparing to unpack .../libdeflate0_1.7-1_amd64.deb ...
Unpacking libdeflate0:amd64 (1.7-1) over (1.10-2~bpo11+1) ...
Selecting previously unselected package libdeflate-dev:amd64.
Preparing to unpack .../libdeflate-dev_1.7-1_amd64.deb ...
Unpacking libdeflate-dev:amd64 (1.7-1) ...
Setting up libdeflate0:amd64 (1.7-1) ...
Setting up libdeflate-dev:amd64 (1.7-1) ...
Processing triggers for libc-bin (2.31-13+deb11u5) ...
Scanning application launchers
Removing duplicate launchers or broken launchers
Launchers are updated
                                         




The following NEW packages will be installed:
  bzip2-doc{a} libbz2-dev{a} libgif-dev{a} libid3tag0-dev{a} libimlib2-dev libjbig-dev{a} libjpeg-dev{a} libjpeg62-turbo-dev{a} liblzma-dev{a} 
  libtiff-dev{a} libtiffxx5{a} libwebp-dev{a} 
The following packages will be upgraded:
  libtiff5 
1 packages upgraded, 12 newly installed, 0 to remove and 195 not upgraded.
Need to get 2,645 kB of archives. After unpacking 6,161 kB will be used.
Do you want to continue? [Y/n/?] Y
Get: 1 https://deb.parrot.sh/parrot lts/main amd64 bzip2-doc all 1.0.8-4 [514 kB]
Get: 2 https://deb.parrot.sh/parrot lts/main amd64 libbz2-dev amd64 1.0.8-4 [30.1 kB]
Get: 3 https://deb.parrot.sh/parrot lts/main amd64 libgif-dev amd64 5.1.9-2 [47.8 kB]
Get: 4 https://deb.parrot.sh/parrot lts/main amd64 libid3tag0-dev amd64 0.15.1b-14 [38.6 kB]
Get: 5 https://deb.parrot.sh/parrot lts/main amd64 libjpeg62-turbo-dev amd64 1:2.0.6-4 [278 kB]
Get: 6 https://deb.parrot.sh/parrot lts/main amd64 libjpeg-dev amd64 1:2.0.6-4 [67.8 kB]
Get: 7 https://deb.parrot.sh/parrot lts/main amd64 libjbig-dev amd64 2.1-3.1+b2 [30.5 kB]
Get: 8 https://deb.parrot.sh/parrot lts/main amd64 liblzma-dev amd64 5.2.5-2.1~deb11u1 [229 kB]
Get: 9 https://deb.parrot.sh/parrot lts/main amd64 libtiff5 amd64 4.2.0-1+deb11u3 [290 kB]
Get: 10 https://deb.parrot.sh/parrot lts/main amd64 libtiffxx5 amd64 4.2.0-1+deb11u3 [129 kB]
Get: 11 https://deb.parrot.sh/parrot lts/main amd64 libtiff-dev amd64 4.2.0-1+deb11u3 [416 kB]
Get: 12 https://deb.parrot.sh/parrot lts/main amd64 libwebp-dev amd64 0.6.1-2.1 [341 kB]
Get: 13 https://deb.parrot.sh/parrot lts/main amd64 libimlib2-dev amd64 1.7.1-2 [232 kB]
Fetched 2,645 kB in 1s (2,156 kB/s) 

```

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

