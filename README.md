# winflexbison
A prefixed version of winflexbison, patched to put pkgdir to ../share/bison

# Intro
This is a MinGW friendly version of flex + bison, which originated its code from the win_flexbison code base, with modified PKGDIR directory defaults to bin/../share/bison.

The original win_flexbison code wont compile under MinGW because its lack of gettime() function as available both in Linux and MSVC, to fix this compilation problem, I had to comment out the line invoking it (I don't have any better way to do this at the moment), if anyone comes up with a better idea how to solve this problem, you are free to pull request from this repo :)
