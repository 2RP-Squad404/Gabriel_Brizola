# Relatório de Estudos

**Nome do Estagiário:** Gabriel Silva Brizola
**Data:** 02/08/2024

**Módulos/Etapas Feitas:**  
1. [**Introdução a Engenharia de dados**](#introducao)
2. [**Git**](#git)

## Resumo dos módulos 

### Introdução a Engenharia de dados <a id="introducao"></a>

Engenheiro de dados gerenciam e convertem dados brutos em informações utilizáveis, foca em criação de sistemas e sua manutenção e também em infraestruturas para coletar, armazenar, processar e analisar grandes volumes de dados. Esta área é muito importante para transformar os dados brutos em informações úteis para serem utilizadas nas empresas, ajuda com a tomada de decisão, análise do negócio e em machine learning.

#### Ferramentas Comuns na Engenharia de Dados

Bancos de Dados: MySQL, PostgreSQL, MongoDB, Cassandra

Data Warehouse: Google BigQuery, Amazon Redshift, , Snowflake, Azure Synapse Analytics

Processamento de Dados: Apache Hadoop, Apache Spark, Apache Flink

Ferramentas ETL (Extract, Transform, Load): Apache Nifi, Apache Airflow, Airbyte, Dataflow

Linguagens de Programação: Python, SQL, Java, Scala, R

#### Principais atividades na engenharia de dados

1.**Coletar os dados**: Coletar o dado bruto de diversas fontes.

2.**Armazenamento de dados**: Desenvolver soluções para o armazenamento de grandes volumes de dados, como datawarehouses(sistema para armazenar dados de uma organização centralizada, dados que foram processados, dados estruturados), data lakes(sistema para armazenar dados em forma bruta e original, pode incluir dados estruturados, semiestruturados e não estruturados.) e bancos de dados diversos.

3.**Processamento de dados**: Transformação e tratamento dos dados para garantir sua qualidade para a análise.

4.**Integração de dados**: Unificar dados de diversas fontes, garantindo sua integridade.

5.**Automatização de Pipelines de dados**: Criação de Pipelines(cadeia de elementos de processamento) automatizadas para manter o fluxo contínuo de dados.

6.**Segurança e governança de dados**: Garantir que os dados são armazenados e utilizados de maneira segura e sem ferir as regulamentações e políticas de privacidade.

### Git <a id="git"></a>

Git é um sistema de controle de versões distribuido podendo visualizar alterações em arquivos e quem as realizou e coordenar o trabalho de uma equipe, permitindo que cada contribuidor da equipe possa adicionar, alterar e excluir arquivos no projeto.

#### Principais Conceitos do Git
- **Repositório**: Local de armazenamento de histórico de alterações, adição de arquivos e pastas para gerenciamento.

- **Commit:** Criado para capturar o estado que o arquivo se encontra naquele momento. cada commit tem um identificador único (hash), podendo assim desfazer o commit criado.

- **Branch:** É uma linha de desenvolvimento que permite adicionar funcionalidades, realizar manutenções sem que o produto principal sofra alterações não aprovadas, realizar manutenções no produto principal decorrentes de bugs drásticos que comprometem o funcionamento do produto. principais branches: main/master(branch principal), develop, feature, hotfix, realese.

- **Merge:** Unificar mudanças de diferentes branches em uma única branch.

- **Fork:** Criação de uma cópia do repositório sem afetar o repositório original.

#### Benefícios do Git
- **Controle de versão:** Pode ser verificado cada alteração do projeto tendo seu histórico completo de mudanças, podendo assim retornar as versões anteriores.

- **Colaboração:** Facilita o trabalho em equipe, podendo cada colaborador do projeto trabalhar em diferentes partes do projeto simultaneamente.

- **Distribuído:** Cada colaborador do projeto possui uma cópia completa do repositório, assim aumentando a eficiência do trabalho e diminuindo o tempo para completar o objetivo do projeto.

## Links de Laboratórios (se houver)

- [Google Colab 1/Notion 1](URL_do_Lab_1)
- [Google Colab 2/Notion 2](URL_do_Lab_2)
- ...

**Recursos Utilizados:**  
- Git
- GitHub

**Principais comandos:**  
- **Git Pull:** Atualiza a cópia do arquivo local com as mudanças do repositório remoto. (git pull origin < nome-da-branch >).

- **Git Push:** Atualiza o repositório remoto com as mudanças do repositório local. (git push).

- **Git Clone:** Criação de uma cópia de um repositório remoto para o repositório local. (git clone <https://link-com-o-nome-do-repositório>)

- **Git Branch:** Comando para mostrar as branches criadas. (git branch).

- **Git Checkout:** Comando para trocar de uma branch para outra. (git checkout < nome-da-branch >).

- **Git Status:** Comando para dar todas as informações da branch atual. (git status).

- **Git Add:** Comando para adicionar as modificações ou exclusões de um arquivo. (git add < nome-do-arquivo >) ou para adicionar todas as modificações (git add .).

- **Git Commit:** Comando para definir um ponto no processo de desenvolvimento, é necessário escrever uma mensagem breve explicando o que foi realizado nesse commit. (git commit -m "docs:exemplo de commit").

- **Git Log:** Comando para verificar quem realizou o commit, sua data e seu hash. (git log).

- **Git Revert:** Comando para desfazer alterações realizadas, para isso é necessário saber o hash do commit. (git revert < hash-do-commit >).

- **Git Fetch:** Comando para buscar atualizações do repositório local, verifica se houve commits novos. (git fetch).

**Desafios Encontrados:**  
Descreva quaisquer desafios ou obstáculos que você encontrou durante a trilha de aprendizagem e como você os superou ou planeja superá-los.

**Feedback e Ajustes:**  
Descreva qualquer feedback que você recebeu e como você ajustou sua abordagem de estudo com base nesse feedback.

**Próximos Passos:**  
Descreva os próximos passos em sua trilha de aprendizagem. Quais são as próximas etapas ou módulos que você irá abordar?