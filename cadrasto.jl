using Genie
using Genie.Router, Genie.Renderer, Genie.Renderer.Html, Genie.Renderer.Json, Genie.Requests
using SQLite
using JSON
using DataFrames
using JSONTables
include("bd_cadrato.jl")
include("bd_endereco.jl")
include("endereco.jl")
include("conta.jl")
include("confir_Email.jl")

route("/addcpf", method = POST) do 
    cpf = postpayload(:cpf)

    if (verifcar_num(cpf) == false ) || (length(cpf) != 11)
      return "CPF invalido"
    
    elseif bd_cadrato.verificar_existencia("cpf",cpf) == true
      
      return "CPF já cadrastado"
      
    end
      
end
      
      nome =postpayload(:nome)
      senha = postpayload(:senha)
    email = postpayload(:email)
    codigo = postpayload(:codigo)
    senha_cartao= postpayload(:senha_cartao)
    
    
    
    
    
    if bd_cadrato.verificar_existencia("email",email) == true
      return "email já cadrastado"
      
    elseif confir_Email.enviar_email(email) != codigo 
      return "codigo de confirmação incorreto"
      
      
      
      route("/addtelefone", method = POST) do 
        telefone = postpayload(:telefone)
        
        if (verifcar_num(telefone) == false ) || (length(telefone) != 11)
          return "telefone invalido"
          
        elseif bd_cadrato.verificar_existencia("telefone",telefone) == true
    
      return "telefone já cadrastado"


    elseif length(senha) < 8 
      return "Senha deve conter mais de 8 caracteres"

    elseif (verifcar_num(senha_cartao) == false ) || (length(senha_cartao) != 6)
        return "senha deve conter 6 numero "

    else
      bd_cadrato.insert(cpf , nome , senha, email , telefone ,senha_cartao)
      dados = bd_cadrato.consultar("cpf" , cpf)
      bd_endereco.inseir_id(dados.id_cliente)
      conta.inseir_id(dados.id_cliente)
    end
    return "POST OK"



function verifcar_num(palavra)
try
  typeof(parse(Int ,palavra))

catch
 
  return false
end
  return true

end




up(8001, async = false)
end