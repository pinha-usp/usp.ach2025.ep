# Custo-benefício da materialização da visão

A materialização da visão `documentos_usuarios` talvez não seja tão vantajosa,
já que o custo de manutenção da visão é alto, já que a visão precisa ser 
atualizada sempre que um usuário criar um novo documento, o que é uma ação comum 
de ser feita.

O único benefício da materialização é que a consulta na visão é mais rápida que
consultar com as tabelas originais, mas mesmo assim esse benefício não compensaria
o custo.
