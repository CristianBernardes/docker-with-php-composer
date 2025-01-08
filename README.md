# Como Subir o Projeto com Docker no Windows

Este guia descreve como configurar o ambiente para rodar o Docker em um sistema Windows usando WSL (Windows Subsystem for Linux).

## Pré-requisitos

Antes de iniciar, verifique se você tem o seguinte:

- **Windows 10 ou superior**
- **Docker Desktop instalado e configurado para usar o WSL 2**
- **WSL 2 habilitado** e uma distribuição Linux instalada (recomendado: Ubuntu)

Se algum desses itens não estiver configurado, siga os passos abaixo.

## 1. Instalar o WSL e Ubuntu

1. Abra o PowerShell como Administrador e execute:
   ```powershell
   wsl --install -d Ubuntu
   ```
   Isso instalará o WSL 2 e a distribuição Ubuntu.

2. Reinicie o computador, se solicitado.

3. Abra o Ubuntu pelo menu Iniciar e configure seu usuário e senha.

## 2. Instalar o Docker Desktop

1. Baixe o Docker Desktop para Windows em: [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop).
2. Instale o Docker Desktop e habilite o suporte ao WSL durante a instalação.
3. Abra o Docker Desktop e certifique-se de que o WSL 2 está configurado como backend:
    - Vá em **Settings > General** e habilite **Use the WSL 2 based engine**.
    - Em **Settings > Resources > WSL Integration**, habilite sua distribuição Linux (Ubuntu).

## 3. Subir o Container

### Clonar o Repositório

Clone este repositório em sua máquina local:
```bash
git clone <URL-DO-REPOSITORIO>
```

Navegue até a pasta do projeto:
```bash
cd <NOME-DA-PASTA>
```

### Build e Run do Container

No terminal do WSL (Ubuntu), execute o seguinte comando para criar a imagem e rodar o container:
```bash
docker build -t php-container . && docker run -d --name php-container --restart always -v /mnt/c/Ops/projetos:/var/www php-container
```

### Detalhes do Comando
- `docker build -t php-container .`: Cria a imagem do Docker com base no Dockerfile presente na pasta atual.
- `docker run -d --name php-container --restart always -v /mnt/c/Ops/projetos:/var/www php-container`:
    - Roda o container no modo desanexado.
    - Mapeia a pasta `C:\Ops\projetos` no Windows para `/var/www` no container.
    - Configura o container para reiniciar automaticamente.

### Verificar o Status do Container

Verifique se o container está rodando com:
```bash
docker ps
```

Se precisar parar ou remover o container:
- Parar: `docker stop php-container`
- Remover: `docker rm php-container`

---

## Considerações Finais

Certifique-se de que a pasta `C:\Ops\projetos` contém os arquivos necessários para o funcionamento do projeto. Agora o ambiente está configurado e pronto para uso!
