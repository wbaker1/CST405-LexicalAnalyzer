# CST405-LexicalAnalyzer

To run the lexer.l, download Linux/Unix
Download Flex & Bison

Navigate and put the lexer.l, test.cmm.txt and test2.cmm.txt in the same directory.
Within the console navigate to that directory and run the following commands

flex lexer.l
gcc -o lexer lex.yy.c
./lexer test.cmm.txt
or for test2.cmm.txt
./lexer test2.cmm.txt
