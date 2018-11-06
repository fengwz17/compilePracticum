all:	eeyore

eeyore: lex.yy.c y.tab.c 
	g++ --std=c++11 -o eeyore lex.yy.c y.tab.c

lex.yy.c: minic.lex
	flex minic.lex

y.tab.c y.tab.h: minic.y
	bison -y -d minic.y

clean:
	-rm y.tab.c y.tab.h lex.yy.c eeyore