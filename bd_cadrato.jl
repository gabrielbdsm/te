
module bd_cadrato

using SQLite
using DataFrames
#colocar telefone unique

#conectar/criar banco de dados
db = SQLite.DB("client.db")
# criar TABLE
SQLite.execute(db,"CREATE TABLE IF NOT EXISTS dados(
id_cliente INTEGER UNIQUE NOT NULL PRIMARY KEY AUTOINCREMENT,
cpf        TEXT    UNIQUE
NOT NULL,
nome       TEXT    NOT NULL,
senha      TEXT    NOT NULL,
email      TEXT    UNIQUE
NOT NULL,
telefone   TEXT    UNIQUE
NOT NULL,
senha_cartao TEXT)")





function insert(cpf,nome,senha , email , telefone ,senha_cartao )

    
SQLite.execute(db,"INSERT INTO dados(cpf,nome,senha, email, telefone , saldo) VALUES
('$cpf','$nome','$senha' ,'$email', '$telefone' ,'$senha_cartao')")
end


#mostrar tabela infor
#println(SQLite.columns(db,"dados"))

#deletar linha
function delete(coluna , linha)
    
    SQLite.execute(db,"DELETE FROM dados WHERE $coluna = '$linha'")
end

#mudar valior coluna set o que vai mudar  where onde (chave)
#SQLite.execute(db,"UPDATE dados SET id = 5 WHERE nome = 'micaelly'  ")

function verificar_existencia(coluna , linha )
    try
        
            select =SQLite.DBInterface.execute(db, "SELECT $coluna FROM dados WHERE $coluna = '$linha'")
            select = DataFrames.DataFrame(select)
            select = Tuple(select[1,:])
        catch
            return false
        end
        
        return true
    

end

function  consultar(coluna , linha)
    if  verificar_existencia(coluna , linha) == true
    select =SQLite.DBInterface.execute(db, "SELECT * FROM dados WHERE $coluna = '$linha'")
    select = DataFrames.DataFrame(select)
    select= NamedTuple(select[1,:])
    
    return select
   else
        return -1
     end
end

end