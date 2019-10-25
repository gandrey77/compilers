# Linguagem NAJA
## Descritivo de arquivos

### Analisador léxico
**analex/scanner.l**
* Analisador léxico em linguagem Flex (com expressões regulares).

**analex/lex.yy.c**
* Analisador léxico compilado em linguagem C.

___
### Analisador sintático
**anasint/parser.y**
* Analisador sintático em linguagem Bison (definição da gramática LC).

**anasint/y.tab.c (Linux) ou anasint/parser.tab.c (Windows)**
* Analisador sintático compiado em linguagem C.

___
### Documentos

**docs\lang-description**
* Descrição da linguagem. Contém explicativos das ideias e expressões regulares, bem como a gramática livre de contexto e manual de uso.

___
### Testes

**tests\aritmetica.txt**
* Arquivo texto com testes para operações aritmeticas.

**tests\comparacao.txt**
* Arquivo texto com testes para comparações.

> Linguagem definida por Douglas A. C. Canevarollo e Gabriel A. P. Nunes
