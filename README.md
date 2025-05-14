# Sankhya Integrations

## Objetivo do Projeto

Este projeto tem como objetivo integrar sistemas Ruby on Rails ao ERP Sankhya, facilitando a comunicação, consulta e manipulação de dados das entidades do Sankhya via API RESTful. Ele centraliza autenticação, consultas genéricas e mapeamento de dados para uso em aplicações Ruby.

## Requisitos

- Ruby >= 3.0
- Rails >= 7.0
- Bundler
- Gem `dotenv-rails` para gerenciamento de variáveis de ambiente
- Gem `faraday` para requisições HTTP
- Conta de acesso válida no Sankhya (usuário e senha)

## Versões

- Ruby: 3.0 ou superior
- Rails: 7.0 ou superior
- Sankhya: compatível com API REST padrão (exemplo: MobileLoginSP.login, CRUDServiceProvider.loadRecords)

## Debug com Ruby LSP (Shopify)

Para realizar o debug deste projeto Ruby on Rails, siga os passos abaixo:

### 1. Instale a extensão Ruby LSP (Shopify)

No VSCode, procure por **Ruby LSP (Shopify)** e instale a extensão.

### 2. Execute o servidor Rails em modo debug

No terminal, rode o seguinte comando:

```sh
bundle exec rdbg -O -n -c -- bin/rails server -p 3000
```

- Isso iniciará o servidor Rails na porta 3000 com suporte a debug.
- O Ruby LSP irá se conectar automaticamente ao processo para permitir breakpoints, inspeção de variáveis, etc.

### 3. Configuração de Debug no VSCode

Você pode adicionar o seguinte trecho ao seu arquivo `.vscode/launch.json` para facilitar o debug de scripts, testes e para anexar o debugger ao servidor Rails:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "ruby_lsp",
      "name": "Debug script",
      "request": "launch",
      "program": "ruby ${file}"
    },
    {
      "type": "ruby_lsp",
      "name": "Debug test",
      "request": "launch",
      "program": "ruby -Itest ${relativeFile}"
    },
    {
      "type": "ruby_lsp",
      "name": "Attach debugger",
      "request": "attach"
    }
  ]
}
```

- Isso permite iniciar o debug de scripts, testes ou anexar ao processo do servidor Rails já em execução.

### 4. Variáveis de ambiente

Lembre-se de configurar o arquivo `.env` com as credenciais e URL do Sankhya:

**Nunca faça commit do arquivo `.env` com dados sensíveis em repositórios públicos!**

---

Para dúvidas ou problemas, consulte a documentação do Ruby LSP (Shopify) ou abra uma issue neste repositório.
