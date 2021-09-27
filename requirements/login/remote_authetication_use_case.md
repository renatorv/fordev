# Remote Authentication Use Case

> ## Caso de sucesso
1. :ok: Sistema valida os dados
2. :ok: Sistema faz uma requisão para a URL da API de login
3. Sistema valida os dados recebidos da API
4. Sistema entrega os dados da conta do usuário

> ## Exceção - URL inválida
1. Sistema retorna uma mensagem de erro inesperado

> ## Exceção - Dados inválidos
1. :ok: Sistema retorna uma mensagem de erro inesperado

> ## Exceção - Resposta inválida
1. Sistema retorna uma mensagem de erro inesperado

> ## Exceção - Falha no servidor
1. Sistema retorna uma mensagem de erro inesperado

> ## Exceção - Credenciais inválidas
1. Sistema retorna uma mensagem de erro inesperado que as credenciais estão erradas